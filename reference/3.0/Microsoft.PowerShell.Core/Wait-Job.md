---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113422
external help file:  System.Management.Automation.dll-Help.xml
title:  Wait-Job
---

# Wait-Job
## SYNOPSIS
Suppresses the command prompt until one or all of the Windows PowerShell background jobs running in the session are complete.
## SYNTAX

### SessionIdParameterSet (Default)
```
Wait-Job [-Any] [-Timeout <Int32>] [-Force] [-Id] <Int32[]> [<CommonParameters>]
```

### JobParameterSet
```
Wait-Job [-Job] <Job[]> [-Any] [-Timeout <Int32>] [-Force] [<CommonParameters>]
```

### NameParameterSet
```
Wait-Job [-Any] [-Timeout <Int32>] [-Force] [-Name] <String[]> [<CommonParameters>]
```

### InstanceIdParameterSet
```
Wait-Job [-Any] [-Timeout <Int32>] [-Force] [-InstanceId] <Guid[]> [<CommonParameters>]
```

### StateParameterSet
```
Wait-Job [-Any] [-Timeout <Int32>] [-Force] [-State] <JobState> [<CommonParameters>]
```

### FilterParameterSet
```
Wait-Job [-Any] [-Timeout <Int32>] [-Force] [-Filter] <Hashtable> [<CommonParameters>]
```

## DESCRIPTION
The **Wait-Job** cmdlet waits for Windows PowerShell background jobs to complete before it displays the command prompt.
You can wait until any background job is complete, or until all background jobs are complete, and you can set a maximum wait time for the job.

When the commands in the job are complete, **Wait-Job** displays the command prompt and returns a job object so that you can pipe it to another command.

You can use **Wait-Job** cmdlet to wait for background jobs, such as those that were started by using the Start-Job cmdlet or the **AsJob** parameter of the Invoke-Command cmdlet.
For more information about Windows PowerShell background jobs, see [about_Jobs](./About/about_Jobs.md).

Beginning in Windows PowerShell 3.0, the **Wait-Job** cmdlet also waits for custom job types, such as workflow jobs and instances of scheduled jobs.
To enable **Wait-Job** to wait for jobs of a particular type, import the module that supports the custom job type into the session before running a **Get-Job** command, either by using the Import-Module cmdlet or by using or getting a cmdlet in the module.
For information about a particular custom job type, see the documentation of the custom job type feature.
## EXAMPLES

### Example 1
```
PS C:\> Get-Job | Wait-Job
```

This command waits for all of the background jobs running in the session to complete.
### Example 2
```
PS C:\> $s = New-PSSession Server01, Server02, Server03
PS C:\> Invoke-Command -Session $s -ScriptBlock {Start-Job -Name Date1 -ScriptBlock {Get-Date}}
PS C:\> $done = Invoke-Command -Session $s -Command {Wait-Job -Name Date1}
PS C:\> $done.Count
3
```

This example shows how to use the Wait-Job cmdlet with jobs started on remote computers by using the Start-Job cmdlet.
Both the Start-Job and Wait-Job commands are submitted to the remote computer by using the Invoke-Command cmdlet.

This example uses Wait-Job to determine whether a Get-Date command running as a background job on three different computers is complete.

The first command creates a Windows PowerShell session (PSSession) on each of the three remote computers and stores them in the $s variable.

The second command uses the Invoke-Command cmdlet to run a Start-Job command in each of the three sessions in $s.
All of the jobs are named Date1.

The third command uses the Invoke-Command cmdlet to run a Wait-Job command.
This command waits for the Date1 jobs on each computer to complete.
It stores the resulting collection (array) of job objects in the $done variable.

The fourth command uses the Count property of the array of job objects in the $done variable to determine how many of the jobs are complete.
### Example 3
```
PS C:\> $s = New-PSSession (Get-Content Machines.txt)
PS C:\> $c = 'Get-EventLog -LogName System | where {$_.EntryType -eq "error" --and $_.Source -eq "LSASRV"} | Out-File Errors.txt'
PS C:\> Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {$Using:c}
PS C:\> Invoke-Command -Session $s -ScriptBlock {Wait-Job -Any}
```

This example uses the **Any** parameter of **Wait-Job** to determine when the first of many background jobs running in the current session are complete.
It also shows how to use the **Wait-Job** cmdlet to wait for remote jobs to complete.

The first command creates a PSSession on each of the computers listed in the Machines.txt file and stores the PSSessions in the $s variable.
The command uses the Get-Content cmdlet to get the contents of the file.
The **Get-Content** command is enclosed in parentheses to ensure that it runs before the New-PSSession command.

The second command stores a **Get-EventLog** command string (in quotation marks) in the $c variable.

The third command uses the Invoke-Command cmdlet to run a **Start-Job** command in each of the sessions in $s.
The **Start-Job** command starts a background job that runs the **Get-EventLog** command in the $c variable.

The command uses the **Using** scope modifier to indicate that the $c variable was defined on the local computer.
The **Using** scope modifier is introduced in Windows PowerShell 3.0.
For more information about the **Using** scope modifier, see [about_Remote_Variables](./About/about_Remote_Variables.md).

The fourth command uses the **Invoke-Command** cmdlet to run a **Wait-Job** command in the sessions.
It uses the **Any** parameter to wait until the first job on the remote computers is complete.
### Example 4
```
PS C:\> $s = New-PSSession Server01, Server02, Server03
PS C:\> $jobs = Invoke-Command -Session $s -ScriptBlock {Start-Job -ScriptBlock {Get-Date}}
PS C:\> $done = Invoke-Command -Session $s -ScriptBlock {Wait-Job -Timeout 30}
```

This example shows how to use the Timeout parameter of Wait-Job to set a maximum wait time for the jobs running on remote computers.

The first command creates a PSSession on each of three remote computers (Server01, Server02, and Server03), and it saves the PSSessions in the $s variable.

The second command uses the Invoke-Command cmdlet to run a Start-Job command in each of the PSSessions in $s.
It saves the resulting job objects in the $jobs variable.

The third command uses the Invoke-Command cmdlet to run a Wait-Job command in each of the PSSessions in $s.
The Wait-Job command determines whether all of the commands have completed within 30 seconds.
It uses the Timeout parameter with a value of 30 (seconds) to establish the maximum wait time and saves the results of the command in the $done variable.

In this case, after 30 seconds, only the command on the Server02 computer has completed.
Wait-Job ends the wait, displays the command prompt, and returns the object that represents the job that was completed.

The $done variable contains a job object that represents the job that ran on Server02.
### Example 5
```
PS C:\> Wait-Job -id 1,2,5 -Any
```

This command identifies three jobs by their IDs and waits until any of them are complete.
The command prompt returns when the first job completes.
### Example 6
```
PS C:\> Wait-Job -Name DailyLog -Timeout 120
```

This command waits 120 seconds (two minutes) for the DailyLog job to complete.
If the job does not complete in the next two minutes, the command prompt returns anyway, and the job continues to run in the background.
### Example 7
```
PS C:\> Wait-Job -Name Job3
```

This Wait-Job command uses the job name to identify the job to wait for.
### Example 8
```
PS C:\> $j = Start-Job -ScriptBlock {Get-ChildItem *.ps1| where {$_lastwritetime -gt ((Get-Date) - (New-TimeSpan -Days 7))}}
PS C:\> $j | Wait-Job
```

This example shows how to use the Wait-Job cmdlet with jobs started on the local computer by using the Start-Job cmdlet.

These commands start a job that gets the Windows PowerShell script files that were added or updated in the last week.

The first command uses the Start-Job cmdlet to start a background job on the local computer.
The job runs a Get-ChildItem command that gets all of the files with a ".ps1" file name extension that were added or updated in the last week.

The third command uses the Wait-Job cmdlet to wait until the job is complete.
When the job completes, the command displays the job object, which contains information about the job.
### Example 9
```
PS C:\> $s = New-PSSession Server01, Server02, Server03
PS C:\> $j = Invoke-Command -Session $s -ScriptBlock {Get-Process} -AsJob
PS C:\> $j | Wait-Job
```

This example shows how to use the Wait-Job cmdlet with jobs started on remote computers by using the AsJob parameter of the Invoke-Command cmdlet.
When using AsJob, the job is created on the local computer and the results are automatically returned to the local computer, even though the job runs on the remote computers.

This example uses Wait-Job to determine whether a Get-Process command running in the sessions on three remote computers is complete.

The first command creates PSSessions on three computers and stores them in the $s variable.

The second command uses the Invoke-Command cmdlet to run a Get-Process command in each of the three PSSessions in $s.
The command uses the AsJob parameter to run the command asynchronously as a background job.
The command returns a job object, just like the jobs started by using Start-Job, and the job object is stored in the $j variable.

The third command uses a pipeline operator (|) to send the job object in $j to the Wait-Job cmdlet.
Notice that an Invoke-Command command is not required in this case, because the job resides on the local computer.
### Example 10
```
PS C:\> Get-Job

Id   Name     State      HasMoreData     Location             Command
--   ----     -----      -----------     --------             -------
1    Job1     Completed  True            localhost,Server01.. get-service
4    Job4     Completed  True            localhost            dir | where

PS C:\> Wait-Job -id 1
```

This command waits for the job with an ID value of 1.
## PARAMETERS

### -Any
Displays the command prompt (and returns the job object) when any job completes.
By default, Wait-Job waits until all of the specified jobs are complete before displaying the prompt.

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

### -Filter
Waits for jobs that satisfy all of the conditions established in the associated hash table.
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

### -Id
Waits for jobs with the specified IDs.

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
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId
Waits for jobs with the specified instance IDs.
The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer.
To find the instance ID of a job, use Get-Job.

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
Waits for the specified jobs.
Enter a variable that contains the job objects or a command that gets the job objects.
You can also use a pipeline operator to send job objects to the Wait-Job cmdlet.
By default, Wait-Job waits for all jobs created in the current session.

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
Waits for jobs with the specified friendly name.

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
Waits only for jobs in the specified state.
Valid values are NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, Stopping.

For more information about job states, see [JobState Enumeration](/dotnet/api/system.management.automation.jobstate) in the MSDN library.

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

### -Timeout
Determines the maximum wait time for each background job, in seconds.
The default, -1, waits until the job completes, no matter how long it runs.
The timing starts when you submit the Wait-Job command, not the Start-Job command.

If this time is exceeded, the wait ends and the command prompt returns, even if the job is still running.
No error message is displayed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Continues waiting if jobs are in the **Suspended** or **Disconnected** state.
By default, **Wait-Job** returns (terminates the wait) when jobs are in one of the following states: Completed, Failed, Stopped, Suspended, or Disconnected.

This parameter is introduced in Windows PowerShell 3.0.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).
## INPUTS

### System.Management.Automation.RemotingJob
You can pipe a job object to Wait-Job.
## OUTPUTS

### System.Management.Automation.PSRemotingJob
Wait-Job returns job objects that represent the completed jobs.
If the wait ends because the value of the Timeout parameter is exceeded, Wait-Job does not return any objects.
## NOTES
* By default, **Wait-Job** returns (terminates the wait) when jobs are in one of the following states: Completed, Failed, Stopped, Suspended, or Disconnected. To direct **Wait-Job** to continue waiting for **Suspended** and **Disconnected** jobs, use the **Force** parameter.
## RELATED LINKS

[Get-Job](Get-Job.md)

[Invoke-Command](Invoke-Command.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[about_Jobs](About/about_Jobs.md)

[about_Job_Details](About/about_Job_Details.md)

[about_Remote_Jobs](About/about_Remote_Jobs.md)

[about_Remote_Variables](About/about_Remote_Variables.md)