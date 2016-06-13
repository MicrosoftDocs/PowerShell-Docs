---
external help file: PSITPro3_Core.xml
online version: http://go.microsoft.com/fwlink/?LinkID=113377
schema: 2.0.0
---

# Remove-Job
## SYNOPSIS
Deletes a Windows PowerShell background job.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-Job [-Id] <Int32[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-Job [-Command <String[]>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Remove-Job [-Filter] <Hashtable> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Remove-Job [-InstanceId] <Guid[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Remove-Job [-Job] <Job[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_6
```
Remove-Job [-Name] <String[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_7
```
Remove-Job [-State] <JobState> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-Job cmdlet deletes Windows PowerShell background jobs that were started by using the Start-Job or the AsJob parameter of any cmdlet.

You can use this cmdlet to delete all jobs or delete selected jobs based on their name, ID, instance ID, command, or state, or by passing a job object to Remove-Job.
Without parameters or parameter values, Remove-Job has no effect.

Beginning in Windows PowerShell 3.0, you can use the Remove-Job cmdlet to delete custom job types, such as scheduled jobs and workflow jobs.
If you use Remove-Job to delete a scheduled job, it deletes the scheduled job and deletes all instances of the scheduled job on disk, including the results of all triggered job instances.

Before deleting a running job, use the Stop-Job cmdlet to stop the job.
If you try to delete a running job, the command fails.
You can use the Force parameter of Remove-Job to delete a running job.

If you do not delete a background job, the job remains in the global job cache until you close the session in which the job was created.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$batch = Get-Job -Name BatchJob
PS C:\>$batch | Remove-Job
```

These commands delete a background job named BatchJob from the current session.
The first command uses the Get-Job cmdlet to get an object representing the job, and then it saves the job in the $batch variable.
The second command uses a pipeline operator (|) to send the job to the Remove-Job cmdlet.

This command is equivalent to using the Job parameter of Remove-Job, for example, "remove-job -job $batch".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-job | Remove-Job
```

This command deletes all of the jobs in the current session.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Remove-Job -State NotStarted
```

This command deletes all jobs from the current session that have not yet been started.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Remove-Job -Name *batch -Force
```

This command deletes all jobs with friendly names that end with "batch" from the current session, including jobs that are running.

It uses the Name parameter of Remove-Job to specify a job name pattern, and it uses the Force parameter to ensure that all jobs are removed, even those that might be in progress.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>$j = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Process} -AsJob
PS C:\>$j | Remove-Job
```

This example shows how to use the Remove-Job cmdlet to remove a job that was started on a remote computer by using the AsJob parameter of the Invoke-Command cmdlet.

The first command uses the Invoke-Command cmdlet to run a job on the Server01 computer.
It uses the AsJob parameter to run the command as a background job, and it saves the resulting job object in the $j variable.

Because the command used the AsJob parameter, the job object is created on the local computer, even though the job runs on a remote computer.
As a result, you use local commands to manage the job.

The second command uses the Remove-Job cmdlet to remove the job.
It uses a pipeline operator (|) to send the job in $j to Remove-Job.
Note that this is a local command.
A remote command is not required to remove a job that was started by using the AsJob parameter.

### -------------------------- EXAMPLE 6 --------------------------
```
The first command uses the New-PSSession cmdlet to create a PSSession (a persistent connection) to the Server01 computer. A persistent connection is required when running a Start-Job command remotely. The command saves the PSSession in the $s variable.
PS C:\>$s = New-PSSession -ComputerName Server01

The second command uses the Invoke-Command cmdlet to run a Start-Job command in the PSSession in $s. The job runs a Get-Process command. It uses the Name parameter of Start-Job to specify a friendly name for the job.
PS C:\>Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-Process} -Name MyJob}

The third command uses the Invoke-Command cmdlet to run a Remove-Job command in the PSSession in $s. The command uses the Name parameter of Remove-Job to identify the job to be deleted.
PS C:\>Invoke-Command -Session $s -ScriptBlock {Remove-Job -Name MyJob}
```

This example shows how to remove a job that was started by using Invoke-Command to run a Start-Job command.
In this case, the job object is created on the remote computer and you use remote commands to manage the job.

### -------------------------- EXAMPLE 7 --------------------------
```
The first command uses the Start-Job cmdlet to start a background job. The command saves the resulting job object in the $j variable.
PS C:\>$j = Start-Job -ScriptBlock {Get-Process Powershell}

The second command uses a pipeline operator (|) to send the job object in $j to the Format-List cmdlet. The Format-List command uses the Property parameter with a value of * (all) to display all of the properties of the job object in a list.The job object display shows the values of the ID and InstanceID properties, along with the other properties of the object.
PS C:\>$j | Format-List -Property *

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

The third command uses a Remove-Job command to remove the job from the current session. To generate the command, you can copy and paste the InstanceID value from the object display.To copy a value in the Windows PowerShell console, use the mouse to select the value, and then press Enter to copy it. To paste a value, right-click.
PS C:\>Remove-Job -InstanceID dce2ee73-f8c9-483e-bdd7-a549d8687eed
```

This example shows how to remove a job based on its instance ID.

## PARAMETERS

### -Command
Deletes jobs that include the specified words in the command.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force
Deletes the job even if the status is "Running".
Without the Force parameter, Remove-Job does not delete running jobs.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job
Specifies the jobs to be deleted.
Enter a variable that contains the jobs or a command that gets the jobs.
You can also use a pipeline operator to submit jobs to the Remove-Job cmdlet.

```yaml
Type: Job[]
Parameter Sets: UNNAMED_PARAMETER_SET_5
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Name
Deletes only the jobs with the specified friendly names.
Wildcards are permitted.

Because the friendly name is not guaranteed to be unique, even within the session, use the WhatIf and Confirm parameters when deleting jobs by name.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_6
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
To delete jobs with a state of Running, use the Force parameter.

```yaml
Type: JobState
Parameter Sets: UNNAMED_PARAMETER_SET_7
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.Job
You can pipe a job object to Remove-Job.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Get-Job](1352c534-7193-46ca-9ab1-0c5219a661ad)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[Receive-Job](78fcc10b-5cde-4bf2-a901-33f8237f87fe)

[Resume-Job](3a22c75a-f0bd-4afd-ac3c-da7ccd22ec45)

[Start-Job](2bc04935-0deb-4ec0-b856-d7290cca6442)

[Stop-Job](b998b518-121a-48f4-b062-2b388069de18)

[Suspend-Job](3496f930-2c84-4a90-9c65-ad562f0dc4cf)

[Wait-Job](cb8a2c67-f8a5-45a8-a27f-2ec028c9da8f)

[about_Job_Details](7c86b964-86d2-4bfc-89db-a74f9d926215)

[about_Remote_Jobs](b68c635f-5ee0-44fd-8693-28f8f4ca9fa0)

[about_Jobs]()

