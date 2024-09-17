---
Download Help Link: https://aka.ms/powershell74-help
Help Version: 7.4.0.0
Locale: en-US
Module Guid: 5714753b-2afd-4492-a5fd-01d9e2cff8b5
Module Name: PSReadLine
ms.date: 09/17/2024
schema: 2.0.0
title: PSReadLine
---
# PSReadLine Module

## Description

The PSReadLine module contains cmdlets that let you customize the command-line
editing environment in PowerShell.

There have been many updates to PSReadLine since the version that ships in
Windows PowerShell 5.1.

- v2.3.5 first shipped in PowerShell 7.4.2 and 7.5.0-preview.3
- v2.3.4 first shipped in PowerShell 7.4.0-rc.1
- v2.2.6 first shipped in PowerShell 7.3.0
- v2.1.0 first shipped in PowerShell 7.2.5
- v2.0.4 first shipped in PowerShell 7.0.11
- v2.0.0 ships in Windows PowerShell 5.1

For more information about version differences, see
[about_PSReadLine_Release_Notes](about/about_PSReadLine_Release_Notes.md).

These articles document version 2.3.5 of PSReadLine.

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
Gets values for the options that can be configured.

### [PSConsoleHostReadLine](PSConsoleHostReadLine.md)
This function is the main entry point for PSReadLine.

### [Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)
Removes a key binding.

### [Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)
Binds keys to user-defined or PSReadLine key handler functions.

### [Set-PSReadLineOption](Set-PSReadLineOption.md)
Customizes the behavior of command line editing in **PSReadLine**.
