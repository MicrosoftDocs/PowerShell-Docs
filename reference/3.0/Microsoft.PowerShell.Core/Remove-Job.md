---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113377
external help file:  System.Management.Automation.dll-Help.xml
title:  Remove-Job
---
# Remove-Job

## SYNOPSIS

Deletes a Windows PowerShell background job.

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

The **Remove-Job** cmdlet deletes Windows PowerShell background jobs that were started by using the Start-Job or the **AsJob** parameter of any cmdlet.

You can use this cmdlet to delete all jobs or delete selected jobs based on their name, ID, instance ID, command, or state, or by passing a job object to **Remove-Job**.
Without parameters or parameter values, **Remove-Job** has no effect.

Beginning in Windows PowerShell 3.0, you can use the **Remove-Job** cmdlet to delete custom job types, such as scheduled jobs and workflow jobs.
If you use **Remove-Job** to delete a scheduled job, it deletes the scheduled job and deletes all instances of the scheduled job on disk, including the results of all triggered job instances.

Before deleting a running job, use the **Stop-Job** cmdlet to stop the job.
If you try to delete a running job, the command fails.
You can use the **Force** parameter of **Remove-Job** to delete a running job.

If you do not delete a background job, the job remains in the global job cache until you close the session in which the job was created.

## EXAMPLES

### Example 1

```
PS> $batch = Get-Job -Name BatchJob
PS> $batch | Remove-Job
```

These commands delete a background job named BatchJob from the current session.
The first command uses the Get-Job cmdlet to get an object representing the job, and then it saves the job in the $batch variable.
The second command uses a pipeline operator (|) to send the job to the Remove-Job cmdlet.

This command is equivalent to using the **Job** parameter of **Remove-Job**, for example, "remove-job -job $batch".

### Example 2

```
PS> Get-job | Remove-Job
```

This command deletes all of the jobs in the current session.

### Example 3

```
PS> Remove-Job -State NotStarted
```

This command deletes all jobs from the current session that have not yet been started.

### Example 4

```
PS> Remove-Job -Name *batch -Force
```

This command deletes all jobs with friendly names that end with "batch" from the current session, including jobs that are running.

It uses the **Name** parameter of **Remove-Job** to specify a job name pattern, and it uses the **Force** parameter to ensure that all jobs are removed, even those that might be in progress.

### Example 5

```
PS> $j = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Process} -AsJob
PS> $j | Remove-Job
```

This example shows how to use the **Remove-Job** cmdlet to remove a job that was started on a remote computer by using the **AsJob** parameter of the Invoke-Command cmdlet.

The first command uses the **Invoke-Command** cmdlet to run a job on the Server01 computer.
It uses the **AsJob** parameter to run the command as a background job, and it saves the resulting job object in the $j variable.

Because the command used the **AsJob** parameter, the job object is created on the local computer, even though the job runs on a remote computer.
As a result, you use local commands to manage the job.

The second command uses the **Remove-Job** cmdlet to remove the job.
It uses a pipeline operator (|) to send the job in $j to **Remove-Job**.
Note that this is a local command.
A remote command is not required to remove a job that was started by using the **AsJob** parameter.

### Example 6

```
The first command uses the New-PSSession cmdlet to create a PSSession (a persistent connection) to the Server01 computer. A persistent connection is required when running a Start-Job command remotely. The command saves the PSSession in the $s variable.
PS> $s = New-PSSession -ComputerName Server01

The second command uses the **Invoke-Command** cmdlet to run a **Start-Job** command in the PSSession in $s. The job runs a **Get-Process** command. It uses the **Name** parameter of **Start-Job** to specify a friendly name for the job.
PS> Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-Process} -Name MyJob}

The third command uses the **Invoke-Command** cmdlet to run a **Remove-Job** command in the PSSession in $s. The command uses the **Name** parameter of Remove-Job to identify the job to be deleted.
PS> Invoke-Command -Session $s -ScriptBlock {Remove-Job -Name MyJob}
```

This example shows how to remove a job that was started by using Invoke-Command to run a Start-Job command.
In this case, the job object is created on the remote computer and you use remote commands to manage the job.

### Example 7

```
The first command uses the Start-Job cmdlet to start a background job. The command saves the resulting job object in the $j variable.
PS> $j = Start-Job -ScriptBlock {Get-Process Powershell}

The second command uses a pipeline operator (|) to send the job object in $j to the Format-List cmdlet. The **Format-List** command uses the **Property** parameter with a value of * (all) to display all of the properties of the job object in a list.The job object display shows the values of the **ID** and **InstanceID** properties, along with the other properties of the object.
PS> $j | Format-List -Property *

HasMoreData   : False
StatusMessage :
Location      : localhost
Command       : get-process powershell
JobStateInfo  : Failed
Finished      : System.Threading.ManualResetEvent
InstanceId    : dce2ee73-f8c9-483e-bdd7-a549d8687eed
Id            : 1
Name          : Job1
ChildJobs     : {Job2}
Output        : {}
Error         : {}
Progress      : {}
Verbose       : {}
Debug         : {}
Warning       : {}
StateChanged  :

The third command uses a **Remove-Job** command to remove the job from the current session. To generate the command, you can copy and paste the **InstanceID** value from the object display.To copy a value in the Windows PowerShell console, use the mouse to select the value, and then press Enter to copy it. To paste a value, right-click.
PS> Remove-Job -InstanceID dce2ee73-f8c9-483e-bdd7-a549d8687eed
```

This example shows how to remove a job based on its instance ID.

## PARAMETERS

### -Command

Deletes jobs that include the specified words in the command.

```yaml
Type: String[]
Parameter Sets: CommandParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter

Deletes jobs that satisfy all of the conditions established in the associated hash table.
Enter a hash table where the keys are job properties and the values are job property values.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs.
It does not work on standard background jobs, such as those created by using the Start-Job cmdlet.
For information about support for this parameter, see the help topic for the job type.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: Hashtable
Parameter Sets: FilterParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Deletes the job even if the status is "Running".
Without the **Force** parameter, **Remove-Job** does not delete running jobs.

```yaml
Type: SwitchParameter
Parameter Sets: SessionIdParameterSet, JobParameterSet, NameParameterSet, InstanceIdParameterSet, FilterParameterSet
Aliases: F

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Deletes background jobs with the specified IDs.

The ID is an integer that uniquely identifies the job within the current session.
It is easier to remember and type than the instance ID, but it is unique only within the current session.
You can type one or more IDs (separated by commas).
To find the ID of a job, type "Get-Job" without parameters.

```yaml
Type: Int32[]
Parameter Sets: SessionIdParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Deletes jobs with the specified instance IDs.

An instance ID is a GUID that uniquely identifies the job on the computer.
To find the instance ID of a job, use Get-Job or display the job object.

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job

Specifies the jobs to be deleted.
Enter a variable that contains the jobs or a command that gets the jobs.
You can also use a pipeline operator to submit jobs to the **Remove-Job** cmdlet.

```yaml
Type: Job[]
Parameter Sets: JobParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Deletes only the jobs with the specified friendly names.
Wildcards are permitted.

Because the friendly name is not guaranteed to be unique, even within the session, use the **WhatIf** and **Confirm** parameters when deleting jobs by name.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State

Deletes only jobs with the specified status.
Valid values are Valid values are NotStarted, Running, Completed, Failed, Stopped, Blocked, Disconnected, Suspending, Stopping, and Suspended.
To delete jobs with a state of Running, use the **Force** parameter.

```yaml
Type: JobState
Parameter Sets: StateParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.Job

You can pipe a job object to Remove-Job.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)

[about_Job_Details](About/about_Job_Details.md)

[about_Remote_Jobs](About/about_Remote_Jobs.md)

[about_Jobs](About/about_Jobs.md)