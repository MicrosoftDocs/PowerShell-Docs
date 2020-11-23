---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/25/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Date
---

# Get-Date

## SYNOPSIS
Gets the current date and time.

## SYNTAX

### Date (Default)

```
Get-Date [[-Date] <DateTime>] [-Year <Int32>] [-Month <Int32>] [-Day <Int32>] [-Hour <Int32>]
 [-Minute <Int32>] [-Second <Int32>] [-Millisecond <Int32>] [-DisplayHint <DisplayHintType>]
 [-Format <String>] [-AsUTC] [<CommonParameters>]
```

### DateUFormat

```
Get-Date [[-Date] <DateTime>] [-Year <Int32>] [-Month <Int32>] [-Day <Int32>] [-Hour <Int32>]
 [-Minute <Int32>] [-Second <Int32>] [-Millisecond <Int32>] [-DisplayHint <DisplayHintType>]
 -UFormat <String> [<CommonParameters>]
```

### UnixTimeSeconds

```
Get-Date -UnixTimeSeconds <Int64> [-Year <Int32>] [-Month <Int32>] [-Day <Int32>] [-Hour <Int32>]
 [-Minute <Int32>] [-Second <Int32>] [-Millisecond <Int32>] [-DisplayHint <DisplayHintType>]
 [-Format <String>] [-AsUTC] [<CommonParameters>]
```

### UnixTimeSecondsUFormat

```
Get-Date -UnixTimeSeconds <Int64> [-Year <Int32>] [-Month <Int32>] [-Day <Int32>] [-Hour <Int32>]
 [-Minute <Int32>] [-Second <Int32>] [-Millisecond <Int32>] [-DisplayHint <DisplayHintType>]
 -UFormat <String> [<CommonParameters>]
```

## DESCRIPTION

The `Get-Date` cmdlet gets a **DateTime** object that represents the current date or a date that you
specify. `Get-Date` can format the date and time in several .NET and UNIX formats. You can use
`Get-Date` to generate a date or time character string, and then send the string to other cmdlets or
programs.

`Get-Date` uses the computer's culture settings to determine how the output is formatted. To view
your computer's settings, use `(Get-Culture).DateTimeFormat`.

## EXAMPLES

### Example 1: Get the current date and time

In this example, `Get-Date` displays the current system date and time. The output is in the
long-date and long-time formats.

```powershell
Get-Date
```

```Output
Tuesday, June 25, 2019 14:53:32
```

### Example 2: Get elements of the current date and time

This example shows how to use `Get-Date` to get either the date or time element. The parameter uses
the arguments **Date**, **Time**, or **DateTime**.

```powershell
Get-Date -DisplayHint Date
```

```Output
Tuesday, June 25, 2019
```

`Get-Date` uses the **DisplayHint** parameter with the **Date** argument to get only the date.

### Example 3: Get the date and time with a .NET format specifier

In this example, a .NET format specifier is used to customize the output's format. The output is a
**String** object.

```powershell
Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
```

```Output
Tuesday 06/25/2019 16:17 -07:00
```

`Get-Date` uses the **Format** parameter to specify several format specifiers.

The .NET format specifiers used in this example are defined as follows:

| Specifier |                      Definition                       |
| --------- | ----------------------------------------------------- |
| `dddd`    | Day of the week - full name                           |
| `MM`      | Month number                                          |
| `dd`      | Day of the month - 2 digits                           |
| `yyyy`    | Year in 4-digit format                                |
| `HH:mm`   | Time in 24-hour format - no seconds                    |
| `K`       | Time zone offset from Universal Time Coordinate (UTC) |

For more information about .NET format specifiers, see
[Custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8).

### Example 4: Get the date and time with a UFormat specifier

In this example, several **UFormat** format specifiers are used to customize the output's format.
The output is a **String** object.

```powershell
Get-Date -UFormat "%A %m/%d/%Y %R %Z"
```

```Output
Tuesday 06/25/2019 16:19 -07
```

`Get-Date` uses the **UFormat** parameter to specify several format specifiers.

The **UFormat** format specifiers used in this example are defined as follows:

| Specifier |                      Definition                       |
| --------- | ----------------------------------------------------- |
| `%A`      | Day of the week - full name                           |
| `%m`      | Month number                                          |
| `%d`      | Day of the month - 2 digits                           |
| `%Y`      | Year in 4-digit format                                |
| `%R`      | Time in 24-hour format - no seconds                    |
| `%Z`      | Time zone offset from Universal Time Coordinate (UTC) |

For a list of valid **UFormat** format specifiers, see the [Notes](#notes) section.

### Example 5: Get a date's day of the year

In this example, a property is used to get the numeric day of the year.

The Gregorian calendar has 365 days, except for leap years that have 366 days. For example, December
31, 2020 is day 366.

```powershell
(Get-Date -Year 2020 -Month 12 -Day 31).DayOfYear
```

```Output
366
```

`Get-Date` uses three parameters to specify the date: **Year**, **Month**, and **Day**. The command
is wrapped with parentheses so that the result is evaluated by the **DayofYear** property.

### Example 6: Check if a date is adjusted for daylight savings time

This example uses a boolean method to verify if a date is adjusted by daylight savings time.

```powershell
$DST = Get-Date
$DST.IsDaylightSavingTime()
```

```Output
True
```

A variable, `$DST` stores the result of `Get-Date`. `$DST` uses the **IsDaylightSavingTime** method
to test if the date is adjusted for daylight savings time.

### Example 7: Convert the current time to UTC time

In this example, the current time is converted to UTC time. The UTC offset for the system's locale
is used to convert the time. A table in the [Notes](#notes) section lists the valid **UFormat**
format specifiers.

```powershell
Get-Date -UFormat "%A %B/%d/%Y %T %Z"
$Time = Get-Date
$Time.ToUniversalTime()
```

```Output
Wednesday June/26/2019 10:45:26 -07

Wednesday, June 26, 2019 17:45:26
```

`Get-Date` uses the **UFormat** parameter with format specifiers to display the current system date
and time. The format specifier **%Z** represents the UTC offset of **-07**.

The `$Time` variable stores the current system date and time. `$Time` uses the **ToUniversalTime()**
method to convert the time based on the computer's UTC offset.

### Example 8: Create a timestamp

In this example, a format specifier creates a timestamp **String** object for a directory name. The
timestamp includes the date, time, and UTC offset.

```powershell
$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
New-Item -Path C:\Test\$timestamp -Type Directory
```

```Output
Directory: C:\Test

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         6/27/2019    07:59                2019-06-27T07.59.24.4603750-07.00
```

The `$timestamp` variable stores the results of a `Get-Date` command. `Get-Date` uses the **Format**
parameter with the format specifier of lowercase `o` to create a timestamp **String** object. The
object is sent down the pipeline to `ForEach-Object`. A **ScriptBlock** contains the `$_` variable
that represents the current pipeline object. The timestamp string is delimited by colons that are
replaced by periods.

`New-Item` uses the **Path** parameter to specify the location for a new directory. The path
includes the `$timestamp` variable as the directory name. The **Type** parameter specifies that a
directory is created.

### Example 9: Convert a Unix timestamp

This example converts a Unix time (represented by the number of seconds since 1970-01-01 0:00:00) to DateTime.

```powershell
Get-Date -UnixTimeSeconds 1577836800
```

```Output
Wednesday, January 01, 2020 12:00:00 AM
```

### Example 10: Return a date value interpreted as UTC

This example shows how to interpret a date value as its UTC equivalent. For the example, this
machine is set to **Pacific Standard Time**. By default, `Get-Date` returns values for that
timezone. Use the **AsUTC** parameter to convert the value to the UTC equivalent time.

```powershell
PS> Get-TimeZone

Id                         : Pacific Standard Time
DisplayName                : (UTC-08:00) Pacific Time (US & Canada)
StandardName               : Pacific Standard Time
DaylightName               : Pacific Daylight Time
BaseUtcOffset              : -08:00:00
SupportsDaylightSavingTime : True

PS> (Get-Date -Date "2020-01-01T00:00:00").Kind
Unspecified

PS> Get-Date -Date "2020-01-01T00:00:00"

Wednesday, January 1, 2020 12:00:00 AM

PS> (Get-Date -Date "2020-01-01T00:00:00" -AsUTC).Kind
Utc

PS> Get-Date -Date "2020-01-01T00:00:00" -AsUTC

Wednesday, January 1, 2020 8:00:00 AM
```

## PARAMETERS

### -AsUTC

Converts the date value to the equivalent time in UTC.

This parameter was introduced in PowerShell 7.1.

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

### -Date

Specifies a date and time. Time is optional and if not specified, returns 00:00:00.

Enter the date and time in a format that is standard for the system locale.

For example, in US English:

`Get-Date -Date "6/25/2019 12:30:22"` returns Tuesday, June 25, 2019 12:30:22

```yaml
Type: System.DateTime
Parameter Sets: DateAndFormat, DateAndUFormat
Aliases: LastWriteTime

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Day

Specifies the day of the month that is displayed. Enter a value from 1 to 31.

If the specified value is greater than the number of days in a month, PowerShell adds the number of
days to the month. For example, `Get-Date -Month 2 -Day 31` displays **March 3**, not **February 31**.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayHint

Determines which elements of the date and time are displayed.

The accepted values are as follows:

- **Date**: displays only the date
- **Time**: displays only the time
- **DateTime**: displays the date and time

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

### -Format

Displays the date and time in the Microsoft .NET Framework format indicated by the format specifier.
The **Format** parameter outputs a **String** object.

For a list of available .NET format specifiers, see
[Custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8).

When the **Format** parameter is used, `Get-Date` only gets the **DateTime** object's properties
necessary to display the date. As a result, some of the properties and methods of **DateTime**
objects might not be available.

Starting in PowerShell 5.0, you can use the following additional formats as values for the
**Format** parameter.

- **FileDate**. A file or path-friendly representation of the current date in local time. The format
  is `yyyyMMdd` (case-sensitive, using a 4-digit year, 2-digit month, and 2-digit day). For example:
  20190627.

- **FileDateUniversal**. A file or path-friendly representation of the current date in universal
  time (UTC). The format is `yyyyMMddZ` (case-sensitive, using a 4-digit year, 2-digit month,
  2-digit day, and the letter `Z` as the UTC indicator). For example: 20190627Z.

- **FileDateTime**. A file or path-friendly representation of the current date and time in local
  time, in 24-hour format. The format is `yyyyMMddTHHmmssffff` (case-sensitive, using a 4-digit
  year, 2-digit month, 2-digit day, the letter `T` as a time separator, 2-digit hour, 2-digit
  minute, 2-digit second, and 4-digit millisecond). For example: 20190627T0840107271.

- **FileDateTimeUniversal**. A file or path-friendly representation of the current date and time in
  universal time (UTC), in 24-hour format. The format is `yyyyMMddTHHmmssffffZ` (case-sensitive,
  using a 4-digit year, 2-digit month, 2-digit day, the letter `T` as a time separator, 2-digit
  hour, 2-digit minute, 2-digit second, 4-digit millisecond, and the letter `Z` as the UTC
  indicator). For example: 20190627T1540500718Z.

```yaml
Type: System.String
Parameter Sets: DateAndFormat, UnixTimeSecondsAndFormat
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hour

Specifies the hour that is displayed. Enter a value from 0 to 23.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Millisecond

Specifies the milliseconds in the date. Enter a value from 0 to 999.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minute

Specifies the minute that is displayed. Enter a value from 0 to 59.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Month

Specifies the month that is displayed. Enter a value from 1 to 12.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Second

Specifies the second that is displayed. Enter a value from 0 to 59.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UFormat

Displays the date and time in UNIX format. The **UFormat** parameter outputs a string object.

**UFormat** specifiers are preceded by a percent sign (`%`), for example, `%m`, `%d`, and `%Y`. The [Notes](#notes)
section contains a table of valid **UFormat specifiers**.

When the **UFormat** parameter is used, `Get-Date` only gets the **DateTime** object's properties
necessary to display the date. As a result, some of the properties and methods of **DateTime**
objects might not be available.

```yaml
Type: System.String
Parameter Sets: DateAndUFormat, UnixTimeSecondsAndUFormat
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnixTimeSeconds

Date and time represented in seconds since January 1, 1970, 0:00:00.

This parameter was introduced in PowerShell 7.1.

```yaml
Type: System.Int64
Parameter Sets: UnixTimeSecondsAndFormat, UnixTimeSecondsAndUFormat
Aliases: UnixTime

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Year

Specifies the year that is displayed. Enter a value from 1 to 9999.

```yaml
Type: System.Int32
Parameter Sets: (All)
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Pipeline input

`Get-Date` accepts pipeline input. For example, `Get-ChildItem | Get-Date`.

## OUTPUTS

### System.DateTime or System.String

`Get-Date` returns a **DateTime** object except when the **Format** and **UFormat** parameters are
used. The **Format** or **UFormat** parameters return **String** objects.

When a **DateTime** object is sent down the pipeline to a cmdlet such as `Add-Content` that expects
string input, PowerShell converts the object to a **String** object.

The method `(Get-Date).ToString()` converts a **DateTime** object a **String** object.

To display an object's properties and methods, send the object down the pipeline to `Get-Member`.
For example, `Get-Date | Get-Member`.

## NOTES

**DateTime** objects are in long-date and long-time formats for the system locale.

The valid **UFormat specifiers** are displayed in the following table:

| Format specifier |                                 Meaning                     |         Example          |
| ---- | ----------------------------------------------------------------------- | ------------------------ |
| `%A` | Day of the week - full name                                             | Monday                   |
| `%a` | Day of the week - abbreviated name                                      | Mon                      |
| `%B` | Month name - full                                                       | January                  |
| `%b` | Month name - abbreviated                                                | Jan                      |
| `%C` | Century                                                                 | 20 for 2019              |
| `%c` | Date and time - abbreviated                                             | Thu Jun 27 08:44:18 2019 |
| `%D` | Date in mm/dd/yy format                                                 | 06/27/19                 |
| `%d` | Day of the month - 2 digits                                             | 05                       |
| `%e` | Day of the month - preceded by a space if only a single digit           | \<space\>5               |
| `%F` | Date in YYYY-mm-dd format, equal to %Y-%m-%d (the ISO 8601 date format) | 2019-06-27               |
| `%G` | Same as 'Y'                                                             |                          |
| `%g` | Same as 'y'                                                             |                          |
| `%H` | Hour in 24-hour format                                                  | 17                       |
| `%h` | Same as 'b'                                                             |                          |
| `%I` | Hour in 12-hour format                                                  | 05                       |
| `%j` | Day of the year                                                         | 1-366                    |
| `%k` | Same as 'H'                                                             |                          |
| `%l` | Same as 'I' (Upper-case I)                                              | 05                       |
| `%M` | Minutes                                                                 | 35                       |
| `%m` | Month number                                                            | 06                       |
| `%n` | newline character                                                       |                          |
| `%p` | AM or PM                                                                |                          |
| `%R` | Time in 24-hour format -no seconds                                      | 17:45                    |
| `%r` | Time in 12-hour format                                                  | 09:15:36 AM              |
| `%S` | Seconds                                                                 | 05                       |
| `%s` | Seconds elapsed since January 1, 1970 00:00:00                          | 1150451174               |
| `%t` | Horizontal tab character                                                |                          |
| `%T` | Time in 24-hour format                                                  | 17:45:52                 |
| `%U` | Same as 'W'                                                             |                          |
| `%u` | Day of the week - number                                                | Sunday = 0               |
| `%V` | Week of the year                                                        | 01-53                    |
| `%w` | Same as 'u'                                                             |                          |
| `%W` | Week of the year                                                        | 00-52                    |
| `%X` | Same as 'T'                                                             |                          |
| `%x` | Date in standard format for locale                                      | 06/27/19 for English-US  |
| `%Y` | Year in 4-digit format                                                  | 2019                     |
| `%y` | Year in 2-digit format                                                  | 19                       |
| `%Z` | Time zone offset from Universal Time Coordinate (UTC)                   | -07                      |

## RELATED LINKS

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Get-Culture](Get-Culture.md)

[Get-Member](Get-Member.md)

[New-Item](../Microsoft.PowerShell.Management/New-Item.md)

[New-TimeSpan](New-TimeSpan.md)

[Set-Date](Set-Date.md)
