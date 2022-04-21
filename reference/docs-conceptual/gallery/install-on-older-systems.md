---
description: This article explains how to install the PowerShellGet module in older versions of PowerShell.
ms.date: 04/21/2022
title: Installing PowerShellGet on older Windows systems
---
# Installing PowerShellGet on older Windows systems

Older versions of Windows shipped with different versions of PowerShell. The **PowerShellGet**
module requires **PowerShell 3.0 or newer**.

**PowerShellGet** requires .NET Framework 4.5 or above. For more information, see
[Install the .NET Framework for developers](/dotnet/framework/install/guide-for-developers).

[!INCLUDE [TLS 1.2 Requirements](../../includes/tls-gallery.md)]

## For computers running PowerShell 3.0 or PowerShell 4.0

These instructions apply to computers that have the **PackageManagement Preview** installed or don't
have any version of **PowerShellGet** installed.

The `Save-Module` cmdlet is used in both sets of instructions. `Save-Module` downloads and saves a
module and any dependencies from a registered repository. The module's most current version is saved
to a specified path on the local computer, but isn't installed. To install the modules in PowerShell
3.0 or 4.0, copy the saved module folders to `$env:ProgramFiles\WindowsPowerShell\Modules`.

For more information, see [Save-Module](/powershell/module/PowershellGet/Save-Module).

> [!NOTE]
> PowerShell 3.0 and PowerShell 4.0 only supported one version of a module. Starting in PowerShell
> 5.0, modules are installed in `<modulename>\<version>`. This allows you to install
> multiple versions side-by-side. After downloading the module using `Save-Module` you must copy the
> files from the `<modulename>\<version>` to the `<modulename>` folder on the destination machine,
> as shown in the instructions below.

### Preparatory Step on computers running PowerShell 3.0

The instructions in the sections below install the modules in directory
`$env:ProgramFiles\WindowsPowerShell\Modules`. In PowerShell 3.0, this directory isn't listed in
`$env:PSModulePath` by default, so you'll need to add it in order for the modules to be auto-loaded.

Open an elevated PowerShell session and run the following command:

```powershell
[Environment]::SetEnvironmentVariable(
  'PSModulePath',
  ((([Environment]::GetEnvironmentVariable('PSModulePath', 'Machine') -split ';') + "$env:ProgramFiles\WindowsPowerShell\Modules") -join ';'),
  'Machine'
)
```

The updated value of `$env:PSModulePath` is not available in the current session. You must open a
new PowerShell session.

### For computers with the PackageManagement Preview installed

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
