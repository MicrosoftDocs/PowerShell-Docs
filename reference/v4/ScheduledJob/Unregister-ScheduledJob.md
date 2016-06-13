---
external help file: PSITPro4_ScheduledJob.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=287623
schema: 2.0.0
---

# Unregister-ScheduledJob
## SYNOPSIS
Deletes scheduled jobs on the local computer.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Unregister-ScheduledJob [-InputObject] <ScheduledJobDefinition[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Unregister-ScheduledJob [-Name] <String[]> [-Force] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Unregister-ScheduledJob [-Id] <Int32[]> [-Force] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Unregister-ScheduledJob cmdlet deletes scheduled jobs from the local computer.

When it deletes or "unregisters" a scheduled job, Unregister-ScheduledJob deletes the directory for the scheduled job (in the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory), which contains the XML file that defines the scheduled job, the job execution history, and all job results.
This action also deletes the job from Task Scheduler.

Unregister-ScheduledJob deletes only the scheduled jobs that are created by using the Register-ScheduledJob cmdlet.
It does not delete scheduled jobs that are created in Task Scheduler.

You can use the parameters of Unregister-ScheduledJob to delete scheduled jobs by ID or name, or pipe scheduled jobs from Get-ScheduledJob to Unregister-ScheduledJob.

Unregister-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Delete a scheduled job
```
PS C:\>Unregister-ScheduledJob TestJob
```

This command deletes the TestJob scheduled job on the local computer.

### Example 2: Delete all scheduled jobs
```
PS C:\>Get-ScheduledJob | Unregister-ScheduledJob -Force
 
                      
PS C:\>Unregistered-ScheduledJob -Name * -Force
```

This examples shows two different commands that delete all scheduled jobs on the local computer.

The first command uses the Get-ScheduledJob cmdlet to get all scheduled jobs on the local computer.
A pipeline operator (|) sends the scheduled jobs to Unregister-ScheduleJob, which deletes them.

The second command uses the Name parameter of Unregister-ScheduledJob with a value of all (*) to delete all scheduled jobs.

Both commands use the Force parameter, which deletes a scheduled job even if an instance of the job is running.

### Example 3: Delete a scheduled job on a remote computer
```
PS C:\>Invoke-Command -ComputerName Server01 { Unregister-ScheduledJob -Name Test*}
```

This command deletes scheduled jobs with names that begin with "Test" on the Server01 remote computer.
The command uses the Invoke-Command cmdlet to run the Unregister-ScheduledJob command on the Server02 computer.

## PARAMETERS

### -Force
Deletes the scheduled job even if an instance of the job is running.
By default, Unregister-ScheduledJob does not interrupt running jobs.

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

### -Id
Deletes the scheduled jobs with the specified identification numbers (ID).
Enter the IDs of scheduled jobs on the computer.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a scheduled job.
Enter a variable that contains  ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command.
You can also pipe ScheduledJob objects to Unregister-JobTrigger.

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
Deletes the scheduled jobs with the specified names.
Enter the names of one or more scheduled jobs on the computer.
Wildcards are supported.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
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

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
You can pipe scheduled jobs to Unregister-ScheduledJob

## OUTPUTS

### None
This cmdlet does not generate any output.

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

