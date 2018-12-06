---
external help file: Microsoft.PowerShell.Commands.Diagnostics.dll-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Diagnostics
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821527
schema: 2.0.0
title: Export-Counter
---

# Export-Counter

## SYNOPSIS
Exports performance counter data to log files.

## SYNTAX

```
Export-Counter [-Path] <String> [-FileFormat <String>] [-MaxSize <UInt32>]
 -InputObject <PerformanceCounterSampleSet[]> [-Force] [-Circular] [<CommonParameters>]
```

## DESCRIPTION
The **Export-Counter** cmdlet exports performance counter data (PerformanceCounterSampleSet objects) to log files in binary performance log (.blg), comma-separated value (.csv), or tab-separated value (.tsv) format.
You use this cmdlet to log performance counter data.

The **Export-Counter** cmdlet is designed to export data that is returned by the Get-Counter and Import-Counter cmdlets.

This cmdlet runs only on Windows 7, Windows Server 2008 R2, and later versions of Windows.

## EXAMPLES

### EXAMPLE 1: Export counter data to a file
```
PS C:\> Get-Counter "\Processor(*)\% Processor Time" | Export-Counter -Path $home\Counters.blg
```

This command exports counter data to a BLG file.

The command uses the Get-Counter cmdlet to collect processor time data.
It uses a pipeline operator (|) to send the data to the **Export-Counter** cmdlet.
The **Export-Counter** command uses the **Path** variable to specify the output file.

Because the data set might be very large, this example sends the data to **Export-Counter** through the pipeline.
If the data were saved in a variable, you might use a disproportionate amount of memory.

### Example 2: Export a file to a counter file format
```
The first command uses the built-in Windows PowerShell conversion feature to store the value of 1 gigabyte (GB) in bytes in the $1GBInBytes variable. When you type a value followed by KB (kilobyte), MB (megabyte), GB (gigabyte), TB (terabyte), and PB (Petabyte), Windows PowerShell returns the value in bytes.
PS C:\> $1GBInBytes = 1GB

The second command uses the Import-Counter cmdlet to import performance counter data from the Threads.csv file. The example presumes that this file was previously exported by using the **Export-Counter** cmdlet. A pipeline operator (|) sends the imported data to the **Export-Counter** cmdlet. The command uses the *Path* parameter to specify the location of the output file. It uses the *Circular* and *MaxSize* parameters to direct the **Export-Counter** cmdlet to create a circular log that wraps at 1 GB.
PS C:\> Import-Counter Threads.csv | Export-Counter -Path ThreadTest.blg -Circular -MaxSize $1GBinBytes
```

This example converts a CSV file to a counter data BLG format.

### Example 3: Get counter data from a remote computer and save the data to a file
```
The first command uses the Get-Counter cmdlet to collect working set counter data from Server01, a remote computer. The command saves the data in the $C variable.
PS C:\> $C = Get-Counter -ComputerName Server01 -Counter "\Process(*)\Working Set - Private" -MaxSamples 20

The second command uses a pipeline operator (|) to send the data in $C to the **Export-Counter** cmdlet, which saves it in the Workingset.blg file in the Perf share of the Server01 computer.
PS C:\> $C | Export-Counter -Path \\Server01\Perf\WorkingSet.blg
```

This example shows how to get performance counter data from a remote computer and save the data in a file on the remote computer.

### Example 4: Re-log existing data
```
The first command uses the **Import-Counter** cmdlet to import performance counter data from the DiskSpace.blg log. It saves the data in the $All variable. This file contains samples of the "LogicalDisk\% Free Space" counter on more than 200 remote computers in the enterprise.
PS C:\> $All = Import-Counter DiskSpace.blg

The second command uses the **CounterSamples** property of the sample set object in $All and the Where-Object cmdlet (alias = "where") to select objects with **CookedValues** of less than 15 (percent). The command saves the results in the $LowSpace variable.
PS C:\> $LowSpace = $All.CounterSamples | where {$_.CookedValues -lt 15}

The third command uses a pipeline operator (|) to send the data in the $LowSpace variable to the **Export-Counter** cmdlet. The command uses the *Path* parameter to indicate that the selected data should be logged in the LowDiskSpace.blg file.
PS C:\> $LowSpace | Export-Counter -Path LowDiskSpace.blg
```

This example shows how to use the Import-Counter and **Export-Counter** cmdlets to re-log existing data.

## PARAMETERS

### -Circular
Indicates that the output file is a circular log with first in, first out (FIFO) format.
When you include this parameter, the *MaxSize* parameter is required.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileFormat
Specifies the output format of the output log file.

The acceptable values for this parameter are:

- CSV
- TSV
- BLG

The default value is BLG.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overwrites and replaces an existing file if one exists in the location specified by the *Path* parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies, as an array, the counter data to export.
Enter a variable that contains the data or a command that gets the data, such as the **Get-Counter** or **Import-Counter** cmdlet.

```yaml
Type: PerformanceCounterSampleSet[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MaxSize
Specifies the maximum size of the output file.

If the *Circular* parameter is specified, then when the log file reaches the specified maximum size, the oldest entries are deleted as newer ones are added.
If the *Circular* parameter is not specified, then when the log file reaches the specified maximum size, no new data is added and the cmdlet generates a non-terminating error.

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path and file name of the output file.
Enter a relative or absolute path on the local computer, or a Uniform Naming Convention (UNC) path to a remote computer, such as \\\\Computer\Share\file.blg.
This parameter is required.

The file format is determined by the value of the *FileFormat* parameter, not by the file name extension in the path.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet
You can pipe performance counter data from **Get-Counter** or **Import-Counter** to this cmdlet.

## OUTPUTS

### None

## NOTES
* The log file generator expects that all input objects have the same counter path and that the objects are arranged in ascending time order.

  The counter type and path of the first input object determines the properties recorded in the log file.
If other input objects do not have a value for a recorded property, the property field is empty.
If the objects have property values that were not recorded, the extra property values are ignored.

  Performance Monitor might not be able to read all logs that **Export-Counter** generates.
For instance, Performance Monitor requires that all objects have the same path and that all objects are separated by the same time interval.

  The **Import-Counter** cmdlet does not have a *ComputerName* parameter.
However, if the computer is configured for remote Windows PowerShell Windows PowerShell, you can use the Invoke-Command cmdlet to run an Import-Counter command on a remote computer.

*

## RELATED LINKS

[Get-Counter](Get-Counter.md)

[Import-Counter](Import-Counter.md)