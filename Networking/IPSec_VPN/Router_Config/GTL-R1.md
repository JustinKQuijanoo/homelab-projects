# GTL-R1

## Complete configuration
```Cisco
configure terminal

hostname GTL-R1

interface Loopback0
ip address 1.1.1.1 255.255.255.255

interface GigabitEthernet0/0
ip address 172.16.31.2 255.255.255.0
description Connection to LAN1
no shut

interface GigabitEthernet1/0
ip address 10.1.0.1 255.255.255.0
description Connection to GTL-R2
no shut

ip route 0.0.0.0 0.0.0.0 172.16.31.1

router ospf 1
router-id 1.1.1.1
network 1.1.1.1 0.0.0.0 area 0
network 10.1.0.0 0.0.0.255 area 0
network 172.16.31.0 0.0.0.255 area 0

router bgp 10101
neighbor 172.16.31.2 remote-as 10101
neighbor 172.16.31.2 next-hop-self
```

