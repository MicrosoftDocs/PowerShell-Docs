---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/27/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-uptime?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Uptime
---

# Get-Uptime

## SYNOPSIS
Get the **TimeSpan** since last boot.

## SYNTAX

### Timespan (Default)

```
Get-Uptime [<CommonParameters>]
```

### Since

```
Get-Uptime [-Since] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet returns the time elapsed since the last boot of the operating system.

The `Get-Uptime` cmdlet was introduced in PowerShell 6.0.

## EXAMPLES

### Example 1 - Show time since last boot

```powershell
Get-Uptime
```

```Output
Days              : 9
Hours             : 0
Minutes           : 9
Seconds           : 45
Milliseconds      : 0
Ticks             : 7781850000000
TotalDays         : 9.00677083333333
TotalHours        : 216.1625
TotalMinutes      : 12969.75
TotalSeconds      : 778185
TotalMilliseconds : 778185000
```

### Example 2 - Show the time of the last boot

```powershell
Get-Uptime -Since
```

```Output
Tuesday, June 18, 2019 2:34:56 PM
```

## PARAMETERS

### -Since

Cause the cmdlet to return a **DateTime** object representing the last time that the operating
system was booted.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Since
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.TimeSpan

This is the default return type when no parameters are used.

### System.DateTime

This type is returned when using the **Since** parameter.

> [!NOTE]
> If Windows fast startup is enabled, Windows does not update the value stored in
> **LastBootUpTime**. To disable fast startup, run the following command: `Powercfg -h off`.
>
> For more information about Windows fast startup, see
> [Distinguishing Fast Startup from Wake-from-Hibernation](/windows-hardware/drivers/kernel/distinguishing-fast-startup-from-wake-from-hibernation).

## NOTES

On Windows, the value returned is the same as the **LastBootUpTime** property of the
**Win32_OperatingSystem** class in WMI.

## RELATED LINKS

[Win32_OperatingSystem](/windows/win32/cimwin32prov/win32-operatingsystem#properties)

