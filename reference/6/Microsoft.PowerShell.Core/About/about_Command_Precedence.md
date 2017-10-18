---
ms.date:  2017-06-27
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Command_Precedence
---

# About Command Precedence

## SHORT DESCRIPTION

Describes how PowerShell determines which command to run.

## LONG DESCRIPTION

This topic explains how PowerShell determines which command to run, especially
when a session contains more than one command with the same name. It also
explains how to run commands that do not run by default, and it explains how
to avoid command-name conflicts in your session.

## COMMAND PRECEDENCE

When a session includes commands that have the same name, Windows PowerShell
uses the following rules to decide which command to run.

These rules become very important when you add commands to your session from
modules, snap-ins, and other sessions.

If you specify the path to a command, PowerShell runs the command at the
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

If you do not specify a path, PowerShell uses the following precedence order
when it runs commands:

1. Alias
2. Function
3. Cmdlet
4. Native Windows commands

Therefore, if you type "help", PowerShell first looks for an alias named
"help", then a function named "Help", and finally a cmdlet named "Help". It
runs the first "help" item that it finds.

For example, if you have a "Get-Map" function in the session and you import a
cmdlet named "Get-Map". By default, when you type "Get-Map", Windows
PowerShell runs the "Get-Map" function.

When the session contains items of the same type that have the same name, such
as two cmdlets with the same name, PowerShell runs the item that was added to
the session most recently.

For example, if you have a cmdlet named "Get-Date" and you import another
cmdlet named "Get-Date", by default, PowerShell runs the most-recently
imported cmdlet when you type "Get-Date".

## HIDDEN and REPLACED ITEMS

As a result of these rules, items can be replaced or hidden by items with the
same name.

Items are "hidden" or "shadowed" if you can still access the original item,
such as by qualifying the item name with a module or snap-in name.

For example, if you import a function that has the same name as a cmdlet in
the session, the cmdlet is hidden (but not replaced) because it was imported
from a snap-in or module.

Items are "replaced" or "overwritten" if you can no longer access the original
item.

For example, if you import a variable that has the same name as a a variable
in the session, the original variable is replaced and is no longer accessible.
You cannot qualify a variable with a module name.

Also, if you type a function at the command line and then import a function
with the same name, the original function is replaced and is no longer
accessible.

## FINDING HIDDEN COMMANDS

The **All** parameter of the [Get-Command](../../Microsoft.PowerShell.Core/Get-Command.md)
cmdlet gets all commands with the specified name, even if they are hidden
or replaced. Beginning in PowerShell 3.0, by default, `Get-Command`
gets only the commands that run when you type the command name.

In the following examples, the session includes a "Get-Date" function and a
[Get-Date](../../Microsoft.PowerShell.Utility/Get-Date.md) cmdlet.

The following command gets the "Get-Date" command that runs when you type
"Get-Date".

```powershell
Get-Command Get-Date
```

```
CommandType     Name                      ModuleName
-----------     ----                      ----------
Function        Get-Date
```

The following command uses the **All** parameter to get all "Get-Date"
commands.

```powershell
Get-Command Get-Date -All
```

```
CommandType     Name                      ModuleName
-----------     ----                      ----------
Function        Get-Date
Cmdlet          Get-Date                  Microsoft.PowerShell.Utility
```

## RUNNING HIDDEN COMMANDS

You can run particular commands by specifying item properties that distinguish
the command from other commands that might have the same name.

You can use this method to run any command, but it is especially useful for
running hidden commands.

Use this method as a best practice when writing scripts that you intend to
distribute because you cannot predict which commands might be present in
the session in which the script runs.

## QUALIFIED NAMES

You can run commands that have been imported from a PowerShell module or from
another session by qualifying the command name with the name of the module or
snap-in in which it originated.

You can qualify commands, but you cannot qualify variables or aliases.

For example, if the `Get-Date` cmdlet from the `Microsoft.PowerShell.Utility`
module is hidden by an alias, function, or cmdlet with the same name, you can
run it by using the module-qualified name of the cmdlet:

```powershell
Microsoft.PowerShell.Utility\Get-Date
```

To run a "New-Map" command that was added by the "MapFunctions" module, use
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

```
Microsoft.PowerShell.Utility
```

## CALL OPERATOR

You can also use the `Call` operator `&` to run any command that you
can get by using a [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md)
(the alias is "dir"), `Get-Command` or
[Get-Module](../../Microsoft.PowerShell.Core/Get-Module.md) command.

To run a command, enclose the `Get-Command` command in parentheses, and use
the Call operator `&` to run the command.

```
&(Get-Command ...)
```

or

```
&(dir ... )
```

For example, if you have a function named "Map" that is hidden by an alias
named "Map", use the following command to run the function.

```powershell
&(Get-Command -Name Map -Type Function)
```

or

```powershell
&(dir Function:\map)
```

You can also save your hidden command in a variable to make it easier to run.

For example, the following command saves the "Map" function in the "$myMap"
variable and then uses the `Call` operator to run it.

```powershell
$myMap = (Get-Command -Name map -Type function)
&($myMap)
```

If a command originated in a module, you can use the following format to run
it.

```
& <PSModuleInfo-object> <command>
```

For example, to run the "Add-File" cmdlet in the "FileCommands" module, use
the following command sequence.

```powershell
$FileCommands = Get-Module -Name FileCommands
& $FileCommands Add-File
```

# REPLACED ITEMS

Items that have not been imported from a module or snap-in, such as functions,
variables, and aliases that you create in your session or that you add by
using a profile can be replaced by commands that have the same name. If they
are replaced, you cannot access them.

Variables and aliases are always replaced even if they have been imported from
a module or snap-in because you cannot use a call operator or a qualified name
to run them.

For example, if you type a "Get-Map" function in your session, and you import
a function called "Get-Map", the original function is replaced. You cannot
retrieve it in the current session.

## AVOIDING NAME CONFLICTS

The best way to manage command name conflicts is to prevent them. When you
name your commands, use a name that is very specific or is likely to be
unique. For example, add your initials or company name acronym to the nouns in
your commands.

Also, when you import commands into your session from a PowerShell
module or from another session, use the **Prefix** parameter of the
[Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md) or
[Import-PSSession](../../Microsoft.PowerShell.Utility/Import-PSSession.md)
cmdlet to add a prefix to the nouns in the names of commands.

For example, the following command avoids any conflict with the `Get-Date`
and [Set-Date](../../Microsoft.PowerShell.Utility/Set-Date.md) cmdlets that
come with PowerShell when you import the "DateFunctions" module.

```powershell
Import-Module -Name DateFunctions -Prefix ZZ
```

For more information, see `Import-Module` and `Import-PSSession` below.

## SEE ALSO

- [about_Path_Syntax](about_Path_Syntax.md)
- [about_Aliases](about_Aliases.md)
- [about_Functions](about_Functions.md)
- [Alias-Provider](../../Microsoft.PowerShell.Core/Providers/Alias-Provider.md)
- [Function-Provider](../../Microsoft.PowerShell.Core/Providers/Function-Provider.md)
- [Get-Command](../../Microsoft.PowerShell.Core/Get-Command.md)
- [Import-Module](../../Microsoft.PowerShell.Core/Import-Module.md)
- [Import-PSSession](../../Microsoft.PowerShell.Utility/Import-PSSession.md)