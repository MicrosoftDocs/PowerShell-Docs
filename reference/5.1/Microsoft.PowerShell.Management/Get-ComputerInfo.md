---
author: jpjofre
description: 
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell, cmdlet
manager: carolz
ms.date: 2016-10-11
ms.prod: powershell
ms.technology: powershell
ms.topic: reference
online version: http://go.microsoft.com/fwlink/?LinkId=822226
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
The **Get-ComputerInfo** cmdlet gets a consolidated object of system and operating system properties.

## EXAMPLES

### Example 1: Get all computer properties
```
PS C:\>Get-ComputerInfo
```

This command gets all system and operating system properties from the computer.

### Example 2: Get all computer operating system properties
```
PS C:\>Get-ComputerInfo -Property "os*"
```

This command gets all operating system properties from the computer.

## PARAMETERS

### -Property
Specifies, as a string array, the computer properties in which this cmdlet displays.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### Microsoft.PowerShell.Management.ComputerInfo

## NOTES

## RELATED LINKS

