# ISP-R4

## Complete configuration
```Cisco
configure terminal

hostname ISP-R4

interface Loopback0
ip address 4.4.4.4 255.255.255.255

interface GigabitEthernet0/0
ip address 76.9.128.13 255.255.255.252
description Connection to ISP-R3
no shut

interface GigabitEthernet1/0
ip address 56.2.11.34 255.255.255.252
description Connection to AWS-R5
no shut

router ospf 1
router-id 4.4.4.4
network 4.4.4.4 0.0.0.0 area 0
network 76.9.128.12 0.0.0.3 area 0

```


