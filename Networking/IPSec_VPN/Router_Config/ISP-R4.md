## ISP-R4

```Cisco
conf t
int l0
ip add 4.4.4.4 255.255.255.255

int g0/0
no shut
ip add 76.9.128.13 255.255.255.252

int g1/0
no shut
ip add 56.2.11.34 255.255.255.252

router ospf 1
router-id 4.4.4.4
network 4.4.4.4 0.0.0.0 area 0
network 76.9.128.12 0.0.0.3 area 0
network 56.2.11.32 0.0.0.3 area 0

do wri mem



do copy run start



```


