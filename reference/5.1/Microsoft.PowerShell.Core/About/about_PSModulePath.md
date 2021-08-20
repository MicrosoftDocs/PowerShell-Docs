---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
Locale: en-US
ms.date: 08/20/2021
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

## Modifying PSModulePath

To change the default module directories for the current session, use the
following command format to change the value of the `PSModulePath`
environment variable.

For example, to add the `C:\Program Files\Fabrikam\Modules` directory to
the value of the PSModulePath environment variable, type:

```powershell
$Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
```

The semi-colon (`;`) in the command separates the new path from the path that
precedes it in the list. On non-Windows platforms, the colon (`:`) separates
the path locations in the environment variable.

To change the value of `PSModulePath` in every session, add the previous
command to your PowerShell profile or use the **SetEnvironmentVariable**
method of the **Environment** class.

The following command uses the **GetEnvironmentVariable** method to get the
machine setting of `PSModulePath` and the **SetEnvironmentVariable** method
to add the `C:\Program Files\Fabrikam\Modules` path to the value.

```powershell
$path = [Environment]::GetEnvironmentVariable('PSModulePath', 'Machine')
$newpath = $path + ';C:\Program Files\Fabrikam\Modules'
[Environment]::SetEnvironmentVariable('PSModulePath', $newpath, 'Machine')
```

To add a path to the user setting, change the target value to **User**.

```powershell
$path = [Environment]::GetEnvironmentVariable('PSModulePath', 'User')
$newpath = $path + ';C:\Program Files\Fabrikam\Modules'
[Environment]::SetEnvironmentVariable('PSModulePath', $newpath, 'User')
```

For more information about the methods of the **System.Environment** class, see
[Environment Methods](/dotnet/api/system.environment).

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

## See also

- [about_Modules](about_Modules.md)
- [Environment Methods](/dotnet/api/system.environment)
