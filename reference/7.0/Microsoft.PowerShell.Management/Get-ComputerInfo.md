---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-computerinfo?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ComputerInfo
---
# Get-ComputerInfo

## SYNOPSIS
Gets a consolidated object of system and operating system properties.

## SYNTAX

```
Get-ComputerInfo [[-Property] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-ComputerInfo` cmdlet gets a consolidated object of system and operating system properties.
This cmdlet was introduced in Windows PowerShell 5.1.

## EXAMPLES

### Example 1: Get all computer properties

```powershell
Get-ComputerInfo
```

This command gets all system and operating system properties from the computer.

### Example 2: Get all computer operating system properties

```powershell
Get-ComputerInfo -Property "os*"
```

This command gets all operating system properties from the computer.

## PARAMETERS

### -Property

Specifies, as a string array, the computer properties in which this cmdlet displays.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String[]

## OUTPUTS

### Microsoft.PowerShell.Management.ComputerInfo

## NOTES

This cmdlet is only available on Windows platforms.

## RELATED LINKS
