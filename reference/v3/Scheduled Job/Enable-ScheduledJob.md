---
external help file: PSITPro3_ScheduledJob.xml
schema: 2.0.0
---

# Enable-ScheduledJob
## SYNOPSIS
Enables a scheduled job

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Enable-ScheduledJob [-InputObject] <ScheduledJobDefinition> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Enable-ScheduledJob [-Id] <Int32> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Enable-ScheduledJob [-Name] <String> [-PassThru] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Enable-ScheduledJob cmdlet re-enables scheduled jobs that are disabled, such as those that are disabled by using the Disable-ScheduledJob cmdlet.
Enabled jobs run automatically when triggered.

To enable a scheduled job, the Enable-ScheduledJob cmdlet sets the Enabled property of the scheduled job to True \($true\).

Enabled-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Enable a scheduled job
```
PS C:\>Enable-ScheduledJob -ID 2 -Passthru
Id         Name            Triggers        Command                                  Enabled
--         ----            --------        -------                                  -------
2          Inventory       {1, 2}          \\Srv01\Scripts\Get-FullInventory.ps1    True
```

This command enables the scheduled job with ID 2 on the local computer.
The output shows the effect of the command.

### Example 2: Enable  all scheduled jobs
```
PS C:\>Get-ScheduledJob | Enable-ScheduledJob -Passthru
Id         Name            Triggers        Command                                  Enabled
--         ----            --------        -------                                  -------
1          ArchiveProje... {}              C:\Scripts\Archive-DxProjects.ps1        True
2          Inventory       {1, 2}          \\Srv01\Scripts\Get-FullInventory.ps1    True
4          Test-HelpFiles  {1}             .\Test-HelpFiles.ps1                     True
5          TestJob         {1, 2}          .\Run-AllTests.ps1                       True
```

This command enables all scheduled jobs on the local computer.
It uses the Get-ScheduledJob cmdlet to get all scheduled job and the Enable-ScheduledJob cmdlet to enable them.

Enable-ScheduledJob does not generate warnings or errors if you enable a scheduled job that is already enabled, so you can enable all scheduled jobs without conditions.

### Example 3: Enable selected scheduled jobs
```
PS C:\>Get-ScheduledJob | Get-ScheduledJobOption | Where-Object {$_.RunWithoutNetwork} | ForEach-Object {Enable-ScheduledJob -InputObject $_.JobDefinition}
```

This command enables scheduled jobs that do not require a network connection.

The command uses the Get-ScheduledJob cmdlet to get all scheduled jobs on the computer.
A pipeline operator sends the scheduled jobs to the Get-ScheduledJobOption cmdlet, which gets the job options of each scheduled job.
Each job options object has a JobDefinition property that contains the associated scheduled job.
The JobDefinition property is used to complete the command.

The command uses a pipeline operator \(|\) to send the job options to the  Where-Object cmdlet, which selects scheduled job option objects in which the RunWithoutNetwork property has a value of True \($true\).
Another pipeline operator sends the selected scheduled job options objects to the ForEach-Object cmdlet which runs an Enable-ScheduledJob command on the scheduled job in the value of the JobDefinition property of each job options object.

### Example 4: Enable scheduled jobs on a remote computer
```
PS C:\>Invoke-Command -ComputerName Srv01, Srv10 -ScriptBlock {Enable-ScheduledJob -Name Inventory}
```

This command enables scheduled jobs that have "test" in their names on two remote computers, Srv01 and Srv10.

The command uses the Invoke-Command cmdlet to run an Enable-ScheduledJob command on the Srv01 and Srv10 computers.
The command uses the Name parameter of Enable-ScheduledJob to enable the Inventory scheduled job on each computer.

## PARAMETERS

### -Id
Enables the scheduled job with the specified identification number \(ID\).
Enter the ID of a scheduled job.

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -InputObject
Specifies the scheduled job to be enabled.
Enter a variable that contains  ScheduledJobDefinition objects or type a command or expression that gets ScheduledJobDefinition objects, such as a Get-ScheduledJob command.
You can also pipe a ScheduledJobDefinition object to Enable-ScheduledJob.

```yaml
Type: ScheduledJobDefinition
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Enables the scheduled jobs with the specified names.
Enter the name of a scheduled job.
Wildcards are supported.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: false
Accept wildcard characters: False
```

### -PassThru
Returns the scheduled jobs that were enabled.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
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

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
You can pipe a scheduled job to Enable-ScheduledJob.

## OUTPUTS

### None or Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
If you use the Passthru parameter, Enable-ScheduledJob returns the scheduled job that was enabled.
Otherwise, this cmdlet does not generate any output.

## NOTES
Enable-ScheduledJob does not generate warnings or errors if you use it to enable a scheduled job that is already enabled.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=223926)

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


