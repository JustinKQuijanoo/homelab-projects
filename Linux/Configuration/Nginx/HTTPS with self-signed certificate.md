## Objectives
- Configure HTTPS using self-signed certificate

## `/etc/`
- Two directories where configuration changes are needed
    - `/etc/nginx`: Nginx files
    - `/etc/ssl`: SSL/TLS files 

## `/etc/ssl`
- List the default files and folders
```bash
/etc/ssl$ ls
certs  openssl.cnf  private
```

- Create a folder to store `nginx` certificates
```bash
/etc/ssl$ sudo mkdir nginx 

/etc/ssl$ ls
certs  nginx  openssl.cnf  private
```

### Create certificate and sign with private key

## `/etc/nginx/sites-available/default`
```bash
# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        include snippets/self-signed.conf;
        include snippets/ssl-params.conf;
        server_name hydrohomie.ca www.hydrohomie.ca;
```

## Test Nginx config files
```bash
sudo nginx -t
```

- Output should be similar to below
```bash
/etc/nginx/sites-available$ sudo nginx -t
nginx: [warn] "ssl_stapling" ignored, issuer certificate not found for certificate "/etc/ssl/nginx/nginx-selfsigned.crt"
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
