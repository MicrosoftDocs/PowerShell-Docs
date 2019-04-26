---
external help file: PSDiagnostics-help.xml
Module Name: PSDiagnostics
online version:
schema: 2.0.0
ms.date:  11/27/2018
---
# Enable-PSTrace

## SYNOPSIS
Enables the Microsoft-Windows-PowerShell event provider logs.

## SYNTAX

```
Enable-PSTrace [-Force] [-AnalyticOnly]
```

## DESCRIPTION

This cmdlet enables the Operational and Analytic event logs of the Microsoft-Windows-PowerShell
event provider.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Enable the Analytic event log for PowerShell

The following example enables only the Analytic event log of the Microsoft-Windows-PowerShell
provider.

```powershell
Enable-PSTrace -AnalyticOnly
```

## PARAMETERS

### -AnalyticOnly

When this parameter is used, the cmdlet enables the Analytic event log of the
Microsoft-Windows-PowerShell provider. The Operational event log is not changed.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Used to force the change without prompting.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### None

## NOTES

This cmdlet uses the `Get-LogProperties` and `Set-LogProperties` cmdlets.

You must run this cmdlet from an elevated PowerShell session.

## RELATED LINKS

[Get-LogProperties](Get-LogProperties.md)

[Set-LogProperties](Set-LogProperties.md)

[Disable-PSTrace](Disable-PSTrace.md)