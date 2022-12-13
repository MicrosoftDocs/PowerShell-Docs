---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/disable-jobtrigger?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-JobTrigger
---

# Disable-JobTrigger

## SYNOPSIS
Disables the job triggers of scheduled jobs.

## SYNTAX

```
Disable-JobTrigger [-InputObject] <ScheduledJobTrigger[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-JobTrigger` cmdlet temporarily disables the job triggers of scheduled jobs. Disabling
preserves all job trigger properties, but it prevents the job trigger from starting the scheduled
job.

To use this cmdlet, use the `Get-JobTrigger` cmdlet to get the job triggers. Then pipe the job
triggers to `Disable-JobTrigger` or use its **InputObject** parameter.

To disable a job trigger, the `Disable-JobTrigger` cmdlet sets the Enabled property of the job
trigger to `$False`. To re-enable the job trigger, use the `Enable-JobTrigger` cmdlet, which sets
the **Enabled** property of the job trigger to $True. Disabling a job trigger does not disable the
scheduled job, such as is done by the `Disable-ScheduledJob` cmdlet, but if you disable all job
triggers, the effect is the same as disabling the scheduled job.

If you disable a scheduled job or disable all job triggers of a scheduled job, you can still start
the job by using the `Start-Job` cmdlet or use the disabled scheduled job as a template.

`Disable-ScheduledJob` is one of a collection of job scheduling cmdlets in the **PSScheduledJob** module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see [about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Disable a job trigger

This example disables the first trigger a scheduled job on the local computer.

```powershell
PS C:\> Get-JobTrigger -Name "Backup-Archives" -TriggerID 1 | Disable-JobTrigger
```

The command uses the `Get-JobTrigger` cmdlet to get the job trigger. A pipeline operator (`|`)sends
the job trigger to the `Disable-JobTrigger` cmdlet, which disables it.

### Example 2: Disable all job triggers

```powershell
Get-ScheduledJob -Name "Backup-Archives,Inventory" | Get-JobTrigger | Disable-JobTrigger
Get-ScheduledJob -Name "Backup-Archives,Inventory" | Get-JobTrigger |
    Format-Table -Property ID, Frequency, At, DaysOfWeek, Enabled, @{Label="JobName";Expression={$_.JobDefinition.Name}} -AutoSize
```

```Output
Id Frequency At                     DaysOfWeek Enabled JobName
-- --------- --                     ---------- ------- -------
1  Weekly    9/28/2011 3:00:00 AM   {Monday}   False   Backup-Archive
2  Daily     9/29/2011 1:00:00 AM              False   Backup-Archive
1  Weekly    10/20/2011 11:00:00 PM {Friday}   False   Inventory
1  Weekly    11/2/2011 2:00:00 PM   {Monday}   False   Inventory
```

The first command uses the `Get-ScheduledJob` cmdlet to get the `Backup-Archives` and Inventory
scheduled jobs. A pipeline operator (`|`) sends the scheduled jobs to the `Get-JobTrigger` cmdlet,
which gets all job triggers of the scheduled jobs. Another pipeline operator sends the job triggers
to the `Disable-JobTrigger` cmdlet, which disables them.The first command uses the
`Get-ScheduledJob` cmdlet to get the jobs, because its **Name** parameter takes multiple names.

The second command displays the results. The command repeats the `Get-ScheduledJob` and
`Get-JobTrigger` command. A pipeline operator sends the job triggers to the `Format-Table` cmdlet,
which displays the job triggers in a table. The `Format-Table` command adds a JobName property that
displays the value of the Name property of the scheduled job in the JobDefinition property of the
job trigger object.

These commands disable all job triggers on two scheduled jobs and display the results.

### Example 3: Disable job trigger of a scheduled job on a remote computer

This example disables the daily job triggers for a scheduled job on a remote computer

```powershell
Invoke-Command -ComputerName Server01 {Get-JobTrigger -Name DeployPackage | Where-Object {$_.Frequency -eq "Daily"} | Disable-JobTrigger}
```

The command uses the `Invoke-Command` cmdlet to run the commands on the Server01 computer. The
remote command uses the `Get-JobTrigger` cmdlet to get the job triggers of the DeployPackage
scheduled job. A pipeline operator sends the job triggers to the `Where-Object` cmdlet, which
returns only daily job triggers. A pipeline operator sends the daily job triggers to the
`Disable-JobTrigger` cmdlet, which disables them.

## PARAMETERS

### -InputObject

Specifies the job trigger to be disabled. Enter a variable that contains **ScheduledJobTrigger**
objects or type a command or expression that gets **ScheduledJobTrigger** objects, such as a
`Get-JobTrigger` command. You can also pipe a **ScheduledJobTrigger** object to
`Disable-JobTrigger`.

```yaml
Type: Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working. By default, this cmdlet does not
generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger

You can pipe a job trigger to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

- `Disable-JobTrigger` does not generate errors or warnings if you disable a job trigger that is
  already disabled.

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
