---
external help file: PSITPro4_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289616
schema: 2.0.0
---

# Stop-Job
## SYNOPSIS
Stops a Windows PowerShell background job.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Stop-Job [-Id] <Int32[]> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Stop-Job [-Filter] <Hashtable> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Stop-Job [-InstanceId] <Guid[]> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Stop-Job [-Job] <Job[]> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Stop-Job [-Name] <String[]> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_6
```
Stop-Job [-State] <JobState> [-PassThru] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Stop-Job cmdlet stops Windows PowerShell background jobs that are in progress.
You can use this cmdlet to stop all jobs or stop selected jobs based on their name, ID, instance ID, or state, or by passing a job object to Stop-Job.

You can use Stop-Job to stop background jobs, such as those that were started by using the Start-Job cmdlet or the AsJob parameter of any cmdlet.
When you stop a background job, Windows PowerShell completes all tasks that are pending in that job queue and then ends the job.
No new tasks are added to the queue after this command is submitted.

This cmdlet does not delete background jobs.
To delete a job, use the Remove-Job cmdlet.

Beginning in Windows PowerShell 3.0, Stop-Job also stops custom job types, such as workflow jobs and instances of scheduled jobs.
To enable Stop-Job to stop a job with custom job type, import the module that supports the custom job type into the session before running a Stop-Job command, either by using the Import-Module cmdlet or by using or getting a cmdlet in the module.
For information about a particular custom job type, see the documentation of the custom job type feature.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$s = New-PSSession -ComputerName Server01 -Credential Domain01\Admin02
PS C:\>$j = Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-EventLog System}}
PS C:\>Invoke-Command -Session $s -ScriptBlock { Stop-job -Job $Using:j }
```

This example shows how to use the Stop-Job cmdlet to stop a job that is running on a remote computer.

Because the job was started by using the Invoke-Command cmdlet to run a Start-Job command remotely, the job object is stored on the remote computer, and you must use another Invoke-Command command to run a Stop-Job command remotely.
For more information about remote background jobs, see about_Remote_Jobs.

The first command creates a Windows PowerShell session (PSSession) on the Server01 computer and saves the session object in the $s variable.
The command uses the credentials of a domain administrator.

The second command uses the Invoke-Command cmdlet to run a Start-Job command in the session.
The command in the job gets all of the events in the System event log.
The resulting job object is stored in the $j variable.

The third command stops the job.
It uses the Invoke-Command cmdlet to run a Stop-Job command in the PSSession on Server01.
Because the job objects are stored in $j, which is a variable on the local computer, the command uses the Using scope modifier to identify $j as a local variable.
For more information about the Using scope modifier, see about_Remote_Variables (http://go.microsoft.com/fwlink/?LinkID=252653).

When the command completes, the job is stopped and the PSSession in $s is available for use.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Stop-Job -Name Job1
```

This command stops the Job1 background job.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Stop-Job -ID 1, 3, 4
```

This command stops three jobs.
It identifies them by their IDs.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Get-Job | Stop-Job
```

This command stops all of the background jobs in the current session.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>Stop-Job -State Blocked
```

This command stops all the jobs that are blocked.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>Get-Job | Format-Table ID, Name, Command, @{Label="State";Expression={$_.JobStateInfo.State}},
InstanceID -Auto

Id Name Command                 State  InstanceId
-- ---- -------                 -----  ----------
1 Job1 start-service schedule Running 05abb67a-2932-4bd5-b331-c0254b8d9146
3 Job3 start-service schedule Running c03cbd45-19f3-4558-ba94-ebe41b68ad03
5 Job5 get-service s*         Blocked e3bbfed1-9c53-401a-a2c3-a8db34336adf

PS C:\>Stop-Job -InstanceId e3bbfed1-9c53-401a-a2c3-a8db34336adf
```

These commands show how to stop a job based on its instance ID.

The first command uses the Get-Job cmdlet to get the jobs in the current session.
The command uses a pipeline operator (|) to send the jobs to a Format-Table command, which displays a table of the specified properties of each job.
The table includes the Instance ID of each job.
It uses a calculated property to display the job state.

The second command uses a Stop-Job command with the InstanceID parameter to stop a selected job.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>$j = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-EventLog System} -AsJob
PS C:\>$j | Stop-Job -PassThru

Id    Name    State      HasMoreData     Location         Command
--    ----    ----      -----------     --------          -------
5     Job5    Stopped    True            user01-tablet   get-eventlog system
```

This example shows how to use the Stop-Job cmdlet to stop a job that is running on a remote computer.

Because the job was started by using the AsJob parameter of the Invoke-Command cmdlet, the job object is located on the local computer, even though the job runs on the remote computer.
As such, you can use a local Stop-Job command to stop the job.

The first command uses the Invoke-Command cmdlet to start a background job on the Server01 computer.
The command uses the AsJob parameter to run the remote command as a background job.

This command returns a job object, which is the same job object that the Start-Job cmdlet returns.
The command saves the job object in the $j variable.

The second command uses a pipeline operator to send the job in the $j variable to Stop-Job.
The command uses the PassThru parameter to direct Stop-Job to return a job object.
The job object display confirms that the State of the job is "Stopped".

For more information about remote background jobs, see about_Remote_Jobs.

## PARAMETERS

### -Filter
Stops jobs that satisfy all of the conditions established in the associated hash table.
Enter a hash table where the keys are job properties and the values are job property values.

This parameter works only on custom job types, such as workflow jobs and scheduled jobs.
It does not work on standard background jobs, such as those created by using the Start-Job cmdlet.
For information about support for this parameter, see the help topic for the job type.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: Hashtable
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: Non
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Stops jobs with the specified IDs.
The default is all jobs in the current session.

The ID is an integer that uniquely identifies the job within the current session.
It is easier to remember and type than the InstanceId, but it is unique only within the current session.
You can type one or more IDs (separated by commas).
To find the ID of a job, type "Get-Job" without parameters.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: All jobs
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId
Stops only jobs with the specified instance IDs.
The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer.
To find the instance ID of a job, use Get-Job.

```yaml
Type: Guid[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: All jobs
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job
Specifies the jobs to be stopped.
Enter a variable that contains the jobs or a command that gets the jobs.
You can also use a pipeline operator to submit jobs to the Stop-Job cmdlet.
By default, Stop-Job deletes all jobs that were started in the current session.

```yaml
Type: Job[]
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: 1
Default value: All jobs
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Name
Stops only the jobs with the specified friendly names.
Enter the job names in a comma-separated list or use wildcard characters (*) to enter a job name pattern.
By default, Stop-Job stops all jobs created in the current session.

Because the friendly name is not guaranteed to be unique, use the WhatIf and Confirm parameters when stopping jobs by name.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_5
Aliases: 

Required: True
Position: 1
Default value: All jobs
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the new background job.
By default, this cmdlet does not generate any output.

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

### -State
Stops only jobs in the specified state.
Valid values are NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping.

For more information about job states, see "JobState Enumeration" in MSDN at http://msdn.microsoft.com/library/windows/desktop/system.management.automation.jobstate(v=vs.85).aspxhttp://msdn.microsoft.com/library/windows/desktop/system.management.automation.jobstate(v=vs.85).aspx

```yaml
Type: JobState
Parameter Sets: UNNAMED_PARAMETER_SET_6
Aliases: 

Required: True
Position: 1
Default value: All jobs
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

### System.Management.Automation.RemotingJob
You can pipe a job object to Stop-Job.

## OUTPUTS

### None or System.Management.Automation.PSRemotingJob
When you use the PassThru parameter, Stop-Job returns a job object.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Get-Job](1352c534-7193-46ca-9ab1-0c5219a661ad)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[Receive-Job](78fcc10b-5cde-4bf2-a901-33f8237f87fe)

[Remove-Job](eaa911ae-3a84-4279-a9db-fead1dfdb8bb)

[Resume-Job](3a22c75a-f0bd-4afd-ac3c-da7ccd22ec45)

[Start-Job](2bc04935-0deb-4ec0-b856-d7290cca6442)

[Stop-Job](b998b518-121a-48f4-b062-2b388069de18)

[Suspend-Job](3496f930-2c84-4a90-9c65-ad562f0dc4cf)

[Wait-Job](cb8a2c67-f8a5-45a8-a27f-2ec028c9da8f)

[about_Job_Details](7c86b964-86d2-4bfc-89db-a74f9d926215)

[about_Remote_Jobs](b68c635f-5ee0-44fd-8693-28f8f4ca9fa0)

[about_Remote_Variables](a31e2e7f-7c66-492c-86ef-d588912feb7d)

[about_Jobs]()

[about_Scopes](807a5b29-3f02-4b97-8eed-854869936017)

