---
external help file: PSITPro3_ScheduledJob.xml
schema: 2.0.0
---

# Enable-JobTrigger
## SYNOPSIS
Enables the job triggers of scheduled jobs

## SYNTAX

```
Enable-JobTrigger [-InputObject] <ScheduledJobTrigger[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Enable-JobTrigger cmdlet re-enables job triggers of scheduled jobs, such as those that were disabled by using the Disable-JobTrigger cmdlet.
Enabled and re-enabled job triggers can start scheduled jobs immediately; there is no need to restart Windows or Windows PowerShell.

To use this cmdlet, use the  Get-JobTrigger cmdlet to get the job triggers.
Then pipe the job triggers to Enable-JobTrigger or use its InputObject parameter.

To enable a job trigger, the Enable-JobTrigger cmdlet sets the Enabled property of the job trigger to True \($true\).

Enable-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Enable a job trigger
```
PS C:\>Get-JobTrigger -Name Backup-Archives -TriggerID 1 | Enable-JobTrigger
```

This command enables the first trigger \(ID=1\) of the Backup-Archives scheduled job on the local computer.

The command uses the Get-JobTrigger cmdlet to get the job trigger.
A pipeline operator sends the job trigger to the Enable-JobTrigger cmdlet, which enables it.

### Example 2: Enable all job triggers
```
PS C:\>Get-ScheduledJob | Get-JobTrigger | Enable-JobTrigger
```

The command uses the Get-ScheduledJob cmdlet to get  the scheduled jobs on the local computer.
A pipeline operator \(|\) sends the scheduled jobs to the Get-JobTrigger cmdlet, which gets all job triggers of the scheduled jobs.
Another pipeline operator sends the job triggers to the Enable-JobTrigger cmdlet, which enables them.

### Example 3: Enable the job trigger of a scheduled job on a remote computer.
```
PS C:\>Invoke-Command -ComputerName Server01 {Get-JobTrigger -Name DeployPackage | Where-Object {$_.Frequency -eq "AtLogon"} | Enable-JobTrigger}
```

This command re-enables the AtLogon job triggers on the DeployPackage scheduled job on the Server01 remote computer.

The command uses the Invoke-Command cmdlet to run the commands on the Server01 computer.
The remote command uses the Get-JobTrigger cmdlet to get the job triggers of the DeployPackage scheduled job.
A pipeline operator sends the job triggers to the Where-Object cmdlet which returns only AtLogon job triggers.
A pipeline operator sends the AtLogon job triggers to the Enable-JobTrigger cmdlets which Enables them.

### Example 4: Display disabled job triggers
```
PS C:\>Get-ScheduledJob | Get-JobTrigger | where {!$_.Enabled} | Format-Table Id, Frequency, At, DaysOfWeek, Enabled, @{Label="JobName";Expression={$_.JobDefinition.Name}}
Id Frequency At                     DaysOfWeek Enabled JobName
-- --------- --                     ---------- ------- -------
 1    Weekly 9/28/2011 3:00:00 AM   {Monday}     False Backup-Archive
 2    Daily 9/29/2011 1:00:00 AM                 False Backup-Archive
 1    Weekly 10/20/2011 11:00:00 PM {Friday}     False Inventory
 1    Weekly 11/2/2011 2:00:00 PM   {Monday}     False Inventory
```

This command displays all disabled job triggers of all scheduled jobs in a table.
You can use a command like this one to discover job triggers that might need to be enabled.

The command uses the Get-ScheduledJob cmdlet to get  the scheduled jobs on the local computer.
A pipeline operator \(|\) sends the scheduled jobs to the Get-JobTrigger cmdlet, which gets all job triggers of the scheduled jobs.
Another pipeline operator sends the job triggers to the Where-Object cmdlet, which returns only job triggers that are disabled, that is, where the value of the Enabled property of the job trigger is not \(!\) true.

Another pipeline operator sends the disabled job triggers to the Format-Table cmdlet, which displays the selected properties of the job triggers in a table.
The properties include a new JobName property that displays the name of the scheduled job in the JobDefinition property of the job trigger.

## PARAMETERS

### -InputObject
Specifies the job trigger to be enabled.
Enter a variable that contains  ScheduledJobTrigger objects or type a command or expression that gets ScheduledJobTriger objects, such as a Get-JobTrigger command.
You can also pipe a ScheduledJobTrigger object to Enable-JobTrigger.

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
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger
You can pipe job triggers to Enable-JobTrigger.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
Enable-JobTrigger does not generate errors or warnings if you enable a job trigger that is already enabled.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=223917)

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


