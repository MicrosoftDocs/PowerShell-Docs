---
external help file: PSDiagnostics-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDiagnostics
ms.date:  11/27/2018
schema: 2.0.0
---

# Stop-Trace

## SYNOPSIS
Stop an Event Trace logging session.

## SYNTAX

```
Stop-Trace [-SessionName] <Object> [-ETS] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet stops a Windows Event Trace logging session.

This cmdlet is used by the following cmdlets:

- `Disable-PSWSManCombinedTrace`
- `Disable-WSManTrace`

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Stop a WSMan Trace logging session

```powershell
Stop-Trace -SessionName 'wsmlog'
```

## PARAMETERS

### -ETS
Send commands to Event Trace Sessions directly without saving or scheduling.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionName
The name of the Event Trace session to be stopped.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

[Disable-PSWSManCombinedTrace](Disable-PSWSManCombinedTrace.md)

[Disable-WSManTrace](Disable-WSManTrace.md)

[Enable-PSWSManCombinedTrace](Enable-PSWSManCombinedTrace.md)

[Enable-WSManTrace](Enable-WSManTrace.md)
