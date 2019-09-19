---
ms.date:  09/19/2019
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

## Get the latest version from PowerShell Gallery

Before updating **PowerShellGet**, you should always install the latest **NuGet** provider. From an
elevated PowerShell session, run the following command.

```powershell
Install-PackageProvider -Name NuGet -Force
Exit
```

### For systems with PowerShell 5.0 (or newer) you can install the latest PowerShellGet

To install PowerShellGet on Windows 10, Windows Server 2016, any system with WMF 5.0 or 5.1
installed, or any system with PowerShell 6, run the following commands from an elevated PowerShell
session.

```powershell
Install-Module -Name PowerShellGet -Force
Exit
```

Use `Update-Module` to get newer versions.

```powershell
Update-Module -Name PowerShellGet
Exit
```

### For computers running PowerShell 3.0 or PowerShell 4.0

These instructions apply to computers that have the **PackageManagement Preview** installed or don't
have any version of **PowerShellGet** installed.

#### Computers with the PackageManagement Preview installed

1. From a PowerShell session, use `Save-Module` to save the modules to a local directory.

   ```powershell
   Save-Module -Name PowerShellGet -Path C:\LocalFolder
   ```

1. Ensure that the **PowerShellGet** and **PackageManagement** modules aren't loaded in any other
   processes.
1. Delete the contents of the folders: `$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\`
   and `$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\`.
1. Reopen the PowerShell console with elevated permissions and run the following commands.

   ```powershell
   Copy-Item "C:\LocalFolder\PowerShellGet\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\" -Recurse -Force
   Copy-Item "C:\LocalFolder\PackageManagement\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\" -Recurse -Force
   ```

#### Computers without PowerShellGet

For a computer that doesn't have any version of **PowerShellGet** installed, you can download it from the [PowerShell Gallery](https://www.powershellgallery.com/).
You'll need a computer that has **PowerShellGet** installed.

1. From a computer that has **PowerShellGet** installed, download the current version of
   **PowerShellGet**. Two folders are downloaded: **PowerShellGet** and **PackageManagement**. Each
   folder contains a subfolder with a version number.

   For more information, see [Save-Module](/powershell/module/PowershellGet/Save-Module).

   ```powershell
   Save-Module -Name PowerShellGet -Path C:\LocalFolder
   ```

1. Copy the **PowerShellGet** and **PackageManagement** folders to the computer that doesn't have
   **PowerShellGet** installed.

   The destination directory is: `$env:ProgramFiles\WindowsPowerShell\Modules`
