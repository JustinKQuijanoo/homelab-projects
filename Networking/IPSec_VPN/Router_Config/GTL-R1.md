## GTL-R1
```Cisco
conf t
int l0
ip add 1.1.1.1 255.255.255.255

int g1/0
no shut
ip add 10.1.0.1 255.255.255.0

int g0/0
no shut
ip add 172.16.31.2 255.255.255.0

router ospf 1
router-id 1.1.1.1
network 1.1.1.1 0.0.0.0 area 0
network 10.1.0.0 0.0.0.255 area 0
network 172.16.31.0 0.0.0.255 area 0

do wri mem



do copy run start



```

