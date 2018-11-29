---
external help file: PSDiagnostics-help.xml
Module Name: PSDiagnostics
online version:
schema: 2.0.0
ms.date:  11/27/2018
---

# Disable-PSTrace

## SYNOPSIS
Disables the Microsoft-Windows-PowerShell event provider logs.

## SYNTAX

```
Disable-PSTrace [-AnalyticOnly]
```

## DESCRIPTION

This cmdlet disables the Operational and Analytic event logs of the Microsoft-Windows-PowerShell
event provider.

You must run this cmdlet from an elevated PowerShell session.

## EXAMPLES

### Example 1: Disable the Analytic event log for PowerShell

The following example disables only the Analytic event log of the Microsoft-Windows-PowerShell
provider.

```powershell
Disable-PSTrace -AnalyticOnly
```

## PARAMETERS

### -AnalyticOnly

When this parameter is used, the cmdlet disables the Analytic event log of the
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

[Enable-PSTrace](Enable-PSTrace.md)
