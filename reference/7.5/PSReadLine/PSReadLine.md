---
Download Help Link: https://aka.ms/powershell75-help
Help Version: 7.5.0.0
Locale: en-US
Module Guid: 5714753b-2afd-4492-a5fd-01d9e2cff8b5
Module Name: PSReadLine
ms.date: 12/04/2023
schema: 2.0.0
title: PSReadLine
---
# PSReadLine Module

## Description

The PSReadLine module contains cmdlets that let you customize the command-line
editing environment in PowerShell.

There have been many updates to PSReadLine since the version that ships in
Windows PowerShell 5.1.

- PowerShell 7.4.0 ships with PSReadLine 2.3.4
- PowerShell 7.3.0 ships with PSReadLine 2.2.6
- PowerShell 7.2.5 ships with PSReadLine 2.1.0
- PowerShell 7.0.11 ships with PSReadLine 2.0.4
- PowerShell 5.1 ships with PSReadLine 2.0.0

These articles document version 2.3.4 of PSReadLine.

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
