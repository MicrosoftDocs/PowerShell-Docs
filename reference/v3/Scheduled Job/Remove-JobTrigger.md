---
external help file: PSITPro3_ScheduledJob.xml
schema: 2.0.0
---

# Remove-JobTrigger
## SYNOPSIS
Delete job triggers from scheduled jobs

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-JobTrigger [-InputObject] <ScheduledJobDefinition[]> [-TriggerId <Int32[]>]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-JobTrigger [-Id] <Int32[]> [-TriggerId <Int32[]>]
```

### UNNAMED_PARAMETER_SET_3
```
Remove-JobTrigger [-Name] <String[]> [-TriggerId <Int32[]>]
```

## DESCRIPTION
The Remove-JobTrigger cmdlet deletes job triggers from scheduled jobs.

A "job trigger" defines a recurring schedule or conditions for starting a scheduled job.
To manage job triggers, use the New-JobTrigger, Add-JobTrigger, Set-JobTrigger, and Set-ScheduledJob cmdlets.

Use the Name, ID, or InputObject parameters of Remove-JobTrigger to identify the scheduled jobs from which the triggers are removed.
Use the TriggerID parameter of Remove-JobTrigger to identify the job triggers to delete.
By default, Remove-JobTrigger deletes all job triggers of a scheduled job.

Remove-JobTrigger is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Delete all job triggers
```
PS C:\>Remove-JobTrigger -Name Test*
```

This command deletes all job triggers from scheduled job that have names that begin with "Test".

### Example 2: Delete selected job triggers
```
PS C:\>Remove-JobTrigger -Name BackupArchive -TriggerID 3
```

This command deletes only the third trigger \(ID = 3\) from the BackupArchive scheduled job.

### Example 3: Delete AtStartup job triggers from all scheduled jobs
```
PS C:\>                
function Delete-AtStartup
{
    Get-ScheduledJob | Get-JobTrigger | Where-Object {$_.Frequency -eq "AtStartup"} | ForEach-Object { Remove-JobTrigger -InputObject $_.JobDefinition -TriggerID $_.ID}
}
```

This function deletes all AtStartup job triggers from all jobs on the local computer.
To use the function, run the function in your session and then type "Delete-AtStartup"

The Delete-AtStartup function contains a single command.
The command uses the Get-ScheduledJob cmdlet to get the scheduled jobs on the local computer.
A pipeline operator \(|\) sends the scheduled jobs to the Get-JobTrigger cmdlet, which gets all of the job triggers from each of the scheduled jobs.
A pipeline operator sends the job triggers to the Where-Object cmdlet, which selects job triggers where the value of the Frequency property of the job trigger equals "AtStartup."

Job trigger objects have a JobDefinition property that contains the scheduled job that they trigger.
The remainder of the command uses that valuable feature.

A pipeline operator sends the AtStartup job triggers to the ForEach-Object cmdlet, which runs a Remove-JobTrigger command on each AtStartup trigger.
The value of the InputObject parameter of Remove-JobTrigger is the scheduled job in the JobDefinition property of the job trigger.
The value of the TriggerID parameter is the identifier in the ID property of the job trigger.

### Example 4: Delete a job trigger from a remote scheduled job
```
PS C:\>Invoke-Command -ComputerName Server01 { Remove-JobTrigger -ID 38 -TriggerID 1 }
```

This command deletes the first job trigger from the Inventory job on the Server01 computer.

The command uses the Invoke-Command cmdlet to run a Remove-JobTrigger command on the Server01 computer.
The Remove-JobTrigger command uses the ID parameter to identify the Inventory scheduled job and the TriggerID parameter to specify the first trigger.
The ID parameter is especially useful when multiple scheduled jobs have the same or similar names.

## PARAMETERS

### -Id
Specifies the identification numbers of the scheduled jobs.
Remove-JobTrigger deletes job triggers from the specified scheduled jobs.

To get the identification number of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -InputObject
Specifies the scheduled jobs.
Enter a variable that contains ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command.
You can also pipe ScheduledJob objects to Remove-JobTrigger.

```yaml
Type: ScheduledJobDefinition[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the names of the scheduled jobs.
Remove-JobTrigger deletes the job triggers from the specified scheduled jobs.
Wildcards are supported.

To get the names of scheduled jobs on the local computer or a remote computer, use the Get-ScheduledJob cmdlet.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: false
Accept wildcard characters: True
```

### -TriggerId
Deletes only the specified job triggers.
By default, Remove-JobTrigger deletes all triggers from the scheduled jobs.
Use this parameter when the scheduled jobs have multiple job triggers.

Enter the trigger IDs of one or more job triggers of a scheduled job.
If you specify multiple scheduled jobs, Remove-JobTrigger deletes the job trigger with the specified ID from all scheduled jobs.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: All triggers
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
You can pipe scheduled jobs to the Remove-JobTrigger cmdlet.

## OUTPUTS

### None
The cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=223914)

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


