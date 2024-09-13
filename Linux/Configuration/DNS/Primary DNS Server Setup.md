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


