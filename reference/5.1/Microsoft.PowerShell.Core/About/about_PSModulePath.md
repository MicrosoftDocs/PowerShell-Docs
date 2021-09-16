---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
Locale: en-US
ms.date: 09/16/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_PSModulePath?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about PSModulePath
---
# about_PSModulePath

The `$env:PSModulePath` environment variable contains a list of folder
locations that are searched to find modules and resources. PowerShell
recursively searches each folder for module (`.psd1` or `.psm1`) files.

By default, the effective locations assigned to `$env:PSModulePath` are:

- System-wide locations: These folders contain modules that ship with
  PowerShell. These modules are store in the `$PSHOME\Modules` folder. This is
  also the location where the Windows management modules are installed.

- User-installed modules: These are modules installed by the user.
  `Install-Module` has a **Scope** parameter that allows you to specify
  whether the module is installed for the current user or for all users. For
  more information, see
  [Install-Module](xref:PowerShellGet.Install-Module).

  - On Windows, the location of the user-specific **CurrentUser** scope is
    the `$HOME\Documents\WindowsPowerShell\Modules` folder. The location of the
    **AllUsers** scope is `$env:ProgramFiles\WindowsPowerShell\Modules`.

In addition, setup programs that install modules in other directories, such
as the Program Files directory, can append their locations to the value of
`$env:PSModulePath`.

> [!NOTE]
> On Windows, the user-specific location is the `WindowsPowerShell\Modules`
> folder located in the **Documents** folder in your user profile. The specific
> path of that location varies by version of Windows and whether or not you are
> using folder redirection. Microsoft OneDrive can also change the location of
> your **Documents** folder. You can verify the location of your **Documents**
> folder using the following command:
> `[Environment]::GetFolderPath('MyDocuments')`.

## PowerShell PSModulePath construction

The value of `$env:PSModulePath` is constructed each time PowerShell starts.
The value varies by version of PowerShell and how it is launched.

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

The **CurrentUser** module path is prefixed only if User scope
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
[Import-Module](xref:Microsoft.PowerShell.Core.Import-Module).

## Modifying PSModulePath

For most situations, you should be installing modules in the default module locations. However, you may have a need to change the value of the `PSModulePath` environment variable.

For example, to temporarily add the `C:\Program Files\Fabrikam\Modules` directory to `$env:PSModulePath` for the current session, type:

```powershell
$Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
```

To change the value of `PSModulePath` in every session, edit the registry key
storing the `PSModulePath` values. The `PSModulePath` values are stored in the
registry as **un-expanded** strings. To avoid permanently saving the
`PSModulePath` values as **expanded** strings, use the **GetValue** method on
the sub-key and edit the value directly.

The following example adds the `C:\Program Files\Fabrikam\Modules` path to the
value of the `PSModulePath` environment variable without expanding the
un-expanded strings.

```powershell
$key = (Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager').OpenSubKey('Environment', $true)
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';C:\Program Files\Fabrikam\Modules' # or '%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString)
```

To add a path to the user setting, change the registry provider from `HKLM:\`
to `HKCU:\`.

```powershell
$key = (Get-Item 'HKCU:\SYSTEM\CurrentControlSet\Control\Session Manager').OpenSubKey('Environment', $true)
$path = $key.GetValue('PSModulePath','','DoNotExpandEnvironmentNames')
$path += ';C:\Program Files\Fabrikam\Modules' # or '%ProgramFiles%\Fabrikam\Modules'
$key.SetValue('PSModulePath',$path,[Microsoft.Win32.RegistryValueKind]::ExpandString))
```

## See also

- [about_Modules](about_Modules.md)
