---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 07/26/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/remove-job?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Job
---

# Remove-Job

## SYNOPSIS
Deletes a PowerShell background job.

## SYNTAX

### SessionIdParameterSet (Default)

```
Remove-Job [-Force] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### JobParameterSet

```
Remove-Job [-Job] <Job[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameParameterSet

```
Remove-Job [-Force] [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdParameterSet

```
Remove-Job [-Force] [-InstanceId] <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FilterParameterSet

```
Remove-Job [-Force] [-Filter] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StateParameterSet

```
Remove-Job [-State] <JobState> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CommandParameterSet

```
Remove-Job [-Command <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Job` cmdlet deletes PowerShell background jobs that were started by the `Start-Job`
cmdlet or by cmdlets such as `Invoke-Command` that support the **AsJob** parameter.

You can use `Remove-Job` to delete all jobs or delete selected jobs. The jobs are identified by
their **Name**, **ID**, **Instance ID**, **Command**, or **State**. Or, a job object can be sent
down the pipeline to `Remove-Job`. Without parameters or parameter values, `Remove-Job` has no
effect.

Since PowerShell 3.0, `Remove-Job` can delete custom job types, such as scheduled jobs and workflow
jobs. For example, `Remove-Job` deletes the scheduled job, all instances of the scheduled job on
disk, and the results of all triggered job instances.

If you try to delete a running job, `Remove-Job` fails. Use the `Stop-Job` cmdlet to stop a running
job. Or, use `Remove-Job` with the **Force** parameter to delete a running job.

Jobs remain in the global job cache until you delete the background job or close the PowerShell
session.

## EXAMPLES

### Example 1: Delete a job by using its name

This example uses a variable and the pipeline to delete a job by name.

```powershell
$batch = Get-Job -Name BatchJob
$batch | Remove-Job
```

`Get-Job` uses the **Name** parameter to specify the job, **BatchJob**. The job object is stored in
the `$batch` variable. The object in `$batch` is sent down the pipeline to `Remove-Job`.

An alternative is to use the **Job** parameter, such as `Remove-Job -Job $batch`.

### Example 2: Delete all jobs in a session

In this example, all the jobs in the current PowerShell session are deleted.

```powershell
Get-job | Remove-Job
```

`Get-Job` gets all the jobs in the current PowerShell session. The job objects are sent down the
pipeline to `Remove-Job`.

### Example 3: Delete NotStarted jobs

This example deletes all jobs from the current PowerShell session that haven't started.

```powershell
Remove-Job -State NotStarted
```

`Remove-Job` uses the **State** parameter to specify the job status.

### Example 4: Delete jobs by using a friendly name

This example deletes all jobs from the current session with friendly names that end with *batch**,
including jobs that are running.

```powershell
Remove-Job -Name *batch -Force
```

`Remove-Job` uses the **Name** parameter to specify a job name pattern. The pattern includes the
asterisk (`*`) wildcard to find all job names that end with **batch**. The **Force** parameter
deletes jobs that running.

### Example 5: Delete a job that was created by Invoke-Command

This example removes a job that was started on a remote computer using `Invoke-Command` with the
**AsJob** parameter.

Because the example uses the **AsJob** parameter, the job object is created on the local computer.
But, the job runs on a remote computer. As a result, you use local commands to manage the job.

```powershell
$job = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Process} -AsJob
$job | Remove-Job
```

`Invoke-Command` runs a job on the **Server01** computer. The **AsJob** parameter runs the
**ScriptBlock** as a background job. The job object is stored in the `$job` variable. The `$job`
variable object is sent down the pipeline to `Remove-Job`.

### Example 6: Delete a job that was created by Invoke-Command and Start-Job

This example shows how to remove a job on a remote computer that was started by using
`Invoke-Command` to run `Start-Job`. The job object is created on the remote computer and remote
commands are used to manage the job. A persistent connection is required when running a remote
`Start-Job` command.

```powershell
$S = New-PSSession -ComputerName Server01
Invoke-Command -Session $S -ScriptBlock {Start-Job -ScriptBlock {Get-Process} -Name MyJob}
Invoke-Command -Session $S -ScriptBlock {Remove-Job -Name MyJob}
```

`New-PSSession` creates a **PSSession**, a persistent connection, to the **Server01** computer. The
connection is saved in the `$S` variable.

`Invoke-Command` connects to the session saved in `$S`. The **ScriptBlock** uses `Start-Job` to
start a remote job. The job runs a `Get-Process` command and uses the **Name** parameter to specify
a friendly job name, **MyJob**.

`Invoke-Command` uses the `$S` session and runs `Remove-Job`. The **Name** parameter specifies that
the job named **MyJob** is deleted.

### Example 7: Delete a job by using its InstanceId

This example removes a job based on its **InstanceId**.

```powershell
$job = Start-Job -ScriptBlock {Get-Process PowerShell}
$job | Format-List -Property *
Remove-Job -InstanceId ad02b942-8007-4407-87f3-d23e71955872
```

```Output
State         : Completed
HasMoreData   : True
StatusMessage :
Location      : localhost
Command       : Get-Process PowerShell
JobStateInfo  : Completed
Finished      : System.Threading.ManualResetEvent
InstanceId    : ad02b942-8007-4407-87f3-d23e71955872
Id            : 3
Name          : Job3
ChildJobs     : {Job4}
PSBeginTime   : 7/26/2019 11:36:56
PSEndTime     : 7/26/2019 11:36:57
PSJobTypeName : BackgroundJob
Output        : {}
Error         : {}
Progress      : {}
Verbose       : {}
Debug         : {}
Warning       : {}
Information   : {}
```

`Start-Job` starts a background job and the job object is saved in the `$job` variable.

The object in `$job` is sent down the pipeline to `Format-List`. The **Property** parameter uses an
asterisk (`*`) to specify that all the object's properties are displayed in a list.

`Remove-Job` uses the **InstanceId** parameter to specify the job to delete.

## PARAMETERS

### -Command

Deletes jobs that include the specified words in the command. You can enter a comma-separated array.

```yaml
Type: System.String[]
Parameter Sets: CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before `Remove-Job` is run.

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

### -Filter

Deletes jobs that satisfy all the conditions established in the associated hash table. Enter a hash
table where the keys are job properties and the values are job property values.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs. It doesn't
work on standard background jobs, such as those created by using the `Start-Job`.

This parameter is introduced in PowerShell 3.0.

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

Deletes a job even if the job's state is **Running**. If the **Force** parameter isn't specified,
`Remove-Job` doesn't delete running jobs.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: SessionIdParameterSet, JobParameterSet, InstanceIdParameterSet, NameParameterSet, FilterParameterSet
Aliases: F

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Deletes background jobs with the specified **Id**. You can enter a comma-separated array. The job's
**Id** is a unique integer that identifies a job within the current session.

To find a job's **Id**, use `Get-Job` without parameters.

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

Deletes jobs with the specified **InstanceId**. You can enter a comma-separated array. An
**InstanceId** is a unique GUID that identifies a job.

To find a job's **InstanceId**, use `Get-Job`.

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

Specifies the jobs to be deleted. Enter a variable that contains the jobs or a command that gets the
jobs. You can enter a comma-separated array.

You can send job objects down the pipeline to `Remove-Job`.

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

Only deletes jobs with the specified friendly name. Wildcards are permitted. You can enter a
comma-separated array.

Friendly names for jobs aren't guaranteed to be unique, even within a PowerShell session. Use the
**WhatIf** and **Confirm** parameters when you delete files by name.

```yaml
Type: System.String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -State

Only deletes jobs with the specified state. To delete jobs with a state of **Running**, use the
**Force** parameter.

Accepted values:

- AtBreakpoint
- Blocked
- Completed
- Disconnected
- Failed
- NotStarted
- Running
- Stopped
- Stopping
- Suspended
- Suspending

```yaml
Type: System.Management.Automation.JobState
Parameter Sets: StateParameterSet
Aliases:
Accepted values: AtBreakpoint, Blocked, Completed, Disconnected, Failed, NotStarted, Running, Stopped, Stopping, Suspended, Suspending

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if `Remove-Job` runs. The cmdlet isn't run.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Job

You can send a job object down the pipeline to `Remove-Job`.

## OUTPUTS

### None

`Remove-Job` doesn't generate any output.

## NOTES

A PowerShell job creates a new process. When the job completes, the process exits. When `Remove-Job`
is run, the job's state is removed.

If a job stops before completion and its process hasn't exited, the process is forcibly terminated.

## RELATED LINKS

[about_Jobs](./About/about_Jobs.md)

[about_Job_Details](./About/about_Job_Details.md)

[about_Remote_Jobs](./About/about_Remote_Jobs.md)

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Wait-Job](Wait-Job.md)

