---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
Locale: en-US
ms.date: 03/24/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_PSModulePath?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSModulePath
---
# about_PSModulePath

## Short description
This article describes the purpose and usage of the `$env:PSModulePath`
environment variable.

## Long description

The `$env:PSModulePath` environment variable contains a list of folder
locations that are searched to find modules and resources. PowerShell
recursively searches each folder for module (`.psd1` or `.psm1`) files.

`Install-Module` has a **Scope** parameter that allows you to specify whether
the module is installed for the current user or for all users. For more
information, see [Install-Module][01].

By default, the effective locations assigned to `$env:PSModulePath` are:

- **System-wide locations**: These folders contain modules that ship with
  PowerShell. These modules are stored in the `$PSHOME\Modules` folder. This is
  also the location where the Windows management modules are installed.

  Modules installed in the **AllUsers** scope are stored in
  `$env:ProgramFiles\WindowsPowerShell\Modules`.

- **User-installed modules**: These are modules installed in the
  **CurrentUser** scope. The location of the **CurrentUser** scope is typically
  the `$HOME\Documents\WindowsPowerShell\Modules` folder. The specific location
  of the `Documents` folder varies by version of Windows and when you use
  folder redirection. Also, Microsoft OneDrive can change the location of your
  `Documents` folder. You can verify the location of your `Documents` folder
  using the following command: `[Environment]::GetFolderPath('MyDocuments')`.

- **Application specific modules**: Setup programs can install modules in other
  directories, such as the `Program Files` directory. The installer may append
  the application location to the value of `$env:PSModulePath`.

## PowerShell PSModulePath construction

The value of `$env:PSModulePath` is constructed each time PowerShell starts.
The value varies by version of PowerShell and how it's launched.

### Windows PowerShell startup

Windows PowerShell uses the following logic to construct the `PSModulePath` at
startup:

- If `PSModulePath` doesn't exist, combine **CurrentUser**, **AllUsers**, and
  the `$PSHOME` modules paths
- If `PSModulePath` does exist:
  - If `PSModulePath` contains `$PSHOME` modules path:
    - **AllUsers** modules path is inserted before `$PSHOME` modules path
  - else:
    - Just use `PSModulePath` as defined since the user deliberately removed
      the `$PSHOME` location

The **CurrentUser** module path is prefixed only if the User scope
`$env:PSModulePath` doesn't exist. Otherwise, the User scope
`$env:PSModulePath` is used as defined.

## Module search behavior

PowerShell recursively searches each folder in the **PSModulePath** for module
(`.psd1` or `.psm1`) files. This search pattern allows multiple versions of the
same module to be installed in different folders. For example:

```Output
    Directory: C:\Program Files\WindowsPowerShell\Modules\PowerShellGet

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           8/14/2020  5:56 PM                1.0.0.1
d----           9/13/2019  3:53 PM                2.1.2
```

By default, PowerShell loads the highest version number of a module when
multiple versions are found. To load a specific version, use `Import-Module`
with the **FullyQualifiedName** parameter. For more information, see
[Import-Module][02].

## Modifying PSModulePath

For most situations, you should be installing modules in the default module
locations. However, you may have a need to change the value of the
`PSModulePath` environment variable.

For example, to temporarily add the `C:\Program Files\Fabrikam\Modules`
directory to `$env:PSModulePath` for the current session, type:

```powershell
$Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
```

To change the value of `PSModulePath` in every session, edit the registry key
storing the `PSModulePath` values. The `PSModulePath` values are stored in the
registry as _unexpanded_ strings. To avoid permanently saving the
`PSModulePath` values as _expanded_ strings, use the **GetValue** method on the
subkey and edit the value directly.

The following example adds the `C:\Program Files\Fabrikam\Modules` path to the
value of the `PSModulePath` environment variable without expanding the
un-expanded strings.

```powershell
$key = (Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager').OpenSubKey('Environment', $true)
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString)
```

To add a path to the user setting, change the registry provider from `HKLM:\`
to `HKCU:\`.

```powershell
$key = (Get-Item 'HKCU:\').OpenSubKey('Environment', $true)
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString)
```

## See also

- [about_Modules][03]

<!-- link references -->
[01]: xref:PowerShellGet.Install-Module
[02]: xref:Microsoft.PowerShell.Core.Import-Module
[03]: about_Modules.md
