---
description: Provides details about background jobs on local and remote computers.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/16/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_job_details?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Job_Details
---
# About Job Details

## Short description
Provides details about background jobs on local and remote computers.

## Detailed description

This topic explains the concept of a background job and provides technical
information about how background jobs work in PowerShell.

This topic is a supplement to the [about_Jobs](about_Jobs.md),
[about_Thread_Jobs](about_Thread_Jobs.md), and
[about_Remote_Jobs](about_Remote_Jobs.md) topics.

### About background jobs

A background job runs a command or expression asynchronously. It might run a
cmdlet, a function, a script, or any other command-based task. It is designed
to run commands that take an extended period of time, but you can use it to run
any command in the background.

When a synchronous command runs, the PowerShell command prompt is suppressed
until the command is complete. But a background job does not suppress the
PowerShell prompt. A command to start a background job returns a job object.
The prompt returns immediately so you can work on other tasks while the
background job runs.

However, when you start a background job, you do not get the results
immediately even if the job runs very quickly. The job object that is returned
contains useful information about the job, but it does not contain the job
results. You must run a separate command to get the job results. You can also
run commands to stop the job, to wait for the job to be completed, and to
delete the job.

To make the timing of a background job independent of other commands, each
background job runs in its own PowerShell session. However, this can be a
temporary connection that is created only to run the job and is then destroyed,
or it can be a persistent **PSSession** that you can use to run several related
jobs or commands.

### Using the job cmdlets

Use a `Start-Job` command to start a background job on a local computer.
`Start-Job` returns a job object. You can also get objects representing the
jobs that were started on the local computer using the `Get-Job` cmdlet.

To get the job results, use a `Receive-Job` command. If the job is not
complete, `Receive-Job` returns partial results. You can also use the
`Wait-Job` cmdlet to suppress the command prompt until one or all of the jobs
that were started in the session are complete.

To stop a background job, use the `Stop-Job` cmdlet. To delete a job, use the
`Remove-Job` cmdlet.

For more information about how the cmdlets work, see the Help topic for each
cmdlet, and see [about_Jobs](about_Jobs.md).

### Starting background jobs on remote computers

You can create and manage background jobs on a local or remote computer. To run
a background job remotely, use the **AsJob** parameter of a cmdlet such as
`Invoke-Command`, or use the `Invoke-Command` cmdlet to run a `Start-Job`
command remotely. You can also start a background job in an interactive
session.

For more information about remote background jobs, see
[about_Remote_Jobs](about_Remote_Jobs.md).

### Child jobs

Each background job consists of a parent job and one or more child jobs. In
jobs started using `Start-Job` or the **AsJob** parameter of `Invoke-Command`,
the parent job is an executive. It does not run any commands or return any
results. The commands are actually run by the child jobs. Jobs started using
other cmdlets might work differently.

The child jobs are stored in the **ChildJobs** property of the parent job
object. The **ChildJobs** property can contain one or many child job objects.
The child job objects have a **Name**, **ID**, and **InstanceId** that differ
from the parent job so that you can manage the parent and child jobs
individually or as a unit.

To get the parent and child jobs of a job, use the **IncludeChildJobs**
parameter of the `Get-Job` cmdlet. The **IncludeChildJob** parameter was
introduced in Windows PowerShell 3.0.

```powershell
PS> Get-Job -IncludeChildJob

Id Name   PSJobTypeName State      HasMoreData   Location    Command
-- ----   ------------- -----      -----------   --------    -------
1  Job1   RemoteJob     Failed     True          localhost   Get-Process
2  Job2                 Completed  True          Server01    Get-Process
3  Job3                 Failed     False         localhost   Get-Process
```

To get the parent job and only the child jobs with a particular **State**
value, use the **ChildJobState** parameter of the `Get-Job` cmdlet. The
**ChildJobState** parameter was introduced in Windows PowerShell 3.0.

```powershell
PS> Get-Job -ChildJobState Failed

Id Name   PSJobTypeName State      HasMoreData   Location    Command
-- ----   ------------- -----      -----------   --------    -------
1  Job1   RemoteJob     Failed     True          localhost   Get-Process
3  Job3                 Failed     False         localhost   Get-Process
```

To get the child jobs of a job on all versions of PowerShell,
use the **ChildJob** property of the parent job.

```powershell
PS> (Get-Job Job1).ChildJobs

Id Name   PSJobTypeName State      HasMoreData   Location    Command
-- ----   ------------- -----      -----------   --------    -------
2  Job2                 Completed  True          Server01    Get-Process
3  Job3                 Failed     False         localhost   Get-Process
```

You can also use a `Get-Job` command on the child job, as shown in the
following command:

```powershell
PS> Get-Job Job3

Id Name   PSJobTypeName State      HasMoreData   Location    Command
-- ----   ------------- -----      -----------   --------    -------
3  Job3                 Failed     False         localhost   Get-Process
```

The configuration of the child job depends on the command that you use to
start the job.

- When you use `Start-Job` to start a job on a local computer, the job consists
  of an executive parent job and a child job that runs the command.

- When you use the **AsJob** parameter of `Invoke-Command` to start a job on one or
  more computers, the job consists of an executive parent job and a child job
  for each job run on each computer.

- When you use `Invoke-Command` to run a `Start-Job` command on one or more remote
  computers, the result is the same as a local command run on each remote
  computer. The command returns a job object for each computer. The job object
  consists of an executive parent job and one child job that runs the command.

The parent job represents all of the child jobs. When you manage a parent job,
you also manage the associated child jobs. For example, if you stop a parent
job, all child jobs are stopped. If you get the results of a parent job, you
get the results of all child jobs.

However, you can also manage child jobs individually. This is most useful when
you want to investigate a problem with a job or get the results of only one of
a number of child jobs started using the **AsJob** parameter of
`Invoke-Command`.

The following command uses the **AsJob** parameter of `Invoke-Command` to start
background jobs on the local computer and two remote computers. The command
saves the job in the `$j` variable.

```powershell
PS> $j = Invoke-Command -ComputerName localhost, Server01, Server02 `
-Command {Get-Date} -AsJob
```

When you display the Name and **ChildJob** properties of the job in `$j`, it
shows that the command returned a job object with three child jobs, one for
each computer.

```powershell
PS> $j | Format-List Name, ChildJobs

Name      : Job3
ChildJobs : {Job4, Job5, Job6}
```

When you display the parent job, it shows that the job failed.

```powershell
PS> $j

Id Name   PSJobTypeName State      HasMoreData   Location
-- ----   ------------- -----      -----------   --------
3  Job3   RemotingJob   Failed     False         localhost,Server...
```

But when you run a `Get-Job` command that gets the child jobs, the output
shows that only one child job failed.

```powershell
PS> Get-Job -IncludeChildJobs

Id  Name   PSJobTypeName State      HasMoreData   Location    Command
--  ----   ------------- -----      -----------   --------    -------
3   Job3   RemotingJob   Failed     False         localhost,Server...
4   Job4                 Completed  True          localhost   Get-Date
5   Job5                 Failed     False         Server01    Get-Date
6   Job6                 Completed  True          Server02    Get-Date
```

To get the results of all child jobs, use the `Receive-Job` cmdlet to get
the results of the parent job. But you can also get the results of a
particular child job, as shown in the following command.

```powershell
PS> Receive-Job -Name Job6 -Keep | Format-Table ComputerName,
>> DateTime -AutoSize
ComputerName DateTime
------------ --------
Server02     Thursday, March 13, 2008 4:16:03 PM
```

The child jobs feature of PowerShell background jobs gives you
more control over the jobs that you run.

### Job types

PowerShell supports different types of jobs for different tasks. Beginning in
Windows PowerShell 3.0, developers can write "job source adapters" that add
new job types to PowerShell and include the job source adapters in modules.
When you import the module, you can use the new job type in your session.

For example, the PSScheduledJob module adds scheduled jobs and the PSWorkflow
module adds workflow jobs.

Custom jobs types might differ significantly from standard PowerShell
background jobs. For example, scheduled jobs are saved on disk; they do not
exist only in a particular session. Workflow jobs can be suspended and
resumed.

The cmdlets that you use to manage custom jobs depend on the job type. For
some, you use the standard job cmdlets, such as `Get-Job` and `Start-Job`. Others
come with specialized cmdlets that manage only a particular type of job. For
detailed information about custom job types, see the help topics about the job
type.

To find the job type of a job, use the `Get-Job` cmdlet. `Get-Job` returns
different job objects for different types of jobs. The value of the
**PSJobTypeName** property of the job objects that `Get-Job` returns indicates
the job type.

The following table lists the job types that come with PowerShell.

|    Job Type    |                       Description                        |
| -------------- | -------------------------------------------------------- |
| BackgroundJob  | Started using the `Start-Job` cmdlet.                    |
| RemoteJob      | Started using the **AsJob** parameter of the             |
|                | `Invoke-Command` cmdlet.                                 |
| PSWorkflowJob  | Started using the **AsJob** parameter of a workflow.     |
| PSScheduledJob | An instance of a scheduled job started by a job trigger. |
| CIMJob         | Started using the **AsJob** parameter of a cmdlet from a |
|                | CDXML module.                                            |
| WMIJob         | Started using the **AsJob** parameter of a cmdlet from a |
|                | WMI module.                                              |
| PSEventJob     | Created using`Register-ObjectEvent` and specifying an    |
|                | action with the **Action** parameter.                    |

NOTE: Before using the `Get-Job` cmdlet to get jobs of a particular type, verify
that the module that adds the job type is imported into the current session.
Otherwise, `Get-Job` does not get jobs of that type.

## Examples

The following commands create a local background job, a remote background job,
a workflow job, and a scheduled job. Then, it uses the `Get-Job` cmdlet to get
the jobs. `Get-Job` does not get the scheduled job, but it gets any started
instances of the scheduled job.

Start a background job on the local computer.

```powershell
PS> Start-Job -Name LocalData {Get-Process}

Id Name        PSJobTypeName   State   HasMoreData   Location   Command
-- ----        -------------   -----   -----------   --------   -------
2  LocalData   BackgroundJob   Running        True   localhost  Get-Process
```

Start a background job that runs on a remote computer.

```powershell
PS> Invoke-Command -ComputerName Server01 {Get-Process} `
-AsJob -JobName RemoteData

Id  Name        PSJobTypeName  State   HasMoreData   Location   Command
--  ----        -------------  -----   -----------   --------   -------
2   RemoteData  RemoteJob      Running        True   Server01   Get-Process
```

Create a scheduled job

```powershell
PS>  Register-ScheduledJob -Name ScheduledJob -ScriptBlock `
 {Get-Process} -Trigger (New-JobTrigger -Once -At "3 PM")

Id         Name            JobTriggers     Command       Enabled
--         ----            -----------     -------       -------
1          ScheduledJob    1               Get-Process   True
```

Create a workflow.

```powershell
PS> workflow Test-Workflow {Get-Process}
```

Run the workflow as a job.

```powershell

PS> Test-Workflow -AsJob -JobName TestWFJob

Id  Name       PSJobTypeName   State   HasMoreData   Location   Command
--  ----       -------------   -----   -----------   --------   -------
2   TestWFJob  PSWorkflowJob   NotStarted     True   localhost  Get-Process
```

Get the jobs. The `Get-Job` command does not get scheduled jobs, but it gets
instances of the scheduled job that are started.

```powershell
PS> Get-Job

Id  Name         PSJobTypeName  State     HasMoreData  Location  Command
--  ----         -------------  -----     -----------  --------  -------
2   LocalData    BackgroundJob  Completed True         localhost Get-Process
4   RemoteData   RemoteJob      Completed True         Server01  Get-Process
6   TestWFJob    PSWorkflowJob  Completed True         localhost WorkflowJob
8   ScheduledJob PSScheduledJob Completed True         localhost Get-Process
```

To get scheduled jobs, use the `Get-ScheduledJob` cmdlet.

```powershell
PS> Get-ScheduledJob

Id         Name            JobTriggers     Command       Enabled
--         ----            -----------     -------       -------
1          ScheduledJob    1               Get-Process   True
```

## See also

- [about_Jobs](about_Jobs.md)
- [about_Remote_Jobs](about_Remote_Jobs.md)
- [about_Thread_Jobs](about_Thread_Jobs.md)
- [about_Remote](about_Remote.md)
- [Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
- [Start-Job](xref:Microsoft.PowerShell.Core.Start-Job)
- [Get-Job](xref:Microsoft.PowerShell.Core.Get-Job)
- [Wait-Job](xref:Microsoft.PowerShell.Core.Wait-Job)
- [Stop-Job](xref:Microsoft.PowerShell.Core.Stop-Job)
- [Remove-Job](xref:Microsoft.PowerShell.Core.Remove-Job)
- [New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)
- [Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)
- [Exit-PSSession](xref:Microsoft.PowerShell.Core.Exit-PSSession)
