## ISP-R3

```Cisco
conf t
int l0
ip add 3.3.3.3 255.255.255.255

int g0/0
no shut
ip add 23.0.1.1 255.255.255.252

int g1/0
no shut
ip add 76.9.128.14 255.255.255.252

router ospf 1
router-id 3.3.3.3
network 3.3.3.3 0.0.0.0 area 0
network 23.0.1.0 0.0.0.3 area 0
network 76.9.128.12 0.0.0.3 area 0

do wri mem



do copy run start



```

## ACL to block RFC 1918 addresses
```Cisco
conf t

access-list 100 deny ip 10.0.0.0 0.255.255.255 10.70.140.0 0.0.0.255
access-list 100 permit ip any any

int g0/0
ip access-group 100 in

show access-lists 100

show ip interface g0/0

```

