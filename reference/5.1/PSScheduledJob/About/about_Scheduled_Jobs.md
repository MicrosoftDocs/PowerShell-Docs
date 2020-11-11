---
description:  Describes scheduled jobs and explains how to use and manage scheduled jobs in PowerShell and in Task Scheduler. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psscheduledjob/about/about_scheduled_jobs?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Scheduled_Jobs
---

# About Scheduled Jobs

## Short description

Describes scheduled jobs and explains how to use and manage scheduled jobs in
PowerShell and in Task Scheduler.

## Long description

PowerShell scheduled jobs are a useful hybrid of PowerShell background jobs and
Task Scheduler tasks.

Like PowerShell background jobs, scheduled jobs run asynchronously in the
background. Instances of scheduled jobs that have run can be managed by using
the job cmdlets, such as `Start-Job`, `Get-Job`, `Stop-Job`, and `Receive-Job`.

Like Task Scheduler tasks, scheduled jobs are saved to disk. You can view and
manage the jobs in Task Scheduler, enable and disable them as needed, run them
or use them as templates, establish a one-time or recurring schedules for
starting the jobs, or set conditions under which the jobs start.

In addition, the results of scheduled job instances are saved to disk in an
easily accessible format, providing a running log of job output. Scheduled jobs
come with a customized set of cmdlets for managing them. The cmdlets let you
create, edit, manage, disable, and re-enable scheduled jobs, job triggers and
job options.

This comprehensive and flexible set of tools make scheduled jobs an essential
component of many professional PowerShell IT solutions.

The scheduled job cmdlets are included in the **PSScheduledJob** module that is
installed with PowerShell. This module was introduced in PowerShell 3.0 and
works in PowerShell 3.0 and later versions of PowerShell. For more information
about the cmdlets contained in the **PSScheduledJob** module, see [PSScheduledJob](xref:PSScheduledJob).

For more information about PowerShell background jobs, see [about_Jobs](../../Microsoft.PowerShell.Core/About/about_Jobs.md).

For more information about Task Scheduler, see [Task Scheduler](/windows/desktop/TaskSchd/task-scheduler-reference).

> [!NOTE]
> You can view and manage PowerShell scheduled jobs in Task Scheduler. The
> PowerShell jobs and scheduled job cmdlets work only on scheduled jobs that
> are created in PowerShell.

## Quick start

This example creates a scheduled job that starts every day at 3:00 AM and runs
the `Get-Process` cmdlet. The job starts even if the computer is running on
batteries.

```powershell
$trigger = New-JobTrigger -Daily -At 3AM
$options = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name ProcessJob -ScriptBlock {Get-Process} `
-Trigger $trigger -ScheduledJobOption $options
```

The `Get-ScheduledJob` cmdlet gets the scheduled jobs on the local computer.

```powershell
Get-ScheduledJob
```

```Output
Id         Name            Triggers        Command            Enabled
--         ----            --------        -------            -------
7          ProcessJob      {1}             Get-Process        True
```

`Get-JobTrigger` gets the job triggers of **ProcessJob**. The input parameters
specify the scheduled job, not the trigger, because triggers are saved in a
scheduled job.

```powershell
Get-JobTrigger -Name ProcessJob
```

```Output
Id         Frequency       Time                   DaysOfWeek        Enabled
--         ---------       ----                   ----------        -------
1          Daily           11/5/2011 3:00:00 AM                     True
```

This example uses the **ContinueIfGoingOnBattery** parameter of the
`Set-ScheduledJob` cmdlet to change the **StopIfGoingOnBatteries** property of
**ProcessJob** to **False**.

```powershell
Get-ScheduledJob -Name ProcessJob | Set-ScheduledJobOption `
-ContinueIfGoingOnBattery -Passthru
```

```Output
StartIfOnBatteries     : True
StopIfGoingOnBatteries : False
WakeToRun              : True
StartIfNotIdle         : True
StopIfGoingOffIdle     : False
RestartOnIdleResume    : False
IdleDuration           : 00:10:00
IdleTimeout            : 01:00:00
ShowInTaskScheduler    : True
RunElevated            : False
RunWithoutNetwork      : True
DoNotAllowDemandStart  : False
MultipleInstancePolicy : IgnoreNew
JobDefinition          : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
```

The `Get-ScheduledJob` cmdlet gets the **ProcessJob** scheduled job.

```powershell
Get-ScheduledJob ProcessJob
```

```Output
Id         Name            Triggers        Command        Enabled
--         ----            --------        -------        -------
7          ProcessJob      {1}             Get-Process    True
```

The `Get-Job` cmdlet gets all instances of the **ProcessJob** scheduled job
that have run thus far. The `Get-Job` cmdlet gets scheduled jobs only when the
**PSScheduledJob** module is imported into the current session.

> [!TIP]
> Notice that you use the scheduled job cmdlets to manage scheduled jobs, but
> you use the job cmdlets to manage instances of scheduled jobs.

```powershell
Get-Job -Name ProcessJob
```

```Output
Id     Name        PSJobTypeName  State    HasMoreData   Location   Command
--     ----        ------------   -----    -----------   --------   -------
45     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
46     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
47     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
48     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
49     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
50     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
51     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
```

The `Receive-Job` cmdlet gets the results of the most recent instance of the
**ProcessJob** scheduled job (ID = 51).

```powershell
Receive-Job -ID 51
```

Even though the `Receive-Job` command did not include the **Keep** parameter,
the results of the job are saved on disk until you delete them or the maximum
number of results are exceeded.

The job results are no longer available in this session, but if you start a new
session or open a new PowerShell window, the results of the job are available
again.

The following command uses the **DefinitionName** parameter of the `Start-Job`
cmdlet to start the **ProcessJob** scheduled job.

Jobs that are started by using the `Start-Job` cmdlet are standard PowerShell
background jobs, not instances of the scheduled job. Like all background jobs,
these jobs start immediately, they aren't subject to job options or affected by
job triggers, and their output is not saved in the output directory of the
scheduled job directory.

```powershell
Start-Job -DefinitionName ProcessJob
```

The `Unregister-ScheduledJob` cmdlet deletes the **ProcessJob** scheduled job
and all saved results of its job instances.

```powershell
Unregister-ScheduledJob ProcessJob
```

## Scheduled jobs concepts

A scheduled job runs commands or a script. A scheduled job can include job
triggers that start the job and job options that set conditions for running the
job.

A job trigger starts a scheduled job automatically. A job trigger can include a
one-time or recurring schedule or specify an event, such as when a user logs on
or Windows starts. A scheduled job can have one or more job triggers, and you
can create, add, enable, disable, and get job triggers.

Job triggers are optional. You can start scheduled jobs immediately by using
the `Start-Job cmdlet`, or by adding the **RunNow** parameter to your
`Register-ScheduledJob` command.

Job options set the conditions for running a scheduled job. Every scheduled job
has one job options object. You can create and edit job options objects and add
them to one or more scheduled jobs.

Each time a scheduled job starts, a job instance is created. Use the PowerShell
job cmdlets to view and manage the job instance.

Scheduled jobs are saved to disk and use the cmdlet verb, `Register`, instead
of `New`. The XML files are located on the local computer in the directory
`$home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs`.

PowerShell creates a directory for each scheduled job and saves the job
commands, job triggers, job options and job results in the scheduled job
directory. Job triggers and job options aren't saved to disk independently.
They are saved in the scheduled job XML of each scheduled job with which they
are associated.

Scheduled jobs, job triggers, and job options appear in PowerShell as objects.
The objects are interlinked, which makes them easy to discover and use in
commands and scripts.

Scheduled jobs appear as **ScheduledJobDefinition** objects. The
**ScheduledJobDefinition** object has a **JobTriggers** property that contains
the job triggers of the scheduled job and an **Options** property that contains
the job options. The **ScheduledJobTriggers** and **ScheduledJobOptions**
objects that represent job triggers and job options, respectively, each have a
**JobDefinition** property that contains the scheduled job with which they are
associated. This recursive interconnection makes it easy to find the triggers
and options of a scheduled job and to find, script, and display the scheduled
job to which any job trigger or job option is associated.

## See also

[about_Scheduled_Jobs_Basics](about_Scheduled_Jobs_Basics.md)

[about_Scheduled_Jobs_Advanced](about_Scheduled_Jobs_Advanced.md)

[about_Scheduled_Jobs_Troubleshooting](about_Scheduled_Jobs_Troubleshooting.md)

[PSScheduledJob](xref:PSScheduledJob) module cmdlets

[Task Scheduler](/windows/desktop/TaskSchd/task-scheduler-reference)
