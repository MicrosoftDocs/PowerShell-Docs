---
external help file: PSDiagnostics-help.xml
Module Name: PSDiagnostics
online version:
schema: 2.0.0
ms.date:  11/27/2018
---

# Get-LogProperties

## SYNOPSIS
Retrieves the properties of a Windows event log.

## SYNTAX

```
Get-LogProperties [-Name] <string> [<CommonParameters>]
```

## DESCRIPTION

This cmdlet gets the configuration settings of a Windows event log. This cmdlet is used by the
`Enable-PSTrace` and `Disable-PSTrace` cmdlets.

## EXAMPLES

### Example 1: Get the configuration settings of the Windows PowerShell event log

```powershell
Get-LogProperties 'Windows PowerShell'
```

```Output
Name       : Windows PowerShell
Enabled    : True
Type       : Admin
Retention  : False
AutoBackup : False
MaxLogSize : 15728640
```

## PARAMETERS

### -Name

The name of the event provider.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### Microsoft.PowerShell.Diagnostics.LogDetails

The **PSDiagnostics** module adds the **LogDetails** class to the
`Microsoft.PowerShell.Diagnostics` namespace.

## NOTES

## RELATED LINKS

[Set-LogProperties](Set-LogProperties.md)

[Enable-PSTrace](Enable-PSTrace.md)

[Disable-PSTrace](Disable-PSTrace.md)
