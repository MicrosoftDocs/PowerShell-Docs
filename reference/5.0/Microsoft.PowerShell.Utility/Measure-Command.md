---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Measure Command
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821828
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Measure-Command

## SYNOPSIS
Measures the time it takes to run script blocks and cmdlets.

## SYNTAX

```
Measure-Command [-InputObject <PSObject>] [-Expression] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION
The **Measure-Command** cmdlet runs a script block or cmdlet internally, times the execution of the operation, and returns the execution time.

## EXAMPLES

### Example 1: Measure the time to run a command
```
PS C:\> Measure-Command { Get-EventLog "windows powershell" }
```

This command measures the time it takes to run a Get-EventLog command that gets the events in the Windows PowerShell event log.

### Example 2: Use a provider-specific filter
```
PS C:\> Measure-Command {Get-ChildItem -Path C:\Windows\*.txt -Recurse}

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
TotalMilliseconds : 8618.2763 PS C:\> Measure-Command {Get-ChildItem C:\Windows -Filter "*.txt" -Recurse}

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

The first command measures the time it takes to process a recursive **Get-ChildItem** command that uses the *Path* parameter to get only .txt files in the C:\Windows directory and its subdirectories.

The second command measures the time it takes to process a recursive **Get-ChildItem** command that uses the provider-specific *Filter* parameter.

## PARAMETERS

### -Expression
Specifies the expression that is being timed.
Enclose the expression in braces ({}).
The parameter name ("Expression") is optional.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
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
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe an object to **Measure-Command**.

## OUTPUTS

### System.TimeSpan
**Measure-Command** returns a time span object that represents the result.

## NOTES
* For more information, type `Get-Help Measure-Command -detailed`. For technical information, type `Get-Help Measure-Command -full`.

  When specifying multiple values for a parameter, use commas to separate the values.
For example, \<parameter-name\> \<value1\>, \<value2\>.

*

## RELATED LINKS

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[Trace-Command](Trace-Command.md)

