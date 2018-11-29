---
external help file: PSDiagnostics-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDiagnostics
ms.date: 11/29/2018
schema: 2.0.0
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
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Event Tracing](/windows/desktop/ETW/event-tracing-portal)

[Start-Trace](start-trace.md)

[Disable-WSManTrace](Disable-WSManTrace.md)

