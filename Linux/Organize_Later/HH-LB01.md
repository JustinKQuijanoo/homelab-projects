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
- Uncomment the line below in `/etc/sysctl.conf`

#### /etc/sysctl.conf
```bash
net.ipv4.ip_forward=1
```

-----------------------

### Verify
```bash
sudo sysctl -p
```

## Nginx - load balancer configuration

### /etc/nginx/sites-available/hydrohomie.ca
```bash
# NGINX Load balancer

http {
        upstream web_servers {
                least_conn; # requests are sent to the server with least active connections
                server 172.16.31.21 slow_start=30s;
                server 172.16.31.22;
        }
}

server {
        listen 8080;
        server_name hydrohomie.ca www.hydrohomie.ca;

        location / {
                proxy_pass http://web_servers;
                proxy_set_header HOST $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
        }
}
```

### Link `sites-available` to `sites-enabled`
```bash
sudo ln -s /etc/nginx/sites-available/hydrohomie.ca /etc/nginx/sites-enabled/hydrohomie.ca
```

### Test nginx configuration
```bash
service nginx configtest
```
