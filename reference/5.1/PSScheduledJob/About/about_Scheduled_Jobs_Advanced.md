---
description:  Explains advanced scheduled job topics, including the file structure that underlies scheduled jobs. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psscheduledjob/about/about_scheduled_jobs_advanced?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Scheduled_Jobs_Advanced
---

# About Scheduled Jobs Advanced

## Short description

Explains advanced scheduled job topics, including the file structure that
underlies scheduled jobs.

## Long description

For more information about the cmdlets contained in the **PSScheduledJob**
module, see [PSScheduledJob](xref:PSScheduledJob).

## Scheduled job directories and files

PowerShell scheduled jobs are both PowerShell jobs and Task Scheduler tasks.
Each scheduled job is registered in Task Scheduler and saved on disk in
Microsoft .NET Framework Serialization XML format.

When you create a scheduled job, PowerShell creates a directory for the
scheduled job in the
`$home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs` directory on
the local computer. The directory name is the same as the job name.

The following is a sample **ScheduledJobs** directory.

```powershell
Get-ChildItem $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs
```

```Output
Directory: C:\Users\User01\AppData\Local
               \Microsoft\Windows\PowerShell\ScheduledJobs

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         9/29/2011  10:03 AM            ArchiveProjects
d----         9/30/2011   1:18 PM            Inventory
d----        10/20/2011   9:15 AM            Backup-Scripts
d----         11/7/2011  10:40 AM            ProcessJob
d----         11/2/2011  10:25 AM            SecureJob
d----         9/27/2011   1:29 PM            Test-HelpFiles
d----         9/26/2011   4:22 PM            DeployPackage
```

Each scheduled job has its own directory. The directory contains the scheduled
job XML file and an **Output** subdirectory.

```powershell
$Path = "$home\AppData\Local\Microsoft\Windows\PowerShell"
$Path += "\ScheduledJobs\ProcessJob"
Get-ChildItem $Path
```

```Output
Directory: C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell
               \ScheduledJobs\ProcessJob

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         11/1/2011   3:00 PM            Output
-a---         11/1/2011   3:43 PM       7281 ScheduledJobDefinition.xml
```

The **Output** directory for a scheduled job contains its execution history.
Each time a job trigger starts a scheduled job, PowerShell creates a
timestamp-named directory in the output directory. The timestamp directory
contains the results of the job in a **Results.xml** file and the job status in
a **Status.xml** file.

The following command shows the execution history directories for the
**ProcessJob** scheduled job.

```powershell
$Path = "$home\AppData\Local\Microsoft"
$Path += "\Windows\PowerShell\ScheduledJobs\ProcessJob\Output"
Get-ChildItem $Path
```

```Output
Directory: C:\Users\User01\AppData\Local\Microsoft
               \Windows\PowerShell\ScheduledJobs\ProcessJob\Output

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

```powershell
$Path = "$home\AppData\Local\Microsoft\Windows\PowerShell\"
$Path += "ScheduledJobs\ProcessJob\Output\20111102-030002-260"
Get-ChildItem $Path
```

```Output
Directory: C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell
               \ScheduledJobs\ProcessJob\Output\20111102-030002-260

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         11/2/2011   3:00 AM     581106 Results.xml
-a---         11/2/2011   3:00 AM       9451 Status.xml
```

You can open and examine the **ScheduledJobDefinition.xml**, **Results.xml**
and **Status.xml** files or use the `Select-XML` cmdlet to parse the files.

> [!WARNING]
> Do not edit the XML files. If any XML file contains invalid XML, PowerShell
> deletes the scheduled job and its execution history, including job results.

## Start a scheduled job immediately

You can start a scheduled job immediately in one of two ways:

- Run the `Start-Job` cmdlet to start any scheduled job.
- Add the **RunNow** parameter to your `Register-ScheduledJob` command to start
  the job as soon as the command is run.

Jobs that are started by using the `Start-Job` cmdlet are standard PowerShell
background jobs, not instances of the scheduled job. Like all background jobs,
these jobs start immediately, they aren't subject to job options or affected by
job triggers. The job output isn't saved in the **Output** directory of the
scheduled job directory.

The following command uses the **DefinitionName** parameter of the `Start-Job`
cmdlet to start the ProcessJob scheduled job.

```powershell
Start-Job -DefinitionName ProcessJob
```

To manage the job and get the job results, use the job cmdlets. For more
information about the job cmdlets, see [about_Jobs](../../Microsoft.PowerShell.Core/About/about_Jobs.md).

> [!NOTE]
> To use the Job cmdlets on instances of scheduled jobs, the **PSScheduledJob**
> module must be imported into the session. To import the **PSScheduledJob**
> module, type `Import-Module PSScheduledJob` or use any scheduled job cmdlet,
> such as `Get-ScheduledJob`.

## Rename a scheduled job

To rename a scheduled job, use the Name parameter of the `Set-ScheduledJob`
cmdlet. When you rename a scheduled job, PowerShell changes the name of the
scheduled job and the scheduled job directory. However, it doesn't change the
names of instances of the scheduled job that have already run.

## Get start and end times

To get the dates and times that job instances started and ended, use the
**PSBeginTime** and **PSEndTime** properties of the ScheduledJob object that
`Get-Job` returns for scheduled jobs.

The following example uses the **Property** parameter of the `Format-Table`
cmdlet to display the **PSBeginTime** and **PSEndTime** properties of each job
instance in a table. A calculated property named **Label** displays the elapsed
time of each job instance.

```powershell
Get-job -Name UpdateHelpJob | 
  Format-Table -Property ID, PSBeginTime, PSEndTime,
@{Label="Elapsed Time";Expression={$.PsEndTime - $.PSBeginTime}}
```

```Output
Id   PSBeginTime             PSEndTime                Elapsed Time
--   -----------             ---------                ------------
 2   11/3/2011 3:00:01 AM    11/3/2011 3:00:39 AM     00:00:38.0053854
 3   11/4/2011 3:00:02 AM    11/4/2011 3:01:01 AM     00:00:59.1188475
 4   11/5/2011 3:00:02 AM    11/5/2011 3:00:50 AM     00:00:48.3692034
 5   11/6/2011 3:00:01 AM    11/6/2011 3:00:54 AM     00:00:52.8013036
 6   11/7/2011 3:00:01 AM    11/7/2011 3:00:38 AM     00:00:37.1930350
 7   11/8/2011 3:00:01 AM    11/8/2011 3:00:57 AM     00:00:56.2570556
 8   11/9/2011 3:00:03 AM    11/9/2011 3:00:55 AM     00:00:51.8142222
 9   11/10/2011 3:00:02 AM   11/10/2011 3:00:42 AM    00:00:40.7195954
```

## Manage execution history

You can determine the number of job instance results that are saved for each
scheduled job and delete the execution history and saved job results of any
scheduled job.

The **ExecutionHistoryLength** property of a scheduled job determines how many
job instance results are saved for the scheduled job. When the number of saved
results exceeds the value of the **ExecutionHistoryLength** property,
PowerShell deletes the results of the oldest instance to make room for the
results of the newest instance.

By default, PowerShell saves the execution history and results of 32 instances
of each scheduled job. To change that value, use the **MaxResultCount**
parameters of the `Register-ScheduledJob` or `Set-ScheduledJob` cmdlets.

To delete the execution history and all results for a scheduled job, use the
**ClearExecutionHistory** parameter of the `Set-ScheduledJob` cmdlet. Deleting
this execution history does not prevent PowerShell from saving the results of
new instances of the scheduled job.

The following example uses splatting to create `$JobParms` which are parameter
values that are passed to the `Register-ScheduledJob` cmdlet. For more
information, see [about_Splatting.md](../../Microsoft.PowerShell.Core/About/about_Splatting.md).
The `Register-ScheduledJob` uses `@JobParms` to create a scheduled job. The
command uses the **MaxResultCount** parameter with a value of 12 to save only
the 12 newest job instance results of the scheduled job.

```powershell
$JobParms = @{
  Name = "ProcessJob"
  ScriptBlock = {Get-Process}
  MaxResultCount = "12"
}

Register-ScheduledJob @JobParms
```

The following command uses the **MaxResultCount** parameter of the
`Set-ScheduledJob` cmdlet to increase the number of saved instance results to
15.

```powershell
Get-ScheduledJob ProcessJob | Set-ScheduledJob -MaxResultCount 15
```

The following command deletes the execution history and the current saved
results of the **ProcessJob** scheduled job.

```powershell
Get-ScheduledJob ProcessJob | Set-ScheduledJob -ClearExecutionHistory
```

The following command gets the values of the name and
**ExecutionHistoryLength** properties of all scheduled jobs on the computer and
displays them in a table.

```powershell
Get-ScheduledJob | 
  Format-Table -Property Name, ExecutionHistoryLength -AutoSize
```

## See also

[about_Scheduled_Jobs_Basics](about_Scheduled_Jobs_Basics.md)

[about_Scheduled_Jobs_Troubleshooting](about_Scheduled_Jobs_Troubleshooting.md)

[about_Scheduled_Jobs](about_Scheduled_Jobs.md)

[about_Splatting.md](../../Microsoft.PowerShell.Core/About/about_Splatting.md)

[PSScheduledJob](xref:PSScheduledJob) module cmdlets

[Task Scheduler](/windows/desktop/TaskSchd/task-scheduler-reference)
