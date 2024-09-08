## Objectives
- Install KVM

## Update and Upgrade
```bash
sudo apt update -y && sudo apt upgrade -y
```

## Check if virtualization is enabled
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo 
```
- Output greater than `0` means it's enabled and compatible


## Verify if KVM is enabled
- Requires `cpu-checker` to be installed
    - `sudo apt install cpu-checker -y`
```bash
kvm-ok
```


## Install KVM and related packages
```bash
sudo apt install \ 
    qemu-kvm \
    virt-manager \
    libvirt-daemon-system \
    virtinst \ 
    libvirt-clients \
    bridge-utils -y
```

## Manage `libvirtd` service

### Enable service
```bash
sudo systemctl enable libvirtd
```

### Start service
```bash
sudo systemctl start libvirtd
```

### Check service status
```bash
sudo systemctl status libvirtd 
```

## Add user to `KVM` and `libvirt` groups
```bash
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```
