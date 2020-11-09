---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-job?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Job
---
# Get-Job

## SYNOPSIS
Gets PowerShell background jobs that are running in the current session.

## SYNTAX

### SessionIdParameterSet (Default)

```
Get-Job [-IncludeChildJob] [-ChildJobState <JobState>] [-HasMoreData <Boolean>] [-Before <DateTime>]
 [-After <DateTime>] [-Newest <Int32>] [[-Id] <Int32[]>] [<CommonParameters>]
```

### InstanceIdParameterSet

```
Get-Job [-IncludeChildJob] [-ChildJobState <JobState>] [-HasMoreData <Boolean>] [-Before <DateTime>]
 [-After <DateTime>] [-Newest <Int32>] [-InstanceId] <Guid[]> [<CommonParameters>]
```

### NameParameterSet

```
Get-Job [-IncludeChildJob] [-ChildJobState <JobState>] [-HasMoreData <Boolean>] [-Before <DateTime>]
 [-After <DateTime>] [-Newest <Int32>] [-Name] <String[]> [<CommonParameters>]
```

### StateParameterSet

```
Get-Job [-IncludeChildJob] [-ChildJobState <JobState>] [-HasMoreData <Boolean>] [-Before <DateTime>]
 [-After <DateTime>] [-Newest <Int32>] [-State] <JobState> [<CommonParameters>]
```

### CommandParameterSet

```
Get-Job [-IncludeChildJob] [-ChildJobState <JobState>] [-HasMoreData <Boolean>] [-Before <DateTime>]
 [-After <DateTime>] [-Newest <Int32>] [-Command <String[]>] [<CommonParameters>]
```

### FilterParameterSet

```
Get-Job [-Filter] <Hashtable> [<CommonParameters>]
```

## DESCRIPTION

The `Get-Job` cmdlet gets objects that represent the background jobs that were started in the
current session. You can use `Get-Job` to get jobs that were started by using the `Start-Job`
cmdlet, or by using the **AsJob** parameter of any cmdlet.

Without parameters, a `Get-Job` command gets all jobs in the current session. You can use the
parameters of `Get-Job` to get particular jobs.

The job object that `Get-Job` returns contains useful information about the job, but it does not
contain the job results. To get the results, use the `Receive-Job` cmdlet.

A Windows PowerShell background job is a command that runs in the background without interacting
with the current session. Typically, you use a background job to run a complex command that takes a
long time to finish. For more information about background jobs in Windows PowerShell, see
[about_Jobs](./about/about_Jobs.md).

Beginning in Windows PowerShell 3.0, the `Get-Job` cmdlet also gets custom job types, such as
workflow jobs and instances of scheduled jobs. To find the job type of a job, use the
**PSJobTypeName** property of the job.

To enable `Get-Job` to get a custom job type, import the module that supports the custom job type
into the session before you run a `Get-Job` command, either by using the `Import-Module` cmdlet or
by using or getting a cmdlet in the module. For information about a particular custom job type, see
the documentation of the custom job type feature.

## EXAMPLES

### Example 1: Get all background jobs started in the current session

This command gets all background jobs started in the current session. It does not include jobs
created in other sessions, even if the jobs run on the local computer.

```
PS C:\> Get-Job
```

### Example 2: Stop a job by using an instance ID

These commands show how to get the instance ID of a job and then use it to stop a job. Unlike the
name of a job, which is not unique, the instance ID is unique.

The first command uses the `Get-Job` cmdlet to get a job. It uses the **Name** parameter to identify
the job. The command stores the job object that `Get-Job` returns in the `$j` variable. In this
example, there is only one job with the specified name. The second command gets the **InstanceId**
property of the object in the `$j` variable and stores it in the `$ID` variable. The third command
displays the value of the `$ID` variable. The fourth command uses `Stop-Job` cmdlet to stop the job.
It uses the **InstanceId** parameter to identify the job and `$ID` variable to represent the
instance ID of the job.

```
PS C:\> $j = Get-Job -Name Job1
PS C:\> $ID = $j.InstanceID
PS C:\> $ID

Guid
----
03c3232e-1d23-453b-a6f4-ed73c9e29d55

PS C:\> Stop-Job -InstanceId $ID
```

### Example 3: Get jobs that include a specific command

This command gets the jobs on the system that include a `Get-Process` command. The command uses the
**Command** parameter of `Get-Job` to limit the jobs retrieved. The command uses wildcard characters
(`*`) to get jobs that include a `Get-Process` command anywhere in the command string.

```
PS C:\> Get-Job -Command "*get-process*"
```

### Example 4: Get jobs that include a specific command by using the pipeline

Like the command in the previous example, this command gets the jobs on the system that include a
`Get-Process` command. The command uses a pipeline operator (`|`) to send a string, in quotation
marks, to the `Get-Job` cmdlet. It is the equivalent of the previous command.

```
PS C:\> "*get-process*" | Get-Job
```

### Example 5: Get jobs that have not been started

This command gets only those jobs that have been created but have not yet been started. This
includes jobs that are scheduled to run in the future and those not yet scheduled.

```
PS C:\> Get-Job -State NotStarted
```

### Example 6: Get jobs that have not been assigned a name

This command gets all jobs that have job names that begin with job. Because `job<number>` is the
default name for a job, this command gets all jobs that do not have an explicitly assigned name.

```
PS C:\> Get-Job -Name Job*
```

### Example 7: Use a job object to represent the job in a command

This example shows how to use `Get-Job` to get a job object, and then it shows how to use the job
object to represent the job in a command.

The first command uses the `Start-Job` cmdlet to start a background job that runs a `Get-Process`
command on the local computer. The command uses the **Name** parameter of `Start-Job` to assign a
friendly name to the job. The second command uses `Get-Job` to get the job. It uses the **Name**
parameter of `Get-Job` to identify the job. The command saves the resulting job object in the `$j`
variable. The third command displays the value of the job object in the `$j` variable. The value of
the **State** property shows that the job is completed. The value of the **HasMoreData** property
shows that there are results available from the job that have not yet been retrieved. The fourth
command uses the `Receive-Job` cmdlet to get the results of the job. It uses the job object in the
`$j` variable to represent the job. You can also use a pipeline operator to send a job object to
`Receive-Job`.

```
PS C:\> Start-Job -ScriptBlock {Get-Process} -Name MyJob
PS C:\> $j = Get-Job -Name MyJob
PS C:\> $j
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
6      MyJob           BackgroundJob   Completed     True            localhost            Get-Process

PS C:\> Receive-Job -Job $j
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    124       4    13572      12080    59            1140 audiodg
    783      16    11428      13636   100             548 CcmExec
     96       4     4252       3764    59            3856 ccmsetup
...
```


### Example 8: Get all jobs including jobs started by a different method

This example demonstrates that the `Get-Job` cmdlet can get all of the jobs that were started in the
current session, even if they were started by using different methods.

The first command uses the `Start-Job` cmdlet to start a job on the local computer. The second
command uses the **AsJob** parameter of the `Invoke-Command` cmdlet to start a job on the S1
computer. Even though the commands in the job run on the remote computer, the job object is created
on the local computer, so you use local commands to manage the job. The third command uses the
`Invoke-Command` cmdlet to run a `Start-Job` command on the S2 computer. By using this method, the
job object is created on the remote computer, so you use remote commands to manage the job. The
fourth command uses `Get-Job` to get the jobs stored on the local computer. The **PSJobTypeName**
property of jobs, introduced in Windows PowerShell 3.0, shows that the local job started by using
the `Start-Job` cmdlet is a background job and the job started in a remote session by using the
`Invoke-Command` cmdlet is a remote job. The fifth command uses `Invoke-Command` to run a `Get-Job`
command on the S2 computer.The sample output shows the results of the `Get-Job` command. On the S2
computer, the job appears to be a local job. The computer name is localhost and the job type is a
background job.For more information about how to run background jobs on remote computers, see
[about_Remote_Jobs](./about/about_Remote_Jobs.md).

```
PS C:\> Start-Job -ScriptBlock {Get-EventLog System}
PS C:\> Invoke-Command -ComputerName S1 -ScriptBlock {Get-EventLog System} -AsJob
PS C:\> Invoke-Command -ComputerName S2 -ScriptBlock {Start-Job -ScriptBlock {Get-EventLog System}}
PS C:\> Get-Job
Id     Name       PSJobTypeName   State         HasMoreData     Location        Command
--     ----       -------------   -----         -----------     --------        -------
1      Job1       BackgroundJob   Running       True            localhost       Get-EventLog System
2      Job2       RemoteJob       Running       True            S1              Get-EventLog System

PS C:\> Invoke-Command -ComputerName S2 -ScriptBlock {Start-Job -ScriptBlock {Get-EventLog System}}
Id    Name     PSJobTypeName  State      HasMoreData   Location   Command
--    ----     -------------  -----      -----------   -------    -------
4     Job4     BackgroundJob  Running    True          localhost  Get-Eventlog System
```

### Example 9: Investigate a failed job

This command shows how to use the job object that `Get-Job` returns to investigate why a job failed.
It also shows how to get the child jobs of each job.

The first command uses the `Start-Job` cmdlet to start a job on the local computer. The job object
that `Start-Job` returns shows that the job failed. The value of the **State** property is Failed.

The second command uses the `Get-Job` cmdlet to get the job. The command uses the dot method to get
the value of the **JobStateInfo** property of the object. It uses a pipeline operator to send the
object in the **JobStateInfo** property to the `Format-List` cmdlet, which formats all of the
properties of the object (`*`) in a list.The result of the `Format-List` command shows that the
value of the **Reason** property of the job is blank.

The third command investigates more. It uses a `Get-Job` command to get the job and then uses a
pipeline operator to send the whole job object to the `Format-List` cmdlet, which displays all of
the properties of the job in a list.The display of all properties in the job object shows that the
job contains a child job named Job2.

The fourth command uses `Get-Job` to get the job object that represents the Job2 child job. This is
the job in which the command actually ran. It uses the dot method to get the **Reason** property of
the **JobStateInfo** property.The result shows that the job failed because of an Access Denied
error. In this case, the user forgot to use the Run as administrator option when starting Windows
PowerShell.Because background jobs use the remoting features of Windows PowerShell, the computer
must be configured for remoting to run a job, even when the job runs on the local computer.For
information about requirements for remoting in Windows PowerShell, see
[about_Remote_Requirements](./about/about_Remote_Requirements.md). For troubleshooting tips, see
[about_Remote_Troubleshooting](./about/about_Remote_Troubleshooting.md).

```
PS C:\> Start-Job -ScriptBlock {Get-Process}
Id     Name       PSJobTypeName   State       HasMoreData     Location             Command
--     ----       -------------   -----       -----------     --------             -------
1      Job1       BackgroundJob   Failed      False           localhost            Get-Process

PS C:\> (Get-Job).JobStateInfo | Format-List -Property *
State  : Failed
Reason :

PS C:\> Get-Job | Format-List -Property *
HasMoreData   : False
StatusMessage :
Location      : localhost
Command       : get-process
JobStateInfo  : Failed
Finished      : System.Threading.ManualReset
EventInstanceId    : fb792295-1318-4f5d-8ac8-8a89c5261507
Id            : 1
Name          : Job1
ChildJobs     : {Job2}
Output        : {}
Error         : {}
Progress      : {}
Verbose       : {}
Debug         : {}
Warning       : {}
StateChanged  :

PS C:\> (Get-Job -Name job2).JobStateInfo.Reason
Connecting to remote server using WSManCreateShellEx api failed. The async callback gave the
following error message: Access is denied.
```

### Example 10: Get filtered results

This example shows how to use the **Filter** parameter to get a workflow job. The **Filter**
parameter, introduced in Windows PowerShell 3.0 is valid only on custom job types, such as workflow
jobs and scheduled jobs.

The first command uses the **Workflow** keyword to create the WFProcess workflow. The second command
uses the **AsJob** parameter of the WFProcess workflow to run the workflow as a background job. It
uses the **JobName** parameter of the workflow to specify a name for the job, and the
**PSPrivateMetadata** parameter of the workflow to specify a custom ID. The third command uses the
**Filter** parameter of `Get-Job` to get the job by custom ID that was specified in the
**PSPrivateMetadata** parameter.

```
PS C:\> Workflow WFProcess {Get-Process}
PS C:\> WFProcess -AsJob -JobName WFProcessJob -PSPrivateMetadata @{MyCustomId = 92107}
PS C:\> Get-Job -Filter @{MyCustomId = 92107}
Id     Name            State         HasMoreData     Location             Command
--     ----            -----         -----------     --------             -------
1      WFProcessJob    Completed     True            localhost            WFProcess
```

### Example 11: Get information about child jobs

This example shows the effect of using the **IncludeChildJob** and **ChildJobState** parameters of
the `Get-Job` cmdlet.

The first command gets the jobs in the current session. The output includes a background job, a
remote job and several instances of a scheduled job. The remote job, Job4, appears to have failed.
The second command uses the **IncludeChildJob** parameter of `Get-Job`. The output adds the child
jobs of all jobs that have child jobs.In this case, the revised output shows that only the Job5
child job of Job4 failed. The third command uses the **ChildJobState** parameter with a value of
Failed.The output includes all parent jobs and only the child jobs that failed. The fifth command
uses the **JobStateInfo** property of jobs and its **Reason** property to discover why Job5 failed.

```
PS C:\> Get-Job
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
2      Job2            BackgroundJob   Completed     True            localhost            .\Get-Archive.ps1
4      Job4            RemoteJob       Failed        True            Server01, Server02   .\Get-Archive.ps1
7      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
8      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
9      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
10     UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help

PS C:\> Get-Job -IncludeChildJob
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
2      Job2            BackgroundJob   Completed     True            localhost           .\Get-Archive.ps1
3      Job3                            Completed     True            localhost           .\Get-Archive.ps1
4      Job4            RemoteJob       Failed        True            Server01, Server02  .\Get-Archive.ps1
5      Job5                            Failed        False           Server01            .\Get-Archive.ps1
6      Job6                            Completed     True            Server02            .\Get-Archive.ps1
7      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
8      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
9      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
10     UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help

PS C:\> Get-Job -Name Job4 -ChildJobState Failed
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
2      Job2            BackgroundJob   Completed     True            localhost           .\Get-Archive.ps1
4      Job4            RemoteJob       Failed        True            Server01, Server02  .\Get-Archive.ps1
5      Job5                            Failed        False           Server01            .\Get-Archive.ps1
7      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
8      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
9      UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help
10     UpdateHelpJob   PSScheduledJob  Completed     True            localhost            Update-Help

PS C:\> (Get-Job -Name Job5).JobStateInfo.Reason
Connecting to remote server Server01 failed with the following error message:
Access is denied.
```

For more information, see the
[about_Remote_Troubleshooting](./about/about_Remote_Troubleshooting.md) Help topic.

## PARAMETERS

### -After

Gets completed jobs that ended after the specified date and time. Enter a **DateTime** object, such
as one returned by the `Get-Date` cmdlet or a string that can be converted to a **DateTime** object,
such as `Dec 1, 2012 2:00 AM` or `11/06`.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs, that have
an **EndTime** property. It does not work on standard background jobs, such as those created by
using the `Start-Job` cmdlet. For information about support for this parameter, see the help topic
for the job type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.DateTime
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before

Gets completed jobs that ended before the specified date and time. Enter a **DateTime** object.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs, that have
an **EndTime** property. It does not work on standard background jobs, such as those created by
using the `Start-Job` cmdlet. For information about support for this parameter, see the help topic
for the job type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.DateTime
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChildJobState

Gets only the child jobs that have the specified state. The acceptable values for this parameter
are:

- NotStarted
- Running
- Completed
- Failed
- Stopped
- Blocked
- Suspended
- Disconnected
- Suspending
- Stopping

By default, `Get-Job` does not get child jobs. By using the **IncludeChildJob** parameter, `Get-Job`
gets all child jobs. If you use the **ChildJobState** parameter, the **IncludeChildJob** parameter
has no effect.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.JobState
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:
Accepted values: NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping, AtBreakpoint

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command

Specifies an array of commands as strings. This cmdlet gets the jobs that include the specified
commands. The default is all jobs. You can use wildcard characters to specify a command pattern.

```yaml
Type: System.String[]
Parameter Sets: CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Filter

Specifies a hash table of conditions. This cmdlet gets jobs that satisfy all of the conditions.
Enter a hash table where the keys are job properties and the values are job property values.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs. It does not
work on standard background jobs, such as those created by using the `Start-Job` cmdlet. For
information about support for this parameter, see the help topic for the job type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: FilterParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HasMoreData

Indicates whether this cmdlet gets only jobs that have the specified **HasMoreData** property value.
The **HasMoreData** property indicates whether all job results have been received in the current
session. To get jobs that have more results, specify a value of `$True`. To get jobs that do not
have more results, specify a value of `$False`.

To get the results of a job, use the `Receive-Job` cmdlet.

When you use the `Receive-Job` cmdlet, it deletes from its in-memory, session-specific storage the
results that it returned. When it has returned all results of the job in the current session, it
sets the value of the **HasMoreData** property of the job to `$False`) to indicate that it has no
more results for the job in the current session. Use the **Keep** parameter of `Receive-Job` to
prevent `Receive-Job` from deleting results and changing the value of the **HasMoreData** property.
For more information, type `Get-Help Receive-Job`.

The **HasMoreData** property is specific to the current session. If results for a custom job type
are saved outside of the session, such as the scheduled job type, which saves job results on disk,
you can use the `Receive-Job` cmdlet in a different session to get the job results again, even if
the value of **HasMoreData** is `$False`. For more information, see the help topics for the custom
job type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Boolean
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies an array of IDs of jobs that this cmdlet gets.

The ID is an integer that uniquely identifies the job in the current session. It is easier to
remember and to type than the instance ID, but it is unique only in the current session. You can
type one or more IDs separated by commas. To find the ID of a job, type `Get-Job` without
parameters.

```yaml
Type: System.Int32[]
Parameter Sets: SessionIdParameterSet
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeChildJob

Indicates that this cmdlet returns child jobs, in addition to parent jobs.

This parameter is especially useful for investigating workflow jobs, for which `Get-Job` returns a
container parent job, and job failures, because the reason for the failure is saved in a property of
the child job.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId

Specifies an array of instance IDs of jobs that this cmdlet gets. The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer. To find the instance ID
of a job, use `Get-Job`.

```yaml
Type: System.Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies an array of instance friendly names of jobs that this cmdlet gets. Enter a job name, or
use wildcard characters to enter a job name pattern. By default, `Get-Job` gets all jobs in the
current session.

```yaml
Type: System.String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Newest

Specifies a number of jobs to get. This cmdlet gets the jobs that ended most recently.

The **Newest** parameter does not sort or return the newest jobs in end-time order. To sort the
output, use the `Sort-Object` cmdlet.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Int32
Parameter Sets: SessionIdParameterSet, InstanceIdParameterSet, NameParameterSet, StateParameterSet, CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State

Specifies a job state. This cmdlet gets only jobs in the specified state. The acceptable values for
this parameter are:

- NotStarted
- Running
- Completed
- Failed
- Stopped
- Blocked
- Suspended
- Disconnected
- Suspending
- Stopping

By default, `Get-Job` gets all the jobs in the current session.

For more information about job states, see
[JobState Enumeration](/dotnet/api/system.management.automation.jobstate).

```yaml
Type: System.Management.Automation.JobState
Parameter Sets: StateParameterSet
Aliases:
Accepted values: NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping, AtBreakpoint

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.RemotingJob

This cmdlet returns objects that represent the jobs in the session.

## NOTES

The **PSJobTypeName** property of jobs indicates the job type of the job. The property value is
determined by the job type author. The following list shows common job types.

- **BackgroundJob**. Local job started by using `Start-Job`.
- **RemoteJob**. Job started in a **PSSession** by using the **AsJob** parameter of the
  `Invoke-Command` cmdlet.
- **PSWorkflowJob**. Job started by using the **AsJob** common parameter of workflows.

## RELATED LINKS

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Wait-Job](Wait-Job.md)

[about_Jobs](About/about_Jobs.md)

[about_Job_Details](About/about_Job_Details.md)

[about_Remote_Jobs](About/about_Remote_Jobs.md)
