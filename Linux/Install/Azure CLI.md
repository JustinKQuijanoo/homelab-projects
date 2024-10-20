# Azure CLI

- Download Azure CLI 

- Authenticate to Microsoft account

Tested on:
    - Linux mint 21.2 (Victoria)
    - Ubuntu 22.04 (Jammy Jellyfish)

## Install 
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### Authenticate to Microsoft account
```Azure CLI
az login
```

### Confirm Azure subscription
```Azure CLI
az account show
```

### Find `subscription_id`
```bash
az account list | grep -e id -e name
```
