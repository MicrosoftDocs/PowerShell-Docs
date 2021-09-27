---
external help file: PSDiagnostics-help.xml
Locale: en-US
Module Name: PSDiagnostics
ms.date: 11/27/2018
online version: https://docs.microsoft.com/powershell/module/psdiagnostics/disable-pstrace?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSTrace
---
# Disable-PSTrace

## Synopsis
Disables the Microsoft-Windows-PowerShell event provider logs.

## Syntax

```
Disable-PSTrace [-AnalyticOnly] [<CommonParameters>]
```

## Description

This cmdlet disables the Operational and Analytic event logs of the Microsoft-Windows-PowerShell
event provider.

You must run this cmdlet from an elevated PowerShell session.

## Examples

### Example 1: Disable the Analytic event log for PowerShell

The following example disables only the Analytic event log of the Microsoft-Windows-PowerShell
provider.

```powershell
Disable-PSTrace -AnalyticOnly
```

## Parameters

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

## Inputs

### None

## Outputs

### System.Object

## Notes

This cmdlet uses the `Get-LogProperties` and `Set-LogProperties` cmdlets.

You must run this cmdlet from an elevated PowerShell session.

## Related links

[Get-LogProperties](Get-LogProperties.md)

[Set-LogProperties](Set-LogProperties.md)

[Enable-PSTrace](Enable-PSTrace.md)
