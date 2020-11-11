---
description: Describes how to get and run commands in the command history. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 05/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_history?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_History
---
# About History

## Short Description
Describes how to get and run commands in the command history.

## Long Description

When you enter a command at the command prompt, PowerShell saves the command in
the command history. You can use the commands in the history as a record of
your work. And, you can recall and run the commands from the command history.

PowerShell has two different history providers: the built-in history and the
history managed by the **PSReadLine** module. The histories are managed
separately, but both histories are available in sessions where **PSReadLine**
is loaded.

## Using the PSReadLine history

The PSReadLine history tracks the commands used in all PowerShell sessions.
The history is written to a central file per host. That history file is
available to all sessions and contains all past history. The history is not
deleted when the session ends. Also, that history cannot be managed by the
`*-History` cmdlets. For more information, see
[about_PSReadLine](../../PSReadLine/About/about_PSReadLine.md).

## Using the built-in session history

The built-in history only tracks the commands used in the current session. The
history is not available to other sessions and is deleted when the session ends.

### History Cmdlets

PowerShell has a set of cmdlets that manage the command history.

| Cmdlet           | Alias  | Description                                |
| ---------------- | ------ | ------------------------------------------ |
| `Get-History`    | `h`    | Gets the command history.                  |
| `Invoke-History` | `r`    | Runs a command in the command history.     |
| `Add-History`    |        | Adds a command to the command history.     |
| `Clear-History`  | `clhy` | Deletes commands from the command history. |

### Keyboard Shortcuts for Managing History

In the PowerShell console, you can use the following shortcuts to manage the
command history.

- <kbd>UpArrow</kbd> - Displays the previous command.
- <kbd>DownArrow</kbd> - Displays the next command.
- <kbd>F7</kbd> - Displays the command history.
- <kbd>ESC</kbd> - To hide the history.
- <kbd>F8</kbd> - Finds a command. Type one or more characters then press
  <kbd>F8</kbd>. Press <kbd>F8</kbd> again the next instance.
- <kbd>F9</kbd> - Find a command by history ID. Type the history ID then press
  <kbd>F9</kbd>. Press <kbd>F7</kbd> to find the ID.
- <kbd>#</kbd>`<string>`</kbd><kbd>Tab</kbd> - Search the history for
  `*<string>*` and returns the most recent match. If you press <kbd>Tab</kbd>
  repeatedly, it cycles through the matching items in your history.

> [!NOTE]
> These key bindings are implemented by the console host application. Other
> applications, such as Visual Studio Code or Windows Terminal, can have
> different key bindings. The bindings can be overridden by the PSReadLine
> module. PSReadLine loads automatically when you start a PowerShell session.
> With PSReadLine loaded, <kbd>F7</kbd> and <kbd>F9</kbd> are not bound to any
> function. PSReadLine does not provide equivalent functionality. For more
> information, see [about_PSReadLine](../../PSReadLine/About/about_PSReadLine.md).

### MaximumHistoryCount

The `$MaximumHistoryCount` preference variable determines the maximum number of
commands that PowerShell saves in the command history. The default value is
4096.

For example, the following command lowers the `$MaximumHistoryCount` to 100
commands:

```powershell
$MaximumHistoryCount = 100
```

To apply the setting, restart PowerShell.

To save the new variable value for all your PowerShell sessions, add the
assignment statement to a PowerShell profile. For more information about
profiles, see [about_Profiles](about_Profiles.md).

For more information about the `$MaximumHistoryCount` preference variable, see
[about_Preference_Variables](about_Preference_Variables.md).

### Order of Commands in the History

Commands are added to the history when the command finishes executing, not when
the command is entered. If commands take some time to be completed, or if the
commands are executing in a nested prompt, the commands might appear to be out
of order in the history. Commands that are executing in a nested prompt are
completed only when you exit the prompt level.

## See Also

- [about_Line_Editing](about_Line_Editing.md)
- [about_Preference_Variables](about_Preference_Variables.md)
- [about_Profiles](about_Profiles.md)
- [about_Variables](about_Variables.md)
- [about_PSReadLine](../../PSReadLine/About/about_PSReadLine.md)
