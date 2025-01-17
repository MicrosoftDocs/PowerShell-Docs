---
description: Explains how to use the Tab Expansion feature in PowerShell.
Locale: en-US
ms.date: 06/13/2024
no-loc: [<kbd>Tab</kbd>, <kbd>Ctrl</kbd>, <kbd>Space</kbd>]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_tab_expansion?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About_tab_expansion
---
# about_Tab_Expansion

## Short description

PowerShell provides completions on input to provide hints, enable discovery,
and speed up input entry. Command names, parameter names, argument values and
file paths can all be completed by pressing the <kbd>Tab</kbd> key.

## Long description

Tab expansion is controlled by the internal function **TabExpansion2**. Since
this function can be modified or overridden, this discussion is a guide to the
behavior of the default PowerShell configuration.

Tab expansion behavior can also be modified by the Predictive IntelliSense
feature of the PSReadLine module. For more information, see
[Predictive IntelliSense][01].

The <kbd>Tab</kbd> key is the default key binding on Windows. You can change
the keybinding using the PSReadLine module or the application that's hosting
PowerShell. The keybinding is different on non-Windows platforms. For more
information, see [about_PSReadLine][02].

> [!NOTE]
> One limitation of the tab expansion process is that tabs are always
> interpreted as attempts to complete a word. If you copy and paste command
> examples into a PowerShell console, make sure that the sample doesn't
> contain tabs. If it does, the results will be unpredictable and will almost
> certainly not be what you intended.

## File and cmdlet name completion

To fill in a filename or path from the available choices automatically, type
part of the name and press the <kbd>Tab</kbd> key. PowerShell automatically
expands the name to the first match that it finds. Pressing the <kbd>Tab</kbd>
key repeatedly cycles through all the available choices.

When the tilde character (`~`) appears at the beginning of a path, PowerShell
interprets it as the user's home directory. This interpretation is common on
Linux and macOS systems. However, many native commands on Windows don't use
this interpretation. Beginning in PowerShell 7.5-preview.3 on Windows, the
tilde character is character is expanded to `$HOME` when using tab completion.
This expansion works with Windows native commands.

## Cmdlet name completion

The tab expansion of cmdlet names is slightly different. To use tab expansion
on a cmdlet name, type the entire first part of the name (the verb) and the
hyphen that follows it. You can fill in more of the name for a partial match.
For example, if you type `get-co` and then press the <kbd>Tab</kbd> key,
PowerShell automatically expands this to the `Get-Command` cmdlet. Notice that
it also changes the case of letters to their standard form. If you press
<kbd>Tab</kbd> key again, PowerShell replaces this with the only other matching
cmdlet name, `Get-Content`.

> [!NOTE]
> As of PowerShell 7.0, <kbd>Tab</kbd> also expands abbreviated cmdlets and
> functions. For example, `i-psdf<tab>` returns `Import-PowerShellDataFile`.

Tab completion also works to resolve PowerShell alias and native executables.

You can use tab expansion repeatedly on the same line. For example, you can use
tab expansion on the name of the `Get-Content` cmdlet by entering:

### Examples

```powershell
PS> Get-Con<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```powershell
PS> Get-Content
```

You can then partially specify the path to the Active Setup log file and use
tab expansion again:

```powershell
PS> Get-Content c:\windows\acts<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```powershell
PS> Get-Content C:\windows\actsetup.log
```

PSReadLine also has a menu completion feature. The default key binding on
Windows is <kbd>Ctrl</kbd>+<kbd>Space</kbd>.

```powershell
PS> fore<Ctrl-Space>
```

When you press <kbd>Ctrl</kbd>+<kbd>Space</kbd>, PowerShell presents the full
list of matching values as a menu:

```powershell
PS> foreach
foreach         ForEach-Object  foreach.cmd
```

In this example the string 'fore' is matched to `foreach` (PowerShell alias),
`ForEach-Object` (cmdlet), and `foreach.cmd` (native command). Use the arrow
keys to select the value you want.

## Parameter argument completion

Tab completion can also work to complete parameter arguments. You can use the
<kbd>Tab</kbd> key to cycle through a list of possible values that are valid
for some parameter. For more information, see
[about_Functions_Argument_Completion][04].

## Enumerated value completion

PowerShell 7.0 added support for tab completion of enums. You can use tab
completion to select the value you want anywhere you use an enum. For example:

```powershell
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

```powershell
[Suits]$suit = 'Clubs'
```

Tab completion also works with .NET enumerations.

```powershell
[System.IO.FileAttributes]$attr = 'S<Tab><Tab>
```

Hitting the <kbd>Tab</kbd> key twice cycles through the two values that start
with the letter `S`. The end result is:

```powershell
[System.IO.FileAttributes]$attr = 'System'
```

Beginning in PowerShell 7.0, tab expansion was added for the values of
`ValidateSet` when assigning to a variable. For example, if you were typing the
following variable definition:

```powershell
[ValidateSet('Chocolate', 'Strawberry', 'Vanilla')]
[string]$flavor = 'Strawberry'
$flavor = <tab>
```

When you hit the <kbd>Tab</kbd> key, you would get the following result:

```powershell
$flavor = 'Chocolate'
```

## Tab completions for comment-based keywords

Beginning in PowerShell 7.2, support was added for tab completion of the
`#requires` parameters and the keywords for comment-based help.

### Example for `#requires` statement

```powershell
#requires -<Ctrl-Space>
```

Menu expansion shows the following parameter options:

```powershell
#requires -<Ctrl-Space>
Modules     PSEdition     RunAsAdministrator    Version
```

### Example for comment-based help

```powershell
<#
    .<Ctrl-Space>
```

Menu expansion shows the following keyword options:

```powershell
 <#
    .COMPONENT
COMPONENT      EXTERNALHELP           FUNCTIONALITY     NOTES         REMOTEHELPRUNSPACE
DESCRIPTION    FORWARDHELPCATEGORY    INPUTS            OUTPUTS       ROLE
EXAMPLE        FORWARDHELPTARGETNAME  LINK              PARAMETER     SYNOPSIS
```

## See also

- [TabExpansion2][06]
- [about_Comment_Based_Help][03]
- [about_Functions_Argument_Completion][04]
- [about_Requires][05]

<!-- link references -->
[01]: /powershell/module/psreadline/about/about_psreadline#predictive-intellisense
[02]: /powershell/module/psreadline/about/about_psreadline#completion-functions
[03]: about_Comment_Based_Help.md
[04]: about_Functions_Argument_Completion.md
[05]: about_Requires.md
[06]: xref:Microsoft.PowerShell.Core.TabExpansion2
