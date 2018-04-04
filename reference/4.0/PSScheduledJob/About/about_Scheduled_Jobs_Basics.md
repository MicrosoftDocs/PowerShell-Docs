---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Scheduled_Jobs_Basics
---

# About Scheduled Jobs Basics
## about_Scheduled_Jobs_Basics



# SHORT DESCRIPTION

Explains how to create and manage scheduled jobs.

# LONG DESCRIPTION

This topic shows how to perform basic tasks of creating and
managing scheduled jobs. For information about more advanced
tasks, see about_Scheduled_Jobs_Advanced.

# HOW TO CREATE A SCHEDULED JOB

To create a scheduled job, use the Register-ScheduledJob
cmdlet. The cmdlet requires a name and the commands or
script that the job runs. You can either run the job
immediately by adding the RunNow parameter, or create a
job trigger and set job options when you create the job
or at a later time.

To create a job that runs a script, use the FilePath
parameter to specify the path to the script file. To create
a job that runs commands, use the ScriptBlock parameter.

The following command creates the ProcessJob, which runs a
Get-Process command. This scheduled job has the default job
options and no job trigger.

PS C:> Register-ScheduledJob -Name ProcessJob -ScriptBlock { Get-Process }

Id         Name            Triggers        Command       Enabled
--         ----            --------        -------       -------
8          ProcessJob      {}              Get-Process   True

# HOW TO CREATE A JOB TRIGGER


Job triggers start a scheduled job automatically. A job trigger
can be one-time or recurring schedule or an event, such as when
a user logs on or Windows starts. Each job can have zero, one,
or multiple job triggers.

To create a job trigger, use the New-JobTrigger cmdlet. The
following command creates a job trigger that starts a job every
Monday and Thursday at 5:00 AM. The command saves the job
trigger in the $t variable.

$t = New-JobTrigger -Weekly -DaysOfWeek "Monday", "Thursday" -At "5:00 AM"

Job triggers are optional. You can start a scheduled job at
any time by adding the RunNow parameter to your
Register-ScheduledJob command, or by using the Start-Job
cmdlets.

# HOW TO ADD A JOB TRIGGER


When you add a job trigger to a scheduled job, the job trigger
is added to the scheduled job XML file for the scheduled job
and becomes part of the scheduled job.

You can add a job trigger to a scheduled job when you create
the scheduled job or at a later time and you can change the
job trigger of a scheduled job at any time.

Windows PowerShell uses some of the same job triggers that Task
Scheduler uses. For detailed information about job triggers,
see the help topic for the New-JobTrigger cmdlet.

The following command uses the Register-ScheduledJob cmdlet
to create the process job. It uses the Trigger parameter to
specify the job trigger in the $t variable.

Register-ScheduledJob -Name ProcessJob -ScriptBlock {Get-Command} -Trigger $t

You can also add a job trigger to an existing scheduled job
at any time. The following command adds the job trigger in the
$t variable to the  ProcessJob scheduled job.

Add-JobTrigger -Name ProcessJob -Trigger $t

As a result of this command, the job trigger starts the
ProcessJob automatically every Monday and Thursday at 5:00 AM.

# HOW TO GET A JOB TRIGGER


To get the job trigger of a scheduled job, use the
Get-JobTrigger cmdlet. Use the Name, ID, and InputObject parameters
to specify the scheduled job (not the job trigger).

The following command gets the job trigger of the ProcessJob.

PS C:> Get-JobTrigger -Name ProcessJob

Id   Frequency       Time                   DaysOfWeek              Enabled
--   ---------       ----                   ----------              -------
1    Weekly          11/7/2011 5:00:00 AM   {Monday, Thursday}      True

# HOW TO CREATE JOB OPTIONS


Job options establish conditions for starting and running the
job. Every job has the default job options unless you change
them. Because job options can prevent a job from running at the
scheduled time, it is important to understand the job options
and use them carefully.

Windows PowerShell uses the same job options that Task Scheduler
uses. For detailed information about the job options, see the
help topic for the New-ScheduledJobOption cmdlet. Type "Get-Help
New-ScheduledJobOption" or see the help topic online at
http://go.microsoft.com/fwlink/?LinkID=223915.

Job options are stored in the scheduled job XML file. You can
set job options when you create a scheduled job or change them at
any time.

The following command creates a scheduled job option in which
the WakeToRun scheduled job option is set to True. The WakeToRun
option runs the scheduled job even if the computer is in the Sleep
or Hibernate state at the scheduled start time. The command saves
the job options in the $o variable.

$o = New-ScheduledJobOption -WakeToRun

# HOW TO GET JOB OPTIONS


To get the job options of a scheduled job, use the
Get-ScheduledJobOption cmdlet. Use the Name, ID, and
InputObject parameters to specify the scheduled job (not
the job options).

The following command gets the job options of the ProcessJob.

PS C:> Get-ScheduledJobOption -Name ProcessJob

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

# HOW TO CHANGE JOB OPTIONS


You can change the job options of a scheduled job when you
create a scheduled job or at any time thereafter.

The following command uses the Register-JobTrigger cmdlet
to create the process job. It uses the ScheduledJobOption
parameter to specify the job options in the $o variable.

Register-JobTrigger -Name ProcessJob -ScriptBlock {Get-Process} -ScheduledJobOption $o

You can also change the job options to an existing scheduled
job at any time. The following command uses the
Set-ScheduledJobOption cmdlet to change the value of the
WakeToRun option of the ProcessJob scheduledJob to True.

Like all of the Set cmdlets in the PSScheduledJob module,
Set-ScheduledJobOption cmdlet does not have Name or ID parameters.
You can use the InputObject parameter to specify the scheduled
job options or pipe a scheduled job from Get-ScheduledJobOption
cmdlet to Set-ScheduledJobOption.

The following command uses the Get-ScheduledJob cmdlet to get the
ProcessJob. It uses the Get-ScheduledJobOption cmdlet to get the
job options in the ProcessJob and the Set-ScheduledJobOption cmdlet
to change the WakeToRun job option in the ProcessJob to True.

Get-ScheduledJob -Name ProcessJob | Get-ScheduledJobOption | Set-ScheduledJobOption -WakeToRun

# HOW TO GET SCHEDULED JOB INSTANCES


When a scheduled job is started, Windows PowerShell creates a
job instance that is similar to a standard Windows PowerShell
background job. You can use the Job cmdlets, such as Get-Job,
Stop-Job and Receive-Job to manage the job instances.

NOTE: To use the Job cmdlets on instances of scheduled jobs, the
PSScheduledJob module  must be imported into the session. To
import the PSScheduledJob module, type "Import-Module PSScheduledJob"
(without quotation marks) or use any Scheduled Job cmdlet, such
as Get-ScheduledJob.

To get all instances of Windows PowerShell scheduled jobs (and
all active standard jobs), use the Get-Job cmdlet. The following
command imports the PSScheduledJob module and then gets all jobs on
the local computer.

PS C:> Import-Module PSScheduledJob

PS C:> Get-Job

The following command gets all instances of the ProcessJob on
the local computer.

PS C:> Get-Job -Name ProcessJob

Id     Name        PSJobTypeName  State    HasMoreData   Location   Command
--     ----        ------------   -----    -----------   --------   -------
45     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
46     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
47     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
48     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
49     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
50     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process
51     ProcessJob  PSScheduledJob Completed       True   localhost   Get-Process

The default display does not show the start time, which typically
distinguishes instances of the same scheduled job.

The following command uses the Format-Table cmdlet to display the Name,
ID, and BeginTime  properties of the scheduled job.

PS C:> Get-Job ProcessJob | Format-Table -Property Name, ID, BeginTime

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

# GET SCHEDULED JOB RESULTS


To get the results of an instance of a scheduled job, use the
Receive-Job cmdlet.

NOTE: To use the Job cmdlets on instances of scheduled jobs, the
PSScheduledJob module must be imported into the session. To
import the PSScheduledJob module, type "Import-Module PSScheduledJob"
(without quotation marks) or use any Scheduled Job cmdlet, such
as Get-ScheduledJob.

The following command gets the results of the newest instance of
the ProcessJob scheduled job (ID = 51)

PS C:> Import-Module PSScheduledJob

PS C:> Receive-Job -ID 51 -Keep

The results of scheduled jobs are saved on disk, so the Keep parameter
of Receive-Job is not required. However, without the Keep parameter,
you can get the results of a scheduled job only once in each Windows
PowerShell session. To start a new Windows PowerShell session, type
"PowerShell" or open a new Windows PowerShell window.

# SEE ALSO

about_Scheduled_Jobs
about_Scheduled_Jobs_Advanced
about_Scheduled_Jobs_Troubleshooting