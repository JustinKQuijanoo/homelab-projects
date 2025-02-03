# GTL-R1
```Cisco
GTL-R1#configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
GTL-R1(config)#
GTL-R1(config)#hostname GTL-R1
GTL-R1(config)#
GTL-R1(config)#interface Loopback0
GTL-R1(config-if)#ip address 1.1.1.1 255.255.255.255
GTL-R1(config-if)#
GTL-R1(config-if)#interface GigabitEthernet0/0
GTL-R1(config-if)#ip address 172.16.31.2 255.255.255.0
GTL-R1(config-if)#description Connection to LAN1
GTL-R1(config-if)#no shut
GTL-R1(config-if)#
GTL-R1(config-if)#interface GigabitEthernet1/0
GTL-R1(config-if)#ip address 10.1.0.1 255.255.255.0
GTL-R1(config-if)#description Connection to GTL-R2
GTL-R1(config-if)#no shut
GTL-R1(config-if)#
GTL-R1(config-if)#ip route 0.0.0.0 0.0.0.0 172.16.31.1
GTL-R1(config)#
GTL-R1(config)#router ospf 1
GTL-R1(config-router)#router-id 1.1.1.1
GTL-R1(config-router)#network 1.1.1.1 0.0.0.0 area 0
GTL-R1(config-router)#network 10.1.0.0 0.0.0.255 area 0
GTL-R1(config-router)#network 172.16.31.0 0.0.0.255 area 0
GTL-R1(config-router)#
GTL-R1(config-router)#router bgp 10101
GTL-R1(config-router)#neighbor 172.16.31.1 remote-as 10101
GTL-R1(config-router)#neighbor 172.16.31.1 next-hop-self
GTL-R1(config-router)#end
GTL-R1#wri mem
Warning: Attempting to overwrite an NVRAM configuration previously written
by a different version of the system image.
Overwrite the previous NVRAM configuration?[confirm]
Building configuration...
[OK]
GTL-R1#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
GTL-R1#
```

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
neighbor 172.16.31.1 remote-as 10101
neighbor 172.16.31.1 next-hop-self
```
