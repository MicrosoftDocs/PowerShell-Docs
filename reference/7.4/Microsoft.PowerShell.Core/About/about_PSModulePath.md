---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
Locale: en-US
ms.date: 10/14/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_PSModulePath?view=powershell-7.4&WT.mc_id=ps-gethelp
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

- Modules installed in the **CurrentUser** scope:
  - On Windows, these modules are stored in
    `$HOME\Documents\PowerShell\Modules`. The specific location of the
    `Documents` folder varies by version of Windows and when you use folder
    redirection. Also, Microsoft OneDrive can change the location of your
    `Documents` folder. To verify the location of your `Documents` folder, run
    use the following command: `[Environment]::GetFolderPath('MyDocuments')`.
  - On non-Windows systems, these modules are stored in the
    `$HOME/.local/share/powershell/Modules` folder.
- Modules installed in the **AllUsers** scope:
  - On Windows, these modules are stored in
    `$env:ProgramFiles\PowerShell\Modules`.
  - On non-Windows systems, these modules are stored in
    `/usr/local/share/powershell/Modules`.
- Modules that ship with PowerShell are stored in `$PSHOME\Modules`.

> [!NOTE]
> Applications that include PowerShell modules can install modules in other
> directories on Windows, such as the `Program Files` folder. The installer
> package might not append the location to the `$env:PSModulePath`.

The default locations for Windows PowerShell 5.1 are different from PowerShell
7.

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

### PowerShell 7 startup

In Windows, for most environment variables, if the User-scoped variable exists,
a new process uses that value only, even when a Machine-scoped variable of the
same name exists. The _path_ environment variables are treated differently.

On Windows, `PSModulePath` is treated similar to how the `Path`
environment variable is treated. `Path` is treated differently from other
environment variables. When a process is started, Windows combines the
User-scoped `Path` with the Machine-scoped `Path`.

- Retrieve the User-scoped `PSModulePath`
- Compare to process inherited `PSModulePath` environment variable
  - If the same:
    - Append the **AllUsers** `PSModulePath` to the end following the semantics
      of the `Path` environment variable
    - The Windows `System32` path comes from the machine defined `PSModulePath`
      so doesn't need to be added explicitly
  - If different, treat as though user explicitly modified it and don't append
    **AllUsers** `PSModulePath`
- Prefix with PS7 User, System, and `$PSHOME` paths in that order
  - If `powershell.config.json` contains a user scoped `PSModulePath`, use that
    instead of the default for the user
  - If `powershell.config.json` contains a system scoped `PSModulePath`, use
    that instead of the default for the system

Non-Windows systems don't have a separation of User and System environment
variables. `PSModulePath` is inherited and the PS7-specific paths are prefixed
if not already defined.

### Starting Windows PowerShell from PowerShell 7

For this discussion, _Windows PowerShell_ means both `powershell.exe` and
`powershell_ise.exe`.

The value of `$env:PSModulePath` is copied to `WinPSModulePath` with the
following modifications:

- Remove PS7 the User module path
- Remove PS7 the System module path
- Remove PS7 the `$PSHOME` module path

The PS7 paths are removed so that PS7 modules don't get loaded in Windows
PowerShell. The `WinPSModulePath` value is used when starting Windows
PowerShell.

### Starting PowerShell 7 from Windows PowerShell

The PowerShell 7 startup continues as-is with the addition of inheriting paths
that Windows PowerShell added. Since the PS7-specific paths are prefixed,
there's no functional issue.

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

The semi-colon (`;`) in the command separates the new path from the path that
precedes it in the list. On non-Windows platforms, the colon (`:`) separates
the path locations in the environment variable.

### Modifying PSModulePath in non-Windows

To change the value of `PSModulePath` for every session in a non-Windows
environment, add the previous command to your PowerShell profile.

### Modifying PSModulePath in Windows

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
