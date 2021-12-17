---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 11/29/2018
online version: https://docs.microsoft.com/powershell/module/psdiagnostics/disable-pswsmancombinedtrace?view=powershell-7.3&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSWSManCombinedTrace
---
# Disable-PSWSManCombinedTrace

## Synopsis
Stop the logging session started by Enable-PSWSManCombinedTrace.

## Syntax

```
Disable-PSWSManCombinedTrace [<CommonParameters>]
```

## Description

> **This cmdlet is only available on the Windows platform.**

This cmdlet stops the logging session started by `Enable-PSWSManCombinedTrace`.

This cmdlet uses the `Stop-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## Examples

### Example 1: Disable the combined logging session

```powershell
Disable-PSWSManCombinedTrace
```

## Parameters

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### None

## Notes

## Related links

[Event Tracing](/windows/desktop/ETW/event-tracing-portal)

[Stop-Trace](stop-trace.md)

[Enable-PSWSManCombinedTrace](Enable-PSWSManCombinedTrace.md)

