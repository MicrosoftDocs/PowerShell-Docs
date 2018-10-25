---
ms.date:  06/12/2017
contributor:  manikb
keywords:  gallery,powershell,cmdlet,psget
title:  Installing PowerShellGet
---
# Installing PowerShellGet

## PowerShellGet is an in-box module in the following releases

- [Windows 10](https://www.microsoft.com/windows) or newer
- [Windows Server 2016](/windows-server/windows-server) or newer
- [Windows Management Framework (WMF) 5.0](https://www.microsoft.com/download/details.aspx?id=50395) or newer
- [PowerShell 6](https://github.com/PowerShell/PowerShell/releases)

## Get PowerShellGet module for PowerShell versions 3.0 and 4.0

- [PackageManagement MSI](https://www.microsoft.com/download/details.aspx?id=51451)

## Get the latest version from PowerShell Gallery

- Before updating PowerShellGet, you should always install the latest Nuget provider. To do that,
  run the following in an elevated PowerShell session.

  ```powershell
  Install-PackageProvider Nuget –Force
  Exit
  ```

### For systems with PowerShell 5.0 (or newer) you can install the latest PowerShellGet

- To do this on Windows 10, Windows Server 2016, any system with WMF 5.0 or 5.1 installed, or any system with PowerShell 6, run the following commands from an elevated PowerShell session.

  ```powershell
  Install-Module –Name PowerShellGet –Force
  Exit
  ```

- Use `Update-Module` to get newer versions.

  ```powershell
  Update-Module -Name PowerShellGet
  Exit
  ```

### For systems running PowerShell 3 or PowerShell 4, that have installed the [PackageManagement MSI](https://www.microsoft.com/download/details.aspx?id=51451)

- Use below PowerShellGet cmdlet from an elevated PowerShell session to save the modules to a local directory

  ```powershell
  Save-Module PowerShellGet -Path C:\LocalFolder
  Exit
  ```

- Ensure that PowerShellGet and PackageManagment modules are not loaded in any other processes.
- Delete contents of `$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\` and  `$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\` folders.
- Re-open the PS Console with elevated permissions then run the following commands.

  ```powershell
  Copy-Item "C:\LocalFolder\PowerShellGet\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\" -Recurse -Force
  Copy-Item "C:\LocalFolder\PackageManagement\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\" -Recurse -Force
  ```
