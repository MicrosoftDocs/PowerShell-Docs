---
ms.date:  08/28/2018
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Command_Precedence
---
# About Command Precedence

## Short description

Describes how PowerShell determines which command to run.

## Long description

Command precedence describes how PowerShell determines which command to
run when a session contains more than one command with the same name. Commands
within a session can be hidden or replaced by commands with the same
name. This article shows you how to run hidden commands and how to avoid
command-name conflicts.

## Command precedence

When a PowerShell session includes more than one command that has the
same name, PowerShell determines which command to run by using the
following rules.

- If you specify the path to a command, PowerShell runs the command at the
  location specified by the path.

  For example, the following command runs the FindDocs.ps1 script in the
  "C:\\TechDocs" directory:

  ```
  C:\TechDocs\FindDocs.ps1
  ```

  As a security feature, PowerShell does not run executable (native) commands,
  including PowerShell scripts, unless the command is located in a path that is
  listed in the Path environment variable `$env:path` or unless you specify the
  path to the script file.

  To run a script that is in the current directory, specify the full path, or
  type a dot `.` to represent the current directory.

  For example, to run the FindDocs.ps1 file in the current directory, type:

  ```
  .\FindDocs.ps1
  ```

- If you do not specify a path, PowerShell uses the following precedence order
  when it runs commands:

  1. Alias
  2. Function
  3. Cmdlet
  4. Native Windows commands

  Therefore, if you type "help", PowerShell first looks for an alias named
  `help`, then a function named `Help`, and finally a cmdlet named `Help`. It
  runs the first `help` item that it finds.

  For example, if your session contains a cmdlet and a function, both named
  `Get-Map`, when you type `Get-Map`, PowerShell runs the function.

  When the session contains items of the same type that have the same name,
  PowerShell runs the newer item.

  For example, if you import another `Get-Date` cmdlet from a module, when you
  type `Get-Date`, PowerShell runs the imported version over the native one.

## Hidden and replaced items

As a result of these rules, items can be replaced or hidden by items with the
same name.

Items are "hidden" or "shadowed" if you can still access the original item,
such as by qualifying the item name with a module or snap-in name.

For example, if you import a function that has the same name as a cmdlet in
the session, the cmdlet is hidden (but not replaced) because it was imported
from a snap-in or module.

Items are "replaced" or "overwritten" if you can no longer access the original
item.

For example, if you import a variable that has the same name as a variable
in the session, the original variable is replaced and is no longer accessible.
You cannot qualify a variable with a module name.

Also, if you type a function at the command line and then import a function
with the same name, the original function is replaced and is no longer
accessible.

### Finding hidden commands

The **All** parameter of the [Get-Command](../../Microsoft.PowerShell.Core/Get-Command.md)
cmdlet gets all commands with the specified name, even if they are hidden
or replaced. Beginning in PowerShell 3.0, by default, `Get-Command`
gets only the commands that run when you type the command name.

In the following examples, the session includes a `Get-Date` function and a
[Get-Date](../../Microsoft.PowerShell.Utility/Get-Date.md) cmdlet.

The following command gets the `Get-Date` command that runs when you type
`Get-Date`.

```powershell
Get-Command Get-Date
```

```output
CommandType     Name                      ModuleName
-----------     ----                      ----------
Function        Get-Date
```

The following command uses the **All** parameter to get all `Get-Date`
commands.

```powershell
Get-Command Get-Date -All
```

```output
CommandType     Name                      ModuleName
-----------     ----                      ----------
Function        Get-Date
Cmdlet          Get-Date                  Microsoft.PowerShell.Utility
```

### Running hidden commands

You can run particular commands by specifying item properties that distinguish
the command from other commands that might have the same name. You can use this
method to run any command, but it is especially useful for running hidden
commands.

#### Qualified names

Using the module-qualified name of a cmdlet allows you to run commands hidden
by an item with the same name. For example, you can run the `Get-Date` cmdlet
by qualifying it with its module name **Microsoft.PowerShell.Utility**.

Use this preferred method when writing scripts that you intend to
distribute. You cannot predict which commands might be present in
the session in which the script runs.

```powershell
New-Alias -Name "Get-Date" -Value "Get-ChildItem"
Microsoft.PowerShell.Utility\Get-Date
```

```output
Tuesday, September 4, 2018 8:17:25 AM
```

To run a `New-Map` command that was added by the `MapFunctions` module, use
its module-qualified name:

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

```output
Microsoft.PowerShell.Utility
```

> [!NOTE]
> You cannot qualify variables or aliases.

#### Call operator

You can also use the `Call` operator `&` to run hidden commands by combining
it with a call to [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)
(the alias is "dir"), `Get-Command` or
[Get-Module](../../Microsoft.PowerShell.Core/Get-Module.md).

The call operator executes strings and script blocks in a child scope. For more information, see [about_Operators](about_Operators.md).

For example, if you have a function named `Map` that is hidden by an alias
named `Map`, use the following command to run the function.

```powershell
&(Get-Command -Name Map -CommandType Function)
```

or

```powershell
&(dir Function:\map)
```

You can also save your hidden command in a variable to make it easier to run.

For example, the following command saves the `Map` function in the `$myMap`
variable and then uses the `Call` operator to run it.

```powershell
$myMap = (Get-Command -Name map -CommandType function)
&($myMap)
```

### Replaced items

A "replaced" item is one that you can no longer access. You can replace items
by importing items of the same name from a module or snap-in.

For example, if you type a `Get-Map` function in your session, and you import
a function called `Get-Map`, it replaces the original function. You cannot
retrieve it in the current session.

Variables and aliases cannot be hidden because you cannot use a call operator
or a qualified name to run them. When you import variables and aliases from a
module or snap-in, they replace variables in the session with the same name.

### Avoiding name conflicts

The best way to manage command name conflicts is to prevent them. When you name
your commands, use a unique name. For example, add your initials or company
name acronym to the nouns in your commands.

Also, when you import commands into your session from a PowerShell
module or from another session, use the `Prefix` parameter of the
[Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) or

[Import-PSSession](../../Microsoft.PowerShell.Utility/Import-PSSession.md)
cmdlet to add a prefix to the nouns in the names of commands.

For example, the following command avoids any conflict with the `Get-Date`
and `Set-Date` cmdlets that come with PowerShell when you import the
`DateFunctions` module.

```powershell
Import-Module -Name DateFunctions -Prefix ZZ
```

For more information, see `Import-Module` and `Import-PSSession` below.

## See also

- [about_Path_Syntax](about_Path_Syntax.md)
- [about_Aliases](about_Aliases.md)
- [about_Functions](about_Functions.md)
- [Alias-Provider](../../Microsoft.PowerShell.Core/About/about_Alias_Provider.md)
- [Function-Provider](../../Microsoft.PowerShell.Core/About/about_Function_Provider.md)
- [Get-Command](../../Microsoft.PowerShell.Core/Get-Command.md)
- [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md)
- [Import-PSSession](../../Microsoft.PowerShell.Utility/Import-PSSession.md)