# Objectives
- Edit `/etc/default/named`
- Edit `/etc/bind/named.conf.options`

## Edit `/etc/default/named`
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
    file "/etc/bind/zones/db.hydro.homie.ca"; #forward zone file path
    allow-transfer { 192.168.122.15; }; # Primary DNS server
};

zone "122.168.192.in-addr.arpa" {

}
```

