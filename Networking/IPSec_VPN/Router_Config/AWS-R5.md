## AWS-R5

```Cisco 
conf t
int l0
ip add 5.5.5.5 255.255.255.255

int g0/0
no shut
ip add 56.2.11.33 255.255.255.252

int g1/0
no shut
ip add 10.70.140.1 255.255.255.0

router ospf 1
router-id 5.5.5.5
network 5.5.5.5 0.0.0.0 area 0
network 10.70.140.0 0.0.0.255 area 0
network 56.2.11.32 0.0.0.3 area 0

do wri mem



do copy run start




```

## IPSec Config
```Cisco
conf t

crypto isakmp policy 1
authentication pre-share

crypto isakmp key hydrohomie address 23.0.1.2

```

### Access List for LAN traffic
```Cisco
access-list 100 permit ip 10.70.140.0 0.0.0.255 10.0.0.0 0.255.255.255
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
set peer 23.0.1.2
match address 100
exit
```


### Apply crypto map to interface
```Cisco
int g0/0
crypto map CMAP
end
```

### Verification commands
```Cisco
show crypto map
```
