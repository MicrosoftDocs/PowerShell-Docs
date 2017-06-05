---
description:  
manager:  kriscv
ms.topic:  article
author:  tylerl0706
ms.prod:  powershell
keywords:  powershell,cmdlet,gallery
ms.date:  2017-6-3
contributor:  tylerl0706
title:  Get PowerShellGet Module
ms.technology:  powershell
---

Get PowerShellGet Module
========================

### PowerShellGet is an in-box module in the following releases
- [Windows 10](https://www.microsoft.com/en-us/windows/get-windows-10) or newer
- [Windows Server 2016](https://technet.microsoft.com/en-us/windows-server-docs/get-started/windows-server-2016) or newer
- [Windows Management Framework (WMF) 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) or newer
- [PowerShell 6.0.0-Alpha](https://github.com/PowerShell/PowerShell/releases)

### Get PowerShellGet module for PowerShell versions 3.0 and 4.0
- [PackageManagement MSI](http://go.microsoft.com/fwlink/?LinkID=746217&clcid=0x409) 

### Get the latest version from PowerShell Gallery

- Before updating PowerShellGet, you should always install the latest Nuget provider. To do that, run the following in an elevated PowerShell session.
```powershell
Install-PackageProvider Nuget –Force
Exit
```

#### For systems with PowerShell 5.0 (or newer) you can install both PowerShellGet 
- To do this on Windows 10, Windows Server 2016, or any system with WMF 5.0 or 5.1 installed, run the following commands from an elevated PowerShell session.
```powershell
Install-Module –Name PowerShellGet –Force
Exit
```

- Use Update-Module to get the next updated versions.
```powershell
Update-Module -Name PowerShellGet
Exit
```

#### For systems running PowerShell 3 or PowerShell 4, that have installed the [PackageManagement MSI](http://go.microsoft.com/fwlink/?LinkID=746217&clcid=0x409)

- Use below PowerShellGet cmdlet to save the modules to a local directory

```powershell
Save-Module PowerShellGet -Path C:\LocalFolder
Exit
```

- Re-open the PS Console then run the following commands

```powershell
Copy-Item "C:\LocalFolder\PowerShellGet\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\" -Recurse -Force
Copy-Item "C:\LocalFolder\PackageManagement\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\" -Recurse -Force
```