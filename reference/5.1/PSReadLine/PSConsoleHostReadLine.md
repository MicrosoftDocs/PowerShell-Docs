---
external help file: PSReadLine-help.xml
Locale: en-US
Module Name: PSReadLine
ms.date: 01/09/2025
online version: https://learn.microsoft.com/powershell/module/psreadline/psconsolehostreadline?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: PSConsoleHostReadLine
---

# PSConsoleHostReadLine

## SYNOPSIS
This function is the main entry point for PSReadLine.

## SYNTAX

```
PSConsoleHostReadLine
```

## DESCRIPTION

`PSConsoleHostReadLine` is the main entry point for the PSReadLine module. The PowerShell console
host automatically loads the PSReadLine module and calls this function. Under normal operating
conditions, this function isn't intended to be used from the command line.

The extension point `PSConsoleHostReadLine` is special to the console host. The host calls any
alias, function, or script with this name. PSReadLine defines this function so that it is called
from the console host.

## EXAMPLES

### Example 1

This function isn't intended to be used from the command line.

```powershell
PSConsoleHostReadLine
```

## PARAMETERS

## INPUTS

### None

## OUTPUTS

### None

## NOTES

The purpose of this article is to document that this function exists and is used by the PSReadLine
module.

## RELATED LINKS

[about_PSReadLine](./About/about_PSReadLine.md)
