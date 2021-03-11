---
Download Help Link: https://aka.ms/powershell72-help
Help Version: 7.2.0.0
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
in PowerShell. These articles document the current beta version of PSReadLine v2.2.0.

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
Gets the bound key functions for the PSReadLine module.

### [Get-PSReadLineOption](Get-PSReadLineOption.md)
Gets values for the options that can be configured.

### [PSConsoleHostReadLine](PSConsoleHostReadLine.md)
This function is the main entry point for PSReadLine.

### [Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)
Removes a key binding.

### [Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)
Binds keys to user-defined or PSReadLine key handler functions.

### [Set-PSReadLineOption](Set-PSReadLineOption.md)
Customizes the behavior of command line editing in **PSReadLine**.

