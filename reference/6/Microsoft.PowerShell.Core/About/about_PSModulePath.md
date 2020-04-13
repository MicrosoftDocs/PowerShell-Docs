---
keywords: powershell,cmdlet
locale: en-us
ms.date: 04/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_PSModulePath?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSModulePath
---
# About PSModulePath

The `$env:PSModulePath` environment variable contains a list of folder
locations that are searched to find modules and resources.

By default, the effective locations assigned to `$env:PSModulePath` are:

- System-wide locations: `$PSHOME\Modules`

  These folders contain modules that ship with PowerShell.

- User-installed modules: These are modules installed by the user.
  `Install-Module` has a **Scope** parameter that allows you to specify
  whether the module is installed for the current user or for all users. For
  more information, see
  [Install-Module](../../PowerShellGet/Install-Module.md).

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
> On Windows, the user-specific **CurrentUser** location on Windows is the
> `PowerShell\Modules` folder located in the **Documents** location in your
> user profile. The specific path of that location varies by version of Windows
> and whether or not you are using folder redirection. Microsoft OneDrive can
> also change the location of your **Documents** folder. You can verify the
> location of your **Documents** folder using the following command:
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
$path = [System.Environment]::GetEnvironmentVariable("PSModulePath",
  "Machine")
[System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
";C:\Program Files\Fabrikam\Modules", "Machine")
```

To add a path to the user setting, change the target value to User.

```powershell
$path = [System.Environment]::GetEnvironmentVariable("PSModulePath", "User")
[System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
";$home\Documents\Fabrikam\Modules", "User")
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

In PowerShell 7, `PSModulePath` behaves like the `Path` environment variable
works on Windows. `Path` on Windows is treated differently from other
environment variables. When a process is started, Windows combines the
User-scoped `Path` with the Machine-scoped `Path`.

- Retrieve the User-scoped `PSModulePath`
- Compare to process inherited `PSModulePath` env var
  - If the same:
    - Append the `System` `PSModulePath` to the end following the semantics of
      the `Path` env var
    - The Windows system32 path comes from the machine defined `PSModulePath`
      so does not need to be added explicitly
  - If different, treat as though user explicitly modified it and don't append
    `System` `PSModulePath`
- Prefix with PS7 user, system, and $PSHOME paths in that order
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

Copy process `$env:PSModulePath` as `WinPSModulePath`:

- Remove PS7 the User module path
- Remove PS7 the System module path
- Remove PS7 the `$PSHOME` module path

Use that `WinPSModulePath` when starting Windows PowerShell.

### Starting PowerShell 7 from Windows PowerShell

The PowerShell 7 startup continues as-is with the addition of inheriting paths
Windows PowerShell have added. Since the PS7 specific paths are prefixed, there
is no functional issue.

### Starting PowerShell 6 from PowerShell 7

PowerShell Core 6 overwrites `$env:PSModulePath`. No changes are made.

### Starting PowerShell 7 from PowerShell 6

The PowerShell 7 startup continues as-is with the addition of inheriting paths
that PowerShell Core 6 added. Since the PS7-specific paths are prefixed, there
is no functional issue.

## See also

- [about_Modules](about_Modules.md)
- [Environment Methods](/dotnet/api/system.environment)