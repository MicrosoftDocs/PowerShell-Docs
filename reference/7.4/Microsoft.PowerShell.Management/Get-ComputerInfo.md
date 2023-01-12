---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 01/12/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-computerinfo?view=powershell-7.4&WT.mc_id=ps-gethelp
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

> **This cmdlet is only available on the Windows platform.**

The `Get-ComputerInfo` cmdlet gets a consolidated object of system and operating system properties.
This cmdlet was introduced in Windows PowerShell 5.1.

## EXAMPLES

### Example 1: Get all computer properties

This command gets all system and operating system properties from the computer.

```powershell
Get-ComputerInfo
```

### Example 2: Get all computer version properties

This command gets all version properties from the computer.

```powershell
Get-ComputerInfo -Property "*version"
```

```Output
WindowsCurrentVersion              : 6.3
WindowsVersion                     : 2009
BiosBIOSVersion                    : {LENOVO - 1380, N1FET64W (1.38 ), Lenovo - 1380}
BiosEmbeddedControllerMajorVersion : 1
BiosEmbeddedControllerMinorVersion : 17
BiosSMBIOSBIOSVersion              : N1FET64W (1.38 )
BiosSMBIOSMajorVersion             : 2
BiosSMBIOSMinorVersion             : 8
BiosSystemBiosMajorVersion         : 1
BiosSystemBiosMinorVersion         : 38
BiosVersion                        : LENOVO - 1380
OsVersion                          : 10.0.19043
OsCSDVersion                       :
OsServicePackMajorVersion          : 0
OsServicePackMinorVersion          : 0
```

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

You can pipe a string containing the name of a property to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Management.ComputerInfo

This cmdlet returns a **ComputerInfo** object.

## NOTES

PowerShell includes the following aliases for `Get-ComputerInfo`:

- Windows:
  - `gin`

This cmdlet is only available on Windows platforms.

## RELATED LINKS
