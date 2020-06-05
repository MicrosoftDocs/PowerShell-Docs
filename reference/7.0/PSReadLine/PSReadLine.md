---
Download Help Link: https://go.microsoft.com/fwlink/?linkid=2113630
Help Version: 7.0.1.0
keywords: powershell
Locale: en-US
Module Guid: 5714753b-2afd-4492-a5fd-01d9e2cff8b5
Module Name: PSReadLine
ms.date: 02/10/2020
schema: 2.0.0
title: PSReadLine
---

# PSReadLine Module

## Description

The PSReadLine module contains cmdlets that let you customize the command-line editing environment
in PowerShell. These articles documents PSReadLine v2.0. This version ships in PowerShell v6 and
the Windows 10 October 2018 Update (Build 1809).

> [!NOTE]
> Beginning with PowerShell 7.0, PowerShell skips auto-loading PSReadLine on
> Windows if a screen reader program is detected. Currently, PSReadLine doesn't
> work well with the screen readers. The default rendering and formatting of
> PowerShell 7.0 on Windows works properly. You can manually load the module if
> necessary.

## PSReadLine Cmdlets

### [PSConsoleHostReadLine](PSConsoleHostReadLine.md)
The main entry point for PSReadLine.

### [Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)
Gets the key bindings for the PSReadLine module.

### [Get-PSReadLineOption](Get-PSReadLineOption.md)
Returns the values for the options that can be configured.

### [PSConsoleHostReadline](PSConsoleHostReadline.md)
This function is the main entry point for PSReadLine.

### [Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)
Removes a key binding.

### [Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)
Binds keys to user-defined or PSReadLine key handler functions.

### [Set-PSReadLineOption](Set-PSReadLineOption.md)
Customizes the behavior of command line editing in PSReadLine.
