---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Suspend Workflow
---

# About Suspend-Workflow
## about_Suspend-Workflow


# SHORT DESCRIPTION

Describes the Suspend-Workflow activity, which suspends
the workflow in which the activity appears.

# LONG DESCRIPTION

The Suspend-Workflow activity stops workflow processing
temporarily from within the workflow. Before suspending,
Windows PowerShell Workflow takes a checkpoint so the state
and data of the workflow are preserved and the workflow can
resume from the suspension point.

To resume the workflow, the user running the workflow
uses the Resume-Job cmdlet. You cannot resume a workflow
from within the workflow.

# SYNTAX


workflow <Verb-Noun>
{
Suspend-Workflow
}

# DETAILED DESCRIPTION

The Suspend-Workflow stops the  workflow temporarily and
returns a job object that represents the workflow job. A
job object is returned even you did not run the workflow
as job, such as by using the AsJob workflow common parameter.
The job state is Suspended.

You can use the Job cmdlets to manage the suspended workflow
job. To resume the workflow job, use the Resume-Job cmdlet.

When you resume the workflow job, the workflow resumes from
at the command that follows the Suspend-Workflow activity.

For example, the following workflow includes the
Suspend-Workflow activity. When you run the workflow, it runs
the Get-Date activity, saves its output in the $a variable,
and then suspends the workflow, and returns a job object
that represents the suspended workflow. The job type is
PSWorkflowJob.

Workflow Test-Suspend
{
$a = Get-Date
Suspend-Workflow
(Get-Date)- $a
}

PS C:> Test-Suspend

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
8      Job8            PSWorkflowJob   Suspended     True            localhost            Test-Suspend

You can use the job cmdlets, such as Get-Job, to manage
the workflow job.

Resuming a Workflow Job
To resume the workflow job, use the Resume-Job cmdlet.
The Resume-Job cmdlet returns the workflow job object
immediately, even though it might not yet be resumed.
To wait for the job to be resumed, use the Wait
parameter, or use the Get-Job cmdlet to get the current
job object.

PS C:> Resume-Job -Name Job8

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
8      Job8            PSWorkflowJob   Suspended     True            localhost            Test-Suspend

PS C:> Get-Job -Name Job8

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
8      Job8            PSWorkflowJob   Completed     True            localhost            Test-Suspend

Getting the Output of a Workflow Job

To get the output of a workflow job, use the Receive-Job
cmdlet. The output shows that the workflow resumed at the
command that followed the Suspend-Workflow cmdlet. The value
of the $a variable, which was populated before the suspension,
is available to the workflow when it resumes.

PS C:> Get-Job -Name Job8 | Receive-Job

Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 19
Milliseconds      : 823
Ticks             : 198230041
TotalDays         : 0.000229432917824074
TotalHours        : 0.00550639002777778
TotalMinutes      : 0.330383401666667
TotalSeconds      : 19.8230041
TotalMilliseconds : 19823.0041
PSComputerName    : localhost

# SEE ALSO

about_Workflows
Getting Started with Windows PowerShell Workflow (http://go.microsoft.com/fwlink/?LinkID=252592)