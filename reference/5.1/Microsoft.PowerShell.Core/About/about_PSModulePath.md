---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
Locale: en-US
ms.date: 10/14/2024
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
locations. PowerShell recursively searches each folder for module (`.psd1` or
`.psm1`) files.

By default, the effective locations assigned to `$env:PSModulePath` are:

- Modules installed in the **CurrentUser** scope are stored in
  `$HOME\Documents\WindowsPowerShell\Modules`.
- Modules installed in the **AllUsers** scope are stored in
  `$env:ProgramFiles\WindowsPowerShell\Modules`.
- Modules that ship with Windows PowerShell stored in `$PSHOME\Modules`, which
  is `$env:SystemRoot\System32\WindowsPowerShell\1.0\Modules`.

## PowerShell PSModulePath construction

The value of `$env:PSModulePath` is constructed each time PowerShell starts.
The value varies by version of PowerShell and how you launched it.

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
[Import-Module][03].

## Modifying PSModulePath

For most situations, you should be installing modules in the default module
locations. However, you might need to change the value of the `PSModulePath`
environment variable.

For example, to temporarily add the `C:\Program Files\Fabrikam\Modules`
directory to `$env:PSModulePath` for the current session, type:

```powershell
$Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
```

To change the value of `PSModulePath` in every session, edit the registry key
storing the `PSModulePath` values. The `PSModulePath` values are stored in the
registry as _unexpanded_ strings. To avoid permanently saving the
`PSModulePath` values as _expanded_ strings, use the `GetValue()` method on the
subkey and edit the value directly.

The following example adds the `C:\Program Files\Fabrikam\Modules` path to the
value of the `PSModulePath` environment variable without expanding the
unexpanded strings.

```powershell
$key = (Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment')
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString)
```

To add a path to the user setting, use the following code:

```powershell
$key = (Get-Item 'HKCU:\Environment')
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString)
```

## See also

- [about_Modules][01]
- [about_Windows_PowerShell_Compatibility][02]

<!-- link references -->
[01]: about_Modules.md
[02]: /powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility
[03]: xref:Microsoft.PowerShell.Core.Import-Module
