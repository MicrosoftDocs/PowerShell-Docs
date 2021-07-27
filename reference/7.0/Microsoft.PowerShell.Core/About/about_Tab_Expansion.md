---
ms.date: 07/27/2021
description: Explains how to use the Tab Expansion feature in PowerShell.
Locale: en-US
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_tab_expansion?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About tab expansion
---
# about_Tab_Expansion

## Short description
PowerShell provides completions on input to provide hints, enable discovery and
speed up input entry. Command names, parameter names, argument values and file
paths can all be completed by pressing the <kbd>Tab</kbd> key.

## Long description

Tab expansion is controlled by the internal function **TabExpansion** or
**TabExpansion2**. Since this function can be modified or overridden, this
discussion is a guide to the behavior of the default PowerShell configuration.

The <kbd>Tab</kbd> key is the default key binding on Windows. This keybinding
can be changed by the PSReadLine module or the application that is hosting
PowerShell. The keybinding is different on non-Windows platforms. For more
information, see
[about_PSReadLine](/powershell/module/psreadline/about/about_psreadline#completion-functions).

> [!NOTE]
> One limitation of the tab expansion process is that tabs are always
> interpreted as attempts to complete a word. If you copy and paste command
> examples into a PowerShell console, make sure that the sample does not
> contain tabs; if it does, the results will be unpredictable and will almost
> certainly not be what you intended.

## File and cmdlet name completion

To fill in a filename or path from the available choices automatically, type
part of the name and press the <kbd>Tab</kbd> key. PowerShell will
automatically expand the name to the first match that it finds. Pressing the
<kbd>Tab</kbd> key repeatedly will cycle through all of the available choices.

The tab expansion of cmdlet names is slightly different. To use tab expansion
on a cmdlet name, type the entire first part of the name (the verb) and the
hyphen that follows it. You can fill in more of the name for a partial match.
For example, if you type `get-co` and then press the <kbd>Tab</kbd> key,
PowerShell will automatically expand this to the `Get-Command` cmdlet (notice
that it also changes the case of letters to their standard form). If you press
<kbd>Tab</kbd> key again, PowerShell replaces this with the only other matching
cmdlet name, `Get-Content`.

> [!NOTE]
> As of PowerShell 7.0, <kbd>Tab</kbd> will also expand abbreviated cmdlets and
> functions. For example, `i-psdf<tab>` returns `Import-PowerShellDataFile`.

Tab completion also works to resolve PowerShell alias and native executables.

You can use tab expansion repeatedly on the same line. For example, you can use
tab expansion on the name of the `Get-Content` cmdlet by entering:

### Examples

```
PS> Get-Con<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```
PS> Get-Content
```

You can then partially specify the path to the Active Setup log file and use
tab expansion again:

```
PS> Get-Content c:\windows\acts<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```
PS> Get-Content C:\windows\actsetup.log
```

PSReadLine also has a menu completion feature. The default key binding on
Windows is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.

```
PS> fore<Ctrl-Space>
```

When you press <kbd>Ctrl</kbd>-<kbd>Space</kbd>, PowerShell presents the full
list of matching values as a menu:

```
PS> foreach
foreach         ForEach-Object  foreach.cmd
```

In this example the string 'fore' is matched to `foreach` (PowerShell alias),
`ForEach-Object` (cmdlet), and `foreach.cmd` (native command). Use the arrow
keys to select the value you want.

## Parameter argument completion

Tab completion can also work to complete parameter arguments. This allows you
to use the <kbd>Tab</kbd> key to cycle through a list of possible values that
are valid for some parameter.

For more information see,
[about_Functions_Argument_Completion](about_Functions_Argument_Completion.md).

## Enumerated value completion

Beginning in PowerShell 7.0, support for tab completion of enums was added. You
can use tab completion to select the value you want anywhere an enum is used.
For example:

```
enum Suits {
    Clubs = 0
    Diamonds = 1
    Hearts = 2
    Spades = 3
}

[Suits]$suit = 'c<Tab>
```

Enumerated values are strings, so the value to be completed must start with a
single or double-quote character.

When you hit the <kbd>Tab</kbd> key, you get the following results:

```
[Suits]$suit = 'Clubs'
```

Tab completion also works with .NET enumerations.

```
[System.IO.FileAttributes]$attr = 'S<Tab><Tab>
```

Hitting the <kbd>Tab</kbd> key twice cycles through the two values that start
with the letter "S". The end result is:

```
[System.IO.FileAttributes]$attr = 'System'
```

Beginning in PowerShell 7.0, tab expansion was added for the values of
`ValidateSet` when assigning to a variable. For example, if you were typing the
following variable definition:

```
[ValidateSet('Chocolate', 'Strawberry', 'Vanilla')][string]$flavor = 'Strawberry'
$flavor = <tab>
```

When you hit the <kbd>Tab</kbd> key, you would get the following result:

```
$flavor = 'Chocolate'
```

## See also

- [about_Functions_Argument_Completion](about_Functions_Argument_Completion.md)
- [about_Requires](about_Requires.md)
- [about_Comment_Based_Help](about_Comment_Based_Help.md)
