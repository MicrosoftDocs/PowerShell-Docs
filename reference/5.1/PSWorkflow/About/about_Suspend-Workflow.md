---
description:  Describes the `Suspend-Workflow` activity, which suspends the workflow in which the activity appears. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_suspend-workflow?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Suspend Workflow
---

# About Suspend-Workflow

## Short description

Describes the `Suspend-Workflow` activity, which suspends the workflow in which
the activity appears.

## Long description

The `Suspend-Workflow` activity temporarily stops workflow processing from
within the workflow. Before suspending, Windows PowerShell Workflow takes a
checkpoint so the workflow's state and data are preserved and the workflow can
resume from the suspension point.

To resume the workflow, the user running the workflow uses the `Resume-Job`
cmdlet. You can't resume a workflow from within the workflow.

## Syntax

```
workflow <Verb-Noun>
{
    Suspend-Workflow
}
```

## Detailed description

The `Suspend-Workflow` temporarily stops the workflow and returns a job object
that represents the workflow job. A job object is returned even if you didn't
run the workflow as a job. For example, such as by using the **AsJob** workflow
common parameter. The job state is **Suspended**.

You can use the job cmdlets to manage the suspended workflow job. To resume the
workflow job, use the `Resume-Job` cmdlet.

When you resume the workflow job, the workflow resumes at the command that
follows the `Suspend-Workflow` activity.

For example, the following workflow includes the `Suspend-Workflow` activity.
When you run the workflow, it runs the `Get-Date` activity, saves its output in
the `$a` variable, and then suspends the workflow, and returns a job object
that represents the suspended workflow. The job type is **PSWorkflowJob**.

You can use the job cmdlets, such as `Get-Job`, to manage the workflow job.

```powershell
Workflow Test-Suspend
{
    $a = Get-Date
    Suspend-Workflow
    (Get-Date)- $a
}

Test-Suspend
```

```Output
Id  Name  PSJobTypeName  State      HasMoreData  Location  Command
--  ----  -------------  -----      -----------  --------  -------
8   Job8  PSWorkflowJob  Suspended  True         localhost Test-Suspend
```

## Resuming a workflow job

To resume the workflow job, use the `Resume-Job` cmdlet. The `Resume-Job`
cmdlet returns the workflow job object immediately, even though it might not
yet be resumed. To wait for the job to be resumed, use the **Wait** parameter,
or use the `Get-Job` cmdlet to get the current job object.

```powershell
Resume-Job -Name Job8
```

```Output
Id  Name  PSJobTypeName  State    HasMoreData  Location  Command
--  ----  -------------  -----    -----------  --------  -------
8   Job8  PSWorkflowJob  Running  True         localhost Test-Suspend
```

```powershell
Get-Job -Name Job8
```

```Output
Id  Name  PSJobTypeName  State      HasMoreData  Location  Command
--  ----  -------------  -----      -----------  --------  -------
8   Job8  PSWorkflowJob  Completed  True         localhost Test-Suspend
```

## Getting the output of a workflow job

To get the output of a workflow job, use the `Receive-Job` cmdlet. The output
shows that the workflow resumed at the command that followed the
`Suspend-Workflow` cmdlet. The value of the `$a` variable, which was populated
before the suspension, is available to the workflow when it resumes.

```powershell
Get-Job -Name Job8 | Receive-Job
```

```Output
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
```

## See also

[about_Workflows](about_Workflows.md)

[about_WorkflowCommonParameters](about_WorkflowCommonParameters.md)

[PSWorkflow](xref:PSWorkflow) cmdlets

[Workflows Guide](/previous-versions/powershell/scripting/components/workflows-guide)

[Writing a Windows PowerShell Workflow](/previous-versions/powershell/scripting/developer/workflow/writing-a-windows-powershell-workflow)
