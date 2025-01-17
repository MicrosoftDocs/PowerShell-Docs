---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/28/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/set-timezone?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-TimeZone
---

# Set-TimeZone

## SYNOPSIS
Sets the system time zone to a specified time zone.

## SYNTAX

### Name (Default)

```
Set-TimeZone [-Name] <String> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Id

```
Set-TimeZone -Id <String> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject

```
Set-TimeZone [-InputObject] <TimeZoneInfo> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

> **This cmdlet is only available on the Windows platform.**

The `Set-TimeZone` cmdlet sets the system time zone to a specified time zone.

## EXAMPLES

### Example 1: Set the time zone by Id

This example sets the time zone on the local computer to UTC.

```powershell
Set-TimeZone -Id "UTC"
```

```Output
Id                         : UTC
HasIanaId                  : True
DisplayName                : (UTC) Coordinated Universal Time
StandardName               : Coordinated Universal Time
DaylightName               : Coordinated Universal Time
BaseUtcOffset              : 00:00:00
SupportsDaylightSavingTime : False
```

### Example 2: Set the time zone by name

This example sets the time zone on the local computer to UTC.

```powershell
Set-TimeZone -Name 'Coordinated Universal Time' -PassThru
```

As we saw in the previous example, the **Id** and the **Name** of the Time Zone do not always match.
The **Name** parameter must match the **StandardName** or **DaylightName** properties of the
**TimeZoneInfo** object.

> [!NOTE]
> The time zone names can vary based on the Culture settings in Windows. This example shows the
> values for a system set to `en-US`.

### Example 3 - List all available time zones

A full list of Time Zone IDs can be obtained by running the following command:

```powershell
Get-TimeZone -ListAvailable
```

## PARAMETERS

### -Id

Specifies the ID of the time zone that this cmdlet sets.

```yaml
Type: System.String
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

Specifies a **TimeZoneInfo** object to use as input.

```yaml
Type: System.TimeZoneInfo
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the name of the time zone that this cmdlet sets. A full list of Time Zone names can be
obtained by running the following command: `Get-TimeZone -ListAvailable`.

```yaml
Type: System.String
Parameter Sets: Name
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working. By default, this cmdlet does not
generate any output.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.TimeZoneInfo

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.TimeZoneInfo

When you use the **PassThru** parameter, this cmdlet returns a **TimeZoneInfo** object.

## NOTES

PowerShell includes the following aliases for `Set-TimeZone`:

- Windows:
  - `stz`

This cmdlet is only available on Windows platforms.

## RELATED LINKS

[Get-TimeZone](Get-TimeZone.md)
