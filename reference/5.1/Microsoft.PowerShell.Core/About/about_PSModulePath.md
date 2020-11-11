---
description: The PSModulePath environment variable contains a list of folder locations that are searched to find modules and resources.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 11/11/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_PSModulePath?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSModulePath
---
# About PSModulePath

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
    the `$HOME\Documents\PowerShell\Modules` folder. The location of the
    **AllUsers** scope is `$env:ProgramFiles\PowerShell\Modules`.
  - On non-Windows systems, the location of the user-specific **CurrentUser**
    scope is the `$HOME/.local/share/powershell/Modules` folder. The location
    of the **AllUsers** scope is `/usr/local/share/powershell/Modules`.

In addition, setup programs that install modules in other directories, such
as the Program Files directory, can append their locations to the value of
`$env:PSModulePath`.

> [!NOTE]
> On Windows, the user-specific location is the `PowerShell\Modules` folder
> located in the **Documents** folder in your user profile. The specific path
> of that location varies by version of Windows and whether or not you are
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

### PowerShell Core 6 startup

PowerShell Core 6 doesn't use contents of `$env:PSModulePath` if it detects it
was started from PowerShell. It overwrites it with:

- **CurrentUser** modules path + **AllUsers** modules path + `$PSHOME` modules
  path + Windows PowerShell `$PSHOME` modules path.

### PowerShell 7 startup

In Windows, for most environment variables, if the User-scoped variable exists, a
new process uses that value only even if a Machine-scoped variable of the same
name exists.

In PowerShell 7, `PSModulePath` is treated similar to how the `Path`
environment variable is treated on Windows. On Windows, `Path` is treated
differently from other environment variables. When a process is started,
Windows combines the User-scoped `Path` with the Machine-scoped `Path`.

- Retrieve the User-scoped `PSModulePath`
- Compare to process inherited `PSModulePath` environment variable
  - If the same:
    - Append the **AllUsers** `PSModulePath` to the end following the semantics
      of the `Path` environment variable
    - The Windows `System32` path comes from the machine defined `PSModulePath`
      so does not need to be added explicitly
  - If different, treat as though user explicitly modified it and don't append
    **AllUsers** `PSModulePath`
- Prefix with PS7 User, System, and `$PSHOME` paths in that order
  - If `powershell.config.json` contains a user scoped `PSModulePath`, use that
    instead of the default for the user
  - If `powershell.config.json` contains a system scoped `PSModulePath`, use
    that instead of the default for the system

Unix systems don't have a separation of User and System environment variables.
`PSModulePath` is inherited and the PS7-specific paths are prefixed if not
already defined.

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
that Windows PowerShell added. Since the PS7-specific paths are prefixed, there
is no functional issue.

### Starting PowerShell 6 from PowerShell 7

PowerShell Core 6 overwrites `$env:PSModulePath`. No changes are made.

### Starting PowerShell 7 from PowerShell 6

The PowerShell 7 startup continues as-is with the addition of inheriting paths
that PowerShell Core 6 added. Since the PS7-specific paths are prefixed, there
is no functional issue.

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
