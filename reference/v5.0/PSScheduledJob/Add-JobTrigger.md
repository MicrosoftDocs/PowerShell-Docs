---
external help file: PSITPro5_ScheduledJob.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=290620
schema: 2.0.0
---

# Add-JobTrigger
## SYNOPSIS
Adds job triggers to scheduled jobs.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Add-JobTrigger [-InputObject] <ScheduledJobDefinition[]> [-Trigger] <ScheduledJobTrigger[]>
```

### UNNAMED_PARAMETER_SET_2
```
Add-JobTrigger [-Id] <Int32[]> [-Trigger] <ScheduledJobTrigger[]>
```

### UNNAMED_PARAMETER_SET_3
```
Add-JobTrigger [-Name] <String[]> [-Trigger] <ScheduledJobTrigger[]>
```

## DESCRIPTION
The Add-JobTrigger cmdlet adds job triggers to scheduled jobs.
You can use it to add multiple triggers to multiple scheduled jobs.

A job trigger starts a scheduled job on a one-time or recurring schedule or when an event occurs.

Use the Trigger parameter of Add-JobTrigger to identify the job triggers to add.
Use the Name, ID, or InputObject parameters of Add-JobTrigger to identify the scheduled job to which the triggers are added.

To create job triggers for the value of the Trigger parameter, use the New-JobTrigger cmdlet or use a hash table to specify the job trigger.

Add-JobTrigger is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Add a job trigger to a scheduled job
```
PS C:\>$Daily = New-JobTrigger -Daily -At 3AMPS 
PS C:\>Add-JobTrigger -Trigger $Daily -Name "TestJob"
```

These commands add the Daily job trigger to the TestJob scheduled job.

The first command uses the New-JobTrigger cmdlet to create a job trigger that starts a scheduled job every day at 3:00 a.m.
The command saves the job trigger in the $Daily variable.

The second command uses the Add-JobTrigger cmdlet to add the job trigger in the $Startup variable to the TestJob scheduled job.

### Example 2: Add a job trigger to several scheduled jobs
```
PS C:\>Get-ScheduledJob | Add-JobTrigger -Trigger (New-JobTrigger -AtStartup)
```

This command adds an AtStartup job trigger to all scheduled jobs on the local computer.
It uses the Get-ScheduledJob to get all of the scheduled jobs on the computer.
It uses a pipeline operator (|) to send the jobs to the Add-JobTrigger cmdlet, which adds the job trigger to each of the scheduled jobs.
The value of the Trigger parameter is a New-JobTrigger command that creates the AtStartup job trigger.

### Example 3: Copy a job trigger
```
PS C:\>$T = Get-JobTrigger -Name "BackupArchives"
PS C:\>Add-JobTrigger -Name "TestBackup,BackupLogs" -Trigger $T
```

These commands copy the job trigger from the BackupArchives scheduled job and add it to the TestBackup and BackupLogs scheduled jobs.

The first command uses the Get-JobTrigger cmdlet to get the job trigger of the BackupArchives scheduled job.
The command saves the trigger in the $t variable.

The second command uses the Add-JobTrigger cmdlet to add the job trigger in $t to the TestBackup and BackupLogs scheduled jobs.

## PARAMETERS

### -Id
Specifies the identification numbers of the scheduled jobs.
Add-JobTrigger adds the job trigger to the specified scheduled jobs.

To get the identification number of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the scheduled jobs.
Enter a variable that contains ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command.
You can also pipe ScheduledJob objects to Add-JobTrigger.

```yaml
Type: ScheduledJobDefinition[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the names of the scheduled jobs.
Add-JobTrigger adds the job triggers to the specified scheduled jobs.
Wildcards are supported.

To get the names of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trigger
Specifies the job triggers to add.
Enter a hash table that specifies job triggers or a variable that contains ScheduledJobTrigger objects, or type a command or expression that gets ScheduledJobTrigger objects, such as a Get-JobTrigger command.
You can also pipe ScheduledJobTrigger objects to Add-JobTrigger.

```yaml
Type: ScheduledJobTrigger[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger, Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
You can pipe job triggers or scheduled jobs to Add-JobTrigger.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[about_Scheduled_Jobs](3b546629-703c-4939-b44f-52dd567bce92)

[Add-JobTrigger](d0ab1b5d-ca22-4518-a3dc-88ffb4578b62)

[Disable-JobTrigger](6387c972-06c8-4f7c-a1fe-35e0ed03b3cb)

[Disable-ScheduledJob](0f633d57-fe67-4fb8-b6f1-875395c76042)

[Enable-JobTrigger](a76ca67d-298b-4674-be43-af3f781eb570)

[Enable-ScheduledJob](e61a922e-b575-4b19-b29c-2b2b6f58ebcf)

[Get-JobTrigger](60c56495-7aa1-49fd-835a-09dfad27bdf8)

[Get-ScheduledJob](ff366cbf-5e3b-49fb-b987-d1a8d9822172)

[Get-ScheduledJobOption](00b922bf-0816-4817-bd07-0534538e5d68)

[New-JobTrigger](605eb27a-e8ff-4167-b94c-988b2b893696)

[New-ScheduledJobOption](a3262ad6-5b68-452e-80da-f53173bfa89f)

[Register-ScheduledJob](47e8f0de-6a42-447b-a024-9a20da5a852f)

[Remove-JobTrigger](46cc6c3a-d929-40d7-bf3f-0eb38d203879)

[Set-JobTrigger](d79c9eef-5446-40c2-a29c-28c13dffcd7c)

[Set-ScheduledJob](f759d9ff-6807-45d5-af98-7e56efd9615c)

[Set-ScheduledJobOption](5fe666db-ceed-4261-89ec-376dd01712f9)

[Unregister-ScheduledJob](a76ff3d0-1496-46a8-885a-b54552eda897)

