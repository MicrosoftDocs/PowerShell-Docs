---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/01/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-timespan?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-TimeSpan
---
# New-TimeSpan

## SYNOPSIS
Creates a TimeSpan object.

## SYNTAX

### Date (Default)

```
New-TimeSpan [[-Start] <DateTime>] [[-End] <DateTime>] [<CommonParameters>]
```

### Time

```
New-TimeSpan [-Days <Int32>] [-Hours <Int32>] [-Minutes <Int32>] [-Seconds <Int32>] [<CommonParameters>]
```

## DESCRIPTION

The `New-TimeSpan` cmdlet creates a **TimeSpan** object that represents a time interval.
You can use a **TimeSpan** object to add or subtract time from **DateTime** objects.

Without parameters, a `New-TimeSpan` command returns a **TimeSpan** object that represents a time
interval of zero.

## EXAMPLES

### Example 1: Create a TimeSpan object for a specified duration

This command creates a **TimeSpan** object with a duration of 1 hour and 25 minutes and stores it in
a variable named `$TimeSpan`. It displays a representation of the **TimeSpan** object.

```powershell
$TimeSpan = New-TimeSpan -Hours 1 -Minutes 25
$TimeSpan
```

```Output
Days              : 0
Hours             : 1
Minutes           : 25
Seconds           : 0
Milliseconds      : 0
Ticks             : 51000000000
TotalDays         : 0.0590277777777778
TotalHours        : 1.41666666666667
TotalMinutes      : 85
TotalSeconds      : 5100
TotalMilliseconds : 5100000
```

### Example 2: Create a TimeSpan object for a time interval

This example creates a new **TimeSpan** object that represents the interval between the time that
the command is run and January 1, 2010.

This command does not require the **Start** parameter, because the default value of the **Start**
parameter is the current date and time.

```powershell
New-TimeSpan -End (Get-Date -Year 2010 -Month 1 -Day 1)
```

### Example 3: Get the date 90 days from the current date

```powershell
$90days = New-TimeSpan -Days 90
(Get-Date) + $90days
```

These commands return the date that is 90 days after the current date.

### Example 4: Discover the TimeSpan since a file was updated

This command tells you how long it has been since the [about_remote](../Microsoft.PowerShell.Core/About/about_Remote.md)
help file was last updated.
You can use this command format on any file, or any other object that has a **LastWriteTime**
property.

This command works because the **Start** parameter of `New-TimeSpan` has an alias of
**LastWriteTime**. When you pipe an object that has a **LastWriteTime** property to `New-TimeSpan`,
PowerShell uses the value of the **LastWriteTime** property as the value of the **Start** parameter.

```powershell
Get-ChildItem $PSHOME\en-us\about_remote.help.txt | New-TimeSpan
```

```Output
Days              : 321
Hours             : 21
Minutes           : 59
Seconds           : 22
Milliseconds      : 312
Ticks             : 278135623127728
TotalDays         : 321.916230471907
TotalHours        : 7725.98953132578
TotalMinutes      : 463559.371879547
TotalSeconds      : 27813562.3127728
TotalMilliseconds : 27813562312.7728
```

## PARAMETERS

### -Days

Specifies the days in the time span.
The default value is 0.

```yaml
Type: System.Int32
Parameter Sets: Time
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -End

Specifies the end of a time span.
The default value is the current date and time.

```yaml
Type: System.DateTime
Parameter Sets: Date
Aliases:

Required: False
Position: 1
Default value: Current date and time
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Hours

Specifies the hours in the time span.
The default value is zero.

```yaml
Type: System.Int32
Parameter Sets: Time
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minutes

Specifies the minutes in the time span.
The default value is 0.

```yaml
Type: System.Int32
Parameter Sets: Time
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Seconds

Specifies the length of the time span in seconds.
The default value is 0.

```yaml
Type: System.Int32
Parameter Sets: Time
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start

Specifies the start of a time span.
Enter a string that represents the date and time, such as "3/15/09" or a **DateTime** object, such
as one from a `Get-Date` command. The default value is the current date and time.

You can use **Start** or its alias, **LastWriteTime**.
The **LastWriteTime** alias lets you pipe objects that have a **LastWriteTime** property,
such as files in the file system `[System.Io.FileIO]`, to the **Start** parameter of `New-TimeSpan`.

```yaml
Type: System.DateTime
Parameter Sets: Date
Aliases: LastWriteTime

Required: False
Position: 0
Default value: Current date and time
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.DateTime

You can pipe a **DateTime** object that represents that start time to `New-TimeSpan`.

## OUTPUTS

### System.TimeSpan

`New-TimeSpan` returns an object that represents the time span.

## NOTES

## RELATED LINKS

[Get-Date](Get-Date.md)

[Set-Date](Set-Date.md)

