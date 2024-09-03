---
description: Describes how PowerShell determines which command to run.
Locale: en-US
ms.date: 03/05/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_command_precedence?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Command_Precedence
---
# about_Command_Precedence

## Short description

Describes how PowerShell determines which command to run.

## Long description

Command precedence describes how PowerShell determines which command to run
when a session contains more than one command with the same name. Commands
within a session can be hidden or replaced by commands with the same name. This
article shows you how to run hidden commands and how to avoid command-name
conflicts.

## Command precedence

When a PowerShell session includes more than one command that has the same
name, PowerShell determines which command to run using the following rules.

If you specify the path to a command, PowerShell runs the command at the
location specified by the path.

For example, the following command runs the FindDocs.ps1 script in the
`C:\TechDocs` directory:

```powershell
C:\TechDocs\FindDocs.ps1
```

You can run any executable command using its full path. As a security feature,
PowerShell doesn't run executable commands, including PowerShell scripts and
native commands, unless the command is located in a path listed in the
`$env:Path` environment variable.

To run an executable file that's in the current directory, specify the full
path or use the relative path `.\` to represent the current directory.

For example, to run the `FindDocs.ps1` file in the current directory, type:

```powershell
.\FindDocs.ps1
```

If you don't specify a path, PowerShell uses the following precedence order
when it runs commands.

1. Alias
1. Function
1. Cmdlet (see [Cmdlet name resolution][05])
1. External executable files (including PowerShell script files)

Therefore, if you type `help`, PowerShell first looks for an alias named
`help`, then a function named `Help`, and finally a cmdlet named `Help`. It
runs the first `help` item that it finds.

For example, if your session contains a cmdlet and a function, both named
`Get-Map`, when you type `Get-Map`, PowerShell runs the function.

> [!NOTE]
> This only applies to loaded commands. If there is a `build` executable and an
> Alias `build` for a function with the name of `Invoke-Build` inside a module
> that is not loaded into the current session, PowerShell runs the `build`
> executable instead. It doesn't auto-load modules if it finds the external
> executable. It's only when no external executable is found that an alias,
> function, or cmdlet with the given name is invoked.

## Resolving items with the same names

As a result of these rules, items can be replaced or hidden by items with the
same name.

Items are _hidden_ or _shadowed_ if you can still access the original item,
such as by qualifying the item name with a module name.

For example, if you import a function that has the same name as a cmdlet in the
session, the cmdlet is _hidden_, but not replaced. You can run the cmdlet by
specifying its module-qualified name.

When items are _replaced_ or _overwritten_, you can no longer access the
original item.

For example, if you import a variable that has the same name as a variable in
the session, the original variable is replaced. You can't qualify a variable
with a module name.

If you create a function at the command line and then import a function with
the same name, the original function is replaced.

## Finding hidden commands

The **All** parameter of the [Get-Command][10] cmdlet gets all commands with
the specified name, even if they're hidden or replaced. Beginning in PowerShell
3.0, by default, `Get-Command` gets only the commands that run when you type
the command name.

In the following examples, the session includes a `Get-Date` function and a
[Get-Date][14] cmdlet. You can use `Get-Command` to determine which command is
chosen first.

```powershell
Get-Command Get-Date
```

```Output
CommandType     Name                      ModuleName
-----------     ----                      ----------
Function        Get-Date
```

Uses the **All** parameter to list available `Get-Date` commands.

```powershell
Get-Command Get-Date -All
```

```Output
CommandType     Name                 Version    Source
-----------     ----                 -------    ------
Function        Get-Date
Cmdlet          Get-Date             7.0.0.0    Microsoft.PowerShell.Utility
```

```powershell
Get-Command where -All
```

```Output
CommandType Name                     Version      Source
----------- ----                     -------      ------
Alias       where -> Where-Object
Application where.exe                10.0.22621.1 C:\Windows\system32\where.exe
```

You can run particular commands by including qualifying information that
distinguishes the command from other commands that might have the same name.
For cmdlets, you can use the module-qualified name. For executables, you can
include the file extension. For example, to run the executable version of
`where` use `where.exe`.

### Use module-qualified names

Using the module-qualified name of a cmdlet allows you to run commands hidden
by an item with the same name. For example, you can run the `Get-Date` cmdlet
by qualifying it with its module name **Microsoft.PowerShell.Utility** or its
path. When you use module-qualified names, the module can be automatically
imported into the session depending on the value of
[`$PSModuleAutoLoadingPreference`][03].

> [!NOTE]
> You can't use module names to qualify variables or aliases.

Using module-qualified names ensures that you are running the command that you
intend to run. This is the recommended method of calling cmdlets when writing
scripts that you intend to distribute.

The following example illustrates how to qualify a command by including its
module name.

> [!IMPORTANT]
> Module qualification uses the backslash character (`\`) to separate the
> module name from the command name, regardless of the platform.

```powershell
New-Alias -Name "Get-Date" -Value "Get-ChildItem"
Microsoft.PowerShell.Utility\Get-Date
```

```Output
Tuesday, May 16, 2023 1:32:51 PM
```

To run a `New-Map` command from the `MapFunctions` module, use its
module-qualified name:

```powershell
MapFunctions\New-Map
```

To find the module from which a command was imported, use the **ModuleName**
property of commands.

```
(Get-Command <command-name>).ModuleName
```

For example, to find the source of the `Get-Date` cmdlet, type:

```powershell
(Get-Command Get-Date).ModuleName
```

```Output
Microsoft.PowerShell.Utility
```

If you want to qualify the name of the command using the path to the module,
you must use the forward slash (`/`) as the path separator and the backslash
character (`\`) before the command name. Use the following example to run the
`Get-Date` cmdlet:

```powershell
//localhost/c$/Progra~1/PowerShell/7-preview/Modules/Microsoft.PowerShell.Utility\Get-Date
```

The path can be a full path or a path that is relative to the current location.
On Windows, you can't use a drive-qualified path. You must use a UNC path, as
shown in the previous example, or a path that's relative to the current drive.
The following example assumes that your current location is in the `C:` drive.

```powershell
/Progra~1/PowerShell/7-preview/Modules/Microsoft.PowerShell.Utility\Get-Date
```

### Use the call operator

You can also use the call operator (`&`) to run hidden commands by combining it
with a call to [Get-ChildItem][13] (the alias is `dir`), `Get-Command` or
[Get-Module][11].

The call operator executes strings and script blocks in a child scope. For more
information, see [about_Operators][08].

For example, use the following command to run the function named `Map` that's
hidden by an alias named `Map`.

```powershell
& (Get-Command -Name Map -CommandType Function)
```

or

```powershell
& (dir Function:\map)
```

You can also save your hidden command in a variable to make it easier to run.

For example, the following command saves the `Map` function in the `$myMap`
variable and then uses the `Call` operator to run it.

```powershell
$myMap = (Get-Command -Name map -CommandType function)
& ($myMap)
```

## Replaced items

A _replaced_ item is one that you can no longer access. You can replace items
by importing items of the same name from a module.

For example, if you type a `Get-Map` function in your session, and you import a
function called `Get-Map`, it replaces the original function. You can't
retrieve it in the current session.

Variables and aliases can't be hidden because you can't use a call operator or
a qualified name to run them. When you import variables and aliases from a
module, they replace variables in the session with the same name.

## Cmdlet name resolution

When you don't use the qualified name of a cmdlet, PowerShell checks to see if
the cmdlet is loaded in the current session. If there are multiple modules
loaded that contain the same cmdlet name, PowerShell uses the cmdlet from the
first module found alphabetically.

If the cmdlet isn't loaded, PowerShell searches the installed modules and
autoloads the first module that contains the cmdlet and runs that cmdlet.
PowerShell searches for modules in each path defined in the `$env:PSModulePath`
environment variable. The paths are searched in the order that they're listed
in the variable. Within each path, the modules are searched in alphabetical
order. PowerShell uses the cmdlet from the first match it finds.

## Avoiding name conflicts

The best way to manage command name conflicts is to prevent them. When you name
your commands, use a unique name. For example, add your initials or company
name acronym to the nouns in your commands.

When you import commands into your session from a PowerShell module or from
another session, you can use the `Prefix` parameter of the [Import-Module][12]
or [Import-PSSession][15] cmdlet to add a prefix to the nouns in the names of
commands.

For example, the following command avoids any conflict with the `Get-Date` and
`Set-Date` cmdlets that come with PowerShell when you import the
`DateFunctions` module.

```powershell
Import-Module -Name DateFunctions -Prefix ZZ
```

## Running external executables

On Windows. PowerShell treats the file extensions listed in the `$env:PATHEXT`
environment variable as executable files. Files that aren't Windows executables
are handed to Windows to process. Windows looks up the file association and
executes the default Windows Shell verb for the extension. For Windows to
support the execution by file extension, the association must be registered
with the system.

You can register the executable engine for a file extension using the `ftype`
and `assoc` commands of the CMD command shell. PowerShell has no direct method
to register the file handler. For more information, see the documentation for
the [ftype][04] command.

For PowerShell to see a file extension as executable in the current session,
you must add the extension to the `$env:PATHEXT` environment variable.

## See also

- [about_Aliases][06]
- [about_Functions][07]
- [about_Path_Syntax][09]
- [Alias-Provider][01]
- [Function-Provider][02]
- [Get-Command][10]
- [Import-Module][12]
- [Import-PSSession][15]

<!-- link references -->
[01]: ./about_Alias_Provider.md
[02]: ./about_Function_Provider.md
[03]: ./about_preference_variables.md#psmoduleautoloadingpreference
[04]: /windows-server/administration/windows-commands/ftype
[05]: #cmdlet-name-resolution
[06]: about_Aliases.md
[07]: about_Functions.md
[08]: about_Operators.md
[09]: about_Path_Syntax.md
[10]: xref:Microsoft.PowerShell.Core.Get-Command
[11]: xref:Microsoft.PowerShell.Core.Get-Module
[12]: xref:Microsoft.PowerShell.Core.Import-Module
[13]: xref:Microsoft.PowerShell.Management.Get-ChildItem
[14]: xref:Microsoft.PowerShell.Utility.Get-Date
[15]: xref:Microsoft.PowerShell.Utility.Import-PSSession
