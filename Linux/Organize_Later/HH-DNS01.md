# Install BIND9 
```bash
sudo apt install \
	bind9 \
	bind9utils \
	bind9-doc -y
```

## /etc/bind/named.conf.options
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
