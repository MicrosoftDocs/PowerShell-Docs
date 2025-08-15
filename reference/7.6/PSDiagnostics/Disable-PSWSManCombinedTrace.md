---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/psdiagnostics/disable-pswsmancombinedtrace?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSWSManCombinedTrace
---

# Disable-PSWSManCombinedTrace

## SYNOPSIS
Stop the logging session started by Enable-PSWSManCombinedTrace.

## SYNTAX

```
Disable-PSWSManCombinedTrace [<CommonParameters>]
```

## DESCRIPTION

> **This cmdlet is only available on the Windows platform.**

This cmdlet stops the logging session started by `Enable-PSWSManCombinedTrace`.

This cmdlet uses the `Stop-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Disable the combined logging session

```powershell
Disable-PSWSManCombinedTrace
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS

[Event Tracing](/windows/desktop/ETW/event-tracing-portal)

[Stop-Trace](stop-trace.md)

[Enable-PSWSManCombinedTrace](Enable-PSWSManCombinedTrace.md)
