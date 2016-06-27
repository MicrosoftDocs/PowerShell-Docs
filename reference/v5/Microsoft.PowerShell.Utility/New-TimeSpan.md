---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293994
schema: 2.0.0
---

# New-TimeSpan
## SYNOPSIS
Creates a TimeSpan object.

## SYNTAX

### Date (Default)
```
New-TimeSpan [[-Start] <DateTime>] [[-End] <DateTime>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### Time
```
New-TimeSpan [-Days <Int32>] [-Hours <Int32>] [-Minutes <Int32>] [-Seconds <Int32>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The New-TimeSpan cmdlet creates a TimeSpan object that represents a time interval You can use a TimeSpan object to add or subtract time from DateTime objects.

Without parameters, a "New-Timespan" command returns a timespan object that represents a time interval of zero.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$timespan = new-timespan -hour 1 -minute 25
```

This command creates a TimeSpan object with a duration of 1 hour and 25 minutes and stores it in a variable named $timespan.
It displays a representation of the TimeSpan object.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>new-timespan -end (get-date -year 2010 -month 1 -day 1)
```

This example creates a new TimeSpan object that represents the interval between the time that the command is run and January 1, 2010.

This command does not require the Start parameter, because the default value of the Start parameter is the current date and time.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$90days = new-timespan -days 90
PS C:\>(get-date) + $90days
```

These commands return the date that is 90 days after the current date.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>dir $pshome\en-us\about_remote.help.txt | new-timespan

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

# Equivalent to:

PS C:\>new-timespan -start (dir $pshome\en-us\about_remote.help.txt).lastwritetime
```

This command tells you how long it has been since the about_remote.help.txt file was last updated.
You can use this command format on any file, and on any other object that has a LastWriteTime property.

This command works because the Start parameter of New-TimeSpan has an alias of LastWriteTime.
When you pipe an object that has a LastWriteTime property to New-TimeSpan, Windows PowerShell uses the value of the LastWriteTime property as the value of the Start parameter.

## PARAMETERS

### -Days
Indicates the days in the time span.
The default is 0.

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
Indicates the end of a time span.
The default is the current date and time.

```yaml
Type: DateTime
Parameter Sets: Date
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Hours
Indicates the hours in the time span.
The default is zero.

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

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minutes
Indicates the minutes in the time span.
The default is 0.

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
Indicates the length of the time span in seconds.
The default is 0.

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
Indicates the start of a time span.
Enter a string that represents the date and time, such as "3/15/09" or a DateTime object, such as one from a Get-Date command. 
The default is the current date and time.

You can use Start or its alias, LastWriteTime.
The LastWriteTime alias lets you pipe objects that have a LastWriteTime property, such as files in the file system (System.Io.FileIO), to the Start parameter of New-TimeSpan.

```yaml
Type: DateTime
Parameter Sets: Date
Aliases: LastWriteTime

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.DateTime
You can pipe a DateTime object that represents that start time to New-TimeSpan.

## OUTPUTS

### System.TimeSpan
New-TimeSpan returns an object that represents the time span.

## NOTES

## RELATED LINKS

[Get-Date]()

[Set-Date]()

