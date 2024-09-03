---
description: Explains how to use the Tab Expansion feature in PowerShell.
Locale: en-US
ms.date: 06/13/2024
no-loc: [<kbd>Tab</kbd>, <kbd>Ctrl</kbd>, <kbd>Space</kbd>]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_tab_expansion?view=powershell-5.1&WT.mc_id=ps-gethelp
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
PowerShell. For more information, see [about_PSReadLine][02].

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

The tab expansion of cmdlet names is slightly different. To use tab expansion
on a cmdlet name, type the entire first part of the name (the verb) and the
hyphen that follows it. You can fill in more of the name for a partial match.
For example, if you type `get-co` and then press the <kbd>Tab</kbd> key,
PowerShell automatically expands this to the `Get-Command` cmdlet. Notice that
it also changes the case of letters to their standard form. If you press
<kbd>Tab</kbd> key again, PowerShell replaces this with the only other matching
cmdlet name, `Get-Content`.

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
