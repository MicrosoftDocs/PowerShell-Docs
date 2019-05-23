---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821509
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

The **Remove-Job** cmdlet deletes PowerShell background jobs.
You can start jobs by using the Start-Job or the *AsJob* parameter of any cmdlet.

You can use this cmdlet to delete all jobs or delete jobs based on their name, ID, instance ID, command, or state, or by passing a job object to **Remove-Job**.
Without parameters or parameter values, **Remove-Job** has no effect.

Starting in Windows PowerShell 3.0, you can use the **Remove-Job** cmdlet to delete custom job types, such as scheduled jobs and workflow jobs.
If you use **Remove-Job** to delete a scheduled job, it deletes the scheduled job and deletes all instances of the scheduled job on disk.
This includes the results of all triggered job instances.

Before deleting a running job, use the Stop-Job cmdlet to stop the job.
If you try to delete a running job, the command fails.
You can use the *Force* parameter of **Remove-Job** to delete a running job.

If you do not delete a background job, the job remains in the global job cache until you close the session in which the job was created.

## EXAMPLES

### Example 1: Delete a job by using its name

```powershell
$batch = Get-Job -Name "BatchJob"
$batch | Remove-Job
```

This example deletes a background job named BatchJob from the current session.
The first command uses the **Get-Job** cmdlet to get an object that represents the job, and then it saves the job in the $batch variable.

The second command uses a pipeline operator (|) to send the job to the Remove-Job cmdlet.

This command is equivalent to using the *Job* parameter of **Remove-Job**, for example, `Remove-Job -Job $batch`.

### Example 2: Delete all jobs in a session

```powershell
Get-Job | Remove-Job
```

This command deletes all of the jobs in the current session.

### Example 3: Delete NotStarted jobs

```powershell
Remove-Job -State NotStarted
```

This command deletes all jobs from the current session that have not yet been started.

### Example 4: Delete jobs by using a friendly name

```powershell
Remove-Job -Name *batch -Force
```

This command deletes all jobs that have friendly names that end with batch from the current session.
These include jobs that are running.

The command uses the *Name* parameter of **Remove-Job** to specify a job name pattern, and it uses the *Force* parameter to make sure that all jobs are removed, even those that might be in progress.

### Example 5: Delete a job that was created by Invoke-Command

```powershell
$j = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Process} -AsJob
$j | Remove-Job
```

This example shows how to use the **Remove-Job** cmdlet to remove a job that was started on a remote computer by using the *AsJob* parameter of the Invoke-Command cmdlet.

The first command uses the **Invoke-Command** cmdlet to run a job on the Server01 computer.
It uses the *AsJob* parameter to run the command as a background job, and it saves the resulting job object in the $j variable.

Because the command used the *AsJob* parameter, the job object is created on the local computer, even though the job runs on a remote computer.
As a result, you use local commands to manage the job.

The second command uses the **Remove-Job** cmdlet to remove the job.
It uses a pipeline operator (|) to send the job in $j to **Remove-Job**.
This is a local command.
A remote command is not required to remove a job that was started by using the *AsJob* parameter.

### Example 6: Delete a job that was created by Invoke-Command and Start-Job

```powershell
$s = New-PSSession -ComputerName Server01
Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-Process} -Name MyJob}
Invoke-Command -Session $s -ScriptBlock {Remove-Job -Name MyJob}
```

The first command uses the New-PSSession cmdlet to create a **PSSession**, which is a persistent
connection, to the Server01 computer. A persistent connection is required when you run **Start-Job**
remotely. The command stores the **PSSession** in the $s variable.

The second command uses the **Invoke-Command** cmdlet to run a **Start-Job** command in the
**PSSession** in $s. The job runs a **Get-Process** command. It uses the *Name* parameter of
**Start-Job** to specify a friendly name for the job.

The third command uses the **Invoke-Command** cmdlet to run a **Remove-Job** command in the
**PSSession** in $s. The command uses the *Name* parameter to identify the job to delete.

### Example 7: Delete a job by using its instance ID

This example shows how to remove a job based on its instance ID.

```powershell
$j = Start-Job -ScriptBlock {Get-Process Powershell}
$j | Format-List -Property *
```

```Output
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
```

```powershell
Remove-Job -InstanceID dce2ee73-f8c9-483e-bdd7-a549d8687eed
```

The first command uses **Start-Job** to start a background job. The command saves the resulting job object in the $j variable.
The second command uses a pipeline operator (|) to send the job object in $j to the Format-List cmdlet. The **Format-List** command uses the *Property* parameter with a value of * (all) to display all of the properties of the job object in a list.The job object display shows the values of the **ID** and **InstanceID** properties, together with the other properties of the object.

The third command uses a **Remove-Job** command to remove the job from the current session. To generate the command, you can copy and paste the *InstanceID* value from the object display.To copy a value in the PowerShell console, use the mouse to select the value, and then press Enter to copy it. To paste a value, right-click.

## PARAMETERS

### -Command

Specifies an array of words that appear in commands.
This cmdlet deletes jobs that include the specified words.

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

Specifies a hash table of conditions.
This cmdlet deletes jobs that satisfy all of the conditions.
Enter a hash table where the keys are job properties and the values are job property values.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs.
It does not work on standard background jobs, such as those created by using the **Start-Job** cmdlet.
For information about support for this parameter, see the help topic for the job type.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Hashtable
Parameter Sets: FilterParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet deletes a job even if the status is Running.
By default, this cmdlet does not delete running jobs.

```yaml
Type: SwitchParameter
Parameter Sets: SessionIdParameterSet, JobParameterSet, NameParameterSet, InstanceIdParameterSet, FilterParameterSet
Aliases: F

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies an array of IDs of background jobs that this cmdlet deletes.

The ID is an integer that uniquely identifies the job in the current session.
It is easier to remember and type than the instance ID, but it is unique only in the current session.
You can type one or more IDs, separated by commas.
To find the ID of a job, type `Get-Job`.

```yaml
Type: Int32[]
Parameter Sets: SessionIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies an array of instance IDs of jobs that this cmdlet deletes.

An instance ID is a GUID that uniquely identifies the job on the computer.
To find the instance ID of a job, use the **Get-Job** cmdlet or display the job object.

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job

Specifies the jobs to be deleted.
Enter a variable that contains the jobs or a command that gets the jobs.
You can also use a pipeline operator to submit jobs to this cmdlet.

```yaml
Type: Job[]
Parameter Sets: JobParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Specifies an array of friendly names of jobs that this cmdlet deletes.
Wildcard characters are permitted.

Because the friendly name is not guaranteed to be unique, even in the session, use the *WhatIf* and *Confirm* parameters when you delete jobs by name.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State

Specifies the state of jobs to delete.
The acceptable values for this parameter are:

- NotStarted
- Running
- Completed
- Failed
- Stopped
- Blocked
- Disconnected
- Suspending
- Stopping
- Suspended

To delete jobs with a state of Running, use the *Force* parameter.

```yaml
Type: JobState
Parameter Sets: StateParameterSet
Aliases:
Accepted values: NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping, AtBreakpoint

Required: True
Position: 0
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Job

You can pipe a job object to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Wait-Job](Wait-Job.md)
