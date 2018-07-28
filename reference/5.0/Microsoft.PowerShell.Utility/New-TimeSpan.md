---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821837
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  New-TimeSpan
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
The **New-TimeSpan** cmdlet creates a **TimeSpan** object that represents a time interval.
You can use a **TimeSpan** object to add or subtract time from **DateTime** objects.

Without parameters, a **New-Timespan** command returns a timespan object that represents a time interval of zero.

## EXAMPLES

### Example 1: Create a TimeSpan object for a specified duration
```
PS C:\> $TimeSpan = New-TimeSpan -Hour 1 -Minute 25
```

This command creates a **TimeSpan** object with a duration of 1 hour and 25 minutes and stores it in a variable named $TimeSpan.
It displays a representation of the **TimeSpan** object.

### Example 2: Create a TimeSpan object for a time interval
```
PS C:\> new-timespan -end (get-date -year 2010 -month 1 -day 1)
```

This example creates a new **TimeSpan** object that represents the interval between the time that the command is run and January 1, 2010.

This command does not require the *Start* parameter, because the default value of the *Start* parameter is the current date and time.

### Example 3: Get the date 90 days from the current date
```
PS C:\> $90days = New-TimeSpan -Days 90
PS C:\> (Get-Date) + $90days
```

These commands return the date that is 90 days after the current date.

### Example 4: Discover the TimeSpan since a file was updated
```
PS C:\> dir $pshome\en-us\about_remote.help.txt | New-TimeSpan
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
TotalMilliseconds : 27813562312.7728 PS C:\> # Equivalent to:

PS C:\> New-TimeSpan -Start (dir $pshome\en-us\about_remote.help.txt).lastwritetime
```

This command tells you how long it has been since the about_remote.help.txt file was last updated.
You can use this command format on any file, and on any other object that has a **LastWriteTime** property.

This command works because the *Start* parameter of **New-TimeSpan** has an alias of LastWriteTime.
When you pipe an object that has a Last****WriteTime property to **New-TimeSpan**, Windows PowerShell uses the value of the **LastWriteTime** property as the value of the *Start* parameter.

## PARAMETERS

### -Days
Specifies the days in the time span.
The default value is 0.

```yaml
Type: Int32
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
Type: DateTime
Parameter Sets: Date
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Hours
Specifies the hours in the time span.
The default value is zero.

```yaml
Type: Int32
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
Type: Int32
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
Type: Int32
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
Enter a string that represents the date and time, such as "3/15/09" or a **DateTime** object, such as one from a Get-Date command.
The default value is the current date and time.

You can use *Start* or its alias, LastWriteTime.
The LastWriteTime alias lets you pipe objects that have a **LastWriteTime** property, such as files in the file system (System.Io.FileIO), to the Start parameter of **New-TimeSpan**.

```yaml
Type: DateTime
Parameter Sets: Date
Aliases: LastWriteTime

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.DateTime
You can pipe a **DateTime** object that represents that start time to **New-TimeSpan**.

## OUTPUTS

### System.TimeSpan
**New-TimeSpan** returns an object that represents the time span.

## NOTES

## RELATED LINKS

[Get-Date](Get-Date.md)

[Set-Date](Set-Date.md)