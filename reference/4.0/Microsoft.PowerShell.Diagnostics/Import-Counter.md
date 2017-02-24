---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Import Counter
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/p/?linkid=289627
external help file:   Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
---


# Import-Counter

## SYNOPSIS
Imports performance counter log files (.blg, .csv, .tsv) and creates the objects that represent each counter sample in the log.

## SYNTAX

### GetCounterSet (Default)
```
Import-Counter [-Path] <String[]> [-StartTime <DateTime>] [-EndTime <DateTime>] [-Counter <String[]>]
 [-MaxSamples <Int64>] [<CommonParameters>]
```

### ListSetSet
```
Import-Counter [-Path] <String[]> -ListSet <String[]> [<CommonParameters>]
```

### SummarySet
```
Import-Counter [-Path] <String[]> [-Summary] [<CommonParameters>]
```

## DESCRIPTION
The Import-Counter cmdlet imports performance counter data from performance counter log files and creates objects for each counter sample in the file.
The PerformanceCounterSampleSet objects that it creates are identical to the objects that Get-Counter returns when it collects performance counter data.

You can import data from comma-separated value (.csv), tab-separated value ( .tsv), and binary performance log (.blg) performance log files.
If you are using .blg files, you can import multiple files (up to 32 different files) in each command.
And, you can use the parameters of Import-Counter to filter the data that you import.

Along with Get-Counter and Export-Counter, this feature lets you collect, export, import, combine, filter, manipulate, and re-export performance counter data within Windows PowerShell.

## EXAMPLES

### Example 1
```
PS C:\> $Data = Import-Counter -Path ProcessorData.csv
```

This command imports all of the counter data from the ProcessorData.csv file into the $Data variable.

### Example 2
```
PS C:\> $i = Import-Counter -Path ProcessorData.blg -Counter "\\SERVER01\Processor(_Total)\Interrupts/sec"
```

This command imports only the **"Processor(_total)\Interrupts/sec"** counter data from the ProcessorData.blg file into the $i variable.

### Example 3
```
The first command uses **Import-Counter** to import all of the performance counter data from the ProcessorData.blg files. The command saves the data in the $Data variable.
PS C:\> $Data = Import-Counter .\ProcessorData.blg

The second command displays the counter paths in the $Data variable. To get the display shown in the command output, the example uses the Format-Table cmdlet to format as a table the counter paths of the first counter in the $Data variable.
PS C:\> $Data[0].CounterSamples | Format-Table -Property Path

Path
----
\\SERVER01\Processor(_Total)\DPC Rate
\\SERVER01\Processor(1)\DPC Rate
\\SERVER01\Processor(0)\DPC Rate
\\SERVER01\Processor(_Total)\% Idle Time
\\SERVER01\Processor(1)\% Idle Time
\\SERVER01\Processor(0)\% Idle Time
\\SERVER01\Processor(_Total)\% C3 Time
\\SERVER01\Processor(1)\% C3 Time

The third command gets the counter paths that end in "Interrupts/sec" and saves the paths in the $IntCtrs variable. It uses the Where-Object cmdlet to filter the counter paths and the ForEach-Object cmdlet to get only the value of the **Path** property of each selected path object.
PS C:\> $IntCtrs = $Data[0].Countersamples | Where-Object {$_.Path -like "*Interrupts/sec"} | ForEach-Object {$_.Path}

The fourth command displays the selected counter paths in the $IntCtrs variable.
PS C:\> $IntCtrs

\\SERVER01\Processor(_Total)\Interrupts/sec
\\SERVER01\Processor(1)\Interrupts/sec
\\SERVER01\Processor(0)\Interrupts/sec

The fifth command uses the **Import-Counter** cmdlet to import the data. It uses the $IntCtrs variable as the value of the **Counter** parameter to import only data for the counter paths in $IntCtrs.
PS C:\> $i = Import-Counter -Path .\ProcessorData.blg -Counter $intCtrs

The sixth command uses the Export-Counter cmdlet to export the data to the Interrupts.csv file.
PS C:\> $i | Export-Counter -Path .\Interrupts.csv -Format CSV
```

This example shows how to select data from a performance counter log file (.blg) and then export the selected data to a .csv file.
The first four commands get the counter paths from the file and save them in a variable.
The last two commands import selected data and then export only the selected data.

### Example 4
```
The first command uses the **ListSet** parameter of the **Import-Counter** cmdlet to get all of the counter sets that are represented in a counter data file.
PS C:\> Import-Counter -Path ProcessorData.csv -ListSet *

CounterSetName     : Processor
MachineName        : \\SERVER01
CounterSetType     : MultiInstance
Description        :
Paths              : {\\SERVER01\Processor(*)\DPC Rate, \\SERVER01\Processor(*)\% Idle Time, \\SERVER01
\Processor(*)\% C3 Time, \\SERVER01\Processor(*)\% Interrupt Time...}
PathsWithInstances : {\\SERVER01\Processor(_Total)\DPC Rate, \\SERVER01\Processor(1)\DPC Rate, \\SERVER01
\Processor(0)\DPC Rate, \\SERVER01\Processor(_Total)\% Idle Time...}
Counter            : {\\SERVER01\Processor(*)\DPC Rate, \\SERVER01\Processor(*)\% Idle Time, \\SERVER01
\Processor(*)\% C3 Time, \\SERVER01\Processor(*)\% Interrupt Time...}

The second command gets all of the counter paths from the list set.
PS C:\> Import-Counter -Path ProcessorData.csv -ListSet * | ForEach-Object {$_.Paths}

\\SERVER01\Processor(*)\DPC Rate
\\SERVER01\Processor(*)\% Idle Time
\\SERVER01\Processor(*)\% C3 Time
\\SERVER01\Processor(*)\% Interrupt Time
\\SERVER01\Processor(*)\% C2 Time
\\SERVER01\Processor(*)\% User Time
\\SERVER01\Processor(*)\% C1 Time
\\SERVER01\Processor(*)\% Processor Time
\\SERVER01\Processor(*)\C1 Transitions/sec
\\SERVER01\Processor(*)\% DPC Time
\\SERVER01\Processor(*)\C2 Transitions/sec
\\SERVER01\Processor(*)\% Privileged Time
\\SERVER01\Processor(*)\C3 Transitions/sec
\\SERVER01\Processor(*)\DPCs Queued/sec
\\SERVER01\Processor(*)\Interrupts/sec
```

This example shows how to display all the counter paths in a group of imported counter sets.

### Example 5
```
The first command lists in a table the time stamps of all of the data in the ProcessorData.blg file.
PS C:\> Import-Counter -Path .\disk.blg | Format-Table -Property Timestamp

The second command saves particular time stamps in the $Start and $End variables. The strings are cast to DateTime objects.
PS C:\> $Start = [datetime]"7/9/2008 3:47:00 PM"; $End = [datetime]"7/9/2008 3:47:59 PM"

The third command uses the **Import-Counter** cmdlet to get only counter data that has a time stamp between the start and end times (inclusive). The command uses the **StartTime** and **EndTime** parameters of **Import-Counter** to specify the range.
PS C:\> Import-Counter -Path Disk.blg -StartTime $start -EndTime $end
```

This example imports only the counter data that has a time stamp between the starting an ending ranges specified in the command.

### Example 6
```
The first command uses the **Import-Counter** cmdlet to import the first (oldest) five samples from the Disk.blg file. The command uses the **MaxSamples** parameter to limit the import to five counter samples.
PS C:\> Import-Counter -Path Disk.blg -MaxSamples 5

The second command uses array notation and the Windows PowerShell range operator (..) to get the last five counter samples from the file. These are the five newest samples.
PS C:\> (Import-Counter -Path Disk.blg)[-1 .. -5]
```

This example shows how to import the five oldest and five newest samples from a performance counter log file.

### Example 7
```
PS C:\> Import-Counter D:\Samples\memory.blg -Summary

OldestRecord            NewestRecord            SampleCount
------------            ------------            -----------
7/10/2008 2:59:18 PM    7/10/2008 3:00:27 PM    1000
```

This command uses the **Summary** parameter of the **Import-Counter** cmdlet to get a summary of the counter data in the Memory.blg file.

PS C:\\\>

### Example 8
```
The first command uses the **ListSet** parameter of **Import-Counter** to get the counters in OldData.blg, an existing counter log file. The command uses a pipeline operator (|) to send the data to a ForEach-Object command that gets only the values of the **PathsWithInstances** property of each object
PS C:\> $Counters = Import-Counter OldData.blg -ListSet * | ForEach-Object {$_.PathsWithInstances}

The second command gets updated data for the counters in the $Counters variable. It uses the Get-Counter cmdlet to get a current sample, and then export the results to the NewData.blg file.
PS C:\> Get-Counter -Counter $Counters -MaxSamples 20 | Export-Counter C:\Logs\NewData.blg
```

This example updates a performance counter log file.

### Example 9
```
PS C:\> $counters = "d:\test\pdata.blg", "d:\samples\netlog.blg" | import-counter
```

This command imports performance log data from two logs and saves the data in the $Counters variable.
The command uses a pipeline operator to send the performance log paths to Import-Counter, which imports the data from the specified paths.

Notice that each path is enclosed in quotation marks and that the paths are separated from each other by a comma.

## PARAMETERS

### -Counter
Imports data only for the specified performance counters.
By default, Import-Counter imports all data from all counters in the input files. 
Enter one or more counter paths.
Wildcards are permitted in the Instance part of the path.

Each counter path has the following format.
Notice that the ComputerName value is required in the path, even on the local computer.

"\\\\\<ComputerName\>\\\<CounterSet\>(\<Instance\>)\\\<CounterName\>"

For example:

"\\\\Server01\Processor(2)\% User Time"

"\\\\Server01\Processor(*)\% Processor Time

```yaml
Type: String[]
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: All counter
Accept pipeline input: False
Accept wildcard characters: True
```

### -EndTime
Imports only counter data with a timestamp less than or equal to the specified date and time.
Enter a DateTime object, such as one created by the Get-Date cmdlet.
By default, Import-Counter imports all counter data in the files specified by the Path parameter.

```yaml
Type: DateTime
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: No end time
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListSet
Gets the performance counter sets that are represented in the exported files.
Commands with this parameter do not import any data.

Enter one or more counter set names.
Wildcards are permitted. 
To get all counter sets in the file, type "import-counter -listset *".

```yaml
Type: String[]
Parameter Sets: ListSetSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -MaxSamples
Specifies the maximum number of samples of each counter to import.
By default, Get-Counter imports all of the data in the files specified by the Path parameter.

```yaml
Type: Int64
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: No maximum
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the file paths of the files to be imported.
This parameter is required.

Enter the path and file name of a, .csv,, .tsv, or .blg file that you exported by using the Export-Counter cmdlet.
You can specify only one .csv or .tsv file, but you can specify multiple .blg files (up to 32) in each command.
You can also pipe file path strings (in quotation marks) to Import-Counter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSPath

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -StartTime
Imports only counter data with a timestamp greater than or equal to the specified date and time.
Enter a DateTime object, such as one created by the Get-Date cmdlet.
By default, Import-Counter imports all counter data in the files specified by the Path parameter.

```yaml
Type: DateTime
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: No start time
Accept pipeline input: False
Accept wildcard characters: False
```

### -Summary
Gets a summary of the imported data, instead of getting individual counter data samples.

```yaml
Type: SwitchParameter
Parameter Sets: SummarySet
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe performance counter log paths to Import-Counter.

## OUTPUTS

### Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet, Microsoft.PowerShell.Commands.GetCounter.CounterSet, Microsoft.PowerShell.Commands.GetCounter.CounterFileInfo
By default, Import-Counter returns a Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet.
If you use the ListSet parameter, Import-Command returns a Microsoft.PowerShell.Commands.GetCounter.CounterSet object.
If you use the Summary parameter, Import-Command returns a Microsoft.PowerShell.Commands.GetCounter.CounterFileInfo object.

## NOTES
* The Import-Counter cmdlet does not have a ComputerName parameter. However, if the computer is configured for Windows PowerShell remoting, you can use the Invoke-Command cmdlet to run an Import-Counter command on a remote computer.

*

## RELATED LINKS

[Export-Counter](Export-Counter.md)

[Get-Counter](Get-Counter.md)

