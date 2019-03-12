---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821828
schema: 2.0.0
title: Measure-Command
---
# Measure-Command

## SYNOPSIS
Measures the time it takes to run script blocks and cmdlets.

## SYNTAX

```
Measure-Command [-InputObject <PSObject>] [-Expression] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION

The `Measure-Command` cmdlet runs a script block or cmdlet internally, times the execution of the operation, and returns the execution time.

## EXAMPLES

### Example 1: Measure a command

This command measures the time it takes to run a `Get-EventLog` command that gets the events in the Windows PowerShell event log.

```powershell
Measure-Command { Get-EventLog "windows powershell" }
```

### Example 2: Compare two outputs from Measure-Command

The first command measures the time it takes to process a recursive `Get-ChildItem` command that uses the `-Path` parameter to get only .txt files in the C:\Windows directory and its subdirectories.

The second command measures the time it takes to process a recursive `Get-ChildItem` command that uses the provider-specific `-Filter` parameter.

These commands show the value of using a provider-specific filter in PowerShell commands.

```powershell
Measure-Command { Get-ChildItem -Path C:\Windows\*.txt -Recurse }
```

```output
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
```

```powershell
Measure-Command {Get-ChildItem C:\Windows -Filter "*.txt" -Recurse}
```

```output
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

### Example 3: Use the InputObject parameter of Measure-Command

This example shows how to use the `InputObject` parameter of `Measure-Command`. The `ScriptBlock` passed to the `Expression` parameter is executed once for each object passed, or piped into the `InputObject` parameter.

> [!NOTE]
> `Measure-Command` still provides a measurement of overall `ScriptBlock` execution for every element passed to the `InputObject` parameter.

```powershell
# Perform a simple operation to demonstrate the InputObject parameter
# Note that no output is displayed.
10, 20, 50 | Measure-Command -Expression {for($i=0; $i - lt $_;$i++) {$i} }
```

```output
Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 0
Milliseconds      : 12
Ticks             : 122672
TotalDays         : 1.41981481481481E-07
TotalHours        : 3.40755555555556E-06
TotalMinutes      : 0.000204453333333333
TotalSeconds      : 0.0122672
TotalMilliseconds : 12.2672
```

```powershell
# Perform the same operation as above adding Out-Default to every execution.
# This will show that the ScriptBlock is in fact executing for every item.
10, 20, 50 | Measure-Command -Expression {for($i=0; $i -lt $_;$i++) {$i}; "$($_)" | Out-Default }
```

```output
10
20
50


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 0
Milliseconds      : 11
Ticks             : 113745
TotalDays         : 1.31649305555556E-07
TotalHours        : 3.15958333333333E-06
TotalMinutes      : 0.000189575
TotalSeconds      : 0.0113745
TotalMilliseconds : 11.3745
```

## PARAMETERS

### -Expression

Specifies the expression that is being timed.
Enclose the expression in braces ({}).
The parameter name ("**Expression**") is optional.

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

Objects bound to the `InputObject` parameter are optional input for the `ScriptBlock` passed to the `Expression` parameter.
Inside the `ScriptBlock`, `$_` can be used to reference the current object in the pipeline.

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

You can pipe an object to `Measure-Command`.

## OUTPUTS

### System.TimeSpan

`Measure-Command` returns a time span object that represents the result.

## NOTES

## RELATED LINKS

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[Trace-Command](Trace-Command.md)