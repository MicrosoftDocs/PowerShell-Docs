---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 11/29/2018
online version: https://docs.microsoft.com/powershell/module/psdiagnostics/enable-wsmantrace?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Enable-WSManTrace
---
# Enable-WSManTrace

## SYNOPSIS
Start a logging session with the WSMan providers enabled.

## SYNTAX

```
Enable-WSManTrace [<CommonParameters>]
```

## DESCRIPTION
This cmdlet starts a logging session with the WSMan providers enabled. The following event providers are enabled:

- Event Forwarding
- IpmiDrv
- IPMIPrv
- WinRM
- WinrsCmd
- WinrsExe
- WinrsMgr
- WSManProvHost

The session is named 'wsmlog'.

This cmdlet uses the `Start-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Start a WSMan logging session.

```powershell
Enable-WSManTrace
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Event Tracing](/windows/desktop/ETW/event-tracing-portal)

[Start-Trace](start-trace.md)

[Disable-WSManTrace](Disable-WSManTrace.md)

