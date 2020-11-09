---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/suspend-job?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Suspend-Job
---

# Suspend-Job

## SYNOPSIS
Temporarily stops workflow jobs.

## SYNTAX

### SessionIdParameterSet (Default)

```
Suspend-Job [-Force] [-Wait] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### JobParameterSet

```
Suspend-Job [-Job] <Job[]> [-Force] [-Wait] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameParameterSet

```
Suspend-Job [-Force] [-Wait] [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdParameterSet

```
Suspend-Job [-Force] [-Wait] [-InstanceId] <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FilterParameterSet

```
Suspend-Job [-Force] [-Wait] [-Filter] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StateParameterSet

```
Suspend-Job [-Force] [-Wait] [-State] <JobState> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Suspend-Job` cmdlet suspends workflow jobs. Suspend means to temporarily interrupt or pause a
workflow job. This cmdlet allows users who are running workflows to suspend the workflow. It
complements the Suspend-Workflowhttps://go.microsoft.com/fwlink/?LinkId=267141 activity, which is a
command in the workflow that suspends the workflow.

The `Suspend-Job` cmdlet works only on workflow jobs. It does not work on standard background jobs,
such as those that are started by using the `Start-Job` cmdlet.

To identify a workflow job, look for a value of PSWorkflowJob in the **PSJobTypeName** property of
the job. To determine whether a particular custom job type supports the `Suspend-Job` cmdlet, see
the help topics for the custom job type.

When you suspend a workflow job, the workflow job runs to the next checkpoint, suspends, and
immediately returns a workflow job object. To wait for the suspension to complete before getting the
job, use the **Wait** parameter of `Suspend-Job` or the `Wait-Job` cmdlet. When the workflow job is
suspended, the value of the **State** property of the job is Suspended.

Suspending correctly relies on checkpoints. The current job state, metadata, and output are saved in
the checkpoint so the workflow job can be resumed without loss of state or data. If the workflow job
does not have checkpoints, it cannot be suspended correctly. To add checkpoints to a workflow that
you are running, use the **PSPersist** workflow common parameter. You can use the **Force**
parameter to suspend any workflow job immediately and to suspend a workflow job that does not have
checkpoints, but the action could cause loss of state and data.

Before you use a Job cmdlet on a custom job type, such as a workflow job (**PSWorkflowJob**) import
the module that supports the custom job type, either by using the `Import-Module` cmdlet or using or
using a cmdlet in the module.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Suspend a workflow job by name

This example shows how to suspend a workflow job.

The first command creates the `Get-SystemLog` workflow. The workflow uses the `CheckPoint-Workflow`
activity to define a checkpoint in the workflow.

The second command uses the **AsJob** parameter that is common to all workflows to run the
`Get-SystemLog` workflow as a background job. The command uses the **JobName** workflow common
parameter to specify a friendly name for the workflow job.

The third command uses the `Get-Job` cmdlet to get the `Get-SystemLogJob` workflow job. The output
shows that the value of the **PSJobTypeName** property is PSWorkflowJob.

The fourth command uses the `Suspend-Job` cmdlet to suspend the `Get-SystemLogJob` job. The job runs
to the checkpoint and then suspends.

```
#Sample WorkflowWorkflow Get-SystemLog
{
    $Events = Get-WinEvent -LogName System
    CheckPoint-Workflow
    InlineScript {\\Server01\Scripts\Analyze-SystemEvents.ps1 -Events $Events}
}

PS C:\> Get-SystemLog -AsJob -JobName "Get-SystemLogJob"

PS C:\> Get-Job -Name Get-SystemLogJob
Id     Name              PSJobTypeName   State       HasMoreData     Location   Command
--     ----              -------------   -----       -----------     --------   -------
4      Get-SystemLogJob  PSWorkflowJob   Running     True            localhost   Get-SystemLog

PS C:\> Suspend-Job -Name Get-SystemLogJob
Id     Name              PSJobTypeName   State       HasMoreData     Location   Command
--     ----              -------------   -----       -----------     --------   -------
4      Get-SystemLogJob  PSWorkflowJob   Suspended   True            localhost   Get-SystemLog
```


### Example 2: Suspend and resume a workflow job

This example shows how to suspend and resume a workflow job.

The first command suspends the LogWorkflowJob job.The command returns immediately. The output shows
that the workflow job is still running, even though it is being suspended.

The second command uses the `Get-Job` cmdlet to get the LogWorkflowJob job. The output shows that
the workflow job suspended successfully.

The third command uses the `Get-Job` cmdlet to get the LogWorkflowJob job and the `Resume-Job`
cmdlet to resume it. The output shows that the workflow job resumed successfully and is now running.

```
PS C:\> Suspend-Job -Name LogWorkflowJob
Id     Name          PSJobTypeName      State         HasMoreData     Location             Command
--     ----          -------------      -----         -----------     --------             -------
67     LogflowJob    PSWorkflowJob      Running       True            localhost            LogWorkflow

PS C:\> Get-Job -Name LogWorkflowJob
Id     Name          PSJobTypeName      State         HasMoreData     Location             Command
--     ----          -------------      -----         -----------     --------             -------
67     LogflowJob    PSWorkflowJob      Suspended     True            localhost            LogWorkflow

PS C:\> Get-Job -Name LogWorkflowJob | Resume-Job
Id     Name          PSJobTypeName      State         HasMoreData     Location             Command
--     ----          -------------      -----         -----------     --------             -------
67     LogflowJob    PSWorkflowJob      Running       True            localhost            LogWorkflow
```


### Example 3: Suspend a workflow job on a remote computer

```
PS C:\> Invoke-Command -ComputerName Srv01 -Scriptblock {Suspend-Job -Filter @{CustomID="031589"}
```

This command uses the `Invoke-Command` cmdlet to suspend a workflow job on the Srv01 remote
computer. The value of the **Filter** parameter is a hash table that specifies a CustomID value.
This **CustomID** is job metadata (**PSPrivateMetadata**).

### Example 4: Wait for the workflow job to suspend

```
PS C:\> Suspend-Job VersionCheck -Wait
Id     Name          PSJobTypeName      State         HasMoreData     Location             Command
--     ----          -------------      -----         -----------     --------             -------
 5     VersionCheck  PSWorkflowJob      Suspended     True            localhost            LogWorkflow
```

This command suspends the VersionCheck workflow job. The command uses the **Wait** parameter to wait
until the workflow job is suspended. When the workflow job runs to the next checkpoint and is
suspended, the command finishes and returns the job object.

### Example 5: Force a workflow job to suspend

```
PS C:\> Suspend-Job Maintenance -Force
```

This command suspends the Maintenance workflow job forcibly. The Maintenance job does not have
checkpoints. It cannot be suspended correctly and might not resume correctly.

## PARAMETERS

### -Filter

Specifies a hash table of conditions. This cmdlet suspends jobs that satisfy all of the conditions.
Enter a hash table where the keys are job properties and the values are job property values.

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

### -Force

Suspends the workflow job immediately. This action could cause a loss of state and data.

By default, `Suspend-Job` lets the workflow job run until the next checkpoint and then suspends it.
You can also use this parameter to suspend workflow jobs that do not have checkpoints.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: F

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the IDs of jobs that this cmdlet suspends.

The ID is an integer that uniquely identifies the job in the current session. It is easier to
remember and to type than the instance ID, but it is unique only in the current session. You can
type one or more IDs, separated by commas. To find the ID of a job, use the `Get-Job` cmdlet.

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

Specifies the instance IDs of jobs that this cmdlet suspends. The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer. To find the instance ID
of a job, use `Get-Job`.

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

Specifies the workflow jobs that this cmdlet stops. Enter a variable that contains the workflow jobs
or a command that gets the workflow jobs. You can also pipe workflow jobs to the `Suspend-Job`
cmdlet.

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

Specifies friendly names of jobs that this cmdlet suspends. Enter one or more workflow job names.
Wildcard characters are supported.

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

Specifies a job state. This cmdlet stops only jobs in the specified state. The acceptable values for
this parameter are:

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

`Suspend-Job` suspends only workflow jobs in the **Running** state.

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

Indicates that this cmdlet suppresses the command prompt until the workflow job is in the suspended
state. By default, `Suspend-Job` returns immediately, even if the workflow job is not yet in the
suspended state.

The **Wait** parameter is equivalent to piping a `Suspend-Job` command to the `Wait-Job` cmdlet.

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

You can pipe all types of jobs to this cmdlet. However, if `Suspend-Job` gets a job of an
unsupported type, it returns a terminating error.

## OUTPUTS

### System.Management.Automation.Job
This cmdlet returns the jobs that it suspended.

## NOTES

- The mechanism and location for saving a suspended job might vary depending on the job type. For
  example, suspended workflow jobs are saved in a flat file store by default, but can also be saved
  in a database.
- If you submit a workflow job that is not in the Running state, `Suspend-Job` displays a warning
  message. To suppress the warning, use the **WarningAction** common parameter with a value of
  SilentlyContinue.

  If a job is not of a type that supports suspending, `Suspend-Job` returns a terminating error.

- To find the workflow jobs that are suspended, including those that were suspended by this cmdlet,
  use the **State** parameter of the `Get-Job` cmdlet to get workflow jobs in the Suspended state.
- Some job types have options or properties that prevent Windows PowerShell from suspending the job.
  If attempts to suspend the job fail, verify that the job options and properties allow for
  suspending.

## RELATED LINKS

[Get-Job](Get-Job.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)
