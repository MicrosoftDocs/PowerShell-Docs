---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-timezone?view=powershell-7.3&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-TimeZone
---
# Get-TimeZone

## Synopsis
Gets the current time zone or a list of available time zones.

## Syntax

### Name (Default)

```
Get-TimeZone [[-Name] <String[]>] [<CommonParameters>]
```

### Id

```
Get-TimeZone -Id <String[]> [<CommonParameters>]
```

### ListAvailable

```
Get-TimeZone [-ListAvailable] [<CommonParameters>]
```

## Description

> **This cmdlet is only available on the Windows platform.**

The `Get-TimeZone` cmdlet gets the current time zone or a list of available time zones.

## Examples

### Example 1: Get the current time zone

```powershell
Get-TimeZone
```

This command gets the current time zone.

### Example 2: Get time zones that match a specified string

```powershell
Get-TimeZone -Name "*pac*"
```

```Output
Pacific Standard Time (Mexico)

(UTC-08:00) Pacific Time (US &amp; Canada)

Pacific Standard Time

SA Pacific Standard Time

Pacific SA Standard Time

West Pacific Standard Time

Central Pacific Standard Time
```

This command gets all time zones that match the specified wildcard.

### Example 3: Get all available time zones

```powershell
Get-TimeZone -ListAvailable
```

This command gets all available time zones.

## Parameters

### -Id

Specifies, as a string array, the ID or IDs of the time zones that this cmdlet gets.

```yaml
Type: System.String[]
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ListAvailable

Indicates that this cmdlet gets all available time zones.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ListAvailable
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies, as a string array, the name or names of the time zones that this cmdlet gets.

```yaml
Type: System.String[]
Parameter Sets: Name
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String[]

## Outputs

### System.TimeZoneInfo[]

## Notes

This cmdlet is only available on Windows platforms.

## Related links

[Set-TimeZone](Set-TimeZone.md)
