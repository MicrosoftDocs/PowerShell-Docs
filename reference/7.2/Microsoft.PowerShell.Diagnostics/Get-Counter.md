---
external help file: Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Diagnostics
ms.date: 11/06/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Counter
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

The `Get-Counter` cmdlet gets performance counter data directly from the performance monitoring
instrumentation in the Windows family of operating systems. `Get-Counter` gets performance data from
a local computer or remote computers.

You can use the `Get-Counter` parameters to specify one or more computers, list the performance
counter sets and the instances they contain, set the sample intervals, and specify the maximum
number of samples. Without parameters, `Get-Counter` gets performance counter data for a set of
system counters.

Many counter sets are protected by access control lists (ACL). To see all counter sets, open
PowerShell with the **Run as administrator** option.

This cmdlet was reintroduced in PowerShell 7.

## EXAMPLES

### Example 1: Get the counter set list

This example gets the local computer's list of counter sets.

```powershell
Get-Counter -ListSet *
```

```Output
CounterSetName     : Processor
MachineName        : .
CounterSetType     : MultiInstance
Description        : The Processor performance object consists of counters that measure aspects ...
                     computer that performs arithmetic and logical computations, initiates ...
                     computer can have multiple processors.  The processor object represents ...
Paths              : {\Processor(*)\% Processor Time, \Processor(*)\% User Time, ...
PathsWithInstances : {\Processor(0)\% Processor Time, \Processor(1)\% Processor Time, ...
Counter            : {\Processor(*)\% Processor Time, \Processor(*)\% User Time, ...
```

`Get-Counter` uses the **ListSet** parameter with an asterisk (`*`) to get the list of counter sets.
The dot (`.`) in the **MachineName** column represents the local computer.

### Example 2: Specify the SampleInterval and MaxSamples

This examples gets the counter data for all processors on the local computer. Data is collected at
two-second intervals until there are three samples.

```powershell
Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 3
```

```Output
Timestamp                 CounterSamples
---------                 --------------
6/18/2019 14:39:56        \\Computer01\processor(_total)\% processor time :
                          20.7144271584086

6/18/2019 14:39:58        \\Computer01\processor(_total)\% processor time :
                          10.4391790575511

6/18/2019 14:40:01        \\Computer01\processor(_total)\% processor time :
                          37.5968799396998
```

`Get-Counter` uses the **Counter** parameter to specify the counter path
`\Processor(_Total)\% Processor Time`. The **SampleInterval** parameter sets a two-second interval
to check the counter. **MaxSamples** determines that three is the maximum number of times to check
the counter.

### Example 3: Get continuous samples of a counter

This examples gets continuous samples for a counter every second. To stop the command, press
<kbd>CTRL</kbd>+<kbd>C</kbd>. To specify a longer interval between samples, use the
**SampleInterval** parameter.

```powershell
Get-Counter -Counter "\Processor(_Total)\% Processor Time" -Continuous
```

```Output
Timestamp                 CounterSamples
---------                 --------------
6/19/2019 15:35:03        \\Computer01\processor(_total)\% processor time :
                          43.8522842937022

6/19/2019 15:35:04        \\Computer01\processor(_total)\% processor time :
                          29.7896844697383

6/19/2019 15:35:05        \\Computer01\processor(_total)\% processor time :
                          29.4962645638135

6/19/2019 15:35:06        \\Computer01\processor(_total)\% processor time :
                          25.5901500127408
```

`Get-Counter` uses the **Counter** parameter to specify the `\Processor\% Processor Time` counter.
The **Continuous** parameter specifies to get samples every second until the command is stopped with
<kbd>CTRL</kbd>+<kbd>C</kbd>.

### Example 4: Alphabetical list of counter sets

This example uses the pipeline to get the counter list set and then sort the list in alphabetical
order.

```powershell
Get-Counter -ListSet * |
  Sort-Object -Property CounterSetName |
    Format-Table CounterSetName, CounterSetType -AutoSize
```

```Output
CounterSetName                        CounterSetType
--------------                        --------------
.NET CLR Data                         SingleInstance
.NET Data Provider for SqlServer      SingleInstance
AppV Client Streamed Data Percentage  SingleInstance
Authorization Manager Applications    SingleInstance
BitLocker                             MultiInstance
Bluetooth Device                      SingleInstance
Cache                                 SingleInstance
Client Side Caching                   SingleInstance
```

`Get-Counter` uses the **ListSet** parameter with an asterisk (`*`) to get a complete list of
counter sets. The **CounterSet** objects are sent down the pipeline. `Sort-Object` uses the
**Property** parameter to specify that the objects are sorted by **CounterSetName**. The objects are
sent down the pipeline to `Format-Table`. The **AutoSize** parameter adjusts the column widths to
minimize truncation.

The dot (`.`) in the **MachineName** column represents the local computer.

### Example 5: Run a background job to get counter data

In this example, `Start-Job` runs a `Get-Counter` command as a background job on the local computer.
To view the performance counter output from the job, use the `Receive-Job` cmdlet.

```powershell
Start-Job -ScriptBlock {Get-Counter -Counter "\LogicalDisk(_Total)\% Free Space" -MaxSamples 1000}
```

```Output
Id     Name  PSJobTypeName   State    HasMoreData  Location   Command
--     ----  -------------   -----    -----------  --------   -------
1      Job1  BackgroundJob   Running  True         localhost  Get-Counter -Counter
```

`Start-Job` uses the **ScriptBlock** parameter to run a `Get-Counter` command. `Get-Counter` uses
the **Counter** parameter to specify the counter path `\LogicalDisk(_Total)\% Free Space`. The
**MaxSamples** parameter specifies to get 1000 samples of the counter.

### Example 6: Get counter data from multiple computers

This example uses a variable to get performance counter data from two computers.

```powershell
$DiskReads = "\LogicalDisk(C:)\Disk Reads/sec"
$DiskReads | Get-Counter -ComputerName Server01, Server02 -MaxSamples 10
```

```Output
Timestamp                 CounterSamples
---------                 --------------
6/21/2019 10:51:04        \\Server01\logicaldisk(c:)\disk reads/sec :
                          0

                          \\Server02\logicaldisk(c:)\disk reads/sec :
                          0.983050344269146
```

The `$DiskReads` variable stores the `\LogicalDisk(C:)\Disk Reads/sec` counter path. The
`$DiskReads` variable is sent down the pipeline to `Get-Counter`. **Counter** is the first position
parameter and accepts the path stored in `$DiskReads`. **ComputerName** specifies the two computers
and **MaxSamples** specifies to get 10 samples from each computer.

### Example 7: Get a counter's instance values from multiple random computers

This example gets the value of a performance counter on 50 random, remote computers in the
enterprise. The **ComputerName** parameter uses random computer names stored in a variable. To
update the computer names in the variable, recreate the variable.

An alternative for the server names in the **ComputerName** parameter is to use a text file. For
example:

`-ComputerName (Get-Random (Get-Content -Path C:\Servers.txt) -Count 50)`

The counter path includes an asterisk (`*`) in the instance name to get the data for each of the
remote computer's processors.

```powershell
$Servers = Get-Random (Get-Content -Path C:\Servers.txt) -Count 50
$Counter = "\Processor(*)\% Processor Time"
Get-Counter -Counter $Counter -ComputerName $Servers
```

```Output
Timestamp                 CounterSamples
---------                 --------------
6/20/2019 12:20:35        \\Server01\processor(0)\% processor time :
                          6.52610319637854

                          \\Server01\processor(1)\% processor time :
                          3.41030663625782

                          \\Server01\processor(2)\% processor time :
                          9.64189975649925

                          \\Server01\processor(3)\% processor time :
                          1.85240835619747

                          \\Server01\processor(_total)\% processor time :
                          5.35768447160776
```

The `Get-Random` cmdlet uses `Get-Content` to select 50 random computer names from the
`Servers.txt` file. The remote computer names are stored in the `$Servers` variable. The
`\Processor(*)\% Processor Time` counter's path is stored in the `$Counter` variable. `Get-Counter`
uses the **Counter** parameter to specify the counters in the `$Counter` variable. The
**ComputerName** parameter specifies the computer names in the `$Servers` variable.

### Example 8: Use the Path property to get formatted path names

This example uses the **Path** property of a counter set to find the formatted path names for the
performance counters.

The pipeline is used with the `Where-Object` cmdlet to find a subset of the path names. To find a
counter sets complete list of counter paths, remove the pipeline (`|`) and `Where-Object` command.

The `$_` is an automatic variable for the current object in the pipeline.
For more information, see [about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md).

```powershell
(Get-Counter -ListSet Memory).Paths | Where-Object { $_ -like "*Cache*" }
```

```Output
\Memory\Cache Faults/sec
\Memory\Cache Bytes
\Memory\Cache Bytes Peak
\Memory\System Cache Resident Bytes
\Memory\Standby Cache Reserve Bytes
\Memory\Standby Cache Normal Priority Bytes
\Memory\Standby Cache Core Bytes
\Memory\Long-Term Average Standby Cache Lifetime (s)
```

`Get-Counter` uses the **ListSet** parameter to specify the **Memory** counter set. The command is
enclosed in parentheses so that the **Paths** property returns each path as a string. The objects
are sent down the pipeline to `Where-Object`. `Where-Object` uses the variable `$_` to process each
object and uses the `-like` operator to find matches for the string `*Cache*`. The asterisks (`*`)
are wildcards for any characters.

### Example 9: Use the PathsWithInstances property to get formatted path names

This example gets the formatted path names that include the instances for the **PhysicalDisk**
performance counters.

```powershell
(Get-Counter -ListSet PhysicalDisk).PathsWithInstances
```

```Output
\PhysicalDisk(0 C:)\Current Disk Queue Length
\PhysicalDisk(_Total)\Current Disk Queue Length
\PhysicalDisk(0 C:)\% Disk Time
\PhysicalDisk(_Total)\% Disk Time
\PhysicalDisk(0 C:)\Avg. Disk Queue Length
\PhysicalDisk(_Total)\Avg. Disk Queue Length
\PhysicalDisk(0 C:)\% Disk Read Time
\PhysicalDisk(_Total)\% Disk Read Time
```

`Get-Counter` uses the **ListSet** parameter to specify the **PhysicalDisk** counter set. The
command is enclosed in parentheses so that the **PathsWithInstances** property returns each path
instance as a string.

### Example 10: Get a single value for each counter in a counter set

In this example, a single value is returned for each performance counter in the local computer's
**Memory** counter set.

```powershell
$MemCounters = (Get-Counter -ListSet Memory).Paths
Get-Counter -Counter $MemCounters
```

```Output
Timestamp                 CounterSamples
---------                 --------------
6/19/2019 12:05:00        \\Computer01\memory\page faults/sec :
                          868.772077545597

                          \\Computer01\memory\available bytes :
                          9031176192

                          \\Computer01\memory\committed bytes :
                          8242982912

                          \\Computer01\memory\commit limit :
                          19603333120
```

`Get-Counter` uses the **ListSet** parameter to specify the **Memory** counter set. The command is
enclosed in parentheses so that the **Paths** property returns each path as a string. The paths are
stored in the `$MemCounters` variable. `Get-Counter` uses the **Counter** parameter to specify the
counter paths in the `$MemCounters` variable.

### Example 11: Display an object's property values

The property values in the **PerformanceCounterSample** object represent each data sample. In this
example we use the properties of the **CounterSamples** object to examine, select, sort, and group
the data.

```powershell
$Counter = "\\Server01\Process(Idle)\% Processor Time"
$Data = Get-Counter $Counter
$Data.CounterSamples | Format-List -Property *
```

```Output
Path             : \\Server01\process(idle)\% processor time
InstanceName     : idle
CookedValue      : 198.467899571389
RawValue         : 14329160321003
SecondValue      : 128606459528326201
MultipleCount    : 1
CounterType      : Timer100Ns
Timestamp        : 6/19/2019 12:20:49
Timestamp100NSec : 128606207528320000
Status           : 0
DefaultScale     : 0
TimeBase         : 10000000
```

The counter path is stored in the `$Counter` variable. `Get-Counter` gets one sample of the counter
values and stores the results in the `$Data` variable. The `$Data` variable uses the
**CounterSamples** property to get the object's properties. The object is sent down the pipeline to
`Format-List`. The **Property** parameter uses an asterisk (`*`) wildcard to select all the
properties.

### Example 12: Performance counter array values

In this example, a variable stores each performance counter. The **CounterSamples** property is an
array that can display specific counter values.

To display each counter sample, use `$Counter.CounterSamples`.

```powershell
$Counter = Get-Counter -Counter "\Processor(*)\% Processor Time"
$Counter.CounterSamples[0]
```

```Output
Path                                         InstanceName        CookedValue
----                                         ------------        -----------
\\Computer01\processor(0)\% processor time   0              1.33997091699662
```

`Get-Counter` uses the **Counter** parameter to specify the counter
`\Processor(*)\% Processor Time`. The values are stored in the `$Counter` variable.
`$Counter.CounterSamples[0]` displays the array value for the first counter value.

### Example 13: Compare performance counter values

This example finds the amount of processor time used by each processor on the local computer. The
**CounterSamples** property is used to compare the counter data against a specified value.

To display each counter sample, use `$Counter.CounterSamples`.

```powershell
$Counter = Get-Counter -Counter "\Processor(*)\% Processor Time"
$Counter.CounterSamples | Where-Object { $_.CookedValue -lt "20" }
```

```Output
Path                                         InstanceName        CookedValue
----                                         ------------        -----------
\\Computer01\processor(0)\% processor time   0              12.6398025240208
\\Computer01\processor(1)\% processor time   1              15.7598095767344
```

`Get-Counter` uses the **Counter** parameter to specify the counter
`\Processor(*)\% Processor Time`. The values are stored in the `$Counter` variable. The objects
stored in `$Counter.CounterSamples` are sent down the pipeline. `Where-Object` uses a script block
to compare each objects value against a specified value of 20. The `$_.CookedValue` is a variable
for the current object in the pipeline. Counters with a **CookedValue** that is less than 20 are
displayed.

### Example 14: Sort performance counter data

This example shows how to sort performance counter data. The example finds the processes on the
computer that are using the most processor time during the sample.

```powershell
$Procs = Get-Counter -Counter "\Process(*)\% Processor Time"
$Procs.CounterSamples | Sort-Object -Property CookedValue -Descending |
   Format-Table -Property Path, InstanceName, CookedValue -AutoSize
```

```Output
Path                                                         InstanceName             CookedValue
----                                                         ------------             -----------
\\Computer01\process(_total)\% processor time                _total              395.464129650573
\\Computer01\process(idle)\% processor time                  idle                389.356575524695
\\Computer01\process(mssense)\% processor time               mssense             3.05377706293879
\\Computer01\process(csrss#1)\% processor time               csrss               1.52688853146939
\\Computer01\process(microsoftedgecp#10)\% processor time    microsoftedgecp     1.52688853146939
\\Computer01\process(runtimebroker#5)\% processor time       runtimebroker                      0
\\Computer01\process(settingsynchost)\% processor time       settingsynchost                    0
\\Computer01\process(microsoftedgecp#16)\% processor time    microsoftedgecp                    0
```

`Get-Counter` uses the **Counter** parameter to specify the `\Process(*)\% Processor Time` counter
for all the processes on the local computer. The result is stored in the `$Procs` variable. The
`$Procs` variable with the **CounterSamples** property sends the **PerformanceCounterSample**
objects down the pipeline. `Sort-Object` uses the **Property** parameter to sort the objects by
**CookedValue** in **Descending** order. `Format-Table` uses the **Property** parameter to select
the columns for the output. The **AutoSize** parameter adjusts the column widths to minimize
truncation.

## PARAMETERS

### -ComputerName

Specifies one computer name or a comma-separated array of **remote** computer names. Use the NetBIOS
name, an IP address, or the computer's fully qualified domain name.

To get performance counter data from the **local** computer, exclude the **ComputerName** parameter.
For output such as a **ListSet** that contains the **MachineName** column, a dot (`.`) indicates the
local computer.

`Get-Counter` doesn't rely on PowerShell remoting. You can use the **ComputerName** parameter even
if your computer isn't configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Continuous

When the **Continuous** is specified, `Get-Counter` gets samples until you press
<kbd>CTRL</kbd>+<kbd>C</kbd>. Samples are obtained every second for each specified performance
counter. Use the **SampleInterval** parameter to increase the interval between continuous samples.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GetCounterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Counter

Specifies the path to one or more counter paths. Paths are input as a comma-separated array, a
variable, or values from a text file. You can send counter path strings down the pipeline to
`Get-Counter`.

Counter paths use the following syntax:

`\\ComputerName\CounterSet(Instance)\CounterName`

`\CounterSet(Instance)\CounterName`

For example:

`\\Server01\Processor(*)\% User Time`

`\Processor(*)\% User Time`

The `\\ComputerName` is optional in a performance counter path. If the counter path doesn't include
the computer name, `Get-Counter` uses the local computer.

An asterisk (`*`) in the instance is a wildcard character to get all instances of the counter.

```yaml
Type: System.String[]
Parameter Sets: GetCounterSet
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -ListSet

Lists the performance counter sets on the computers. Use an asterisk (`*`) to specify all counter
sets. Enter one name or a comma-separated string of counter set names. You can send counter set
names down the pipeline.

To get a counter sets formatted counter paths, use the **ListSet** parameter. The **Paths** and
**PathsWithInstances** properties of each counter set contain the individual counter paths formatted
as a string.

You can save the counter path strings in a variable or use the pipeline to send the string to
another `Get-Counter` command.

For example to send each **Processor** counter path to `Get-Counter`:

`Get-Counter -ListSet Processor | Get-Counter`

> [!NOTE]
> In PowerShell 7, `Get-Counter` can't retrieve the **Description** property of the counter set. The
> **Description** is set to `$null`.

```yaml
Type: System.String[]
Parameter Sets: ListSetSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -MaxSamples

Specifies the number of samples to get from each specified performance counter. To get a constant
stream of samples, use the **Continuous** parameter.

If the **MaxSamples** parameter isn't specified, `Get-Counter` only gets one sample for each
specified counter.

To collect a large data set, run `Get-Counter` as a PowerShell background job. For more information,
see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md).

```yaml
Type: System.Int64
Parameter Sets: GetCounterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SampleInterval

Specifies the number of seconds between samples for each specified performance counter. If the
**SampleInterval** parameter isn't specified, `Get-Counter` uses a one-second interval.

```yaml
Type: System.Int32
Parameter Sets: GetCounterSet
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

`Get-Counter` accepts pipeline input for counter paths and counter set names.

## OUTPUTS

### Microsoft.PowerShell.Commands.GetCounter.CounterSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet, Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample

To view an object's properties, send the output down the pipeline to `Get-Member`. The object types
that are output are as follows:

**ListSet** parameter: **Microsoft.PowerShell.Commands.GetCounter.CounterSet**

**Counter** parameter: **Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet**

**CounterSamples** property: **Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample**

## NOTES

If no parameters are specified, `Get-Counter` gets one sample for each specified performance
counter. Use the **MaxSamples** and **Continuous** parameters to get more samples.

`Get-Counter` uses a one-second interval between samples. Use the **SampleInterval** parameter to
increase the interval.

The **MaxSamples** and **SampleInterval** values apply to all the counters on each computer in the
command. To set different values for different counters, enter separate `Get-Counter` commands.

In PowerShell 7, when using the **ListSet** parameter, `Get-Counter` can't retrieve the
**Description** property of the counter set. The **Description** is set to `$null`.

## RELATED LINKS

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md)

[Format-List](../Microsoft.PowerShell.Utility/Format-List.md)

[Format-Table](../Microsoft.PowerShell.Utility/Format-Table.md)

[Get-Member](../Microsoft.PowerShell.Utility/Get-Member.md)

[Receive-Job](../Microsoft.PowerShell.Core/Receive-Job.md)

[Start-Job](../Microsoft.PowerShell.Core/Start-Job.md)

[Where-Object](..//Microsoft.PowerShell.Core/Where-Object.md)

