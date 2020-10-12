---
description: Explains how to create a customize how PowerShell reads input at the console prompt. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/04/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_psconsolehostreadline?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSConsoleHostReadLine
---
# about_PSConsoleHostReadLine

## SHORT DESCRIPTION
Explains how to create a customize how PowerShell reads input at the console
prompt.

## LONG DESCRIPTION

Starting in Windows PowerShell 3.0, you can write a function named
PSConsoleHostReadLine that overrides the default way that console input is
processed.

### EXAMPLES

The following example launches Notepad and gets input from a text File that
the user creates:

```powershell
function PSConsoleHostReadLine
{
  $inputFile = Join-Path $env:TEMP PSConsoleHostReadLine
  Set-Content $inputFile "PS > "

  # Notepad opens. Enter your command in it, save the file, and then exit.
  notepad $inputFile | Out-Null
  $userInput = Get-Content $inputFile
  $resultingCommand = $userInput.Replace("PS >", "")
  $resultingCommand
}
```

### REMARKS

By default, PowerShell reads input from the console in what is known as "Cooked
Mode" -- in which the Windows console subsystem handles all the keypresses, F7
menus, and other input. When you press Enter or Tab, PowerShell gets the text
that you have typed up to that point. There is no way for it to know that you
pressed Ctrl-R, Ctrl-A, Ctrl-E, or any other keys before pressing Enter or Tab.
In Windows PowerShell 3.0, the PSConsoleHostReadLine function solves this
issue. When you define a function named PSConsoleHostReadline in the PowerShell
console host, PowerShell calls that function instead of the "Cooked Mode" input
mechanism.

### SEE ALSO

[about_Prompts](about_Prompts.md)
