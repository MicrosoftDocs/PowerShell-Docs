---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113413
external help file:  System.Management.Automation.dll-Help.xml
title:  Stop-Job
---

# Stop-Job
## SYNOPSIS
Stops a Windows PowerShell background job.
## SYNTAX

### SessionIdParameterSet (Default)
```
Stop-Job [-PassThru] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### JobParameterSet
```
Stop-Job [-Job] <Job[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameParameterSet
```
Stop-Job [-PassThru] [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdParameterSet
```
Stop-Job [-PassThru] [-InstanceId] <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StateParameterSet
```
Stop-Job [-PassThru] [-State] <JobState> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FilterParameterSet
```
Stop-Job [-PassThru] [-Filter] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Stop-Job** cmdlet stops Windows PowerShell background jobs that are in progress.
You can use this cmdlet to stop all jobs or stop selected jobs based on their name, ID, instance ID, or state, or by passing a job object to Stop-Job.

You can use **Stop-Job** to stop background jobs, such as those that were started by using the Start-Job cmdlet or the **AsJob** parameter of any cmdlet.
When you stop a background job, Windows PowerShell completes all tasks that are pending in that job queue and then ends the job.
No new tasks are added to the queue after this command is submitted.

This cmdlet does not delete background jobs.
To delete a job, use the Remove-Job cmdlet.

Beginning in Windows PowerShell 3.0, **Stop-Job** also stops custom job types, such as workflow jobs and instances of scheduled jobs.
To enable **Stop-Job** to stop a job with custom job type, import the module that supports the custom job type into the session before running a **Stop-Job** command, either by using the Import-Module cmdlet or by using or getting a cmdlet in the module.
For information about a particular custom job type, see the documentation of the custom job type feature.
## EXAMPLES

### Example 1
```
PS C:\> $s = New-PSSession -ComputerName Server01 -Credential Domain01\Admin02
PS C:\> $j = Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-EventLog System}}
PS C:\> Invoke-Command -Session $s -ScriptBlock { Stop-job -Job $Using:j }
```

This example shows how to use the **Stop-Job** cmdlet to stop a job that is running on a remote computer.

Because the job was started by using the Invoke-Command cmdlet to run a **Start-Job** command remotely, the job object is stored on the remote computer, and you must use another **Invoke-Command** command to run a **Stop-Job** command remotely.
For more information about remote background jobs, see [about_Remote_Jobs](./About/about_Remote_Jobs.md).

The first command creates a Windows PowerShell session (PSSession) on the Server01 computer and saves the session object in the $s variable.
The command uses the credentials of a domain administrator.

The second command uses the **Invoke-Command** cmdlet to run a **Start-Job** command in the session.
The command in the job gets all of the events in the System event log.
The resulting job object is stored in the $j variable.

The third command stops the job.
It uses the **Invoke-Command** cmdlet to run a **Stop-Job** command in the PSSession on Server01.
Because the job objects are stored in $j, which is a variable on the local computer, the command uses the Using scope modifier to identify $j as a local variable.
For more information about the Using scope modifier, see [about_Remote_Variables](./About/about_Remote_Variables.md).

When the command completes, the job is stopped and the PSSession in $s is available for use.
### Example 2
```
PS C:\> Stop-Job -Name Job1
```

This command stops the Job1 background job.
### Example 3
```
PS C:\> Stop-Job -ID 1, 3, 4
```

This command stops three jobs.
It identifies them by their IDs.
### Example 4
```
PS C:\> Get-Job | Stop-Job
```

This command stops all of the background jobs in the current session.
### Example 5
```
PS C:\> Stop-Job -State Blocked
```

This command stops all the jobs that are blocked.
### Example 6
```
PS C:\> Get-Job | Format-Table ID, Name, Command, @{Label="State";Expression={$_.JobStateInfo.State}},
InstanceID -Auto

Id Name Command                 State  InstanceId
-- ---- -------                 -----  ----------
1 Job1 start-service schedule Running 05abb67a-2932-4bd5-b331-c0254b8d9146
3 Job3 start-service schedule Running c03cbd45-19f3-4558-ba94-ebe41b68ad03
5 Job5 get-service s*         Blocked e3bbfed1-9c53-401a-a2c3-a8db34336adf

PS C:\> Stop-Job -InstanceId e3bbfed1-9c53-401a-a2c3-a8db34336adf
```

These commands show how to stop a job based on its instance ID.

The first command uses the Get-Job cmdlet to get the jobs in the current session.
The command uses a pipeline operator (|) to send the jobs to a Format-Table command, which displays a table of the specified properties of each job.
The table includes the Instance ID of each job.
It uses a calculated property to display the job state.

The second command uses a **Stop-Job** command with the **InstanceID** parameter to stop a selected job.
### Example 7
```
PS C:\> $j = Invoke-Command -ComputerName Server01 -ScriptBlock {Get-EventLog System} -AsJob
PS C:\> $j | Stop-Job -PassThru

Id    Name    State      HasMoreData     Location         Command
--    ----    ----      -----------     --------          -------
5     Job5    Stopped    True            user01-tablet   get-eventlog system
```

This example shows how to use the **Stop-Job** cmdlet to stop a job that is running on a remote computer.

Because the job was started by using the **AsJob** parameter of the Invoke-Command cmdlet, the job object is located on the local computer, even though the job runs on the remote computer.
As such, you can use a local **Stop-Job** command to stop the job.

The first command uses the **Invoke-Command** cmdlet to start a background job on the Server01 computer.
The command uses the **AsJob** parameter to run the remote command as a background job.

This command returns a job object, which is the same job object that the Start-Job cmdlet returns.
The command saves the job object in the $j variable.

The second command uses a pipeline operator to send the job in the $j variable to Stop-Job.
The command uses the **PassThru** parameter to direct **Stop-Job** to return a job object.
The job object display confirms that the State of the job is "Stopped".

For more information about remote background jobs, see [about_Remote_Jobs](./About/about_Remote_Jobs.md).
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
Parameter Sets: FilterParameterSet
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
Parameter Sets: SessionIdParameterSet
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
Parameter Sets: InstanceIdParameterSet
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
Parameter Sets: JobParameterSet
Aliases:

Required: True
Position: 1
Default value: All jobs
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Stops only the jobs with the specified friendly names.
Enter the job names in a comma-separated list or use wildcard characters (*) to enter a job name pattern.
By default, Stop-Job stops all jobs created in the current session.

Because the friendly name is not guaranteed to be unique, use the WhatIf and Confirm parameters when stopping jobs by name.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
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

For more information about job states, see [JobState Enumeration](/dotnet/api/system.management.automation.jobstate) in the MSDN library.

```yaml
Type: JobState
Parameter Sets: StateParameterSet
Aliases:

Required: True
Position: 1
Default value: All jobs
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

### System.Management.Automation.RemotingJob
You can pipe a job object to Stop-Job.
## OUTPUTS

### None or System.Management.Automation.PSRemotingJob
When you use the PassThru parameter, Stop-Job returns a job object.
Otherwise, this cmdlet does not generate any output.
## NOTES

## RELATED LINKS

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)

[about_Job_Details](About/about_Job_Details.md)

[about_Remote_Jobs](About/about_Remote_Jobs.md)

[about_Remote_Variables](About/about_Remote_Variables.md)

[about_Jobs](About/about_Jobs.md)

[about_Scopes](About/about_scopes.md)