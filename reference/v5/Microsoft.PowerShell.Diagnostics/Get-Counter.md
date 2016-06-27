---
external help file: Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289625
schema: 2.0.0
---

# Get-Counter
## SYNOPSIS
Gets performance counter data from local and remote computers.

## SYNTAX

### GetCounterSet (Default)
```
Get-Counter [[-Counter] <String[]>] [-SampleInterval <Int32>] [-MaxSamples <Int64>] [-Continuous]
 [-ComputerName <String[]>]
```

### ListSetSet
```
Get-Counter [-ListSet] <String[]> [-ComputerName <String[]>]
```

## DESCRIPTION
The Get-Counter cmdlet gets live, real-time performance counter data directly from the performance monitoring instrumentation in Windows. 
You can use it to get performance data from the local or remote computers at the sample interval that you specify.

Without parameters, a "Get-Counter" command gets counter data for a set of system counters.

You can use the parameters of Get-Counter to specify one or more computers, to list the performance counter sets and the counters that they contain, and to set the sample size and interval.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-Counter -ListSet *
```

This command gets all of the counter sets on the local computer.

Because many of the counter sets are protected by access control lists (ACLs), to see all counter sets, open Windows PowerShell with the "Run as administrator" option before using the Get-Counter command.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 3
```

This command gets the current "% Processor Time" combined values for all processors on the local computer.
It collects data every two seconds until it has three values.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Get-Counter -ListSet * | Sort-Object CounterSetName | Format-Table CounterSetName
```

This command gets an alphabetically sorted list of the names of all of the counter sets on the local computer.

### -------------------------- EXAMPLE 4 --------------------------
```
The first command gets the path names of the performance counters in the Memory counter set on the local computer.
PS C:\>(Get-Counter -ListSet Memory).Paths

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
PS C:\>(Get-Counter -ListSet Memory).Paths | Where {$_ -like "*Cache*"}

\Memory\Cache Faults/sec
\Memory\Cache Bytes
\Memory\Cache Bytes Peak
\Memory\System Cache Resident Bytes
\Memory\Standby Cache Reserve Bytes
\Memory\Standby Cache Normal Priority Bytes
\Memory\Standby Cache Core Bytes
```

These commands use the Path property of a counter set to find the correctly formatted path names for the performance counters.
You can use a command like this one to get the correct counter path names.

### -------------------------- EXAMPLE 5 --------------------------
```
The first command saves the Disk Reads/sec counter path in the $DiskReads variable.
PS C:\>$DiskReads = "\LogicalDisk(C:)\Disk Reads/sec"

The second command uses a pipeline operator (|) to send the counter path in the $DiskReads variable to the Get-Counter cmdlet. The command uses the MaxSamples parameter to limit the output to 10 samples.
PS C:\>$DiskReads | Get-Counter -Computer Server01, Server02 -MaxSamples 10
```

These commands get the Disk Reads/sec counter data from the Server01 and Server02 computers.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>(Get-Counter -List PhysicalDisk).PathsWithInstances
```

This command gets the correctly formatted path names for the PhysicalDisk performance counters, including the instance names.

### -------------------------- EXAMPLE 7 --------------------------
```
The first command uses the Get-Content cmdlet to get the list of enterprise servers from the Servers.txt file. It uses the Get-Random cmdlet to select 50 server names randomly from the Servers.txt file contents. The results are saved in the $Servers variable.
PS C:\>$Servers = Get-Random (Get-Content Servers.txt) -Count 50

The second command saves the path to the "% DPC Time" counter in the $Counter variable. The counter path includes a wildcard character in the instance name to get the data on all of the processors on each of the computers.
PS C:\>$Counter = "\Processor(*)\% DPC Time"

The third command uses the Get-Counter cmdlet to get the counter values. It uses the Counter parameter to specify the counters and the ComputerName parameter to specify the computers saved in the $servers variable.
PS C:\>Get-Counter -Counter $Counter -ComputerName $Servers
```

These commands get the value of the "% DPC Time" performance counter on 50 randomly select computers in the enterprise.

### -------------------------- EXAMPLE 8 --------------------------
```
The first command uses the Get-Counter cmdlet to get the counter paths. It saves them in the $MemCounters variable.
PS C:\>$MemCounters = (Get-Counter -List Memory).Paths

The second command uses the Get-Counter cmdlet to get the counter data for each counter. It uses the Counter parameter to specify the counters in the $MemCounters variable.
PS C:\>Get-Counter -Counter $MemCounters
```

These commands get a single value for all of the performance counters in the Memory counter set on the local computer.

### -------------------------- EXAMPLE 9 --------------------------
```
The first command saves a counter path in the $Counter variable.
PS C:\>$Counter = "\\SERVER01\Process(Idle)\% Processor Time"

The second command uses the Get-Counter cmdlet to get one sample of the counter values. It saves the results in the $Data variable.
PS C:\>$Data = Get-Counter $Counter

The third command uses the Format-List cmdlet to display all the properties of the CounterSamples property of the sample set object as a list.
PS C:\>$Data.CounterSamples | Format-List -Property *

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

This example shows the property values in the PerformanceCounterSample object that represents each data sample. 
You can use the properties of the CounterSamples object to examine, select, sort,  and group the data.

### -------------------------- EXAMPLE 10 --------------------------
```
PS C:\>Start-Job -ScriptBlock {Get-Counter -Counter "\LogicalDisk(_Total)\% Free Space" -MaxSamples 1000}
```

The command runs a Get-Counter command as background job.
For more information, see Start-Job.

PS C:\\\>

PS C:\\\>

### -------------------------- EXAMPLE 11 --------------------------
```
PS C:\>Get-Counter -ComputerName (Get-Random Servers.txt -Count 50) -Counter "\LogicalDisk(*)\% Free Space"
```

This command uses the Get-Counter and Get-Random cmdlets to find the percentage of free disk space on 50 computers selected randomly from the Servers.txt file.

### -------------------------- EXAMPLE 12 --------------------------
```
The first command uses the Get-Counter cmdlet to get the "LogicalDisk\% Free Space" counter value from two remote computers, S1 and S2. It saves the result in the $DiskSpace variable.
PS C:\>$DiskSpace = Get-Counter "\LogicalDisk(_Total)\% Free Space" -ComputerName s1, s2

The second command displays the results that were saved in the $DiskSpace variable. All of the data is stored in the object, but it is not easy to see it in this form.
PS C:\>$DiskSpace

Timestamp                 CounterSamples
---------                 --------------
7/29/2009 3:04:33 PM      \\s1\\logicaldisk(_total)\% free space :
45.6992854507028
\\s2\\logicaldisk(_total)\% free space :
3.73238142733405

The third command displays in a table the value of the CounterSamples property of the PerformanceCounterSampleSet object that Get-Counter returns. (To see all of the properties and methods of the object, pipe it to the Get-Member cmdlet.)
PS C:\>$DiskSpace.CounterSamples | Format-Table -AutoSize

Path                                     InstanceName CookedValue
----                                     ------------ -----------
\\s1\\logicaldisk(_total)\% free space   _total       45.6992854507028
\\s2\\logicaldisk(_total)\% free space   _total       3.73238142733405

The CounterSamples property contains a PerformanceCounterSample object with its own properties and methods. The fourth command uses array notation to get the first counter sample and a pipeline operator to send the counter sample object to the Format-List cmdlet, which displays all of its properties and property value in a list. This display shows the richness of the data in each counter sample object.
PS C:\>$DiskSpace.countersamples[0] | Format-Table -Property *

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

The fifth command shows how to select data from the counter samples. It uses the Where-Object cmdlet to get only the counter samples with a CookedValue of less than 15.
PS C:\>$DiskSpace.CounterSamples | Where-Object {$_.CookedValue -lt 15}

Path                                InstanceName    CookedValue
----                                ------------    -----------
\\s2\\logicaldisk(_total)\% free... _total          3.73238142733405
```

This example shows how to associate counter data with the computer on which it originated, and how to manipulate the data.

### -------------------------- EXAMPLE 13 --------------------------
```
The first command uses the Get-Counter cmdlet to get the "Process\% Processor Time" counter for all the processes on the computer. The command saves the results in the $p variable.
PS C:\>$p = Get-counter '\Process(*)\% Processor Time'

The second command gets the CounterSamples property of the sample set object in $p. It uses the Sort-Object cmdlet to sort the samples in descending order based on the cooked value of the sample. Then, the command uses Format-Table cmdlet to display the data in a table and its AutoSize parameter to optimize the display.
PS C:\>$p.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Auto

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

This example shows how to sort the performance counter data that you retrieve.
The example finds the processes on the computer that are using the most processor time during the sampling.

### -------------------------- EXAMPLE 14 --------------------------
```
The first command gets one sample of the "Process\Working Set - Private" counter for each process. The command saves the counter data in the $ws variable.
PS C:\>$ws = Get-Counter "\Process(*)\Working Set - Private"

The second command uses a pipeline operator (|) to send the data in the CounterSamples property of the $ws variable to the Sort-Object cmdlet, where the process data is sorted in descending order by the value of the CookedValue property. Another pipeline sends the sorted data to the Format-Table cmdlet, where the data is formatted as a table with InstanceName and CookedValue columns.
PS C:\>$ws.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Property InstanceName, CookedValue -AutoSize

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

These commands find the processes on the computer with the largest working sets.
They list the processes in descending order based on their working set size.

### -------------------------- EXAMPLE 15 --------------------------
```
PS C:\>Get-Counter -Counter "\Processor(_Total)\% Processor Time" -Continuous
```

This command gets a series of samples of the Processor\% Processor Time counter at the default one second interval.
To stop the command, press CTRL + C.

## PARAMETERS

### -ComputerName
Gets data from the specified computers.
Type the NetBIOS name, an Internet Protocol (IP) address, or the fully qualified domain names of the computers.
The default value is the local computer.

Note:  Get-Counter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-Counter even if your computer is not configured for remoting in Windows PowerShell.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Continuous
Gets samples continuously until you press CTRL+C.
By default, Get-Counter gets only one counter sample.
You can use the SampleInterval parameter to set the interval for continuous sampling.

```yaml
Type: SwitchParameter
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Counter
Gets data from the specified performance counters.
Enter one or more counter paths.
Wildcards are permitted only in the Instance value.
You can also pipe counter path strings to Get-Counter.

Each counter path has the following format:

"\[\\\\\<ComputerName\>\]\\\<CounterSet\>(\<Instance\>)\\\<CounterName\>"

For example:

"\\\\Server01\Processor(2)\% User Time"

The \<ComputerName\> element is optional.
If you omit it, Get-Counter uses the value of the ComputerName parameter.

Note:  To get correctly formatted counter paths, use the ListSet parameter to get a performance counter set.
The Paths and PathsWithInstances properties of each performance counter set contain the individual counter paths formatted as a string.
You can save the counter path strings in a variable or pipe the string directly to another Get-Counter command.
For a demonstration, see the examples.

```yaml
Type: String[]
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -ListSet
Gets the specified performance counter sets on the computers.
Enter the names of the counter sets.
Wildcards are permitted.
You can also pipe counter set names to Get-Counter.

```yaml
Type: String[]
Parameter Sets: ListSetSet
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -MaxSamples
Specifies the number of samples to get from each counter.
The default is 1 sample.
To get samples continuously (no maximum sample size), use the Continuous parameter.

To collect a very large data set, consider running a Get-Counter command as a Windows PowerShell background job.
For more information, see about_Jobs and Start-Job.

```yaml
Type: Int64
Parameter Sets: GetCounterSet
Aliases: 

Required: False
Position: Named
Default value: 1
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
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String[]
You can pipe counter paths and counter set (ListSet) names to Get-Counter.

## OUTPUTS

### Microsoft.PowerShell.Commands.GetCounter.CounterSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample
The ListSet parameter gets Microsoft.PowerShell.Commands.GetCounter.CounterSet objects.
The Counter parameter gets Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet objects. 
Each counter value is a Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample object.

## NOTES
Performance counters are often protected by access control lists (ACLs).
To get all available performance counters, open Windows PowerShell with the "Run as administrator" option.

By default, Get-Counter gets one sample during a one-second sample interval.
To change this behavior, use the MaxSamples and Continuous parameters.

The MaxSamples and SampleInterval values that you set apply to all the counters on all the computers in the command.
To set different values for different counters, enter separate Get-Counter commands for each counter.

## RELATED LINKS

[Export-Counter]()

[Import-Counter]()

