---
external help file: PSReadLine-help.xml
Locale: en-US
Module Name: PSReadLine
ms.date: 12/07/2018
online version: https://docs.microsoft.com/powershell/module/psreadline/psconsolehostreadline?view=powershell-7.2&WT.mc_id=ps-gethelp
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
conditions, this function is not intended to be used from the command line.

The extension point `PSConsoleHostReadLine` is special to the console host. The host calls any
alias, function, or script with this name. PSReadLine defines this function so that it is called
from the console host.

## EXAMPLES

### Example 1

This function is not intended to be used from the command line.

## PARAMETERS

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[about_PSReadLine](./About/about_PSReadLine.md)

