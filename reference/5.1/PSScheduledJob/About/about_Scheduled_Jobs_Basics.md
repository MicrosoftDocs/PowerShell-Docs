---
description:  Explains how to create and manage scheduled jobs. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psscheduledjob/about/about_scheduled_jobs_basics?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Scheduled_Jobs_Basics
---

# About Scheduled Jobs Basics

## Short description

Explains how to create and manage scheduled jobs.

## Long description

This document shows how to perform basic tasks of creating and managing
scheduled jobs. For information about more advanced tasks, see [about_Scheduled_Jobs_Advanced](about_Scheduled_Jobs_Advanced.md).

For more information about the cmdlets contained in the **PSScheduledJob**
module, see [PSScheduledJob](xref:PSScheduledJob).

## How to create a scheduled job

To create a scheduled job, use the `Register-ScheduledJob` cmdlet. The cmdlet
requires a name and the commands or script that the job runs. You can either
run the job immediately by adding the **RunNow** parameter, or create a job
trigger and set job options when you create the job, or edit an existing job.

To create a job that runs a script, use the **FilePath** parameter to specify
the path to the script file. To create a job that runs commands, use the
**ScriptBlock** parameter.

The `Register-ScheduledJob` cmdlet creates the **ProcessJob**, which runs a
`Get-Process` command. This scheduled job has the default job options and no
job trigger.

```powershell
Register-ScheduledJob -Name ProcessJob -ScriptBlock { Get-Process }
```

```Output
Id         Name            Triggers        Command       Enabled
--         ----            --------        -------       -------
8          ProcessJob      {}              Get-Process   True
```

## How to create a job trigger

Job triggers start a scheduled job automatically. A job trigger can be one-time
or recurring schedule or an event, such as when a user logs on or Windows
starts. Each job can have zero, one, or multiple job triggers.

To create a job trigger, use the `New-JobTrigger` cmdlet. The following command
creates a job trigger that starts a job every Monday and Thursday at 5:00 AM.
The command saves the job trigger in the `$T` variable.

```powershell
$T = New-JobTrigger -Weekly -DaysOfWeek "Monday", "Thursday" -At "5:00 AM"
```

Job triggers are optional. You can start a scheduled job at any time by adding
the **RunNow** parameter to your `Register-ScheduledJob` command, or by using
the `Start-Job` cmdlets.

## How to add a job trigger

When you add a job trigger to a scheduled job, the job trigger is added to the
scheduled job XML file for the scheduled job and becomes part of the scheduled
job.

You can add a job trigger to a scheduled job when you create the scheduled job,
or edit an existing job. You can change the job trigger of a scheduled job at
any time.

PowerShell uses some of the same job triggers that Task Scheduler uses. For
detailed information about job triggers, see the help topic for the [New-JobTrigger](xref:PSScheduledJob.New-JobTrigger)
cmdlet.

The following example uses splatting to create `$JobParms` which are parameter
values that are passed to the `Register-ScheduledJob` cmdlet. For more
information, see [about_Splatting.md](../../Microsoft.PowerShell.Core/About/about_Splatting.md).
The `Register-ScheduledJob` uses `@JobParms` to create a scheduled job. It uses
the **Trigger** parameter to specify the job trigger in the `$T` variable.

```powershell
$JobParms = @{
  Name = "ProcessJob"
  ScriptBlock = {Get-Command}
  Trigger = $T
}

Register-ScheduledJob @JobParms
```

You can also add a job trigger to an existing scheduled job at any time. The
`Add-JobTrigger` cmdlet adds the job trigger in the `$T` variable to the
**ProcessJob** scheduled job.

```powershell
Add-JobTrigger -Name ProcessJob -Trigger $T
```

As a result, the job trigger starts the **ProcessJob** automatically every
Monday and Thursday at 5:00 AM.

## How to get a job trigger

To get the job trigger of a scheduled job, use the `Get-JobTrigger` cmdlet. Use
the **Name**, **ID**, and **InputObject** parameters to specify the scheduled
job, not the job trigger.

`Get-JobTrigger` gets the job trigger of the **ProcessJob**.

```powershell
Get-JobTrigger -Name ProcessJob
```

```Output
Id   Frequency       Time                   DaysOfWeek              Enabled
--   ---------       ----                   ----------              -------
1    Weekly          11/7/2011 5:00:00 AM   {Monday, Thursday}      True
```

## How to create job options

Job options establish conditions for starting and running the job. Every job
has the default job options unless you change them. Because job options can
prevent a job from running at the scheduled time, it is important to understand
the job options and use them carefully.

PowerShell uses the same job options that Task Scheduler uses. For detailed
information about the job options, see the help topic for [New-ScheduledJobOption](xref:PSScheduledJob.New-ScheduledJobOption).

Job options are stored in the scheduled job XML file. You can set job options
when you create a scheduled job or change them at any time.

The `New-ScheduledJobOption` cmdlet creates a scheduled job option in which the
**WakeToRun** scheduled job option is set to True. The **WakeToRun** option
runs the scheduled job even if the computer is in the Sleep or Hibernate state
at the scheduled start time. The command saves the job options in the `$O`
variable.

```powershell
$O = New-ScheduledJobOption -WakeToRun
```

## How to get job options

To get the job options of a scheduled job, use the `Get-ScheduledJobOption`
cmdlet. Use the **Name**, **ID**, and **InputObject** parameters to specify the
scheduled job, not the job options.

`Get-ScheduledJobOption` gets the job options of the **ProcessJob**.

```powershell
Get-ScheduledJobOption -Name ProcessJob
```

```Output
StartIfOnBatteries     : False
StopIfGoingOnBatteries : True
WakeToRun              : False
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

## How to change job options

You can change the job options of a scheduled job when you create a scheduled
job or edit an existing job.

The splatted `$JobParms` are passed to the `Add-JobTrigger` cmdlet to create
the process job. It uses the **ScheduledJobOption** parameter to specify the
job options in the `$O` variable.

```powershell
$JobParms = @{
  Name = "ProcessJob"
  ScriptBlock = {Get-Process}
  ScheduledJobOption = $O
}

Add-JobTrigger @JobParms
```

You can also change the job options to an existing scheduled job at any time.
The following command uses the `Set-ScheduledJobOption` cmdlet to change the
value of the **WakeToRun** option of the **ProcessJob** scheduledJob to
**True**.

The `Set` cmdlets in the **PSScheduledJob** module, such as the
`Set-ScheduledJobOption` cmdlet, don't have **Name** or **ID** parameters. You
can use the **InputObject** parameter to specify the scheduled job options or
pipe a scheduled job from `Get-ScheduledJobOption` cmdlet to
`Set-ScheduledJobOption`.

This example uses the `Get-ScheduledJob` cmdlet to get the ProcessJob. It uses
the `Get-ScheduledJobOption` cmdlet to get the job options in the
**ProcessJob** and the `Set-ScheduledJobOption` cmdlet to change the
**WakeToRun** job option in the ProcessJob to True.

```powershell
Get-ScheduledJob -Name ProcessJob | Get-ScheduledJobOption |
 Set-ScheduledJobOption -WakeToRun
```

## How to get scheduled job instances

When a scheduled job is started, PowerShell creates a job instance that is
similar to a standard PowerShell background job. You can use the job cmdlets,
such as `Get-Job`, `Stop-Job` and `Receive-Job` to manage the job instances.

> [!NOTE]
> To use the job cmdlets on instances of scheduled jobs, the **PSScheduledJob**
> module must be imported into the session. To import the **PSScheduledJob**
> module, type `Import-Module PSScheduledJob` or use any scheduled job cmdlet,
> such as `Get-ScheduledJob`.

To get all instances of PowerShell scheduled jobs, and all active standard
jobs, use the `Get-Job` cmdlet. The `Import-Module` cmdlet imports the
**PSScheduledJob** module and `Get-Job` gets the jobs on the local computer.

```powershell
Import-Module PSScheduledJob
Get-Job
```

`Get-Job` gets instances of **ProcessJob** on the local computer.

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

The default display does not show the start time, which typically distinguishes
instances of the same scheduled job.

The `Get-Job` cmdlet sends objects down the pipeline. The `Format-Table` cmdlet
displays the **Name**, **ID**, and **BeginTime** properties of the scheduled
job.

```powershell
Get-Job ProcessJob | Format-Table -Property Name, ID, BeginTime
```

```Output
Name       Id BeginTime
----       -- ---------
ProcessJob 43 11/2/2011 3:00:02 AM
ProcessJob 44 11/3/2011 3:00:02 AM
ProcessJob 45 11/4/2011 3:00:02 AM
ProcessJob 46 11/5/2011 3:00:02 AM
ProcessJob 47 11/6/2011 3:00:02 AM
ProcessJob 48 11/7/2011 12:00:01 AM
ProcessJob 49 11/7/2011 3:00:02 AM
ProcessJob 50 11/8/2011 3:00:02 AM
```

## Get scheduled job results

To get the results of an instance of a scheduled job, use the `Receive-Job`
cmdlet.

> [!NOTE]
> To use the Job cmdlets on instances of scheduled jobs, the **PSScheduledJob**
> module must be imported into the session. To import the **PSScheduledJob**
> module, type `Import-Module PSScheduledJob` or use any scheduled job cmdlet,
> such as `Get-ScheduledJob`.

This examples gets the results of the newest instance of the
**ProcessJob** scheduled job (ID = 51).

```powershell
Import-Module PSScheduledJob
Receive-Job -ID 51 -Keep
```

The results of scheduled jobs are saved on disk, so the **Keep** parameter of
`Receive-Job` is not required. However, without the **Keep** parameter, you can
get the results of a scheduled job only once in each PowerShell session. To
start a new PowerShell session, type `PowerShell` or open a new PowerShell
window.

## See also

[about_Scheduled_Jobs_Advanced](about_Scheduled_Jobs_Advanced.md)

[about_Scheduled_Jobs_Troubleshooting](about_Scheduled_Jobs_Troubleshooting.md)

[about_Scheduled_Jobs](about_Scheduled_Jobs.md)

[about_Splatting.md](../../Microsoft.PowerShell.Core/About/about_Splatting.md)

[PSScheduledJob](xref:PSScheduledJob) module cmdlets

[Task Scheduler](/windows/desktop/TaskSchd/task-scheduler-reference)
