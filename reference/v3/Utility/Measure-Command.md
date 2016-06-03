---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Measure-Command
## SYNOPSIS
Measures the time it takes to run script blocks and cmdlets.

## SYNTAX

```
Measure-Command [-Expression] <ScriptBlock> [-InputObject <PSObject>]
```

## DESCRIPTION
The Measure-Command cmdlet runs a script block or cmdlet internally, times the execution of the operation, and returns the execution time.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Measure-Command { Get-EventLog "windows powershell" }
```

This command measures the time it takes to run a Get-EventLog command that gets the events in the Windows PowerShell event log.

### -------------------------- EXAMPLE 2 --------------------------
```
The first command measures the time it takes to process a recursive Get-ChildItem command that uses the Path parameter to get only .txt files in the C:\Windows directory and its subdirectories.
PS C:\>Measure-Command {Get-ChildItem –Path C:\Windows\*.txt -Recurse}

Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 8
Milliseconds      : 618
Ticks             : 86182763
TotalDays         : 9.9748568287037E-05
TotalHours        : 0.00239396563888889
TotalMinutes      : 0.143637938333333
TotalSeconds      : 8.6182763
TotalMilliseconds : 8618.2763

The second command measures the time it takes to process a recursive Get-ChildItem command that uses the provider-specific Filter parameter.
PS C:\>Measure-Command {Get-ChildItem C:\Windows -Filter "*.txt" -Recurse}

PS C:\>
Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 1
Milliseconds      : 140
Ticks             : 11409189
TotalDays         : 1.32050798611111E-05
TotalHours        : 0.000316921916666667
TotalMinutes      : 0.019015315
TotalSeconds      : 1.1409189
TotalMilliseconds : 1140.9189
```

These commands show the value of using a provider-specific filter in Windows PowerShell commands.

## PARAMETERS

### -Expression
Specifies the expression that is being timed.
Enclose the expression in braces \({}\).
The parameter name \("Expression"\) is optional.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -InputObject
Specifies objects representing the expressions to be measured.
Enter a variable that contains the objects or type a command or expression that gets the objects.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe an object to Measure-Command.

## OUTPUTS

### System.TimeSpan
Measure-Command returns a time span object that represents the result.

## NOTES
For more information, type "Get-Help Measure-Command -detailed".
For technical information, type "Get-Help Measure-Command -full".

When specifying multiple values for a parameter, use commas to separate the values.
For example, "\<parameter-name\> \<value1\>, \<value2\>".

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113348)

[Invoke-Command](00000000-0000-0000-0000-000000000000)

[Trace-Command](db7c9374-998e-44c3-ad94-e0445176cf7b)


