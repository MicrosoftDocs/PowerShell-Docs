---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSScheduledJob
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821702
schema: 2.0.0
title: Register-ScheduledJob
---

# Register-ScheduledJob

## SYNOPSIS
Creates a scheduled job.

## SYNTAX

### ScriptBlock (Default)
```
Register-ScheduledJob [-ScriptBlock] <ScriptBlock> [-Name] <String> [-Trigger <ScheduledJobTrigger[]>]
 [-InitializationScript <ScriptBlock>] [-RunAs32] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-ScheduledJobOption <ScheduledJobOptions>]
 [-ArgumentList <Object[]>] [-MaxResultCount <Int32>] [-RunNow] [-RunEvery <TimeSpan>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### FilePath
```
Register-ScheduledJob [-FilePath] <String> [-Name] <String> [-Trigger <ScheduledJobTrigger[]>]
 [-InitializationScript <ScriptBlock>] [-RunAs32] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-ScheduledJobOption <ScheduledJobOptions>]
 [-ArgumentList <Object[]>] [-MaxResultCount <Int32>] [-RunNow] [-RunEvery <TimeSpan>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Register-ScheduledJob** cmdlet creates scheduled jobs on the local computer.

A scheduled job is a Windows PowerShell background job that can be started automatically on a one-time or recurring schedule.
Scheduled jobs are stored on disk and registered in Task Scheduler, so they can be managed in Task Scheduler or by using the Scheduled Job cmdlets in Windows PowerShell.

When a scheduled job starts, it creates an instance of the scheduled job.
Scheduled job instances are identical to Windows PowerShell background jobs, except that the results are saved on disk.
Use the Job cmdlets, such as Start-Job, Get-Job, and Receive-Job to start, view, and get the results of the job instances.

Use **Register-ScheduledJob** to create a new scheduled job.
To specify the commands that the scheduled job runs, use the *ScriptBlock* parameter; to specify a script that the job runs, use the *FilePath* parameter.

Windows PowerShell-scheduled jobs use the same job triggers and job options that Task Scheduler uses for scheduled tasks.

The *Trigger* parameter of **Register-ScheduledJob** adds one or more job triggers that start the job.
The *Trigger* parameter is optional, so you can add triggers when you create the scheduled job, add job triggers later, add the *RunNow* parameter to start the job immediately, use the Start-Job cmdlet to start the job immediately at any time, or save the untriggered scheduled job as a template for other jobs.

The *Options* parameter lets you customize the options settings for the scheduled job.
The *Options* parameter is also optional, so you can set job options when you create the scheduled job or change them at any time.
Because job option settings can prevent the scheduled job from running, review the job options and set them carefully.

**Register-ScheduledJob** is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Create a scheduled job
```
PS C:\> Register-ScheduledJob -Name "Archive-Scripts" -ScriptBlock { dir $home\*.ps1 -Recurse | Copy-Item -Destination "\\Server\Share\PSScriptArchive" }
```

This command creates the Archive-Scripts scheduled job.
The *ScriptBlock* parameter value contains a command that searches the $home directory recursively for .ps1 files and copies them to a directory in a file share.

Because the scheduled job does not contain a trigger, it is not started automatically.
You can use add job triggers later, use the Start-Job cmdlet to start the job on demand, or use the scheduled job as a template for other scheduled jobs.

### Example 2: Create a scheduled job with triggers and custom options
```
The first command uses the New-ScheduledJobOption cmdlet to create a job option object, which it saves in the $O parameter. The options start the scheduled job even if the computer is not idle, wake the computer to run the job, if necessary, and allows multiple instances of the job to run in a series.
PS C:\> $O = New-ScheduledJobOption -WakeToRun -StartIfNotIdle -MultipleInstancesPolicy Queue


The second command uses the New-JobTrigger cmdlet to create job trigger that starts a job every other Monday at 9:00 PM.
PS C:\> $T = New-JobTrigger -Weekly -At "9:00 PM" -DaysOfWeek Monday -WeeksInterval 2

This command creates the UpdateVersion scheduled job, which runs the UpdateVersion.ps1 script every Monday at 9:00 p.m. The command uses the *FilePath* parameter to specify the script that the job runs. It uses the *Trigger* parameter to specify the job triggers in the $T variable and the *ScheduledJobOption* parameter to specify the option object in the $O variable.
PS C:\> Register-ScheduledJob -Name "UpdateVersion" -FilePath "\\Srv01\Scripts\UpdateVersion.ps1" -Trigger $T -ScheduledJobOption $O
```

This example shows how to create a scheduled job that has a job trigger and custom job options.

### Example 3: Use hash tables to specify a trigger and job options
```
PS C:\> Register-ScheduledJob -FilePath "\\Srv01\Scripts\Update-Version.ps1" -Trigger @{Frequency=Weekly; At="9:00PM"; DaysOfWeek="Monday"; Interval=2} -ScheduledJobOption @{WakeToRun; StartIfNotIdle; MultipleInstancesPolicy="Queue"}
```

This command is has the same effect as the command in Example 2.
It creates a scheduled job, but it uses hash tables to specify the values of the *Trigger* and *ScheduledJobOption* parameters.

### Example 4: Create scheduled jobs on remote computers
```
PS C:\> Invoke-Command -ComputerName (Get-Content Servers.txt) -ScriptBlock {Register-ScheduledJob -Name "Get-EnergyData" -FilePath "\\Srv01\Scripts\Get-EnergyData.ps1" -ScheduledJobOption $O -Trigger $T } -Credential $Cred
```

This command creates the EnergyData scheduled job on multiple remote computers.
The scheduled job runs a script that gathers raw data and saves it in a running log.
The scheduled jobs are created on the remote computer, run on the remote computer, and store their results on the remote computer.

The command uses the Invoke-Command cmdlet to run a **Register-ScheduledJob** command on the computers in the Servers.txt file.
The **Invoke-Command** command uses the *Credential* parameter to provide the credentials of a user that has permission to create scheduled jobs on the computers in the Servers.txt file.

The **Register-ScheduledJob** command creates a scheduled job on the remote computer that runs the EnergyData.ps1 script on the scheduled specified by the job trigger in the $T variable.
The script is located on a file server that is available to all participating computers.

### Example 5: Create a scheduled job that runs a script on remote computers
```
PS C:\> Register-ScheduledJob -Name "CollectEnergyData" -Trigger $T -MaxResultCount 99 -ScriptBlock { Invoke-Command -AsJob -ComputerName (Servers.txt) -FilePath "\\Srv01\Scripts\Get-EnergyData.ps1" -Credential $Admin -Authentication CredSSP }
```

This command uses the **Register-ScheduledJob** cmdlet to create the CollectEnergyData scheduled job on the local computer.
The command uses the *Trigger* parameter to specify the job schedule and the *MaxResultCount* parameter to increase the number of saved results to 99.

The CollectEnergyData job uses the Invoke-Command cmdlet to run the EnergyData.ps1 script as a background on the computers listed in the Servers.txt file.
The **Invoke-Command** command uses the *AsJob* parameter to create the background job object on the local computer, even though the Energydata.ps1 script runs on the remote computers.
The command uses the *Credential* parameter to specify a user account that has permission to run scripts on the remote computers and the *Authentication* parameter with a value of **CredSSP** to allow delegated credentials.

## PARAMETERS

### -ArgumentList
Specifies values for the parameters of the script that is specified by the *FilePath* parameter or for the command that is specified by the *ScriptBlock* parameter.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication
Specifies the mechanism that is used to authenticate the user's credentials.
The acceptable values for this parameter are:

- Default
- Basic
- Credssp
- Digest
- Kerberos
- Negotiate
- NegotiateWithImplicitCredential

The default value is Default.
For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](https://msdn.microsoft.com/library/system.management.automation.runspaces.authenticationmechanism) in the MSDN library.

Caution: Credential Security Service Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: (All)
Aliases:
Accepted values: Default, Basic, Negotiate, NegotiateWithImplicitCredential, Credssp, Digest, Kerberos

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to run the scheduled job.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one from the Get-Credential cmdlet.
If you enter only a user name, you are prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies a script that the scheduled job runs.
Enter the path to a .ps1 file on the local computer.
To specify default values for the script parameters, use the *ArgumentList* parameter.
Every **Register-ScheduledJob** command must use either the *ScriptBlock* or *FilePath* parameters.

```yaml
Type: String
Parameter Sets: FilePath
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InitializationScript
Specifies the fully qualified path to a Windows PowerShell script (.ps1).
The initialization script runs in the session that is created for the background job before the commands that are specified by the *ScriptBlock* parameter or the script that is specified by the *FilePath* parameter.
You can use the initialization script to configure the session, such as adding files, functions, or aliases, creating directories, or checking for prerequisites.

To specify a script that runs the primary job commands, use the *FilePath* parameter.

If the initialization script generates an error (even a non-terminating error), the current instance of the scheduled job does not run and its status is Failed.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxResultCount
Specifies how many job result entries are maintained for the scheduled job.
The default value is 32.

Windows PowerShell saves the execution history and results of each triggered instance of the scheduled job on disk.
The value of this parameter determines the number of job instance results that are saved for this scheduled job.
When the number of job instance results exceeds this value, Windows PowerShell deletes the results of the oldest job instance to make room for the results of the newest job instance.

The job execution history and job results are saved in the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\\\<JobName\>\Output\\\<Timestamp\> directories on the computer on which the job is created.
To see the execution history, use the Get-Job cmdlet.
To get the job results, use the Receive-Job cmdlet.

The *MaxResultCount* parameter sets the value of the ExecutionHistoryLength property of the scheduled job.

To delete the current execution history and job results, use the *ClearExecutionHistory* parameter of the Set-ScheduledJob cmdlet.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a name for the scheduled job.
The name is also used for all started instances of the scheduled job.
The name must be unique on the computer.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAs32
Runs the scheduled job in a 32-bit process.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunEvery

Used to specify how often to run the job. For example, use this option to run a job every 15
minutes.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunNow
Starts a job immediately, as soon as the **Register-ScheduledJob** cmdlet is run.
This parameter eliminates the need to trigger Task Scheduler to run a Windows PowerShell script immediately after registration, and does not require users to create a trigger that specifies a starting date and time.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduledJobOption
Sets options for the scheduled job.
Enter a **ScheduledJobOptions** object, such as one that you create by using the New-ScheduledJobOption cmdlet, or a hash table value.

You can set options for a scheduled job when you register the schedule job or use the Set-ScheduledJobOption or Set-ScheduledJob cmdlets to change the options.

Many of the options and their default values determine whether and when a scheduled job runs.
Be sure to review these options before scheduling a job.
For a description of the scheduled job options, including the default values, see New-ScheduledJobOption.

To submit a hash table, use the following keys.
In the following hash table, the keys are shown with their default values.

`@{StartIfOnBattery=$False; StopIfGoingOnBattery=$True; WakeToRun=$False; StartIfNotIdle=$False; IdleDuration="00:10:00"; IdleTimeout="01:00:00"; StopIfGoingOffIdle=$True; RestartOnIdleResume=$False; ShowInTaskScheduler=$True; RunElevated=$False; RunWithoutNetwork=$False; DoNotAllowDemandStart=$False; MultipleInstancePolicy=IgnoreNew}`

```yaml
Type: ScheduledJobOptions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
Specifies the commands that the scheduled job runs.
Enclose the commands in braces ( { } ) to create a script block.
To specify default values for command parameters, use the *ArgumentList* parameter.

Every **Register-ScheduledJob** command must use either the *ScriptBlock* or *FilePath* parameters.

```yaml
Type: ScriptBlock
Parameter Sets: ScriptBlock
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trigger
Specifies the triggers for the scheduled job.
Enter one or more **ScheduledJobTrigger** objects, such as the objects that the New-JobTrigger cmdlet returns, or a hash table of job trigger keys and values.

A job trigger starts the schedule job.
The trigger can specify a one-time or recurring scheduled or an event, such as when a user logs on or Windows starts.

The *Trigger* parameter is optional.
You can add a trigger when you create the scheduled job, use the Add-JobTrigger, Set-JobTrigger, or Set-ScheduledJob cmdlets to add or change job triggers later, or use the Start-Job cmdlet to start the scheduled job immediately.
You can also create and maintain a scheduled job without a trigger that is used as a template.

To submit a hash table, use the following keys:

`@{Frequency="Once"` (or Daily, Weekly, AtStartup, AtLogon); `At="3am"` (or any valid time string);
`DaysOfWeek="Monday", "Wednesday"` (or any combination of day names);
`Interval=2` (or any valid frequency interval);
`RandomDelay="30minutes"` (or any valid timespan string);
`User="Domain1\User01"` (or any valid user; used only with the AtLogon frequency value)
}

```yaml
Type: ScheduledJobTrigger[]
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

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

## NOTES
* Each scheduled job is saved in a subdirectory of the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory on the local computer. The subdirectory is named for the scheduled job and contains an XML file for the scheduled job and records of its execution history. For more information about scheduled jobs on disk, see about_Scheduled_Jobs_Advanced.
* Scheduled jobs that you create in Windows PowerShell appear in Task Scheduler in the Task Scheduler Library\Microsoft\Windows\PowerShell\ScheduledJobs folder. You can use Task Scheduler to view and edit the scheduled job.
* You can use Task Scheduler, the SchTasks.exe command-line tool, and the Task Scheduler cmdlets to manage scheduled jobs that you create with the Scheduled Job cmdlets. However, you cannot use the Scheduled Job cmdlets to manage tasks that you create in Task Scheduler.
* If a scheduled job command fails, Windows PowerShell returns an error message. However, if the job fails when Task Scheduler tries to run it, the error is not available to Windows PowerShell.

  If a scheduled job does not run, use the following methods to find the reason.

- Verify that the job trigger is set properly.
 -- Verify that the conditions set in the job options are satisfied.
- Verify that the user account under which the job runs has permission to run the commands or scripts in the job.
- Check the Task Scheduler history for errors
- Check the Task Scheduler event log for errors.

For more information, see about_Scheduled_Jobs_Troubleshooting.

## RELATED LINKS

[Add-JobTrigger](Add-JobTrigger.md)

[Disable-JobTrigger](Disable-JobTrigger.md)

[Disable-ScheduledJob](Disable-ScheduledJob.md)

[Enable-JobTrigger](Enable-JobTrigger.md)

[Enable-ScheduledJob](Enable-ScheduledJob.md)

[Get-JobTrigger](Get-JobTrigger.md)

[Get-ScheduledJob](Get-ScheduledJob.md)

[Get-ScheduledJobOption](Get-ScheduledJobOption.md)

[New-JobTrigger](New-JobTrigger.md)

[New-ScheduledJobOption](New-ScheduledJobOption.md)

[Register-ScheduledJob](Register-ScheduledJob.md)

[Remove-JobTrigger](Remove-JobTrigger.md)

[Set-JobTrigger](Set-JobTrigger.md)

[Set-ScheduledJob](Set-ScheduledJob.md)

[Set-ScheduledJobOption](Set-ScheduledJobOption.md)

[Unregister-ScheduledJob](Unregister-ScheduledJob.md)