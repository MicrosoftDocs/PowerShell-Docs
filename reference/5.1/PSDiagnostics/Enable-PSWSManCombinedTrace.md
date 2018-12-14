---
external help file: PSDiagnostics-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDiagnostics
ms.date: 11/29/2018
schema: 2.0.0
---

# Enable-PSWSManCombinedTrace

## SYNOPSIS
Start a logging session with the WSMan and PowerShell providers enabled.

## SYNTAX

```
Enable-PSWSManCombinedTrace [-DoNotOverwriteExistingTrace] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet starts a logging session with the following PowerShell providers enabled:

- Microsoft-Windows-PowerShell
- Microsoft-Windows-WinRM

The session is named 'PSTrace'.

This cmdlet uses the `Start-Trace` cmdlet.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Start a combined logging session

```powershell
Enable-PSWSManCombinedTrace
```

## PARAMETERS

### -DoNotOverwriteExistingTrace

By default, the events are written to "$pshome\Traces\PSTrace.etl". When this parameter is used,
the cmdlet creates a unique filename: "$pshome\Traces\PSTrace_{guid}.etl"

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
