---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821528
external help file:  Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
title:  Get-Counter
---

# Get-Counter

## SYNOPSIS
Gets performance counter data from local and remote computers.

## SYNTAX

### GetCounterSet (Default)
```
Get-Counter [[-Counter] <String[]>] [-SampleInterval <Int32>] [-MaxSamples <Int64>] [-Continuous]
 [-ComputerName <String[]>] [<CommonParameters>]
```

### ListSetSet
```
Get-Counter [-ListSet] <String[]> [-ComputerName <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Counter** cmdlet gets live, real-time performance counter data directly from the performance monitoring instrumentation in the Windows family of operating systems.
You can use it to get performance data from the local or remote computers at the sample interval that you specify.

Without parameters, this cmdlet gets counter data for a set of system counters.

You can use the parameters of this cmdlet to specify one or more computers, to list the performance counter sets and the counters that they contain, and to set the sample size and interval.

## EXAMPLES

### Example 1: Get counter sets on the local computer
```
PS C:\> Get-Counter -ListSet *
```

This command gets all of the counter sets on the local computer.

Because many of the counter sets are protected by access control lists (ACLs), to see all counter sets, open Windows PowerShell with the "Run as administrator" option before using the **Get-Counter** command.

### Example 2: Get a counter set with a sample interval for a specified maximum sample
```
PS C:\> Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 3
```

This command gets the current "% Processor Time" combined values for all processors on the local computer.
It collects data every two seconds until it has three values.

### Example 3: Get an alphabetically sorted list of all counter sets
```
PS C:\> Get-Counter -ListSet * | Sort-Object CounterSetName | Format-Table CounterSetName
```

This command gets an alphabetically sorted list of the names of all of the counter sets on the local computer.

### Example 4: Use the counter Path property to find formatted path names for performance counters
```
The first command gets the path names of the performance counters in the Memory counter set on the local computer.
PS C:\> (Get-Counter -ListSet Memory).Paths

\Memory\Page Faults/sec
\Memory\Available Bytes
\Memory\Committed Bytes
\Memory\Commit Limit
\Memory\Write Copies/sec
\Memory\Transition Faults/sec
\Memory\Cache Faults/sec
\Memory\Demand Zero Faults/sec
\Memory\Pages/sec
\Memory\Pages Input/sec
...


The second command gets the path names that include "cache".
PS C:\> (Get-Counter -ListSet Memory).Paths | Where {$_ -like "*Cache*"}

\Memory\Cache Faults/sec
\Memory\Cache Bytes
\Memory\Cache Bytes Peak
\Memory\System Cache Resident Bytes
\Memory\Standby Cache Reserve Bytes
\Memory\Standby Cache Normal Priority Bytes
\Memory\Standby Cache Core Bytes
```

This example uses the **Path** property of a counter set to find the correctly formatted path names for the performance counters.
You can use a command like this one to get the correct counter path names.

### Example 5: Get specific counter data from multiple computers
```
The first command saves the **Disk Reads/sec** counter path in the $DiskReads variable.
PS C:\> $DiskReads = "\LogicalDisk(C:)\Disk Reads/sec"

The second command uses a pipeline operator (|) to send the counter path in the $DiskReads variable to the **Get-Counter** cmdlet. The command uses the **MaxSamples** parameter to limit the output to 10 samples.
PS C:\> $DiskReads | Get-Counter -Computer Server01, Server02 -MaxSamples 10
```

This example gets the **Disk Reads/sec** counter data from the Server01 and Server02 computers.

### Example 6: Get formatted path names for a performance counter
```
PS C:\> (Get-Counter -List PhysicalDisk).PathsWithInstances
```

This command gets the correctly formatted path names for the **PhysicalDisk** performance counters, including the instance names.

### Example 7: Get the value of a specific performance counter on multiple random computers
```
The first command uses the Get-Content cmdlet to get the list of enterprise servers from the Servers.txt file. It uses the Get-Random cmdlet to select 50 server names randomly from the Servers.txt file contents. The results are saved in the $Servers variable.
PS C:\> $Servers = Get-Random (Get-Content Servers.txt) -Count 50

The second command saves the path to the **"% DPC Time**" counter in the $Counter variable. The counter path includes a wildcard character in the instance name to get the data on all of the processors on each of the computers.
PS C:\> $Counter = "\Processor(*)\% DPC Time"

The third command uses the **Get-Counter** cmdlet to get the counter values. It uses the **Counter** parameter to specify the counters and the **ComputerName** parameter to specify the computers saved in the $servers variable.
PS C:\> Get-Counter -Counter $Counter -ComputerName $Servers
```

This example gets the value of the "**% DPC Time**" performance counter on 50 randomly select computers in the enterprise.

### Example 8: Get a single value for all of the performance counters in a counter set
```
The first command uses the **Get-Counter** cmdlet to get the counter paths. It saves them in the $MemCounters variable.
PS C:\> $MemCounters = (Get-Counter -List Memory).Paths

The second command uses the **Get-Counter** cmdlet to get the counter data for each counter. It uses the **Counter** parameter to specify the counters in the $MemCounters variable.
PS C:\> Get-Counter -Counter $MemCounters
```

This example gets a single value for all of the performance counters in the Memory counter set on the local computer.

### Example 9: Display property values in a PerformanceCounterSample
```
The first command saves a counter path in the $Counter variable.
PS C:\> $Counter = "\\SERVER01\Process(Idle)\% Processor Time"

The second command uses the **Get-Counter** cmdlet to get one sample of the counter values. It saves the results in the $Data variable.
PS C:\> $Data = Get-Counter $Counter

The third command uses the Format-List cmdlet to display all the properties of the **CounterSamples** property of the sample set object as a list.
PS C:\> $Data.CounterSamples | Format-List -Property *

Path             : \\SERVER01\process(idle)\% processor time
InstanceName     : idle
CookedValue      : 198.467899571389
RawValue         : 14329160321003
SecondValue      : 128606459528326201
MultipleCount    : 1
CounterType      : Timer100Ns
Timestamp        : 7/15/2008 6:39:12 PM
Timestamp100NSec : 128606207528320000
Status           : 0
DefaultScale     : 0
TimeBase         : 10000000
```

This example shows the property values in the **PerformanceCounterSample** object that represents each data sample. 
You can use the properties of the **CounterSamples** object to examine, select, sort, and group the data.

### Example 10: Get performance counter data as a background job
```
PS C:\> Start-Job -ScriptBlock {Get-Counter -Counter "\LogicalDisk(_Total)\% Free Space" -MaxSamples 1000}
```

The command runs a **Get-Counter** command as background job.
For more information, see Start-Job.

### Example 11: Get the percentage of free disk space on multiple random computers
```
PS C:\> Get-Counter -ComputerName (Get-Random Servers.txt -Count 50) -Counter "\LogicalDisk(*)\% Free Space"
```

This command uses the **Get-Counter** and Get-Random cmdlets to find the percentage of free disk space on 50 computers selected randomly from the Servers.txt file.

### Example 12: Associate counter data with a the computer from which it originated
```
The first command uses the **Get-Counter** cmdlet to get the "LogicalDisk\% Free Space" counter value from two remote computers, S1 and S2. It saves the result in the $DiskSpace variable.
PS C:\> $DiskSpace = Get-Counter "\LogicalDisk(_Total)\% Free Space" -ComputerName s1, s2

The second command displays the results that were saved in the $DiskSpace variable. All of the data is stored in the object, but it is not easy to see it in this form.
PS C:\> $DiskSpace

Timestamp                 CounterSamples
---------                 --------------
7/29/2009 3:04:33 PM      \\s1\\logicaldisk(_total)\% free space :
45.6992854507028
\\s2\\logicaldisk(_total)\% free space :
3.73238142733405

The third command displays in a table the value of the **CounterSamples** property of the **PerformanceCounterSampleSet** object that **Get-Counter** returns. (To see all of the properties and methods of the object, pipe it to the Get-Member cmdlet.)
PS C:\> $DiskSpace.CounterSamples | Format-Table -AutoSize

Path                                     InstanceName CookedValue
----                                     ------------ -----------
\\s1\\logicaldisk(_total)\% free space   _total       45.6992854507028
\\s2\\logicaldisk(_total)\% free space   _total       3.73238142733405

The **CounterSamples** property contains a **PerformanceCounterSample** object with its own properties and methods. The fourth command uses array notation to get the first counter sample and a pipeline operator to send the counter sample object to the Format-List cmdlet, which displays all of its properties and property value in a list. This display shows the richness of the data in each counter sample object.
PS C:\> $DiskSpace.countersamples[0] | Format-Table -Property *

Path             : \\localhost\\logicaldisk(_total)\% free space
InstanceName     : _total
CookedValue      : 45.6992854507028
RawValue         : 108980
SecondValue      : 238472
MultipleCount    : 1
CounterType      : RawFraction
Timestamp        : 7/29/2009 3:04:33 PM
Timestamp100NSec : 128933534734680000
Status           : 0
DefaultScale     : 0
TimeBase         : 14318180

The fifth command shows how to select data from the counter samples. It uses the Where-Object cmdlet to get only the counter samples with a **CookedValue** of less than 15.
PS C:\> $DiskSpace.CounterSamples | Where-Object {$_.CookedValue -lt 15}

Path                                InstanceName    CookedValue
----                                ------------    -----------
\\s2\\logicaldisk(_total)\% free... _total          3.73238142733405
```

This example shows how to associate counter data with the computer on which it originated, and how to manipulate the data.

### Example 13: Sort performance counter data
```
The first command uses the **Get-Counter** cmdlet to get the "Process\% Processor Time" counter for all the processes on the computer. The command saves the results in the $P variable.
PS C:\> $P = Get-Counter '\Process(*)\% Processor Time'

The second command gets the **CounterSamples** property of the sample set object in $p. It uses the Sort-Object cmdlet to sort the samples in descending order based on the cooked value of the sample. Then, the command uses Format-Table cmdlet to display the data in a table and its **AutoSize** parameter to optimize the display.
PS C:\> $p.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Auto

Path                                              InstanceName      CookedValue
----                                              ------------      -----------
\\server01\process(_total)\% processor time        _total        200.00641042078
\\server01\process(idle)\% processor time          idle          200.00641042078
\\server01\process(explorer#1)\% processor time    explorer                    0
\\server01\process(dwm#1)\% processor time         dwm                         0
\\server01\process(taskeng#1)\% processor time     taskeng                     0
\\server01\process(taskhost#1)\% processor time    taskhost                    0
\\server01\process(winlogon)\% processor time      winlogon                    0
\\server01\process(csrss)\% processor time         csrss                       0
```

This example shows how to sort performance counter data.
The example finds the processes on the computer that are using the most processor time during the sampling.

### Example 14: Find processes on a computer with the largest working sets
```
The first command gets one sample of the "Process\Working Set - Private" counter for each process. The command saves the counter data in the $WS variable.
PS C:\> $WS = Get-Counter "\Process(*)\Working Set - Private"

The second command uses a pipeline operator (|) to send the data in the **CounterSamples** property of the $ws variable to the Sort-Object cmdlet, where the process data is sorted in descending order by the value of the **CookedValue** property. Another pipeline sends the sorted data to the Format-Table cmdlet, where the data is formatted as a table with **InstanceName** and **CookedValue** columns.
PS C:\> $ws.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Property InstanceName, CookedValue -AutoSize

InstanceName  CookedValue
------------  -----------
_total          162983936
svchost          40370176
powershell       15110144
explorer         14135296
svchost          10928128
svchost           9027584
...
```

This example finds the processes on the computer with the largest working sets.
The cmdlet lists the processes in descending order based on their working set size.

### Example 15: Get a series of samples of a performance counter
```
PS C:\> Get-Counter -Counter "\Processor(_Total)\% Processor Time" -Continuous
```

This command gets a series of samples of the Processor\% Processor Time counter at the default one second interval.
To stop the command, press CTRL + C.

## PARAMETERS

### -ComputerName
Specifies, as a string array, the names of the computers that this cmdlet gets performance counter data from.
You can specify the NetBIOS name, an Internet Protocol (IP) address, or the fully qualified domain names (FQDN) of the computers.
The default value is the local computer.

This cmdlet does not rely on Windows PowerShell remoting.
You can use the *ComputerName* parameter of the **Get-Counter** cmdlet even if your computer is not configured for remoting in Windows PowerShell.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Continuous
Indicates that this cmdlet gets samples continuously until you press CTRL+C.
By default, this cmdlet gets only one counter sample.
You can use the *SampleInterval* parameter to set the interval for continuous sampling.

```yaml
Type: SwitchParameter
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Counter
Specifies, as a string array, data from the specified performance counters.
Enter one or more counter paths.
You can also pipe counter path strings to this cmdlet.

Each counter path has the following format:

"\[\\\\\<ComputerName\>\]\\\<CounterSet\>(\<Instance\>)\\\<CounterName\>"

For instance:

"\\\\Server01\Processor(2)\% User Time"

The \<ComputerName\> element is optional.
If you omit it, this cmdlet uses the value of the *ComputerName* parameter.

To get correctly formatted counter paths, use the *ListSet* parameter to get a performance counter set.
The **Paths** and **PathsWithInstances** properties of each performance counter set contain the individual counter paths formatted as a string.
You can save the counter path strings in a variable or pipe the string directly to another **Get-Counter** command.
For a demonstration, see the examples.

```yaml
Type: String[]
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ListSet
Specifies the performance counter sets on the computers.
Enter the names of the counter sets.
You can also pipe counter set names to this cmdlet.

```yaml
Type: String[]
Parameter Sets: ListSetSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MaxSamples
Specifies the number of samples to get from each counter.
The default is 1 sample.
To get samples continuously, use the *Continuous* parameter.

To collect a very large data set, consider running a **Get-Counter** cmdlet as a Windows PowerShelll background job.
For more information, see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md) and the Start-Job.

```yaml
Type: Int64
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SampleInterval
Specifies the time between samples in seconds.
The minimum value and the default value are 1 second.

```yaml
Type: Int32
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
You can pipe counter paths and counter set (ListSet) names to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.GetCounter.CounterSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample
This cmdlet returns Microsoft.PowerShell.Commands.GetCounter.CounterSet objects through the *ListSet* parameter.
The *Counter* parameter gets **Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet** objects.
Each counter value is a **Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample** object.

## NOTES
* Performance counters are often protected by access control lists (ACLs). To get all available performance counters, open Windows PowerShell with the "Run as administrator" option.

  By default, **Get-Counter** gets one sample during a one-second sample interval.
To change this behavior, use the *MaxSamples* and *Continuous* parameters.

  The *MaxSamples* and *SampleInterval* values that you set apply to all the counters on all the computers in the command.
To set different values for different counters, enter separate **Get-Counter** commands for each counter.

*

## RELATED LINKS

[Export-Counter](Export-Counter.md)

[Import-Counter](Import-Counter.md)

