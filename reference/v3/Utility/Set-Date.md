---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Set-Date
## SYNOPSIS
Changes the system time on the computer to a time that you specify.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-Date [-Date] <DateTime> [-DisplayHint <DisplayHintType>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Set-Date [-Adjust] <TimeSpan> [-DisplayHint <DisplayHintType>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Set-Date cmdlet changes the system date and time on the computer to a date and time that you specify.
You can specify a new date and/or time by typing a string or by passing a DateTime or TimeSpan object to Set-Date.
To specify a new date or time, use the Date parameter.
To specify a change interval, use the Adjust parameter.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
C:\PS>Set-Date -Date (Get-Date).AddDays(3)
```

Description

-----------

This command adds three days to the current system date.
It does not affect the time.
The command uses the Date parameter to specify the date.
It uses the Get-Date cmdlet to get the current date and time and applies the AddDays .NET method for DateTime objects with a value of 3 \(days\).

### -------------------------- EXAMPLE 2 --------------------------
```
C:\PS>set-date -adjust -0:10:0 -displayHint time
```

Description

-----------

This command sets the current system time back by 10 minutes.
It uses the Adjust parameter to specify an interval of change and the time change \(minus ten minutes\) in standard time format for the locale.
The DisplayHint parameter tells Windows PowerShell to display only the time, but it does not affect the DateTime object that Set-Date returns.

### -------------------------- EXAMPLE 3 --------------------------
```
C:\PS>$t = get-date
PS C:\>set-date -date $t
```

Description

-----------

These commands change the system date and time on the computer to the date and time saved in the variable $t.
The first command gets the date and stores it in $t.
The second command uses the Date parameter to pass the DateTime object in $t to the Set-Date cmdlet.

### -------------------------- EXAMPLE 4 --------------------------
```
C:\PS>$90mins = new-timespan -minutes 90
PS C:\>set-date -adjust $90mins
```

Description

-----------

These commands advance the system time on the local computer by 90 minutes.
The first command uses the New-Timespan cmdlet to create a TimeSpan object with a 90-minute interval, and then it saves the TimeSpan object in the $90mins variable.
The second command uses the Adjust parameter of Set-Date to adjust the date by the value of the TimeSpan object in the $90mins variable.

## PARAMETERS

### -Adjust
Adds or subtracts the specified value from the current date and time.
You can type an adjustment in standard date and time format for your locale or use the Adjust parameter to pass a TimeSpan object from New-TimeSpan to Set-Date.

```yaml
Type: TimeSpan
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Date
Changes the date and time to the specified values.
You can type a new date in the short date format and a time in the standard time format for your locale.
Or, you can pass a Date-Time object from Get-Date.

If you specify a date, but not a time, Set-Date changes the time to midnight on the specified date.
If you specify only a time, it does not change the date.

```yaml
Type: DateTime
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -DisplayHint
Determines which elements of the date and time are displayed.

Valid values are:

-- date: displays only the date
-- time: displays only the time
-- datetime: displays the date and time

This parameter affects only the display.
It does not affect the DateTime object that Get-Date retrieves.

```yaml
Type: DisplayHintType
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.DateTime
You can pipe a date to Set-Date.

## OUTPUTS

### System.DateTime
Set-Date returns an object that represents the date that it set.

## NOTES
Use this cmdlet cautiously.
Changing the date and time on the computer.
The change might prevent the computer from receiving system-wide events and updates that are triggered by a date or time.
Use the -WhatIf and -Confirm parameters to avoid errors.

You can use standard .NET methods with the DateTime and TimeSpan objects used with Set-Date, such as AddDays, AddMonths and FromFileTime.
For more information, see "DateTime Methods" and "TimeSpan Methods."

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113393)

[Get-Date](277ba77f-f2be-44d7-8f15-23069faf0a4b)

[New-TimeSpan](d0503c70-1a91-47b6-84e5-473e78fe02df)


