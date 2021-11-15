---
description: Describes how to access Windows environment variables in PowerShell.
Locale: en-US
ms.date: 11/15/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Environment Variables
---
# about_Environment_Variables

## Short description
Describes how to access Windows environment variables in PowerShell.

## Long description

Environment variables store information about the operating system
environment. This information includes details such as the operating system
path, the number of processors used by the operating system, and the location
of temporary folders.

The environment variables store data that is used by the operating system and
other programs. For example, the `WINDIR` environment variable contains the
location of the Windows installation directory. Programs can query the value of
this variable to determine where Windows operating system files are located.

PowerShell can access and manage environment variables in any of the supported
operating system platforms. The PowerShell environment provider simplifies this
process by making it easy to view and change environment variables.

Environment variables, unlike other types of variables in PowerShell, are
inherited by child processes, such as local background jobs and the sessions in
which module members run. This makes environment variables well suited to
storing values that are needed in both parent and child processes.

## Using and changing environment variables

On Windows, environment variables can be defined in three scopes:

- Machine (or System) scope
- User scope
- Process scope

The _Process_ scope contains the environment variables available in the current
process, or PowerShell session. This list of variables is inherited from the
parent process and is constructed from the variables in the _Machine_ and
_User_ scopes. Unix-based platforms only have the _Process_ scope.

You can display and change the values of environment variables without using a
cmdlet by using a variable syntax with the environment provider. To display the
value of an environment variable, use the following syntax:

```
$Env:<variable-name>
```

For example, to display the value of the `WINDIR` environment variable, type
the following command at the PowerShell command prompt:

```powershell
$Env:windir
```

In this syntax, the dollar sign (`$`) indicates a variable, and the drive name
(`Env:`) indicates an environment variable followed by the variable name
(`windir`).

When you change environment variables in PowerShell, the change affects only
the current session. This behavior resembles the behavior of the `Set` command
in the Windows Command Shell and the `Setenv` command in UNIX-based
environments. To change values in the Machine or User scopes, you must use the
methods of the **System.Environment** class.

To make changes to Machine-scoped variables, you must also have permission. If
you try to change a value without sufficient permission, the command fails and
PowerShell displays an error.

You can change the values of variables without using a cmdlet using the
following syntax:

```powershell
$Env:<variable-name> = "<new-value>"
```

For example, to append `;c:\temp` to the value of the `Path` environment
variable, use the following syntax:

```powershell
$Env:Path += ";c:\temp"
```

On Linux or macOS, the colon (`:`) in the command separates the new path from
the path that precedes it in the list.

```powershell
$Env:PATH += ":/usr/local/temp"
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

## Managing environment variables

PowerShell provides several different methods for managing environment
variables.

- The Environment provider drive
- The Item cmdlets
- The .NET **System.Environment** class
- On Windows, the System Control Panel

### Using the Environment provider

Each environment variable is represented by an instance of the
**System.Collections.DictionaryEntry** class. In each **DictionaryEntry**
object, the name of the environment variable is the dictionary key. The value
of the variable is the dictionary value.

To display the properties and methods of the object that represents an
environment variable in PowerShell, use the `Get-Member` cmdlet. For example,
to display the methods and properties of all the objects in the `Env:` drive,
type:

```powershell
Get-Item -Path Env:* | Get-Member
```

The PowerShell Environment provider lets you access environment variables in a
PowerShell drive (the `Env:` drive). This drive looks much like a file system
drive. To go to the `Env:` drive, type:

```powershell
Set-Location Env:
```

Use the Content cmdlets to get or set the values of an environment variable.

```powershell
PS Env:\> Set-Content -Path Test -Value 'Test value'
PS Env:\> Get-Content -Path Test
Test value
```

You can view the environment variables in the `Env:` drive from any other
PowerShell drive, and you can go into the `Env:` drive to view and change the
environment variables.

### Using Item cmdlets

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

Because environment variables do not have child items, the output of `Get-Item`
and `Get-ChildItem` is the same.

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

### Saving changes to environment variables

To make a persistent change to an environment variable on Windows, use the
System Control Panel. Select **Advanced System Settings**. On the **Advanced**
tab, click **Environment Variable...**. You can add or edit existing
environment variables in the **User** and **System** (Machine) scopes. Windows
writes these values to the Registry so that they persist across sessions and
system restarts.

Alternately, you can add or change environment variables in your PowerShell
profile. This method works for any version of PowerShell on any supported
platform.

### Using System.Environment methods

The **System.Environment** class provides **GetEnvironmentVariable** and
**SetEnvironmentVariable** methods that allow you to specify the scope of the
variable.

The following example uses the **GetEnvironmentVariable** method to get the
machine setting of `PSModulePath` and the **SetEnvironmentVariable** method
to add the `C:\Program Files\Fabrikam\Modules` path to the value.

```powershell
$path = [Environment]::GetEnvironmentVariable('PSModulePath', 'Machine')
$newpath = $path + ';C:\Program Files\Fabrikam\Modules'
[Environment]::SetEnvironmentVariable("PSModulePath", $newpath, 'Machine')
```

For more information about the methods of the **System.Environment** class, see
[Environment Methods](/dotnet/api/system.environment).

## PowerShell's environment variables

PowerShell features can use environment variables to store user preferences.
These variables work like preference variables, but they are inherited by child
sessions of the sessions in which they are created. For more information about
preference variables, see [about_Preference_Variables](about_preference_variables.md).

The environment variables that store preferences include:

- **PSExecutionPolicyPreference**

  Stores the execution policy set for the current session. This environment
  variable exists only when you set an execution policy for a single session.
  You can do this in two different ways.

  - Start a session from the command line using the **ExecutionPolicy**
    parameter to set the execution policy for the session.

  - Use the `Set-ExecutionPolicy` cmdlet. Use the Scope parameter with
    a value of "Process".

    For more information, see [about_Execution_Policies](about_Execution_Policies.md).

- **PSModuleAnalysisCachePath**

  PowerShell provides control over the file that is used to cache data about
  modules and their cmdlets. The cache is read at startup while searching for a
  command and is written on a background thread sometime after a module is
  imported.

  Default location of the cache is:

  - Windows PowerShell 5.1: `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell`
  - PowerShell 6.0 and higher: `$env:LOCALAPPDATA\Microsoft\PowerShell`
  - Non-Windows default: `~/.cache/powershell`

  The default filename for the cache is `ModuleAnalysisCache`. When you have
  multiple instances of PowerShell installed, the filename includes a
  hexadecimal suffix so that there is a a unique filename per installation.

  > [!NOTE]
  > If command discovery isn't working correctly, for example Intellisense
  > shows commands that don't exist, you can delete the cache file. The cache
  > is recreated the next time you start PowerShell.

  To change the default location of the cache, set the environment variable
  before starting PowerShell. Changes to this environment variable only affect
  child processes. The value should name a full path (including filename)
  that PowerShell has permission to create and write files.

  To disable the file cache, set this value to an invalid location, for
  example:

  ```powershell
  # `NUL` here is a special device on Windows that cannot be written to,
  # on non-Windows you would use `/dev/null`
  $env:PSModuleAnalysisCachePath = 'NUL'
  ```

  This sets the path to the **NUL** device. PowerShell can't write to the
  path but no error is returned. You can see the errors reported using a
  tracer:

  ```powershell
  Trace-Command -PSHost -Name Modules -Expression { Import-Module Microsoft.PowerShell.Management -Force }
  ```

- **PSDisableModuleAnalysisCacheCleanup**

  When writing out the module analysis cache, PowerShell checks for modules
  that no longer exist to avoid an unnecessarily large cache. Sometimes these
  checks are not desirable, in which case you can turn them off by setting this
  environment variable value to `1`.

  Setting this environment variable takes effect immediately in the current
  process.

- **PSModulePath**

  The `$env:PSModulePath` environment variable contains a list of folder
  locations that are searched to find modules and resources.

  By default, the effective locations assigned to `$env:PSModulePath` are:

  - System-wide locations: These folders contain modules that ship with
    PowerShell. The modules are store in the `$PSHOME\Modules` location. Also,
    This is the location where the Windows management modules are installed.

  - User-installed modules: These are modules installed by the user.
    `Install-Module` has a **Scope** parameter that allows you to specify
    whether the module is installed for the current user or for all users. For
    more information, see [Install-Module](xref:PowerShellGet.Install-Module).

    - On Windows, the location of the user-specific **CurrentUser** scope is
      the `$HOME\Documents\PowerShell\Modules` folder. The location of the
      **AllUsers** scope is `$env:ProgramFiles\PowerShell\Modules`.
    - On non-Windows systems, the location of the user-specific **CurrentUser**
      scope is the `$HOME/.local/share/powershell/Modules` folder. The location
      of the **AllUsers** scope is `/usr/local/share/powershell/Modules`.

  In addition, setup programs that install modules in other directories, such
  as the Program Files directory, can append their locations to the value of
  `$env:PSModulePath`.

  For more information, see [about_PSModulePath](about_PSModulePath.md).

- **POWERSHELL_UPDATECHECK**

  The update notification behavior can be changed using the
  `POWERSHELL_UPDATECHECK` environment variable. The following values are
  supported:

  - `Off` turns off the update notification feature
  - `Default` is the same as not defining `POWERSHELL_UPDATECHECK`:
    - GA releases notify of updates to GA releases
    - Preview/RC releases notify of updates to GA and preview releases
  - `LTS` only notifies of updates to long-term-servicing (LTS) GA releases

  For more information, see [about_Update_Notifications](about_Update_Notifications.md).

- **POWERSHELL_TELEMETRY_OPTOUT**

  To opt-out of telemetry, set the environment variable to `true`, `yes`, or `1`.

  For more information, see [about_Telemetry](about_Telemetry.md).

## Other environment variables used by PowerShell

### Path information

- **PATHEXT**

  The `$env:PATHEXT` variable contains a list of file extensions that Windows
  considers to be executable files. When a script file with one of the listed
  extensions is executed from PowerShell, the script runs in the current
  console or terminal session. If the file extension is not listed, the script
  runs in a new console session.

  To ensure that scripts for another scripting language run in the current
  console session, add the file extension used by the scripting language. For
  example, to run Python scripts in the current console, add the `.py`
  extension the the environment variable. For Windows to support the `.py`
  extension as an executable file you must register the file extension using
  the `ftype` and `assoc` commands of the CMD command shell. For more
  information, see the documentation for the
  [ftype](/windows-server/administration/windows-commands/ftype) command.

  PowerShell scripts always start in the current console session. You do not
  need to add the `.PS1` extension.

- XDG variables

  On non-Windows platforms, PowerShell uses the following XDG environment
  variables as defined by the [XDG Base Directory Specification][xdg-bds].

  - **XDG_CONFIG_HOME**
  - **XDG_DATA_HOME**
  - **XDG_CACHE_HOME**

### Terminal features

Beginning in PowerShell 7.2, the following environment variables can be used to
control the Virtual Terminal features like ANSI escape sequences that colorize
output. Support for ANSI escape sequences can be turned off using the **TERM**
or **NO_COLOR** environment variables.

- **TERM**

  The following values of `$env:TERM` change the behavior as follows:

  - `dumb` - sets `$Host.UI.SupportsVirtualTerminal = $false`
  - `xterm-mono` - sets `$PSStyle.OutputRendering = PlainText`
  - `xtermm` - sets `$PSStyle.OutputRendering = PlainText`

- **NO_COLOR**

  If `$env:NO_COLOR` exists, then `$PSStyle.OutputRendering` is set to
  **PlainText**. For more information about the **NO_COLOR** environment
  variable, see [https://no-color.org/](https://no-color.org/).

## See also

- [Environment (provider)](../About/about_Environment_Provider.md)
- [about_Modules](about_Modules.md)

[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
