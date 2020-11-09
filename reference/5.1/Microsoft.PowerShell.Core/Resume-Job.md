---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/resume-job?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Resume-Job
---

# Resume-Job

## SYNOPSIS
Restarts a suspended job.

## SYNTAX

### SessionIdParameterSet (Default)

```
Resume-Job [-Wait] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### JobParameterSet

```
Resume-Job [-Job] <Job[]> [-Wait] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameParameterSet

```
Resume-Job [-Wait] [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdParameterSet

```
Resume-Job [-Wait] [-InstanceId] <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StateParameterSet

```
Resume-Job [-Wait] [-State] <JobState> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FilterParameterSet

```
Resume-Job [-Wait] [-Filter] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Resume-Job` cmdlet resumes a workflow job that was suspended, such as by using the
`Suspend-Job` cmdlet or the [about_Suspend-Workflow](../PSWorkflow/about/about_Suspend-Workflow.md)
activity. When a workflow job resumes, the job engine reconstructs the state, metadata, and output
from saved resources, such as checkpoints. The job is restarted without any loss of state or data.
The job state is changed from **Suspended** to **Running**.

Use the parameters of `Resume-Job` to select jobs by name, ID, instance ID or pipe a job object,
such as one returned by the `Get-Job` cmdlet, to `Resume-Job`. You can also use a property filter to
select a job to be resumed.

By default, `Resume-Job` returns immediately, even though all jobs might not yet be resumed. To
suppress the command prompt until all specified jobs are resumed, use the **Wait** parameter.

The `Resume-Job` cmdlet works only on custom job types, such as workflow jobs. It does not work on
standard background jobs, such as those that are started by using the `Start-Job` cmdlet. If you
submit a job of an unsupported type, `Resume-Job` generates a terminating error and stops running.

To identify a workflow job, look for a value of **PSWorkflowJob** in the **PSJobTypeName** property
of the job. To determine whether a particular custom job type supports the `Resume-Job` cmdlet, see
the help topics for the custom job type.

Before using a Job cmdlet on a custom job type, import the module that supports the custom job type,
either by using the `Import-Module` cmdlet or getting or using a cmdlet in the module.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Resume a job by ID

The commands in this example verify that the job is a suspended workflow job and then resume the
job. The first command uses the `Get-Job` cmdlet to get the job. The output shows that the job is a
suspended workflow job. The second command uses the **Id** parameter of the `Resume-Job` cmdlet to
resume the job with an **Id** value of 4.

```
PS C:\> Get-Job EventJob
Id     Name            PSJobTypeName   State         HasMoreData     Location   Command
--     ----            -------------   -----         -----------     --------   -------
4      EventJob        PSWorkflowJob   Suspended     True            Server01   \\Script\Share\Event.ps1

PS C:\> Resume-Job -Id 4
```

### Example 2: Resume a job by name

This command uses the **Name** parameter to resume several workflow jobs on the local computer.

```
PS C:\> Resume-Job -Name WorkflowJob, InventoryWorkflow, WFTest*
```

### Example 3: Use custom property values

This command uses the value of a custom property to identify the workflow job to resume. It uses the
**Filter** parameter to identify the workflow job by its **CustomID** property. It also uses the
**State** parameter to verify that the workflow job is suspended, before it tries to resume it.

```
PS C:\> Resume-Job -Filter @{CustomID="T091291"} -State Suspended
```

### Example 4: Resume all suspended jobs on a remote computer

This command resumes all suspended jobs on the Srv01 remote computer.

```
PS C:\> Invoke-Command -ComputerName Srv01 -ScriptBlock {Get-Job -State Suspended | Resume-Job}
```

The command uses the `Invoke-Command` cmdlet to run a command on the Srv01 computer. The remote
command uses the **State** parameter of the `Get-Job` cmdlet to get all suspended jobs on the
computer. A pipeline operator (`|`) sends the suspended jobs to the `Resume-Job` cmdlet, which
resumes them.

### Example 5: Wait for jobs to resume

This command uses the **Wait** parameter to direct `Resume-Job` to return only after all specified
jobs are resumed. The **Wait** parameter is especially useful in scripts that assume that jobs are
resumed before the script continues.

```
PS C:\> Resume-Job -Name WorkflowJob, InventoryWorkflow, WFTest* -Wait
```

### Example 6: Resume a workflow that suspends itself

This code sample shows the `Suspend-Workflow` activity in a workflow.

The `Test-Suspend` workflow on the Server01 computer. When you run the workflow, the workflow runs
the `Get-Date` activity and stores the result in the `$a` variable. Then it runs the
`Suspend-Workflow` activity. In response, it takes a checkpoint, suspends the workflow, and returns
a workflow job object. `Suspend-Workflow` returns a workflow job object even if the workflow is not
explicitly run as a job.

`Resume-Job` resumes the `Test-Suspend` workflow in Job8. It uses the **Wait** parameter to hold the
command prompt until the job is resumed.

The `Receive-Job` cmdlet gets the results of the `Test-Suspend` workflow. The final command in the
workflow returns a **TimeSpan** object that represents the elapsed time between the current date and
time and the date and time that was saved in the `$a` variable before the workflow was suspended.

```
#SampleWorkflow
Workflow Test-Suspend
{
    $a = Get-Date
    Suspend-Workflow
    (Get-Date)- $a
}

PS C:\> Test-Suspend -PSComputerName Server01
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
8      Job8            PSWorkflowJob   Suspended     True            Server01             Test-Suspend

PS C:\> Resume-Job -Name "Job8" -Wait
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
8      Job8            PSWorkflowJob   Running       True            Server01             Test-Suspend

PS C:\> Receive-Job -Name Job8
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
        PSComputerName    : Server01
```

The `Resume-Job` cmdlet lets you resume a workflow job that was suspend by using the
`Suspend-Workflow` activity. This activity suspends a workflow from within a workflow. It is valid
only in workflows.

For information about the `Suspend-Workflow`, see
about_Suspend-Workflow](../PSWorkflow/about/about_Suspend-Workflow.md).

## PARAMETERS

### -Filter

Specifies a hash table of conditions. This cmdlet resumes jobs that satisfy all of the conditions in
the hash table. Enter a hash table where the keys are job properties and the values are job property
values.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: FilterParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id

Specifies an array of IDs for jobs that this cmdlet resumes.

The ID is an integer that uniquely identifies the job in the current session. It is easier to
remember and to type than the instance ID, but it is unique only in the current session. You can
type one or more IDs, separated by commas. To find the ID of a job, run `Get-Job`.

```yaml
Type: System.Int32[]
Parameter Sets: SessionIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies an array of instance IDs of jobs that this cmdlet resumes. The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer. To find the instance ID
of a job, run `Get-Job`.

```yaml
Type: System.Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job

Specifies the jobs to be resumed. Enter a variable that contains the jobs or a command that gets the
jobs. You can also pipe jobs to the `Resume-Job` cmdlet.

```yaml
Type: System.Management.Automation.Job[]
Parameter Sets: JobParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Specifies an array of friendly names of jobs that this cmdlet resumes. Enter one or more job names.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State

Specifies the state of jobs to resume. The acceptable values for this parameter are:

- NotStarted
- Running
- Completed
- Failed
- Stopped
- Blocked
- Suspended
- Disconnected
- Suspending
- Stopping

This cmdlet resumes only jobs in the **Suspended** state.

For more information about job states, see
[JobState Enumeration](/dotnet/api/system.management.automation.jobstate).

```yaml
Type: System.Management.Automation.JobState
Parameter Sets: StateParameterSet
Aliases:
Accepted values: NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping, AtBreakpoint

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Wait

Indicates that this cmdlet suppresses the command prompt until all job results are restarted. By
default, this cmdlet immediately returns the available results.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Job

You can pipe all types of jobs to this cmdlet. If `Resume-Job` gets a job of an unsupported type, it
returns a terminating error.

## OUTPUTS

### None, System.Management.Automation.Job

This cmdlet returns the jobs that it tries to resume, if you use the **PassThru** parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES

- `Resume-Job` can only resume jobs that are suspended. If you submit a job in a different state,
  `Resume-Job` runs the resume operation on the job, but generates a warning to notify you that the
  job could not be resumed. To suppress the warning, use the **WarningAction** common parameter with
  a value of SilentlyContinue.
- If a job is not of a type that supports resuming, such as a workflow job (**PSWorkflowJob**),
  `Resume-Job` returns a terminating error.
- The mechanism and location for saving a suspended job might vary depending on the job type. For
  example, suspended workflow jobs are saved in a flat file store by default, but can also be saved
  in a SQL database.
- When you resume a job, the job state changes from **Suspended** to **Running**. To find the jobs
  that are running, including those that were resumed by this cmdlet, use the **State** parameter of
  the `Get-Job` cmdlet to get jobs in the **Running** state.
- Some job types have options or properties that prevent Windows PowerShell from suspending the job.
  If attempts to suspend the job fail, verify that the job options and properties allow for
  suspending.

## RELATED LINKS

[Get-Job](Get-Job.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)
