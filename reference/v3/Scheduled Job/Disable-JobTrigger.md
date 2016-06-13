---
external help file: PSITPro3_ScheduledJob.xml
online version: http://go.microsoft.com/fwlink/?LinkID=223918
schema: 2.0.0
---

# Disable-JobTrigger
## SYNOPSIS
Disables the job triggers of scheduled jobs

## SYNTAX

```
Disable-JobTrigger [-InputObject] <ScheduledJobTrigger[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Disable-JobTrigger cmdlet temporarily disables the job triggers of scheduled jobs.
Disabling preserves all job trigger properties, but it prevents the job trigger from starting the scheduled job.

To use this cmdlet, use the  Get-JobTrigger cmdlet to get the job triggers.
Then pipe the job triggers to Disable-JobTrigger or use its InputObject parameter.

To disable a job trigger, the Disable-JobTrigger cmdlet sets the Enabled property of the job trigger to False ($false).
To re-enable the job trigger, use the Enable-JobTrigger cmdlet, which sets the Enabled property of the job trigger to True ($true).
Disabling a job trigger does not disable the scheduled job, such as is done by the Disable-ScheduledJob cmdlet, but if you disable all job triggers, the effect is the same as disabling the scheduled job.

If you disable a scheduled job or disable all job triggers of a scheduled job, you can still start the job by using the Start-Job cmdlet or use the disabled scheduled job as a template.

Disable-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Disable a job trigger
```
PS C:\>Get-JobTrigger -Name Backup-Archives -TriggerID 1 | Disable-JobTrigger
```

This command disables the first trigger (ID=1) of the Backup-Archives scheduled job on the local computer.

The command uses the Get-JobTrigger cmdlet to get the job trigger.
A pipeline operator sends the job trigger to the Disable-JobTrigger cmdlet, which disables it.

### Example 2: Disable all job triggers
```
The first command uses the Get-ScheduledJob cmdlet to get the Backup-Archives and Inventory scheduled jobs. A pipeline operator (|) sends the scheduled jobs to the Get-JobTrigger cmdlet, which gets all job triggers of the scheduled jobs. Another pipeline operator sends the job triggers to the Disable-JobTrigger cmdlet, which disables them.The first command uses the Get-ScheduledJob cmdlet to get the jobs, because its Name parameter takes multiple names.
PS C:\>Get-ScheduledJob -Name Backup-Archives, Inventory | Get-JobTrigger | Disable-JobTrigger

The second command displays the results. The command repeats the Get-ScheduledJob and Get-JobTrigger command. A pipeline operator sends the job triggers to the Format-Table cmdlet, which displays the job triggers in a table. The Format-Table command adds a JobName property that displays the value of the Name property of the scheduled job in the JobDefinition property of the job trigger object. 
PS C:\>Get-ScheduledJob -Name Backup-Archives, Inventory | Get-JobTrigger | Format-Table -Property ID, Frequency, At, DaysOfWeek, Enabled, @{Label="JobName";Expression={$_.JobDefinition.Name}} -AutoSize
Id Frequency At                     DaysOfWeek Enabled JobName
-- --------- --                     ---------- ------- ------- 
1  Weekly    9/28/2011 3:00:00 AM   {Monday}   False   Backup-Archive
2  Daily     9/29/2011 1:00:00 AM              False   Backup-Archive
1  Weekly    10/20/2011 11:00:00 PM {Friday}   False   Inventory
1  Weekly    11/2/2011 2:00:00 PM   {Monday}   False   Inventory
```

These commands disable all job triggers on two scheduled jobs and display the results.

### Example 3: Disable job trigger of a scheduled job on a remote computer.
```
PS C:\>Invoke-Command -ComputerName Server01 {Get-JobTrigger -Name DeployPackage | Where-Object {$_.Frequency -eq "Daily"} | Disable-JobTrigger}
```

This command disables the daily job triggers on the DeployPackage scheduled job on the Server01 remote computer.

The command uses the Invoke-Command cmdlet to run the commands on the Server01 computer.
The remote command uses the Get-JobTrigger cmdlet to get the job triggers of the DeployPackage scheduled job.
A pipeline operator sends the job triggers to the Where-Object cmdlet which returns only daily job triggers.
A pipeline operator sends the daily job triggers to the Disable-JobTrigger cmdlets which disables them.

## PARAMETERS

### -InputObject
Specifies the job trigger to be disabled.
Enter a variable that contains  ScheduledJobTrigger objects or type a command or expression that gets ScheduledJobTriger objects, such as a Get-JobTrigger command.
You can also pipe a ScheduledJobTrigger object to Disable-JobTrigger.

```yaml
Type: ScheduledJobTrigger[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
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

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger
You can pipe job triggers to Disable-JobTrigger.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
Disable-JobTrigger does not generate errors or warnings if you disable a job trigger that is already disabled.

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

