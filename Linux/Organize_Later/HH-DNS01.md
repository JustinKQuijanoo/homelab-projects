# Install BIND9 
```bash
sudo apt install \
	bind9 \
	bind9utils \
	bind9-doc -y
```

## Configure network settings
### /etc/netplan/50-cloud-init.yaml
```bash
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: false
      addresses:
        - 192.168.122.11/24
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
      routes:
        - to: default
          via: 192.168.122.1
```

## DNS Configuration
### /etc/bind/named.conf.options
- create trusted list to allow recursive DNS

```bash
acl "trusted" {
	192.168.122.11;	#hh-dns01
	192.168.122.12;	#hh-dns02
	192.168.122.21;	#hh-ws01
	192.168.122.22;	#hh-ws02
	192.168.122.23;	#hh-ws03
	192.168.122.24;	#hh-ws04
	192.168.122.117; #PILOT-SM0K3Y
};

options {
	directory "/var/cache/bind";

	recursion yes;
	allow-recursion { trusted; };
	listen-on { 192.168.122.11; };
	allow-transfer { none; };

	forwarders {
		192.168.122.1;
		8.8.8.8;
		8.8.4.4;
	};

	dnssec-validation auto;

	listen-on-v6 { any; };
};
```

### /etc/bind/named.conf.local
- specify forward and reverse zones
```bash
// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

zone "hydrohomie.ca" {
	type primary;
	file "/etc/bind/zones/db.hydrohomie.ca";
	allow-transfer { 192.168.122.22; };
};

zone "122.168.192.in-addr.arpa" {
	type primary;
	file "/etc/bind/zones/db.122.168.192";
	allow-transfer { 192.168.122.22; };
};
```

### Create folder to hold forward and reverse zone files in `/etc/bind/`
```bash
sudo mkdir /etc/bind/zones
sudo touch /etc/bind/zones/db.hydrohomie.ca
sudo touch /etc/bind/zones/db.122.168.192
```

### /etc/bind/zones/db.hydrohomie.ca
- forward zone
```bash
;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	hh-dns01.hydrohomie.ca. admin.hydrohomie.ca. (
			      5		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
; name servers - NS records
	IN	NS	hh-dns01.hydrohomie.ca.
	IN	NS	hh-dns02.hydrohomie.ca.
	IN	NS	hh-ws01.hydrohomie.ca.
	IN	NS	hh-ws02.hydrohomie.ca.
	IN	NS	hh-ws03.hydrohomie.ca.
	IN	NS	hh-ws04.hydrohomie.ca.

; name servers - A records
hh-dns01.hydrohomie.ca.		IN	A	192.168.122.11
hh-dns02.hydrohomie.ca.		IN	A	192.168.122.12
hh-ws01.hydrohomie.ca.		IN	A	192.168.122.21
hh-ws02.hydrohomie.ca.		IN	A	192.168.122.22
hh-ws03.hydrohomie.ca.		IN	A	192.168.122.23
hh-ws04.hydrohomie.ca.		IN	A	192.168.122.24

; 192.168.122.0/24 - A records
PILOT-SM0K3Y.hydrohomie.ca.	IN	A	192.168.122.117
```

### /etc/bind/zones/db.122.168.192
```bash
;
; BIND reverse data file for local loopback interface
;
$TTL	604800
@	IN	SOA	hh-dns01.hydrohomie.ca. admin.hydrohomie.ca. (
			      6		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
; name servers - NS records
	IN	NS	hh-dns01.hydrohomie.ca.
	IN	NS	hh-dns02.hydrohomie.ca.
	IN	NS	hh-ws01.hydrohomie.ca.
	IN	NS	hh-ws02.hydrohomie.ca.
	IN	NS	hh-ws03.hydrohomie.ca.
	IN	NS	hh-ws04.hydrohomie.ca.

; PTR Records
168.122.11	IN	PTR	hh-dns01.hydrohomie.ca.		;
168.122.12	IN	PTR	hh-dns02.hydrohomie.ca.		;
168.122.21	IN	PTR	hh-ws01.hydrohomie.ca.		;
168.122.22	IN	PTR	hh-ws02.hydrohomie.ca.		;
168.122.23	IN	PTR	hh-ws03.hydrohomie.ca.		;
168.122.24	IN	PTR	hh-ws04.hydrohomie.ca.		;
168.122.117	IN	PTR	PILOT-SM0K3Y.hydrohomie.ca.	;
```

## Configuration check commands
- confirm there's no errors or misconfigurations

### Check BIND configuration syntax
```bash
sudo named-checkconf
```

#### Example output
- if the configuration files have no syntax errors, there will be no output displayed

----------------------

### Check forward zone files
```bash
sudo named-checkzone hydrohomie.ca /etc/bind/zones/db.hydrohomie.ca
```

#### Example output
```bash
zone hydrohomie.ca/IN: loaded serial 7
OK
```

----------------------

### Check reverse zone files
```bash
sudo named-checkzone 122.168.192.in-addr.arpa /etc/bind/zones/db.122.168.192
```

#### Example output
```bash
zone 122.168.192.in-addr.arpa/IN: loaded serial 7
OK
```

