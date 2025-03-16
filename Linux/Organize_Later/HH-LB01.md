## Configure network settings

### /etc/netplan/50-cloud-init.yaml
```bash
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: false
      addresses:
        - 192.168.122.30/24
      nameservers:
        addresses: [192.168.122.11, 192.168.122.12]
        search: [ hydrohomie.ca ]
      routes:
        - to: default
          via: 192.168.122.1
    enp0s8:
      dhcp4: false
      addresses:
        - 172.16.31.1/24
```

### Enable packet forwarding for IPv4
- Uncomment the line in `/etc/sysctl.conf`

#### /etc/sysctl.conf
```bash
net.ipv4.ip_forward=1
```

### Verify
```bash
sudo sysctl -p
```
