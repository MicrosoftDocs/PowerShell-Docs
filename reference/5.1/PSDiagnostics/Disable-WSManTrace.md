---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/psdiagnostics/disable-wsmantrace?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-WSManTrace
---

# Disable-WSManTrace

## SYNOPSIS
Stop the WSMan logging session started by Enable-WSManTrace.

## SYNTAX

```
Disable-WSManTrace [<CommonParameters>]
```

## DESCRIPTION
This cmdlet stops the WSMan logging session started by Enable-WSManTrace.

This cmdlet uses the `Stop-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Stop a WSMan trace

```powershell
Disable-WSManTrace
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

[Enable-WSManTrace](Enable-WSManTrace.md)
