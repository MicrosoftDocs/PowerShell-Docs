---
description:  Explains how to resolve problems with scheduled jobs 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psscheduledjob/about/about_scheduled_jobs_troubleshooting?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Scheduled_Jobs_Troubleshooting
---

# About Scheduled Jobs Troubleshooting

## Short description

Explains how to resolve problems with scheduled jobs

## Long description

This document describes some of the problems that you might experience when
using the scheduled job features of PowerShell and it suggests solutions to
these problems.

Before using PowerShell scheduled jobs, see [about_Scheduled_Jobs](about_Scheduled_Jobs.md)
and the related scheduled jobs about topics.

For more information about the cmdlets contained in the **PSScheduledJob**
module, see [PSScheduledJob](xref:PSScheduledJob).

## Can't find job results

### Basic method for getting job results in PowerShell

When a scheduled job runs, it creates an instance of the scheduled job. To
view, manage, and get the results of scheduled job instances, use the Job
cmdlets.

> [!NOTE]
> To use the Job cmdlets on instances of scheduled jobs, the **PSScheduledJob**
> module must be imported into the session. To import the **PSScheduledJob**
> module, type `Import-Module PSScheduledJob` or use any scheduled job cmdlet,
> such as `Get-ScheduledJob`.

To get a list of all instances of a scheduled job, use the `Get-Job` cmdlet.

```powershell
Import-Module PSScheduledJob
Get-Job ProcessJob
```

```Output
Id     Name         PSJobTypeName   State         HasMoreData     Location
--     ----         -------------   -----         -----------     --------
43     ProcessJob   PSScheduledJob  Completed     False           localhost
44     ProcessJob   PSScheduledJob  Completed     False           localhost
45     ProcessJob   PSScheduledJob  Completed     False           localhost
46     ProcessJob   PSScheduledJob  Completed     False           localhost
47     ProcessJob   PSScheduledJob  Completed     False           localhost
48     ProcessJob   PSScheduledJob  Completed     False           localhost
49     ProcessJob   PSScheduledJob  Completed     False           localhost
50     ProcessJob   PSScheduledJob  Completed     False           localhost
```

The `Get-Job` cmdlet sends **ProcessJob** objects down the pipeline. The
`Format-Table` cmdlet displays the **Name**, **ID**, and **PSBeginTime**
properties of a scheduled job instance in a table.

```powershell
Get-Job ProcessJob | Format-Table -Property Name, ID, PSBeginTime -Auto
```

```Output
Name       Id PSBeginTime
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

To get the results of an instance of a scheduled job, use the `Receive-Job`
cmdlet. The following command gets the results of the newest instance of the
ProcessJob (ID = 50).

```powershell
Receive-Job -ID 50
```

### Basic method for finding job results on disk

To manage scheduled jobs, use the job cmdlets, such as `Get-Job` and
`Receive-Job`.

If `Get-Job` does not get the job instance or `Receive-Job` does not get the
job results, you can search the execution history files for the job on disk.
The execution history contains a record of all triggered job instances.

Verify that there is a timestamp-named directory in the directory for a
scheduled job in the following path:

`$home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJob\<ScheduledJobName>\Output`

For example:

`C:\Users<UserName>\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJob\<ScheduledJobName>\Output`

For example, the `Get-ChildItem` cmdlet gets the on-disk execution history of
the **ProcessJob** scheduled job.

```powershell
$Path = '$home\AppData\Local\Microsoft\Windows\PowerShell'
$Path += '\ScheduledJobs\ProcessJob\Output'
Get-ChildItem $Path
```

```Output
Directory: C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell
               \ScheduledJobs\ProcessJob\Output

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         11/2/2011   3:00 AM            20111102-030002-260
d----         11/3/2011   3:00 AM            20111103-030002-277
d----         11/4/2011   3:00 AM            20111104-030002-209
d----         11/5/2011   3:00 AM            20111105-030002-251
d----         11/6/2011   3:00 AM            20111106-030002-174
d----         11/7/2011  12:00 AM            20111107-000001-914
d----         11/7/2011   3:00 AM            20111107-030002-376
```

Each timestamp-named directory represents a job instance. The results of each
job instance are saved in a **Results.xml** file in the timestamp-named
directory.

For example, the following command gets the **Results.xml** files for every
saved instance of the **ProcessJob** scheduled job. If the **Results.xml** file
is missing, PowerShell cannot return or display the job results.

```powershell
$Path = '$home\AppData\Local\Microsoft\Windows\PowerShell'
$Path += '\ScheduledJobs\ProcessJob\Output\*\Results.xml'
Get-ChildItem $Path
```

```Output
Directory: C:\Users\User01\Appdata\Local\Microsoft\Windows\PowerShell
               \ScheduledJobs\ProcessJob\Output
```

The job cmdlet might not be able to get scheduled job instances or their
results because the **PSScheduledJob** module is not imported into the session.

> [!NOTE]
> Before using a job cmdlet on scheduled job instances, verify that the
> **PSScheduledJob** module is included in the session. Without the
> **PSScheduledJob** module, the job cmdlets cannot get scheduled job instances
> or their results.

To import the **PSScheduledJob** module:

```powershell
Import-Module PSScheduledJob
```

### Receive-Job cmdlet might already have returned the results

If `Receive-Job` does not return job instance results, it might be because a
`Receive-Job` command has been run for that job instance in the current session
without the **Keep** parameter.

When you use `Receive-Job` without the **Keep** parameter, `Receive-Job`
returns the job results and sets the job instance's **HasMoreData** property to
**False**. The **False** value means that `Receive-Job` returned the job's
results and the instance has no more results to return. This setting is
appropriate for standard background jobs, but not for instances of scheduled
jobs, which are saved to disk.

To get the job instance results again, start a new PowerShell session by typing
`PowerShell`. Import the **PSScheduledJob** module, and try the `Receive-Job`
command again.

```powershell
Receive-Job -ID 50
```

```Output
#No results
```

```powershell
PowerShell.exe
```

```Output
Windows PowerShell
Copyright (C) 2012 Microsoft Corporation. All rights reserved.
```

```powershell
Import-Module PSScheduledJob
Receive-Job -ID 50
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id  ProcessName
-------  ------    -----      ----- -----   ------     --  -----------
1213         33    12348      21676    88    25.71   1608  CcmExec
29            4     1168       2920    43     0.02    748  conhost
46            6     2208       4612    45     0.03   1640  conhost
```

### Using Keep parameter to get results more than one time in a session

To get the result of a job instance more than one time in a session, use the
**Keep** parameter of the `Receive-Job` cmdlet.

```powershell
Import-Module PSScheduledJob
Receive-Job -ID 50 -Keep
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id  ProcessName
-------  ------    -----      ----- -----   ------     --  -----------
1213         33    12348      21676    88    25.71   1608  CcmExec
29            4     1168       2920    43     0.02    748  conhost
46            6     2208       4612    45     0.03   1640  conhost
```

```powershell
Receive-Job -ID 50 -Keep
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id  ProcessName
-------  ------    -----      ----- -----   ------     --  -----------
1213         33    12348      21676    88    25.71   1608  CcmExec
29            4     1168       2920    43     0.02    748  conhost
46            6     2208       4612    45     0.03   1640  conhost
```

### The scheduled job might be corrupted

If a scheduled job becomes corrupted, PowerShell deletes the corrupted
scheduled job and its results. You cannot recover the results of a corrupted
scheduled job.

To determine if a scheduled job still exists, use the `Get-ScheduledJob`
cmdlet.

```powershell
Get-ScheduledJob
```

### The number of results might have exceeded the ExecutionHistoryLength

The **ExecutionHistoryLength** property of a scheduled job determines how many
job instances, and their results, are saved to disk. The default value is 32.
When the number of instances of a scheduled job exceeds this value, PowerShell
deletes the oldest job instance to make room for each new job instance.

To get the value of the **ExecutionHistoryLength** property of a scheduled job,
use the following command format:

```powershell
(Get-ScheduledJob <JobName>).ExecutionHistoryLength
```

For example, the following command gets the value of the
**ExecutionHistoryLength** property of the **ProcessJob** scheduled job.

```powershell
(Get-ScheduledJob ProcessJob).ExecutionHistoryLength
```

To set or change the value of the **ExecutionHistoryLength** property, use the
**MaxResultCount** parameter of the `Register-ScheduledJob` and
`Set-ScheduledJob` cmdlets.

The following command increases the value of the **ExecutionHistoryLength**
property to 50.

```powershell
Get-ScheduledJob ProcessJob | Set-ScheduledJob -MaxResultCount 50
```

### The job instance results might have been deleted

The **ClearExecutionHistory** parameter of the `Set-ScheduledJob` cmdlet
deletes the execution history of a job. You can use this feature to free up
disk space or delete results that are not needed, or already used, analyzed or
saved in a different location.

To delete the execution history of a scheduled job, use the
**ClearExecutionHistory** parameter of the scheduled job.

The following command deletes the execution history of the **ProcessJob**
scheduled job.

```powershell
Get-ScheduledJob ProcessJob | Set-ScheduledJob -ClearExecutionHistory
```

Also, the `Remove-Job` cmdlet deletes job results. When you use `Remove-Job` to
delete a scheduled job, it deletes all instances of the job on disk, including
the execution history and all job results.

### Jobs started by using the Start-Job cmdlet are not saved to disk

When you use `Start-Job` to start a scheduled job, instead of using a job
trigger, `Start-Job` starts a standard background job. The background job and
its results are not stored in the execution history of the job on disk.

You can use the `Get-Job` cmdlet to get the job and the `Receive-Job` cmdlet to
get the job results, but the results are available only until you receive them,
unless you use the Keep parameter of the `Receive-Job` cmdlet.

Also, background jobs and their results are session-specific; they exist only
in the session in which they are created. If you delete the job with
`Remove-Job`, close the session or close PowerShell, the job instance and its
results are deleted.

## Scheduled job doesn't run

Scheduled jobs don't run automatically if the job triggers or the scheduled job
are disabled.

Use the `Get-ScheduledJob` cmdlet to get the scheduled job. Verify that the
value of the **Enabled** property of the scheduled job is **True**.

```powershell
Get-ScheduledJob ProcessJob
```

```Output
Id         Name            Triggers        Command         Enabled
--         ----            --------        -------         -------
4          ProcessJob      {1, 2}          Get-Process     True
```

```powershell
(Get-ScheduledJob ProcessJob).Enabled
```

```Output
True
```

Use the `Get-JobTrigger` cmdlet to get the job triggers of the scheduled job.
Verify that the value of the **Enabled** property of the job trigger is
**True**.

```powershell
Get-ScheduledJob ProcessJob | Get-JobTrigger
```

```Output
Id      Frequency    Time                   DaysOfWeek            Enabled
--      ---------    ----                   ----------            -------
1       Weekly       11/7/2011 5:00:00 AM   {Monday, Thursday}    True
2       Daily        11/7/2011 3:00:00 PM                         True
```

```powershell
Get-ScheduledJob ProcessJob|Get-JobTrigger|Format-Table ID, Enabled -Auto
```

```Output
Id Enabled
-- -------
1    True
2    True
```

### Scheduled jobs don't run automatically if job triggers are invalid

For example, a job trigger might specify a date in the past or a date that does
not occur, such as the 5th Monday of the month.

Scheduled jobs do not run automatically if the conditions of the job trigger or
the job options are not satisfied.

For example, a scheduled job that runs only when a particular user logs on to
the computer will not run if that user does not log on or only connects
remotely.

Examine the options of the scheduled job and make sure that they are satisfied.
For example, a scheduled job that requires that the computer be idle or
requires a network connection, or has a long **IdleDuration** or a brief
**IdleTimeout** might never run.

Use the `Get-ScheduledJobOption` cmdlet to examine the job options and their
values.

```powershell
Get-ScheduledJob -Name ProcessJob
```

```Output
StartIfOnBatteries     : False
StopIfGoingOnBatteries : True
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

For descriptions of the scheduled job options, see [New-ScheduledJobOption](xref:PSScheduledJob.New-ScheduledJobOption).

### The scheduled job instance might have failed

If a scheduled job command fails, PowerShell reports it immediately by
generating an error message. However, if the job fails when Task Scheduler
tries to run it, the error is not available to PowerShell.

Use the following methods to detect and correct job failures:

Check the Task Scheduler event log for errors. To check the log, use Event
Viewer or a PowerShell command such as the following:

```powershell
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational |
 Where {$_.Message -like "fail"}
```

Check the job record in Task Scheduler. PowerShell scheduled jobs are stored in
the following Task Scheduled folder:

`Task Scheduler Library\Microsoft\Windows\PowerShell\ScheduledJobs`

### The scheduled job might not run because of insufficient permission

Scheduled jobs run with the permissions of the user who created the job or the
permissions of the user who is specified by the **Credential** parameter in the
`Register-ScheduledJob` or `Set-ScheduledJob` command.

If that user does not have permission to run the commands or scripts, the job
fails.

## Can't get scheduled job or scheduled job is corrupted

On rare occasions, scheduled jobs can become corrupted or contain internal
contradictions that cannot be resolved. Typically, this happens when the XML
files for the scheduled job are manually edited, resulting in invalid XML.

When a scheduled job is corrupted, PowerShell attempts to delete the scheduled
job, its execution history, and its results from disk.

If it cannot remove the scheduled job, you will get a corrupted job error
message each time you run the `Get-ScheduledJob` cmdlet.

To remove a corrupted scheduled job, use either one of the following methods:

Delete the `<ScheduledJobName>` directory for the scheduled job. Don't delete
the **ScheduledJob** directory.

The directory's location:

`$env:UserProfile\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs<ScheduledJobName>`

For example:

`C:\Users<UserName>\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs<ScheduledJobName>.`

Use Task Scheduler to delete the scheduled job. PowerShell scheduled tasks
appear in the following Task Scheduler path:

`Task Scheduler Library\Microsoft\Windows\PowerShell\ScheduledJobs<ScheduledJobName>`

## Job cmdlets can't consistently find scheduled jobs

When the **PSScheduledJob** module isn't in the current session, the job
cmdlets cannot get scheduled jobs, start them, or get their results.

To import the **PSScheduledJob** module, type `Import-Module PSScheduledJob` or
run or get any cmdlet in the module, such as the `Get-ScheduledJob` cmdlet.
Beginning in PowerShell 3.0, modules are imported automatically when you get or
use any cmdlet in the module.

When the **PSScheduledJob** module isn't in the current session, the following
command sequence is possible.

```powershell
Get-Job ProcessJob
```

```Output
Get-Job : The command cannot find the job because the job name
ProcessJob was not found.
Verify the value of the Name parameter, and then try the command again.
+ CategoryInfo          : ObjectNotFound: (ProcessJob:String) [Get-Job],
PSArgumentException
+ FullyQualifiedErrorId : JobWithSpecifiedNameNotFound,Microsoft.PowerShell.
Commands.GetJobCommand
```

```powershell
Get-Job
Get-ScheduledJob ProcessJob
```

```Output
Id         Name            Triggers        Command      Enabled
--         ----            --------        -------      -------
4          ProcessJob      {1}             Get-Process  True
```

```powershell
Get-Job ProcessJob
```

```Output
Id     Name         PSJobTypeName   State       HasMoreData     Location
--     ----         -------------   -----       -----------     --------
43     ProcessJob   PSScheduledJob  Completed   True            localhost
44     ProcessJob   PSScheduledJob  Completed   True            localhost
45     ProcessJob   PSScheduledJob  Completed   True            localhost
46     ProcessJob   PSScheduledJob  Completed   True            localhost
47     ProcessJob   PSScheduledJob  Completed   True            localhost
48     ProcessJob   PSScheduledJob  Completed   True            localhost
49     ProcessJob   PSScheduledJob  Completed   True            localhost
50     ProcessJob   PSScheduledJob  Completed   True            localhost
```

This behavior occurs because the `Get-ScheduledJob` command automatically
imports the **PSScheduledJob** module, and then runs the command.

## See also

[about_Scheduled_Jobs_Basics](about_Scheduled_Jobs_Basics.md)

[about_Scheduled_Jobs_Advanced](about_Scheduled_Jobs_Advanced.md)

[about_Scheduled_Jobs](about_Scheduled_Jobs.md)

[PSScheduledJob](xref:PSScheduledJob) module cmdlets

[Task Scheduler](/windows/desktop/TaskSchd/task-scheduler-reference)
