---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 11/11/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-timezone?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - gtz
title: Get-TimeZone
---
# Get-TimeZone

## SYNOPSIS
Gets the current time zone or a list of available time zones.

## SYNTAX

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

## DESCRIPTION

The `Get-TimeZone` cmdlet gets the current time zone or a list of available time zones.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

### System.String[]

## OUTPUTS

### System.TimeZoneInfo[]

## NOTES

Windows PowerShell includes the following aliases for `Get-TimeZone`:

- `gtz`

## RELATED LINKS

[Set-TimeZone](Set-TimeZone.md)
