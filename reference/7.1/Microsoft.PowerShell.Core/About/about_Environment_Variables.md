---
description: Describes how to access and manage environment variables in PowerShell.
Locale: en-US
ms.date: 03/31/2022
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Environment Variables
---
# about_Environment_Variables

## Short description
Describes how to access and manage environment variables in PowerShell.

## Long description

Environment variables store data that is used by the operating system and
other programs. For example, the `WINDIR` environment variable contains the
location of the Windows installation directory. Programs can query the value of
this variable to determine where Windows operating system files are located.

PowerShell can access and manage environment variables in any of the supported
operating system platforms. The PowerShell environment provider lets you get,
add, change, clear, and delete environment variables in the current console.

Environment variables, unlike other types of variables in PowerShell, are always
stored as a string and can't be empty. Also unlike other variables, they are
inherited by child processes, such as local background jobs and the sessions in
which module members run. This makes environment variables well suited to
storing values that are needed in both parent and child processes.

On Windows, environment variables can be defined in three scopes:

- Machine (or System) scope
- User scope
- Process scope

The _Process_ scope contains the environment variables available in the current
process, or PowerShell session. This list of variables is inherited from the
parent process and is constructed from the variables in the _Machine_ and
_User_ scopes.

When you change environment variables in PowerShell, the change affects only
the current session. This behavior resembles the behavior of the `Set` command
in the Windows Command Shell and the `Setenv` command in UNIX-based
environments. To change values in the Machine or User scopes, you must use the
methods of the **System.Environment** class.

To make changes to Machine-scoped variables, you must also have permission. If
you try to change a value without sufficient permission, the command fails and
PowerShell displays an error.

PowerShell provides several different methods for using and managing environment
variables.

- The variable syntax
- The Environment provider and Item cmdlets
- The .NET **System.Environment** class

## Using the variable syntax

You can display and change the values of environment variables with the
following syntax:

```
$Env:<variable-name>
```

For example, to display the value of the `WINDIR` environment variable:

```powershell
$Env:windir
```

```Output
C:\Windows
```

In this syntax, the dollar sign (`$`) indicates a variable, and the drive name
(`Env:`) indicates an environment variable followed by the variable name
(`windir`).

You can create and update the value of environment variables with the following
syntax:

```powershell
$Env:<variable-name> = "<new-value>"
```

For example, to create the `Foo` environment variable:

```powershell
$Env:Foo = 'An example'
```

Because environment variables are always strings, you can use them like any
other variable containing a string. For example:

```powershell
"The 'Foo' environment variable is set to: $Env:Foo"
$Env:Foo += '!'
$Env:Foo
```

```Output
The 'Foo' environment variable is set to: An example

An example!
```

Because an environment variable can't be an empty string, setting one to `$null`
or an empty string removes it. For example:

```powershell
$Env:Foo = ''
$Env:Foo | Get-Member -MemberType Properties
```

```Output
Get-Member : You must specify an object for the Get-Member cmdlet.
At line:1 char:12
+ $env:foo | Get-Member
+            ~~~~~~~~~~
    + CategoryInfo          : CloseError: (:) [Get-Member], InvalidOperationException
    + FullyQualifiedErrorId : NoObjectInGetMember,Microsoft.PowerShell.Commands.GetMemberCommand
```

`Get-Member` returned an error because the environment variable was removed. You
can see that it does not return an error when you use it on an empty string:

```powershell
'' | Get-Member -MemberType Properties
```

```Output
   TypeName: System.String

Name   MemberType Definition
----   ---------- ----------
Length Property   int Length {get;}
```

For more information about variables in PowerShell, see
[about_Variables](about_variables.md).

## Using the Environment provider and Item cmdlets

PowerShell's **Environment** provider gives you an interface for interacting
with environment variables in a format that resembles a file system drive. It
lets you get, add, change, clear, and delete environment variables and values in
PowerShell.

For example, to create the `Foo` environment variable with a value of `Bar`:

```powershell
New-Item -Path Env:\Foo -Value 'Bar'
```

```Output
Name                           Value
----                           -----
Foo                            Bar
```

You can also copy the environment variable with `Copy-Item`, set the value of an
environment variable with `Set-Item`, list environment variables with
`Get-Item`, and delete the environment variable with `Remove-Item`.

```powershell
Copy-Item -Path Env:\Foo -Destination Env:\Foo2 -PassThru
Set-Item -Path Env:\Foo2 -Value 'BAR'
Get-Item -Path Env:\Foo*
Remove-Item -Path Env:\Foo* -Verbose
```

```Output
Name                           Value
----                           -----
Foo2                           Bar

Name                           Value
----                           -----
Foo2                           BAR
Foo                            Bar

VERBOSE: Performing the operation "Remove Item" on target "Item: Foo2".
VERBOSE: Performing the operation "Remove Item" on target "Item: Foo".
```

For more information on using the **Environment** provider to manage environment
variables, see [about_Environment_Provider](about_Environment_Provider.md).

## Using the System.Environment methods

The **System.Environment** class provides the **GetEnvironmentVariable** and
**SetEnvironmentVariable** methods to get and modify environment variables.

The following example creates a new environment variable, `Foo`, with a value of
`Bar` and then returns its value.

```powershell
[Environment]::SetEnvironmentVariable('Foo','Bar')
[Environment]::GetEnvironmentVariable('Foo')
```

```Output
Bar
```

You can remove an environment variable with the **SetEnvironmentVariable**
method by specifying an empty string for the variable's value. For example,
to remove the `Foo` environment variable:

```powershell
[Environment]::SetEnvironmentVariable('Foo','')
[Environment]::GetEnvironmentVariable('Foo')
```

```Output

```

For more information about the methods of the **System.Environment** class, see
[Environment Methods](/dotnet/api/system.environment).

## Saving changes to environment variables

On Windows, there are three methods for making a persistent change to an
environment variable: setting them in your profile, using the
**SetEnvironmentVariable** method, and using the System Control Panel.

### Saving environment variables in your profile

Any environment variable you add or change in your PowerShell profile is
available in any session that loads your profile. This method works for any
version of PowerShell on any supported platform.

For example, to create the `CompanyUri` environment variable and update the
`Path` environment variable to include the `C:\Tools` folder, add the following
lines to your PowerShell profile:

```powershell
$Env:CompanyUri = 'https://internal.contoso.com'
$Env:Path += ';C:\Tools'
```

> [!NOTE]
> On Linux or macOS, the colon (`:`) is used instead of a semi-colon(`;`) to
> separate a new path from the path that precedes it in the list.

You can get the path to your PowerShell profile with the `$PROFILE` automatic
variable. For more information on profiles, see
[about_Profiles](about_profiles.md).

### Saving environment variables with SetEnvironmentVariable

On Windows, you can specify a scope for the **SetEnvironmentVariable** method as
the third parameter to set the environment variable in that scope. The machine
and user scopes both persist outside of the current process, allowing you to
save a new or changed environment variable.

For example, to save a new environment variable `Foo` with the value `Bar`to the
machine scope:

```powershell
[Environment]::SetEnvironmentVariable('Foo', 'Bar', 'Machine')
```

You can delete an environment variable from the user or machine scope by setting
the variable's value to an empty string.

```powershell
[Environment]::SetEnvironmentVariable('Foo', '', 'Machine')
```

### Saving environment variables with the System Control Panel

In the System Control Panel, you can add or edit existing environment variables
in the **User** and **System** (Machine) scopes. Windows writes these values to
the Registry so that they persist across sessions and system restarts.

To make a persistent change to an environment variable on Windows using the
System Control Panel:

1. Open the System Control Panel.
1. Select **System**.
1. Select **Advanced System Settings**.
1. Go to the **Advanced** tab.
1. Select **Environment Variables...**.
1. Make your changes.

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

  The default location of the cache is:

  - Windows PowerShell 5.1: `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell`
  - PowerShell 6.0 and higher: `$env:LOCALAPPDATA\Microsoft\PowerShell`
  - Non-Windows default: `~/.cache/powershell`

  The default filename for the cache is `ModuleAnalysisCache`. When you have
  multiple instances of PowerShell installed, the filename includes a
  hexadecimal suffix so that there is a a unique filename per installation.

  > [!NOTE]
  > If command discovery isn't working correctly, for example IntelliSense
  > shows commands that don't exist, you can delete the cache file. The cache
  > is recreated the next time you start PowerShell.

  To change the default location of the cache, set the environment variable
  before starting PowerShell. Changes to this environment variable only affect
  child processes. The value should name a full path (including filename) that
  PowerShell has permission to create and write files.

  To disable the file cache, set this value to an invalid location, for example:

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
  extension to the environment variable. For Windows to support the `.py`
  extension as an executable file you must register the file extension using
  the `ftype` and `assoc` commands of the CMD command shell. PowerShell has no
  direct method to register the file handler. For more information, see the
  documentation for the
  [ftype](/windows-server/administration/windows-commands/ftype) command.

  PowerShell scripts always start in the current console session. You do not
  need to add the `.PS1` extension.

- XDG variables

  On non-Windows platforms, PowerShell uses the following XDG environment
  variables as defined by the [XDG Base Directory Specification][xdg-bds].

  - **XDG_CONFIG_HOME**
  - **XDG_DATA_HOME**
  - **XDG_CACHE_HOME**

## See also

- [about_Environment_Provider](about_Environment_Provider.md)
- [about_Profiles](about_profiles.md)
- [about_Variables](about_variables.md)
- [Environment Methods](/dotnet/api/system.environment)

[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
