# Objectives
- Edit `/etc/default/named`
- Edit `/etc/bind/named.conf.options`

## Edit `/etc/default/named`
- Set BIND to IPv4 mode
```bash
#
# run resolvconf?
RESOLVCONF=no

# startup options for the server
OPTIONS="-u bind -4"
```


## Edit `/etc/bind/named.conf.options`
- Here we'll:
    - Create an ACL for trusted devices
    - Allow recursive DNS queries for the trusted devices

```bash
acl "trusted" {
    192.168.122.0/24;
};

options {
    directory "/var/cache/bind";

    recursion yes; # enables recursive queries
    allow-recursion { trusted; }; # allow recursive queries from "trusted" clients
    listen-on { 192.168.122.15; }; # IP address of main DNS Server 
    allow-transfer { none; }; # disable zone transfers

    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
}
```


## Edit `/etc/bind/named.conf.local`
- Specify forward zone file
- Specify reverse zone file

```bash
zone "hydro.homie.ca" {
    type primary;
    file "/etc/bind/zones/db.hydro.homie.ca"; # forward zone file path
    allow-transfer { 192.168.122.16; }; # secondary DNS server
};

zone "122.168.192.in-addr.arpa" {
    type primary;
    file "/etc/bind/zones/db.122.168.192"; # reverse zone file path 
    allow-transfer { 192.168.122.16; }; # secondary DNS server
}
```
## Create folder for zone files
```bash
sudo mkdir /etc/bind/zones
```

## Create forward zone file 
- We'll use `/etc/bind/db.local` as a template

```bash
sudo cp /etc/bind/db.local /etc/bind/zones/db.hydro.homie.ca
```

### Edit `/etc/bind/zones/db.hydro.homie.ca`
```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     hh-dns01.hydro.homie.ca. admin.hydro.homie.ca. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; name servers - NS records
        IN      NS      hh-ws01.hydro.homie.ca.
        IN      NS      hh-ws02.hydro.homie.ca.

; name servers - A records
hh-ws01.hydro.homie.ca. IN      A       192.168.122.21
hh-ws02.hydro.homie.ca. IN      A       192.168.122.22
```

## Create reverse zone file 
- We'll use `/etc/bind/db.127` as a template 

```bash
sudo cp /etc/bind/db.127 /etc/bind/zones/db.122.168.192
```

## Edit `/etc/bind/zones/db.122.168.192`
```bash
;
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     hh-dns01.hydro.homie.ca. admin.hydro.homie.ca. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
; name servers
        IN      NS      hh-ws01.hydro.homie.ca.
        IN      NS      hh-ws02.hydro.homie.ca.

; PTR Records
21.122  IN      PTR     hh-ws01.hydro.homie.ca. ; 192.168.122.21
22.122  IN      PTR     hh-ws02.hydro.homie.ca. ; 192.168.122.22
```


## Check BIND configuration syntax
```bash
sudo named-checkconf
```

## Check forward zone syntax
```bash
sudo named-checkzone hydro.homie.ca /etc/bind/zones/db.hydro.homie.ca
```

## Check reverse zone syntax 
```bash
sudo named-checkzone 122.168.192.in-addr.arpa /etc/bind/zones/db.122.168.192
```

## Manage BIND service

### Restart BIND 
```bash
sudo systemctl restart bind9
```

### Check BIND status
```bash
sudo systemctl status bind9
```

## Allow BIND on UFW
```bash
sudo ufw allow bind9
```
