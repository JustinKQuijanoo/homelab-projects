# Install PowerShell

## Update system
```bash
sudo apt update -y
```


## Install prerequisite packages
```bash
sudo apt install -y \
    wget \
    apt-transport-https \
    software-properties-common
```


## Download Microsoft repository GPG keys
```bash
wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
```

## Register Microsoft repository GPG keys
```bash
sudo dpkg -i packages-microsoft-prod.deb
```

## Update system again
```bash
sudo apt update -y
```


## Enable universe repositories
```bash
sudo add-apt-repository universe
```

## Install PowerShell
```bash
sudo apt install powershell
```

## Start PowerShell
```bash
pwsh
```

