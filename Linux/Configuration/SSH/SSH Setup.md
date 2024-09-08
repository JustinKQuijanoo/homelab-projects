## Objectives
- Install OpenSSH (Client or Server)
- Create SSH key pair
- Copy key to remote Server

## Install OpenSSH (Client or Server)
```bash
sudo apt install openssh-client -y
sudo apt install openssh-server -y
```

## Create SSH key pair
```bash
ssh-keygen -t ed25519 -C "SSH key"
```
- **-t** = Type of key 
- **-C** = Comment

## Copy key to remote Server
```bash
ssh-copy-id -i ~/.ssh/<SSH key.pub> <Server IP>
```

