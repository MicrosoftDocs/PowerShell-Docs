---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 4/30/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/set-date?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Date
---
# Set-Date

## SYNOPSIS
Changes the system time on the computer to a time that you specify.

## SYNTAX

### Date (Default)

```
Set-Date [-Date] <DateTime> [-DisplayHint <DisplayHintType>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Adjust

```
Set-Date [-Adjust] <TimeSpan> [-DisplayHint <DisplayHintType>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Date` cmdlet changes the system date and time on the computer to a date and time that you
specify.
You can specify a new date and/or time by typing a string or by passing a **DateTime** or
**TimeSpan** object to `Set-Date`. To specify a new date or time, use the **Date** parameter.
To specify a change interval, use the **Adjust** parameter.

## EXAMPLES

### Example 1: Add three days to the system date

This command adds three days to the current system date.
It does not affect the time.
The command uses the **Date** parameter to specify the date.

The `Get-Date` cmdlet returns the current date as a **DateTime** object. The **DateTime** object's
**AddDays** method adds a specified number of days (3) to the current **DateTime** object.

```powershell
Set-Date -Date (Get-Date).AddDays(3)
```

### Example 2: Set the system clock back 10 minutes

This example sets the current system time back by 10 minutes.

The **Adjust** parameter allows you to specify an interval of change (minus ten minutes) in the
standard time format for the locale.

The **DisplayHint** parameter tells PowerShell to display only the time, but it does not
affect the **DateTime** object that `Set-Date` returns.

```powershell
Set-Date -Adjust -0:10:0 -DisplayHint Time
```

### Example 3: Set the date and time to a variable value

These commands change the system date and time on local computer to the date and time saved in the
variable `$T`. The first command gets the date and stores it in `$T`.

The second command uses the **Date** parameter to pass the **DateTime** object in `$T` to the
`Set-Date` cmdlet.

```powershell
$T = Get-Date
Set-Date -Date $T
```

### Example 4: Add 90 minutes to the system clock

These commands advance the system time on the local computer by 90 minutes.

The first command uses the `New-TimeSpan` cmdlet to create a **TimeSpan** object with a 90-minute
interval, and saves it in the `$90mins` variable.

The second command uses the **Adjust** parameter of `Set-Date` to adjust the date by the value of
the **TimeSpan** object in the `$90mins` variable.

```powershell
$90mins = New-TimeSpan -Minutes 90
Set-Date -Adjust $90mins
```

## PARAMETERS

### -Adjust

Specifies the value for which this cmdlet adds or subtracts from the current date and time.
can type an adjustment in standard date and time format for your locale or use the **Adjust**
parameter to pass a **TimeSpan** object from `New-TimeSpan` to `Set-Date`.

```yaml
Type: System.TimeSpan
Parameter Sets: Adjust
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Date

Changes the date and time to the specified values.
You can type a new date in the short date format and a time in the standard time format for your
locale. Or, you can pass a **DateTime** object from `Get-Date`.

If you specify a date, but not a time, `Set-Date` changes the time to midnight on the specified
date. If you specify only a time, it does not change the date.

```yaml
Type: System.DateTime
Parameter Sets: Date
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DisplayHint

Specifies which elements of the date and time are displayed.The acceptable values for this parameter
are:

- **Date** - displays only the date.
- **Time** - displays only the time.
- **DateTime** - displays the date and time.

This parameter affects only the display.
It does not affect the **DateTime** object that `Get-Date` retrieves.

```yaml
Type: Microsoft.PowerShell.Commands.DisplayHintType
Parameter Sets: (All)
Aliases:
Accepted values: Date, Time, DateTime

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.DateTime

You can pipe a date to `Set-Date`.

## OUTPUTS

### System.DateTime

`Set-Date` returns an object that represents the date that it set.

## NOTES

- Use this cmdlet cautiously when changing the date and time on the computer. The change might
  prevent the computer from receiving system-wide events and updates that are triggered by a date or
  time. Use the **WhatIf** and **Confirm** parameters to avoid errors.
- You can use standard .NET methods with the **DateTime** and **TimeSpan** objects used with
  `Set-Date`, such as **AddDays**, **AddMonths**, and **FromFileTime**. For more information, see
  [DateTime Methods](/dotnet/api/system.datetime) and

  [TimeSpan Methods](/dotnet/api/system.timespan) in the .NET SDK.

## RELATED LINKS

[Get-Date](Get-Date.md)

[New-TimeSpan](New-TimeSpan.md)
