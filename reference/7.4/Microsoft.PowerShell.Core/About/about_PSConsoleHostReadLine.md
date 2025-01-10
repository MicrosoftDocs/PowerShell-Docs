---
description: Explains how to customize how PowerShell reads input at the console prompt.
Locale: en-US
ms.date: 01/09/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_psconsolehostreadline?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSConsoleHostReadLine
---
# about_PSConsoleHostReadLine

## Short description
Explains how to customize how PowerShell reads input at the console prompt.

## Long description

Starting in Windows PowerShell 3.0, you can write a function named
`PSConsoleHostReadLine` that overrides the default way that console input is
processed.

This function is extended by the **PSReadLine** module.

### Examples

The following example launches Notepad and gets input from a text file that
the user creates:

```powershell
function PSConsoleHostReadLine {
  $inputFile = Join-Path $env:TEMP PSConsoleHostReadLine
  Set-Content $inputFile "PS > "

  # Notepad opens. Enter your command in it, save the file, and then exit.
  notepad $inputFile | Out-Null
  $userInput = Get-Content $inputFile
  $resultingCommand = $userInput.Replace("PS >", "")
  $resultingCommand
}
```

### Remarks

By default, PowerShell reads input from the console in what is known as "Cooked
Mode" -- in which the Windows console subsystem handles all the keypresses,
<kbd>F7</kbd> menus, and other input. When you press <kbd>Enter</kbd> or
<kbd>Tab</kbd>, PowerShell gets the text that you have typed up to that point.
There is no way for it to know that you pressed <kbd>Ctrl</kbd>+<kbd>R</kbd>,
<kbd>Ctrl</kbd>+<kbd>A</kbd>, <kbd>Ctrl</kbd>+<kbd>E</kbd>, or any other keys
before pressing <kbd>Enter</kbd> or <kbd>Tab</kbd>. In Windows PowerShell 3.0,
the `PSConsoleHostReadLine` function solves this issue. When you define a
function named `PSConsoleHostReadline` in the PowerShell console host,
PowerShell calls that function instead of the "Cooked Mode" input mechanism.

## See Also

- [about_Prompts](about_Prompts.md)
- [PSConsoleHostReadLine](/powershell/module/psreadline/psconsolehostreadline)
- [High-Level Console Modes](/windows/console/high-level-console-modes)
