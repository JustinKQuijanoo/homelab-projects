## GTL-R2

## Complete Configuration
```Cisco
configure terminal

hostname GTL-R2

crypto isakmp policy 1 
authentication pre-share 
crypto isakmp key Hydrohomie address 56.2.11.33 

crypto ipsec transform-set TSET esp-aes esp-sha-hmac

crypto map CMAP 1 ipsec-isakmp
set peer 56.2.11.33
set transform-set TSET
match address 100

access-list 100 permit ip 10.0.0.0 0.255.255.255 10.70.140.0 0.0.0.255

interface Loopback0
ip address 2.2.2.2 255.255.255.255

interface GigabitEthernet0/0
ip address 172.16.31.1 255.255.255.0
no shut

interface GigabitEthernet1/0
ip address 23.0.1.2 255.255.255.252
crypto map CMAP
no shut

interface GigabitEthernet2/0
ip address 10.4.0.1 255.255.255.0
no shut

router ospf 1
router-id 2.2.2.2
network 2.2.2.2 0.0.0.0 area 0
network 10.4.0.0 0.0.0.255 area 0
network 172.16.31.0 0.0.0.255 area 0

router bgp 10101
network 10.1.0.0 mask 255.255.255.0
neighbor 23.0.1.1 remote-as 21949
neighbor 23.0.1.1 next-hop-self
neighbor 172.16.31.2 remote-as 10101
neighbor 172.16.31.2 next-hop-self
```

## IPSec Config
```Cisco
conf t

crypto isakmp policy 1
authentication pre-share

crypto isakmp key hydrohomie address 56.2.11.33

```

### Access List for LAN traffic
```Cisco
access-list 100 permit ip 10.0.0.0 0.255.255.255 10.70.140.0 0.0.0.255
```

### Create transform set
```Cisco
crypto ipsec transform-set TSET esp-sha-hmac esp-aes
exit

```

### Create crypto map
```Cisco
crypto map CMAP 1 ipsec-isakmp
set transform-set TSET
set peer 56.2.11.33
match address 100
exit
```


### Apply crypto map to interface
```Cisco
int g1/0
crypto map CMAP
end
```

### Verification commands
```Cisco
show crypto map
```

### `show crypto map` output
```Cisco
GTL-R2#show crypto map
Crypto Map IPv4 "CMAP" 1 ipsec-isakmp
        Peer = 56.2.11.33
        Extended IP access list 100
            access-list 100 permit ip 10.0.0.0 0.255.255.255 10.70.140.0 0.0.0.255
        Current peer: 56.2.11.33
        Security association lifetime: 4608000 kilobytes/3600 seconds
        Responder-Only (Y/N): N
        PFS (Y/N): N
        Transform sets={
                TSET:  { esp-aes esp-sha-hmac  } ,
        }
        Interfaces using crypto map CMAP:
                GigabitEthernet1/0

```
