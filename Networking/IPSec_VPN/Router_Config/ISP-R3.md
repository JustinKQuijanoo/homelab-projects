# ISP-R3

## Complete configuration
```Cisco
configure terminal 

hostname ISP-R3

access-list 100 deny ip 10.0.0.0 0.255.255.255 10.70.140.0 0.0.0.255
access-list 100 permit ip any any

interface Loopback0
ip address 3.3.3.3 255.255.255.255

interface GigabitEthernet0/0
ip address 23.0.1.1 255.255.255.252
ip access-group 100 in
description Connection to GTL-R2
no shut

interface GigabitEthernet1/0
ip address 76.9.128.14 255.255.255.252
description Connection to ISP-R4
no shut

router ospf 1
router-id 3.3.3.3
network 3.3.3.3 0.0.0.0 area 0
network 76.9.128.12 0.0.0.3 area 0

router bgp 21949
neighbor 23.0.1.2 remote-as 10101
neighbor 23.0.1.2 next-hop-self
neighbor 76.9.128.13 remote-as 21949
neighbor 76.9.128.13 next-hop-self
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

