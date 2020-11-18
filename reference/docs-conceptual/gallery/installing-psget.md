---
ms.date:  09/19/2019
title:  Installing PowerShellGet
description: This article explains how to install the PowerShellGet module in various versions of PowerShell.
---
# Installing PowerShellGet

## PowerShellGet is an in-box module in the following releases

- [Windows 10](https://www.microsoft.com/windows) or newer
- [Windows Server 2016](/windows-server/windows-server) or newer
- [Windows Management Framework (WMF) 5.0](https://www.microsoft.com/download/details.aspx?id=50395)
  or newer
- [PowerShell 6](https://github.com/PowerShell/PowerShell/releases)

## Get the latest version from PowerShell Gallery

Before updating **PowerShellGet**, you should always install the latest **NuGet** provider. From an
elevated PowerShell session, run the following command.

```powershell
Install-PackageProvider -Name NuGet -Force
```

[!INCLUDE [TLS 1.2 Requirements](../../includes/tls-gallery.md)]

### For systems with PowerShell 5.0 (or newer) you can install the latest PowerShellGet

To install PowerShellGet on Windows 10, Windows Server 2016, any system with WMF 5.0 or 5.1
installed, or any system with PowerShell 6, run the following commands from an elevated PowerShell
session.

```powershell
Install-Module -Name PowerShellGet -Force
```

Use `Update-Module` to get newer versions.

```powershell
Update-Module -Name PowerShellGet
Exit
```

### For computers running PowerShell 3.0 or PowerShell 4.0

These instructions apply to computers that have the **PackageManagement Preview** installed or don't
have any version of **PowerShellGet** installed.

The `Save-Module` cmdlet is used in both sets of instructions. `Save-Module` downloads and saves a
module and any dependencies from a registered repository. The module's most current version is saved
to a specified path on the local computer, but isn't installed. To install the modules in PowerShell
3.0 or 4.0, copy the module saved folders to `$env:ProgramFiles\WindowsPowerShell\Modules`.

For more information, see
[Save-Module](/powershell/module/PowershellGet/Save-Module).

> [!NOTE]
> PowerShell 3.0 and PowerShell 4.0 only supported one version of a module. Starting in PowerShell
> 5.0, modules are installed in `<modulename>\<version>`. This allows you to install
> multiple versions side-by-side. After downloading the module using `Save-Module` you must copy the
> files from the `<modulename>\<version>` to the `<modulename>` folder on the destination machine,
> as shown in the instructions below.

#### Preparatory Step on computers running PowerShell 3.0

The instructions in the sections below install the modules in directory
`$env:ProgramFiles\WindowsPowerShell\Modules`. In PowerShell 3.0, this directory isn't listed in
`$env:PSModulePath` by default, so you'll need to add it in order for the modules to be auto-loaded.

Open an elevated PowerShell session and run the following command (which will take effect in future
sessions):

```powershell
[Environment]::SetEnvironmentVariable(
  'PSModulePath',
  ((([Environment]::GetEnvironmentVariable('PSModulePath', 'Machine') -split ';') + "$env:ProgramFiles\WindowsPowerShell\Modules") -join ';'),
  'Machine'
)
```

#### Computers with the PackageManagement Preview installed

> [!NOTE]
> PackageManagement Preview was a downloadable component that made PowerShellGet available to
> PowerShell versions 3 and 4, but it is no longer available. To test if it was installed on a given
> computer, run `Get-Module -ListAvailable PowerShellGet`.

1. From a PowerShell session, use `Save-Module` to download the current version of
   **PowerShellGet**. Two folders are downloaded: **PowerShellGet** and **PackageManagement**. Each
   folder contains a subfolder with a version number.

   ```powershell
   Save-Module -Name PowerShellGet -Path C:\LocalFolder -Repository PSGallery
   ```

1. Ensure that the **PowerShellGet** and **PackageManagement** modules aren't loaded in any other
   processes.

1. Reopen the PowerShell console with elevated permissions and run the following command.

   ```powershell
   'PowerShellGet', 'PackageManagement' | % {
     $targetDir = "$env:ProgramFiles\WindowsPowerShell\Modules\$_"
     Remove-Item $targetDir\* -Recurse -Force
     Copy-Item C:\LocalFolder\$_\*\* $targetDir\ -Recurse -Force
   }
   ```

#### Computers without PowerShellGet

For computers without any version of **PowerShellGet** installed (test with
`Get-Module -ListAvailable PowerShellGet`), a computer with **PowerShellGet** installed is needed to
download the modules.

1. From the computer that has **PowerShellGet** installed, use `Save-Module` to download the current
   version of **PowerShellGet**. Two folders are downloaded: **PowerShellGet** and
   **PackageManagement**. Each folder contains a subfolder with a version number.

   ```powershell
   Save-Module -Name PowerShellGet -Path C:\LocalFolder -Repository PSGallery
   ```

1. Copy the respective `<version>` subfolder in the **PowerShellGet** and **PackageManagement**
   folders to the computer that doesn't have **PowerShellGet** installed, into folders
   `$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\` and
   `$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\` respectively, which requires an
   elevated session.

1. For instance, if you can access the download folder on the other computer, say `ws1`, from the
   target computer via a UNC path, say `\\ws1\C$\LocalFolder`, open a PowerShell console with
   elevated permissions and run the following command:

   ```powershell
   'PowerShellGet', 'PackageManagement' | % {
     $targetDir = "$env:ProgramFiles\WindowsPowerShell\Modules\$_"
     $null = New-Item -Type Directory -Force $targetDir
     $fromComputer = 'ws1'  # Specify the name of the other computer here.
     Copy-Item \\$fromComputer\C$\LocalFolder\$_\*\* $targetDir -Recurse -Force
     if (-not (Get-ChildItem $targetDir)) { Throw "Copying failed." }
   }
   ```
