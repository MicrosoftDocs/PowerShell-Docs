---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 11/29/2018
online version: https://docs.microsoft.com/powershell/module/psdiagnostics/disable-wsmantrace?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-WSManTrace
---
# Disable-WSManTrace

## Synopsis
Stop the WSMan logging session started by Enable-WSManTrace.

## Syntax

```
Disable-WSManTrace [<CommonParameters>]
```

## Description

> **This cmdlet is only available on the Windows platform.**

This cmdlet stops the WSMan logging session started by Enable-WSManTrace.

This cmdlet uses the `Stop-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## Examples

### Example 1: Stop a WSMan trace

```powershell
Disable-WSManTrace
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

[Enable-WSManTrace](Enable-WSManTrace.md)

