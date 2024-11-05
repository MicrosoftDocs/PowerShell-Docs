---
description: Describes how to access and manage environment variables in PowerShell.
Locale: en-US
ms.date: 09/05/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Environment_Variables
---
# about_Environment_Variables

## Short description

Describes how to access and manage environment variables in PowerShell.

Environment variables store data that's used by the operating system and other
programs. PowerShell creates the following environment variables:

- `POWERSHELL_TELEMETRY_OPTOUT`
- `POWERSHELL_DISTRIBUTION_CHANNEL`
- `POWERSHELL_UPDATECHECK`
- `PSExecutionPolicyPreference`
- `PSModulePath`
- `PSModuleAnalysisCachePath`
- `PSDisableModuleAnalysisCacheCleanup`

For full descriptions of these variables, see the
[PowerShell environment variables][03] of this article.

## Long description

PowerShell can access and manage environment variables in any of the supported
operating system platforms. The PowerShell environment provider lets you get,
add, change, clear, and delete environment variables in the current console.

> [!NOTE]
> Unlike Windows, environment variable names on macOS and Linux are
> case-sensitive. For example, `$env:Path` and `$env:PATH` are different
> environment variables on non-Windows platforms.

Environment variables, unlike other types of variables in PowerShell, are
always stored as strings. Also unlike other variables, they're inherited by
child processes, such as local background jobs and the sessions in which module
members run. This makes environment variables well suited to storing values
that are needed in both parent and child processes.

On Windows, environment variables can be defined in three scopes:

- Machine (or System) scope
- User scope
- Process scope

The _Process_ scope contains the environment variables available in the current
process, or PowerShell session. This list of variables is inherited from the
parent process and is constructed from the variables in the _Machine_ and
_User_ scopes.

When you change environment variables in PowerShell, the change affects only
the current session. This behavior resembles the behavior of the `set` command
in the Windows Command Shell and the `setenv` command in UNIX-based
environments. To change values in the Machine or User scopes, you must use the
methods of the **System.Environment** class.

To make changes to Machine-scoped variables, you must also have permission. If
you try to change a value without sufficient permission, the command fails and
PowerShell displays an error.

PowerShell provides several different methods for using and managing
environment variables.

- The variable syntax
- The Environment provider and Item cmdlets
- The .NET **System.Environment** class

## Use the variable syntax

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

In PowerShell, an environment variable can't be set to an empty string. Setting
an environment variable to `$null` or an empty string removes it from the
current session. For example:

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

`Get-Member` returned an error because the environment variable was removed.
You can see that it doesn't return an error when you use it on an empty
string:

```powershell
'' | Get-Member -MemberType Properties
```

```Output
   TypeName: System.String

Name   MemberType Definition
----   ---------- ----------
Length Property   int Length {get;}
```

For more information about variables in PowerShell, see [about_Variables][11].

## Use the Environment provider and Item cmdlets

PowerShell's **Environment** provider gives you an interface for interacting
with environment variables in a format that resembles a file system drive. It
lets you get, add, change, clear, and delete environment variables and values
in PowerShell.

For example, to create the `Foo` environment variable with a value of `Bar`:

```powershell
New-Item -Path Env:\Foo -Value 'Bar'
```

```Output
Name                           Value
----                           -----
Foo                            Bar
```

You can also copy the environment variable with `Copy-Item`, set the value of
an environment variable with `Set-Item`, list environment variables with
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

Use the `Get-ChildItem` cmdlet to see a full list of environment variables:

```powershell
Get-ChildItem Env:
```

For more information on using the **Environment** provider to manage
environment variables, see [about_Environment_Provider][04].

## Use the System.Environment methods

The **System.Environment** class provides the `GetEnvironmentVariable()` and
`SetEnvironmentVariable()` methods to get and modify environment variables.

The following example creates a new environment variable, `Foo`, with a value
of `Bar` and then returns its value.

```powershell
[Environment]::SetEnvironmentVariable('Foo','Bar')
[Environment]::GetEnvironmentVariable('Foo')
```

```Output
Bar
```

You can remove an environment variable with the `SetEnvironmentVariable()`
method by specifying an empty string for the variable's value. For example,
to remove the `Foo` environment variable:

```powershell
[Environment]::SetEnvironmentVariable('Foo','')
[Environment]::GetEnvironmentVariable('Foo')
```

```Output

```

For more information about the methods of the **System.Environment** class, see
[Environment Methods][01].

## Create persistent environment variables in Windows

On Windows, there are three methods for making a persistent change to an
environment variable:

- Set them in your profile
- Using the `SetEnvironmentVariable()` method
- Use the System Control Panel

### Set environment variables in your profile

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
variable. For more information on profiles, see [about_Profiles][07].

### Set environment variables with SetEnvironmentVariable()

On Windows, you can specify a scope for the `SetEnvironmentVariable()` method
as the third parameter to set the environment variable in that scope. The
machine and user scopes both persist outside of the current process, allowing
you to save a new or changed environment variable.

For example, to save a new environment variable `Foo` with the value `Bar`to
the machine scope:

```powershell
[Environment]::SetEnvironmentVariable('Foo', 'Bar', 'Machine')
```

You can delete an environment variable from the user or machine scope by
setting the variable's value to an empty string.

```powershell
[Environment]::SetEnvironmentVariable('Foo', '', 'Machine')
```

### Set environment variables in the System Control Panel

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

## Create persistent environment variables on non-Windows platforms

Linux and macOS have configuration files and scripts that the operating system
uses to set environment variables before starting an application.

When running PowerShell as the default (login) shell, you can define
environment variables in the global initialization files supported by the
operating system. For example on Linux, you can add environment variables to
the `/etc/environment` file or create a script that sets environment variables
and put it in the `/etc/profile.d` folder. On macOS, you can add environment
variables to the `/etc/profile` file.

When starting PowerShell from another shell, you can define environment
variables in the shell-specific initialization files used by non-login shells,
such as `~/.bashrc` for `bash` or `~/.zshrc` for `zsh`.

For more information, see the documentation for your operating system and
default shell.

## PowerShell environment variables

PowerShell features can use environment variables to store user preferences.
These variables work like preference variables, but they're inherited by child
sessions of the sessions in which they're created. For more information about
preference variables, see [about_Preference_Variables][06].

The environment variables that store preferences include:

- `POWERSHELL_TELEMETRY_OPTOUT`

  To opt-out of telemetry, set the environment variable to `true`, `yes`, or
  `1`. For more information, see [about_Telemetry][09].

  For this environment variable to have effect, it must be set before
  starting the PowerShell process. See the previous sections for information
  about creating persistent environment variables.

- `POWERSHELL_DISTRIBUTION_CHANNEL`

  Beginning in PowerShell 7.2, this environment variable is set by the
  installer packages to record the method and source of installation for
  PowerShell.

  This information is included in the telemetry data sent to Microsoft. Users
  shouldn't change this value.

- `POWERSHELL_UPDATECHECK`

  The update notification behavior can be changed using the
  `POWERSHELL_UPDATECHECK` environment variable. For more information, see
  [about_Update_Notifications][10].

  The following values are supported:

  - `Off` turns off the update notification feature
  - `Default` is the same as not defining `POWERSHELL_UPDATECHECK`:
    - GA releases notify of updates to GA releases
    - Preview/RC releases notify of updates to GA and preview releases
  - `LTS` only notifies of updates to long-term-servicing (LTS) GA releases

  Non-default values of environment variable must be set before starting the
  PowerShell process. See the previous sections for information about creating
  persistent environment variables.

- `PSExecutionPolicyPreference`

  Stores the execution policy set for the current session. This environment
  variable exists only when you set an execution policy for a single session.
  You can do this in two different ways.

  - Start a session from the command line using the **ExecutionPolicy**
    parameter to set the execution policy for the session.

  - Use the `Set-ExecutionPolicy` cmdlet. Use the **Scope** parameter with
    a value of `Process`.

  - Manually set the environment variable. Changing the value of this variable
    changes the execution policy of the current process.

  This information only applies to the Windows platform. For more information,
  see [about_Execution_Policies][05].

- `PSModulePath`

  The `$env:PSModulePath` environment variable contains a list of folder
  locations that are searched to find modules and resources. On Windows, the
  list of folder locations is separated by the semi-colon (`;`) character. On
  non-Windows platforms, the colon (`:`) separates the folder locations in the
  environment variable.

  By default, the effective locations assigned to `$env:PSModulePath` are:

  - System-wide locations: These folders contain modules that ship with
    PowerShell. The modules are store in the `$PSHOME\Modules` location. Also,
    This is the location where the Windows management modules are installed.

  - User-installed modules: These are modules installed by the user.
    `Install-Module` has a **Scope** parameter that allows you to specify
    whether the module is installed for the current user or for all users. For
    more information, see [Install-Module][14].

    - On Windows, the location of the user-specific **CurrentUser** scope is
      the `$HOME\Documents\PowerShell\Modules` folder. The location of the
      **AllUsers** scope is `$env:ProgramFiles\PowerShell\Modules`.
    - On non-Windows systems, the location of the user-specific **CurrentUser**
      scope is the `$HOME/.local/share/powershell/Modules` folder. The location
      of the **AllUsers** scope is `/usr/local/share/powershell/Modules`.

  In addition, setup programs that install modules in other directories, such
  as the Program Files directory, can append their locations to the value of
  `$env:PSModulePath`.

  For more information, see [about_PSModulePath][08].

- `PSModuleAnalysisCachePath`

  PowerShell provides control over the file that's used to cache data about
  modules and their cmdlets. The cache is read at startup while searching for a
  command and is written on a background thread sometime after a module is
  imported.

  The default location of the cache is:

  - Windows PowerShell 5.1: `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell`
  - PowerShell 6.0 and higher: `$env:LOCALAPPDATA\Microsoft\PowerShell`
  - Non-Windows default: `~/.cache/powershell`

  The default filename for the cache is `ModuleAnalysisCache`. When you have
  multiple instances of PowerShell installed, the filename includes a
  hexadecimal suffix so that there is a unique filename per installation.

  > [!NOTE]
  > If command discovery isn't working correctly, for example IntelliSense
  > shows commands that don't exist, you can delete the cache file. The cache
  > is recreated the next time you start PowerShell.

  To change the default location of the cache, set the environment variable
  before starting PowerShell. The value should name a full path (including
  filename) that PowerShell has permission to create and write files.

  Changes to this environment variable only affect child processes. See the
  previous sections for information about creating persistent environment
  variables.

  To disable the file cache, set this value to an invalid location, for
  example:

  ```powershell
  # `NUL` here is a special device on Windows that can't be written to,
  # on non-Windows you would use `/dev/null`
  $env:PSModuleAnalysisCachePath = 'NUL'
  ```

  This sets the path to the **NUL** device. PowerShell can't write to the
  path but no error is returned. You can see the errors reported using a
  tracer:

  ```powershell
  Trace-Command -PSHost -Name Modules -Expression {
    Import-Module Microsoft.PowerShell.Management -Force
  }
  ```

- `PSDisableModuleAnalysisCacheCleanup`

  When writing out the module analysis cache, PowerShell checks for modules
  that no longer exist to avoid an unnecessarily large cache. Sometimes these
  checks aren't desirable, in which case you can turn them off by setting this
  environment variable value to `1`.

  Setting this environment variable takes effect for subsequent cleanup events
  in the current process. To ensure that cleanup is disabled at startup, you
  must set the environment variable before starting PowerShell. See the
  previous sections for information about creating persistent environment
  variables.

## Other environment variables used by PowerShell

### Path information

- `PATH`

  The `$env:PATH` environment variable contains a list of folder locations that
  the operating system searches for executable files. On Windows, the list of
  folder locations is separated by the semi-colon (`;`) character. On
  non-Windows platforms, the colon (`:`) separates the folder locations in the
  environment variable.

- `PATHEXT`

  The `$env:PATHEXT` variable contains a list of file extensions that Windows
  considers to be executable files. When a script file with one of the listed
  extensions is executed from PowerShell, the script runs in the current
  console or terminal session. If the file extension isn't listed, the script
  runs in a new console session.

  To ensure that scripts for another scripting language run in the current
  console session, add the file extension used by the scripting language. For
  example, to run Python scripts in the current console, add the `.py`
  extension to the environment variable. For Windows to support the `.py`
  extension as an executable file you must register the file extension using
  the `ftype` and `assoc` commands of the CMD command shell. PowerShell has no
  direct method to register the file handler. For more information, see the
  documentation for the [ftype][02] command.

  PowerShell scripts always start in the current console session. You don't
  need to add the `.PS1` extension.

- `XDG` variables

  On non-Windows platforms, PowerShell uses the following XDG environment
  variables as defined by the [XDG Base Directory Specification][13].

  - `XDG_CONFIG_HOME`
  - `XDG_DATA_HOME`
  - `XDG_CACHE_HOME`

### Terminal features

Beginning in PowerShell 7.2, the following environment variables can be used to
control the Virtual Terminal features like ANSI escape sequences that colorize
output. Support for ANSI escape sequences can be turned off using the `TERM`
or `NO_COLOR` environment variables.

- `TERM`

  The following values of `$env:TERM` change the behavior as follows:

  - `dumb` - sets `$Host.UI.SupportsVirtualTerminal = $false`
  - `xterm-mono` - sets `$PSStyle.OutputRendering = PlainText`
  - `xtermm` - sets `$PSStyle.OutputRendering = PlainText`

- `NO_COLOR`

  If `$env:NO_COLOR` exists, then `$PSStyle.OutputRendering` is set to
  `PlainText`. For more information about the `NO_COLOR` environment
  variable, see [https://no-color.org/][12].

## See also

- [about_Environment_Provider][04]
- [about_Profiles][07]
- [about_Variables][11]
- [Environment Methods][01]

<!-- link references -->
[01]: /dotnet/api/system.environment
[02]: /windows-server/administration/windows-commands/ftype
[03]: #powershell-environment-variables
[04]: about_Environment_Provider.md
[05]: about_Execution_Policies.md
[06]: about_preference_variables.md
[07]: about_profiles.md
[08]: about_PSModulePath.md
[09]: about_Telemetry.md
[10]: about_Update_Notifications.md
[11]: about_variables.md
[12]: https://no-color.org/
[13]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[14]: xref:PowerShellGet.Install-Module
