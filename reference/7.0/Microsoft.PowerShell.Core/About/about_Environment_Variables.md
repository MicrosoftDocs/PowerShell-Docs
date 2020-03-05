---
keywords: powershell,cmdlet
locale: en-us
ms.date: 01/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Environment_Variables
---
# About Environment Variables

## SHORT DESCRIPTION
Describes how to access Windows environment variables in PowerShell.

## LONG DESCRIPTION

Environment variables store information about the operating system
environment. This information includes details such as the operating system
path, the number of processors used by the operating system, and the location
of temporary folders.

The environment variables store data that is used by the operating system and
other programs. For example, the `WINDIR` environment variable contains the
location of the Windows installation directory. Programs can query the value of
this variable to determine where Windows operating system files are located.

PowerShell can manage and access environment variables in any of the supported
operating system platforms. You view and change Windows environment variables,
including the variables set in the registry, and those set for a particular
session. The PowerShell environment provider simplifies this process by making
it easy to view and change the environment variables.

Unlike other types of variables in PowerShell, environment variables
and their values are inherited by child sessions, such as local background
jobs and the sessions in which module members run. This makes environment
variables well suited to storing values that are needed in both parent and
child sessions.

### PowerShell Environment Provider

The PowerShell environment provider lets you access environment variables in a
PowerShell drive (the `Env:` drive). This drive looks much like a file system
drive. To go to the `Env:` drive, type:

```powershell
Set-Location Env:
```

Then, to display the contents of the `Env:` drive, type:

```powershell
Get-ChildItem
```

You can view the environment variables in the `Env:` drive from any other
PowerShell drive, and you can go into the `Env:` drive to view and
change the environment variables.

### Environment Variable Objects

In PowerShell, each environment variable is represented by an object
that is an instance of the **System.Collections.DictionaryEntry** class.

In each **DictionaryEntry** object, the name of the environment variable is the
dictionary key. The value of the variable is the dictionary value.

To display an environment variable in PowerShell, get an object that represents
the variable, and then display the values of the object properties. When you
change an environment variable in PowerShell, use the methods that are
associated with the **DictionaryEntry** object.

To display the properties and methods of the object that represents an
environment variable in PowerShell, use the `Get-Member` cmdlet. For
example, to display the methods and properties of all the objects in the `Env:`
drive, type:

```powershell
Get-Item -Path Env:* | Get-Member
```

### Displaying Environment Variables

You can use the cmdlets that contain the Item noun (the Item cmdlets) to
display and change the values of environment variables. Because environment
variables do not have child items, the output of `Get-Item` and `Get-ChildItem` is
the same.

When you refer to an environment variable, type the `Env:` drive name followed
by the name of the variable. For example, to display the value of the
`COMPUTERNAME` environment variable, type:

```powershell
Get-ChildItem Env:Computername
```

To display the values of all the environment variables, type:

```powershell
Get-ChildItem Env:
```

By default, PowerShell displays the environment variables in the order in which
it retrieves them. To sort the list of environment variables by variable name,
pipe the output of a `Get-ChildItem` command to the `Sort-Object` cmdlet. For
example, from any PowerShell drive, type:

```powershell
Get-ChildItem Env: | Sort Name
```

You can also go into the `Env:` drive by using the `Set-Location` cmdlet:

```powershell
Set-Location Env:
```

When you are in the `Env:` drive, you can omit the `Env:` drive name from the
path. For example, to display all the environment variables, type:

```powershell
PS Env:\> Get-ChildItem
```

To display the value of the `COMPUTERNAME` variable from within the `Env:`
drive, type:

```powershell
PS Env:\> Get-ChildItem ComputerName
```

You can also display and change the values of environment variables without
using a cmdlet by using the expression parser in PowerShell. To
display the value of an environment variable, use the following syntax:

```
$Env:<variable-name>
```

For example, to display the value of the `WINDIR` environment variable,
type the following command at the PowerShell command prompt:

```powershell
$Env:windir
```

In this syntax, the dollar sign (`$`) indicates a variable, and the drive name
indicates an environment variable.

> [!NOTE]
> In Windows, environment variable names are case-insensitive. On Linux and
> macOS, environment variable names are case-sensitive. In most cases,
> environment variables are all uppercase. Refer to the documentation for your
> operating system for specific information.

### Changing Environment Variables

To make a persistent change to an environment variable, use System in Control
Panel (Advanced tab or the Advanced System Settings item) to store the change
in the registry.

When you change environment variables in PowerShell, the change
affects only the current session. This behavior resembles the behavior of the
Set command in Windows-based environments and the `Setenv` command in UNIX-based
environments.

You must also have permission to change the values of the variables. If you
try to change a value without sufficient permission, the command fails, and
PowerShell displays an error.

You can change the values of variables without using a cmdlet by using the
following syntax:

```powershell
$Env:<variable-name> = "<new-value>"
```

For example, to append `;c:\temp` to the value of the `Path` environment
variable, use the following syntax:

```powershell
$Env:path += ";c:\temp"
```

On Linux or MacOS, the colon (`:`) in the command separates the new path from
the path that precedes it in the list.

```powershell
$Env:path += ":/usr/local/temp"
```

You can also use the Item cmdlets, such as `Set-Item`, `Remove-Item`, and
`Copy-Item` to change the values of environment variables. For example, to use
the `Set-Item` cmdlet to append `;c:\temp` to the value of the `Path`
environment variable, use the following syntax:

```powershell
Set-Item -Path Env:Path -Value ($Env:Path + ";C:\Temp")
```

In this command, the value is enclosed in parentheses so that it is
interpreted as a unit.

### Saving Changes to Environment Variables

To create or change the value of an environment variable in every PowerShell
session, add the change to your PowerShell profile.

For example, to add the `C:\Temp` directory to the `Path` environment
variable in every PowerShell session, add the following command to your
PowerShell profile.

```powershell
$Env:Path += ";C:\Temp"
```

To add the command to an existing profile, such as the **CurrentUser**,
**AllHosts** profile, type:

```powershell
Add-Content -Path $Profile.CurrentUserAllHosts -Value '$Env:Path += ";C:\Temp"'
```

### Environment Variables That Store Preferences

PowerShell features can use environment variables to store user
preferences. These variables work like preference variables, but they are
inherited by child sessions of the sessions in which they are created. For
more information about preference variables, see
[about_preference_variables](about_Preference_Variables.md).

The environment variables that store preferences include:

- PSExecutionPolicyPreference

  Stores the execution policy set for the current session. This environment
  variable exists only when you set an execution policy for a single session.
  You can do this in two different ways.

  - Start a session from the command line using the **ExecutionPolicy**
    parameter to set the execution policy for the session.

  - Use the `Set-ExecutionPolicy` cmdlet. Use the Scope parameter with
    a value of "Process".

    For more information, see [about_Execution_Policies](about_Execution_Policies.md).

- PSModuleAnalysisCachePath

  PowerShell provides control over the file that is used to cache data about a
  module, such as the commands it exports.

  By default on Windows, this cache is normally stored in the file
  `Microsoft\Windows\PowerShell\ModuleAnalysisCache` within
  `$env:LOCALAPPDATA`. The cache is typically read at startup while searching
  for a command and is written on a background thread sometime after a module
  is imported.

  To change the default location of the cache, set the
  `$env:PSModuleAnalysisCachePath` environment variable before starting
  PowerShell. Changes to this environment variable only affects children
  processes. The value should name a full path (including filename) that
  PowerShell has permission to create and write files. To disable the file
  cache, set this value to an invalid location, for example:

```powershell
# `NUL` here is a special device on Windows that cannot be written to, on non-Windows you would
# use `/dev/null`
$env:PSModuleAnalysisCachePath = 'NUL'
```

  This sets the path to an invalid device. If PowerShell can't write to the
  path, no error is returned, but you can see error reporting by using a
  tracer:

```powershell
Trace-Command -PSHost -Name Modules -Expression { Import-Module Microsoft.PowerShell.Management -Force }
```

- PSDisableModuleAnalysisCacheCleanup

  When writing out the module analysis cache, PowerShell checks for modules
  that no longer exist to avoid an unnecessarily large cache. Sometimes these
  checks are not desirable, in which case you can turn them off by setting this
  environment variable value to `1`.

  Setting this environment variable takes effect immediately in the current
  process.

- PSModulePath

  Stores the paths to the default module directories. PowerShell looks
  for modules in the specified directories when you do not specify a full path
  to a module.

  The default value of `$Env:PSModulePath` is:

  ```powershell
  $HOME\Documents\WindowsPowerShell\Modules; $PSHOME\Modules
  ```

  - All Users scope

    The `$PSHOME\Modules` folder contains modules that ship with Windows and
    PowerShell.

  - Current User scope

    The user-specific **CurrentUser** location is the
    `WindowsPowerShell\Modules` folder located in the **Documents** location in
    your user profile. The specific path of that location varies by version of
    Windows and whether or not you are using folder redirection. By default, on
    Windows 10, that location is `$HOME\Documents\WindowsPowerShell\Modules`.

  In addition, setup programs that install modules in other directories, such as
  the Program Files directory, can append their locations to the value of
  `PSModulePath`.

  To change the default module directories for the current session, use the
  following command format to change the value of the `PSModulePath` environment
  variable.

  For example, to add the `C:\\Program Files\\Fabrikam\\Modules` directory to
  the value of the PSModulePath environment variable, type:

  ```powershell
  $Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
  ```

  The semi-colon (;) in the command separates the new path from the path that
  precedes it in the list.

  To change the value of `PSModulePath` in every session, add the previous
  command to your PowerShell profile or use the **SetEnvironmentVariable**
  method of the **Environment** class.

  The following command uses the **GetEnvironmentVariable** method to get the
  machine setting of `PSModulePath` and the **SetEnvironmentVariable** method
  to add the `C:\\Program Files\\Fabrikam\\Modules` path to the value.

  ```powershell
  $path = [System.Environment]::GetEnvironmentVariable("PSModulePath",
   "Machine")
  [System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
  ";C:\Program Files\Fabrikam\Modules", "Machine")
  ```

  To add a path to the user setting, change the target value to User.

  ```powershell
  $path = [System.Environment]::GetEnvironmentVariable("PSModulePath",
   "User")
  [System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
  ";$home\Documents\Fabrikam\Modules", "User")
  ```

  For more information about the methods of the System.Environment class, see
  [Environment Methods](/dotnet/api/system.environment) in
  MSDN.

  You can add also add a command that changes the value to your profile or use
  System in Control Panel to change the value of the `PSModulePath` environment
  variable in the registry.

  For more information, see [about_Modules](about_Modules.md).

## SEE ALSO

- [Environment (provider)](../About/about_Environment_Provider.md)
- [about_Modules](about_Modules.md)
