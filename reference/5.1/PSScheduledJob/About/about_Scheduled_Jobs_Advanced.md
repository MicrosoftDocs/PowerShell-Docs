---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Scheduled_Jobs_Advanced
---

# About Scheduled Jobs Advanced
## about_Scheduled_Jobs_Advanced



# SHORT DESCRIPTION

Explains advanced scheduled job topics, including the file structure
that underlies scheduled jobs.

# LONG DESCRIPTION

This topic includes the following sections:

-- Scheduled job directories and files
-- Rename a scheduled job
-- Start a scheduled job immediately
-- Manage execution history

# SCHEDULED JOB DIRECTORIES AND FILES


Windows PowerShell scheduled jobs are both Windows PowerShell
jobs and Task Scheduler tasks. Each scheduled job is registered
in Task Scheduler and saved on disk in Microsoft .Net Framework
Serialization XML format.

When you create a scheduled job, Windows Powershell creates a
directory for the scheduled job in the
$home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs
directory on the local computer. The directory name is the same
as the job name.

The following is a sample ScheduledJobs directory.

PS C:\ps-test> dir $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs

Directory: C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         9/29/2011  10:03 AM            ArchiveProjects
d----         9/30/2011   1:18 PM            Inventory
d----        10/20/2011   9:15 AM            Backup-Scripts
d----         11/7/2011  10:40 AM            ProcessJob
d----         11/2/2011  10:25 AM            SecureJob
d----         9/27/2011   1:29 PM            Test-HelpFiles
d----         9/26/2011   4:22 PM            DeployPackage

Each scheduled job has its own directory. The directory contains
the scheduled job XML file and an Output subdirectory.

PS C:> dir $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\ProcessJob

Directory:
C:\Users\User1\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\ProcessJob

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         11/1/2011   3:00 PM            Output
-a---         11/1/2011   3:43 PM       7281 ScheduledJobDefinition.xml

The Output directory for a scheduled job contains its execution
history. Each time a job trigger starts a scheduled job, Windows
PowerShell creates a timestamp-named directory in the Output
directory. The timestamp directory contains the results of the job
in a Results.xml file and the job status in a Status.xml file.

The following command shows the execution history directories for
the ProcessJob scheduled job.

PS C:> dir $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\ProcessJob\Output

Directory: C:\Users\User01\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\ProcessJob\Output

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         11/2/2011   3:00 AM            20111102-030002-260
d----         11/3/2011   3:00 AM            20111103-030002-277
d----         11/4/2011   3:00 AM            20111104-030002-209
d----         11/5/2011   3:00 AM            20111105-030002-251
d----         11/6/2011   3:00 AM            20111106-030002-174
d----         11/7/2011  12:00 AM            20111107-000001-914
d----         11/7/2011   3:00 AM            20111107-030002-376

PS C:> dir $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\ProcessJob\Output\20111102-030002-260

Directory: C:\Users\juneb\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\testjob\output\20111102-030002-260

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         11/2/2011   3:00 AM     581106 Results.xml
-a---         11/2/2011   3:00 AM       9451 Status.xml

You can open and examine the ScheduledJobDefinition.xml, Results.xml
and Status.xml files or use the Select-XML cmdlet to parse the files.

WARNING: Do not edit the XML files. If any XML file contains invalid
XML, Windows PowerShell deletes the scheduled job and its
execution history, including job results.

# START A SCHEDULED JOB IMMEDIATELY


You can start a scheduled job immediately in one of two ways:

-- Run the Start-Job cmdlet to start any scheduled job
-- Add the RunNow parameter to your Register-ScheduledJob
command to start the job as soon as the command is run

Jobs that are started by using the Start-Job cmdlet are standard
Windows PowerShell background jobs, not instances of the scheduled
job. Like all background jobs, these jobs start immediately --
they are not subject to job options or affected by job triggers
-- and their output is not saved in the Output directory of the
scheduled job directory.

The following command uses the DefinitionName parameter of the
Start-Job cmdlet to start the ProcessJob scheduled job.

Start-Job -DefinitionName ProcessJob

To manage the job and get the job results, use the Job cmdlets.
For more information about the Job cmdlets, see [about_Jobs](../../Microsoft.PowerShell.Core/About/about_Jobs.md).

NOTE: To use the Job cmdlets on instances of scheduled jobs, the
PSScheduledJob module  must be imported into the session.
To import the PSScheduledJob module, type
"Import-Module PSScheduledJob" (without quotation marks) or
use any Scheduled Job cmdlet, such as Get-ScheduledJob.

# RENAME A SCHEDULED JOB


To rename a scheduled job, use the Name parameter of the
Set-ScheduledJob cmdlet. When you rename  a scheduled job,
Windows PowerShell changes the name of the scheduled job and
the scheduled job directory. However, it doesn't change the
names of instances of the scheduled job that have already
run.

# GET START AND END TIMES

To get the dates and times that job instances started and
ended, use the PSBeginTime and PSEndTime properties of the
ScheduledJob object that Get-Job returns for scheduled jobs.

The following example uses the Property parameter of the
Format-Table cmdlet to display the PSBeginTime and PSEndTime
properties of each job instance in a table. The command uses
a calculated property to display the elapsed time of each job
instance.

PS C:> Get-job -Name UpdateHelpJob | Format-Table -Property ID, PSBeginTime, PSEndTime,
@{Label="Elapsed Time";Expression={$.PsEndTime - $.PSBeginTime}}

Id   PSBeginTime             PSEndTime                Elapsed Time
--   -----------             ---------                ------------
# 2   11/3/2011 3:00:01 AM    11/3/2011 3:00:39 AM     00:00:38.0053854

# 3   11/4/2011 3:00:02 AM    11/4/2011 3:01:01 AM     00:00:59.1188475

# 4   11/5/2011 3:00:02 AM    11/5/2011 3:00:50 AM     00:00:48.3692034

# 5   11/6/2011 3:00:01 AM    11/6/2011 3:00:54 AM     00:00:52.8013036

# 6   11/7/2011 3:00:01 AM    11/7/2011 3:00:38 AM     00:00:37.1930350

# 7   11/8/2011 3:00:01 AM    11/8/2011 3:00:57 AM     00:00:56.2570556

# 8   11/9/2011 3:00:03 AM    11/9/2011 3:00:55 AM     00:00:51.8142222

# 9   11/10/2011 3:00:02 AM   11/10/2011 3:00:42 AM    00:00:40.7195954


# MANAGE EXECUTION HISTORY


You can determine the number of job instance results that are
saved for each schedule job and delete the execution history
and saved job results of any scheduled job at any time.

The ExecutionHistoryLength property of a scheduled job determines
how many job instance results are saved for the scheduled job.
When the number of saved results exceeds the value of the
ExecutionHistoryLength property, Windows PowerShell deletes the
results of the oldest instance to make room for the results of
the newest instance.

By default, Windows PowerShell saves the execution history and
results of 32 instances of each scheduled job. To change that
value, use the MaxResultCount parameters of the Register-ScheduledJob
or Set-ScheduledJob cmdlets.

To delete the execution history and all results for a scheduled
job, use the ClearExecutionHistory parameter of the Set-ScheduledJob
cmdlet. Deleting this execution history does not prevent Windows
PowerShell from saving the results of new instances of the scheduled
job.

The following command uses the Register-ScheduledJob cmdlet to
creates a scheduled job. The command uses the MaxResultCount parameter
with a value of 12 to save only the 12 newest job instance results
of the scheduled job.

Register-ScheduledJob -Name ProcessJob -ScriptBlock {Get-Process} -MaxResultCount 12

The following command uses the MaxResultCount parameter of the
Set-ScheduledJob cmdlet to increase the number of saved instance
results to 15.

Get-ScheduledJob ProcessJob | Set-ScheduledJob -MaxResultCount 15

The following command deletes the execution history and all
currently saved results of the ProcessJob scheduled job.

Get-ScheduledJob ProcessJob | Set-ScheduledJob -ClearExecutionHistory

The following command gets the values of the name and
ExecutionHistoryLength properties of all scheduled jobs on the
computer and displays them in a table.

Get-ScheduledJob | Format-Table -Property Name, ExecutionHistoryLength -AutoSize

# SEE ALSO


about_Scheduled_Jobs
about_Scheduled_Jobs_Troubleshooting
about_Jobs

