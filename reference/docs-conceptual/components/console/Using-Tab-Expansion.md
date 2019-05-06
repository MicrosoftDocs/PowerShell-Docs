---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Using Tab Expansion
ms.assetid:  c8730471-bf6a-43b8-ab1d-f9ef5a74f04e
---
# Using Tab Expansion

Command-line shells often provide a way to complete the names of long files or commands
automatically, speeding up command entry and providing hints. PowerShell allows you to fill in file
names and cmdlet names by pressing the <kbd>Tab</kbd> key.

> [!NOTE]
> Tab expansion is controlled by the internal function TabExpansion or TabExpansion2. Since this
> function can be modified or overridden, this discussion is a guide to the behavior of the default
> PowerShell configuration.

To fill in a filename or path from the available choices automatically, type part of the name and
press the <kbd>Tab</kbd> key. PowerShell will automatically expand the name to the first match that
it finds. Pressing the <kbd>Tab</kbd> key repeatedly will cycle through all of the available
choices.

The tab expansion of cmdlet names is slightly different. To use tab expansion on a cmdlet name, type
the entire first part of the name (the verb) and the hyphen that follows it. You can fill in more of
the name for a partial match. For example, if you type `get-co` and then press the <kbd>Tab</kbd>
key, PowerShell will automatically expand this to the `Get-Command` cmdlet (notice that it also
changes the case of letters to their standard form). If you press <kbd>Tab</kbd> key again,
PowerShell replaces this with the only other matching cmdlet name, `Get-Content`.

You can use tab expansion repeatedly on the same line. For example, you can use tab expansion on the
name of the `Get-Content` cmdlet by entering:

```
PS> Get-Con<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```
PS> Get-Content
```

You can then partially specify the path to the Active Setup log file and use tab expansion again:

```
PS> Get-Content c:\windows\acts<Tab>
```

When you press the <kbd>Tab</kbd> key, the command expands to:

```
PS> Get-Content C:\windows\actsetup.log
```

> [!NOTE]
> One limitation of the tab expansion process is that tabs are always interpreted as attempts to
> complete a word. If you copy and paste command examples into a PowerShell console, make sure that
> the sample does not contain tabs; if it does, the results will be unpredictable and will almost
> certainly not be what you intended.