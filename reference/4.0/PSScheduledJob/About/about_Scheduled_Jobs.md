---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Scheduled_Jobs
---

# About Scheduled Jobs
## about_Scheduled_Jobs



# SHORT DESCRIPTION

Describes scheduled jobs and explains how to use and manage
scheduled jobs in Windows PowerShell and in Task Scheduler.

# LONG DESCRIPTION

Windows PowerShell scheduled jobs are a useful hybrid of
Windows PowerShell background jobs and Task Scheduler tasks.

Like Windows PowerShell background jobs, scheduled jobs
run asynchronously in the background. Instances of scheduled
jobs that have run can be managed by using the job cmdlets,
such as Start-Job, Get-Job, Stop-Job, and Receive-Job.

Like Task Scheduler tasks, scheduled jobs are saved to disk.
You can view and manage the jobs in Task Scheduler, enable
and disable them as needed, run them or use them as templates,
establish a one-time or recurring schedules for starting the
jobs, or set conditions under which the jobs start.

In addition, the results of scheduled job instances are saved
to disk in an easily accessible format, providing a running
log of job output. Scheduled jobs come with a customized set
of cmdlets for managing them. The cmdlets let you create, edit,
manage, disable, and re-enable scheduled jobs, job triggers
and job options.

This comprehensive and flexible set of tools make scheduled
jobs an essential component of many professional Windows
PowerShell IT solutions.

The scheduled job cmdlets are included in the PSScheduledJob
module that is installed with Windows PowerShell. This module
was introduced in Windows PowerShell 3.0 and works in Windows
PowerShell 3.0 and later versions of Windows PowerShell.

For more information about Windows PowerShell background jobs,
see [about_Jobs](../../Microsoft.PowerShell.Core/About/about_Jobs.md).

For more information about Task Scheduler, see "Task Scheduler"
in the TechNet Library at
http://go.microsoft.com/fwlink/?LinkId=232928.

NOTE: You can view and manage Windows PowerShell scheduled jobs
in Task Scheduler, but the Windows PowerShell job and Scheduled
Job cmdlets work only on scheduled jobs that are created in
Windows PowerShell.

# SCHEDULED JOB CMDLETS

The PSScheduledJob module contains the following cmdlets.

Register-ScheduledJob:       Creates a scheduled job.
Get-ScheduledJob:            Gets a scheduled job.
Set-ScheduledJob:            Changes the properties of a scheduled job
Disable-ScheduledJob:        Temporarily disables a scheduled job.
Enable-ScheduledJob:         Re-enables a scheduled job.
Unregister-ScheduledJob      Deletes a scheduled job and its saved results.

New-JobTrigger:              Creates a job trigger.
Get-JobTrigger:              Gets a job trigger.
Add-JobTrigger:              Adds a job trigger to a scheduled job.
Set-JobTrigger:              Changes a job trigger.
Disable-JobTrigger:          Temporarily disables a job trigger.
Enable-JobTrigger:           Re-enables a job trigger.
Remove-JobTrigger:           Deletes a job trigger.

New-ScheduledJobOption:      Creates a job options object.
Get-ScheduledJobOption:      Gets the job options of a scheduled job.
Set-ScheduledJobOption:      Changes the job options of a scheduled job.

# QUICK START

The following commands create a scheduled job that starts
every day at 3:00 AM and runs the Get-Process cmdlet. The job
starts even if the computer is running on batteries.

$trigger = New-JobTrigger -Daily -At 3AM

$options = New-ScheduledJobOption -StartIfOnBattery

Register-ScheduledJob -Name ProcessJob -ScriptBlock {Get-Process} `
-Trigger $trigger -ScheduledJobOption $options

The following command gets the scheduled jobs on the local computer.

PS C:> Get-ScheduledJob

Id         Name            Triggers        Command            Enabled
--         ----            --------        -------            -------
7          ProcessJob      {1}             Get-Process        True

The following command gets the job triggers of ProcessJob. The
input parameters specify the scheduled job, not the trigger,
because triggers are saved in a scheduled job.

PS C:> Get-JobTrigger -Name ProcessJob

Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Daily           11/5/2011 3:00:00 AM                           True

The following command uses the ContinueIfGoingOnBattery parameter of
the Set-ScheduledJob cmdlet to change the StopIfGoingOnBatteries property
of ProcessJob to False.

PS C:> Get-ScheduledJob -Name ProcessJob | Set-ScheduledJobOption `
-ContinueIfGoingOnBattery -Passthru

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

The following command gets the ProcessJob scheduled job.

PS C:> Get-ScheduledJob ProcessJob

Id         Name            Triggers        Command        Enabled
--         ----            --------        -------        -------
7          ProcessJob      {1}             Get-Process    True

The following command uses the Get-Job cmdlet to get all instances
of the ProcessJob scheduled job that have run thus far. The Get-Job
cmdlet gets scheduled jobs only when the PSScheduledJob module is
imported into the current session.

TIP: Notice that you use the ScheduledJob cmdlets to manage scheduled
jobs, but you use the Job cmdlets to manage instances of scheduled jobs.

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

The following command gets the results of the most recent instance
of the ProcessJob scheduled job (ID = 51).

Receive-Job -ID 51

Even though the Receive-Job command did not include the Keep parameter,
the results of the job are saved on disk until you delete them or the
maximum number of results are exceeded.

The job results are no longer available in this session, but if you
start a new session or open a new Windows Powershell window, the
results of the job are available again.

The following command uses the DefinitionName parameter of the
Start-Job cmdlet to start the ProcessJob scheduled job.

Jobs that are started by using the Start-Job cmdlet are standard
Windows PowerShell background jobs, not instances of the scheduled
job. Like all background jobs, these jobs start immediately -- they
are not subject to job options or affected by job triggers -- and
their output is not saved in the Output directory of the scheduled
job directory.

PS C:> Start-Job -DefinitionName ProcessJob

The following command deletes the ProcessJob scheduled job and all
saved results of its job instances.

PS C:> Remove-ScheduledJob ProcessJob

# SCHEDULED JOBS CONCEPTS

A "scheduled job" runs commands or a script. A scheduled job can
include "job triggers" that start the job and "job options" that
set conditions for running the job.

A "job trigger" starts a scheduled job automatically. A job trigger
can include a one-time or recurring schedule or specify an event,
such as when a user logs on or Windows starts. A scheduled job can
have one or more job triggers, and you can create, add, enable,
disable, and get job triggers.

Job triggers are optional. You can start also scheduled jobs
immediately by using the Start-Job cmdlet, or by adding the RunNow
parameter to your Register-ScheduledJob command.

"Job options" set the conditions for running a scheduled job.
Every scheduled job has one job options object. You can create
and edit job options objects and add them to one or more scheduled
jobs.

Each time a scheduled job starts, a "job instance" is created.
Use the Windows PowerShell Job cmdlets to view and manage the job
instance.

Scheduled jobs are saved to disk (hence the cmdlet verb, Register,
instead of New) in XML files in the
$home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs
directory on the local computer.

Windows PowerShell creates a directory for each scheduled job and
saves the job commands, job triggers, job options  and job results
in the scheduled job directory. Job triggers and job options are not
saved to disk independently. They are saved in the scheduled job
XML of each scheduled job with which they are associated.

Scheduled jobs, job triggers, and job options appear in Windows
PowerShell as objects. The objects are interlinked, which makes
them easy to discover and use in commands and scripts.

Scheduled jobs appear as ScheduledJobDefinition objects. The
ScheduledJobDefinition object has a  JobTriggers property that
contains the job triggers of the scheduled job and an Options
property that contains the job options. The ScheduledJobTriggers
and ScheduledJobOptions objects that represent job
triggers and job options, respectively, each have a JobDefinition
property that contains the scheduled job with which they are
associated. This recursive interconnection makes it easy to find
the triggers and options of a scheduled job and to find, script,
and display  the scheduled job to which any job trigger or job option
is associated.

# SEE ALSO

about_Scheduled_Jobs_Basics
about_Scheduled_Jobs_Advanced
about_Scheduled_Jobs_Troubleshooting
about_jobs
Task Scheduler (http://go.microsoft.com/fwlink/?LinkId=232928)

Add-JobTrigger
Disable-JobTrigger
Disable-ScheduledJob
Enable-JobTrigger
Enable-ScheduledJob
Get-Job
Get-JobTrigger
Get-ScheduledJob
Get-ScheduledJobOption
New-JobTrigger
New-ScheduledJobOption
Receive-Job
Register-ScheduledJob
Remove-JobTrigger
Set-JobTrigger
Set-ScheduledJob
Set-ScheduledJobOption
Start-Job
Unregister-ScheduledJob

