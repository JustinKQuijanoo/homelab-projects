# Install Azure PowerShell

## Prerequisites
- Install [PowerShell](PowerShell.md)
- Open PowerShell in the terminal using `pwsh`

## Install Azure PowerShell
```PowerShell
Install-Module -Name Az -Repository PSGallery -Force
```

## Update Azure PowerShell module 
```PowerShell
Update-Module -Name Az -Force
```

## Login to Azure 
```PowerShell
Connect-AzAccount
```
