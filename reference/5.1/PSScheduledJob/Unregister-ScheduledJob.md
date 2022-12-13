---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/unregister-scheduledjob?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Unregister-ScheduledJob
---

# Unregister-ScheduledJob

## SYNOPSIS

Deletes scheduled jobs on the local computer.

## SYNTAX

### Definition (Default)

```
Unregister-ScheduledJob [-InputObject] <ScheduledJobDefinition[]> [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DefinitionId

```
Unregister-ScheduledJob [-Id] <Int32[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DefinitionName

```
Unregister-ScheduledJob [-Name] <String[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Unregister-ScheduledJob` cmdlet deletes scheduled jobs from the local computer.

When it deletes or unregisters a scheduled job, `Unregister-ScheduledJob` deletes the directory for
the scheduled job (in the
`$HOME\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory`), which contains the XML
file that defines the scheduled job, the job execution history, and all job results. This action
also deletes the job from Task Scheduler.

`Unregister-ScheduledJob` deletes only the scheduled jobs that are created by using the
`Register-ScheduledJob` cmdlet. It does not delete scheduled jobs that are created in Task
Scheduler.

You can use the parameters of `Unregister-ScheduledJob` to delete scheduled jobs by ID or name, or
pipe scheduled jobs from `Get-ScheduledJob` to `Unregister-ScheduledJob`.

`Unregister-ScheduledJob` is one of a collection of job scheduling cmdlets in the PSScheduledJob
module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see [about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Delete a scheduled job

```powershell
Unregister-ScheduledJob TestJob
```

This command deletes the TestJob scheduled job on the local computer.

### Example 2: Delete all scheduled jobs

```powershell
Get-ScheduledJob | Unregister-ScheduledJob -Force
Unregister-ScheduledJob -Name "*" -Force
```

This example shows two different commands that delete all scheduled jobs on the local computer.

The first command uses the `Get-ScheduledJob` cmdlet to get all scheduled jobs on the local
computer. A pipeline operator (`|`) sends the scheduled jobs to `Unregister-ScheduleJob`, which
deletes them.

The second command uses the **Name** parameter of `Unregister-ScheduledJob` with a value of all
(`*`) to delete all scheduled jobs.

Both commands use the **Force** parameter, which deletes a scheduled job even if an instance of the
job is running.

### Example 3: Delete a scheduled job on a remote computer

```powershell
Invoke-Command -ComputerName "Server01" { Unregister-ScheduledJob -Name "Test*"}
```

This command deletes scheduled jobs with names that begin with Test on the Server01 remote computer.
The command uses the `Invoke-Command` cmdlet to run the `Unregister-ScheduledJob` command on the
Server02 computer.

## PARAMETERS

### -Force

Deletes the scheduled job even if an instance of the job is running. By default,
`Unregister-ScheduledJob` does not interrupt running jobs.

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

### -Id

Deletes the scheduled jobs with the specified identification numbers (ID). Enter the IDs of
scheduled jobs on the computer.

```yaml
Type: System.Int32[]
Parameter Sets: DefinitionId
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a scheduled job. Enter a variable that contains **ScheduledJob** objects or type a command
or expression that gets **ScheduledJob** objects, such as a `Get-ScheduledJob` command. You can also
pipe **ScheduledJob** objects to `Unregister-JobTrigger`.

```yaml
Type: Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition[]
Parameter Sets: Definition
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Deletes the scheduled jobs with the specified names. Enter the names of one or more scheduled jobs
on the computer. Wildcards are supported.

```yaml
Type: System.String[]
Parameter Sets: DefinitionName
Aliases:

Required: True
Position: 0
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

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

You can pipe a scheduled job to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

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
