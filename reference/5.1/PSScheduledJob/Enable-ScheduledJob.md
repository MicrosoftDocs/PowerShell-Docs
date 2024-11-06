---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/enable-scheduledjob?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Enable-ScheduledJob
---

# Enable-ScheduledJob

## SYNOPSIS
Enables a scheduled job.

## SYNTAX

### Definition (Default)

```
Enable-ScheduledJob [-InputObject] <ScheduledJobDefinition> [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DefinitionId

```
Enable-ScheduledJob [-Id] <Int32> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DefinitionName

```
Enable-ScheduledJob [-Name] <String> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Enable-ScheduledJob` cmdlet re-enables scheduled jobs that are disabled, such as those that are
disabled by using the `Disable-ScheduledJob` cmdlet. Enabled jobs run automatically when triggered.

To enable a scheduled job, the `Enable-ScheduledJob` cmdlet sets the Enabled property of the
scheduled job to `$true`.

`Enabled-ScheduledJob` is one of a collection of job scheduling cmdlets in the **PSScheduledJob**
module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see [about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Enable a scheduled job

This example enables the scheduled job on a local computer.

```powershell
Enable-ScheduledJob -ID 2 -PassThru
```

The `Enable-ScheduledJob` command enables the scheduled job with ID 2 on the local computer. The
**PassThru** parameter allows the Job object to be output.

### Example 2: Enable all scheduled jobs

This examples enables all scheduled jobs on the local computer.

```powershell
Get-ScheduledJob | Enable-ScheduledJob
```

The `Get-ScheduledJob` cmdlet gets all scheduled jobs and pipes them to `Enable-ScheduledJob` cmdlet
to enable them.

`Enable-ScheduledJob` does not generate warnings or errors if you enable a scheduled job that is
already enabled, so you can enable all scheduled jobs without conditions.

### Example 3: Enable selected scheduled jobs

This example enables scheduled jobs that do not require a network connection.

```powershell
Get-ScheduledJob | Get-ScheduledJobOption | Where-Object {$_.RunWithoutNetwork} |
    ForEach-Object {Enable-ScheduledJob -InputObject $_.JobDefinition}
```

The command uses the `Get-ScheduledJob` cmdlet to get all scheduled jobs on the computer. A pipeline
operator (`|`) sends the scheduled jobs to the `Get-ScheduledJobOption` cmdlet, which gets the job
options of each scheduled job. Each job options object has a JobDefinition property that contains
the associated scheduled job. The JobDefinition property is used to complete the command.

The command uses a pipeline operator (`|`) to send the job options to the `Where-Object` cmdlet,
which selects scheduled job option objects in which the **RunWithoutNetwork** property has a value
of `$true`. Another pipeline operator sends the selected scheduled job options objects to the
`ForEach-Object` cmdlet which runs an `Enable-ScheduledJob` command on the scheduled job in the
value of the **JobDefinition** property of each job options object.

### Example 4: Enable scheduled jobs on a remote computer

```powershell
Invoke-Command -ComputerName "Srv01,Srv10" -ScriptBlock {Enable-ScheduledJob -Name "Inventory"}
```

This command enables scheduled jobs that have "test" in their names on two remote computers, Srv01
and Srv10.

The command uses the `Invoke-Command` cmdlet to run an `Enable-ScheduledJob` command on the Srv01
and Srv10 computers. The command uses the **Name** parameter of `Enable-ScheduledJob` to enable the
Inventory scheduled job on each computer.

## PARAMETERS

### -Id

Enables the scheduled job with the specified identification number (ID). Enter the ID of a scheduled
job.

```yaml
Type: System.Int32
Parameter Sets: DefinitionId
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the scheduled job to enable. Enter a variable that contains **ScheduledJobDefinition**
objects or type a command or expression that gets **ScheduledJobDefinition** objects, such as a
`Get-ScheduledJob` command. You can also pipe a **ScheduledJobDefinition** object to
`Enable-ScheduledJob`.

```yaml
Type: Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
Parameter Sets: Definition
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Enables the scheduled jobs with the specified names. Enter the name of a scheduled job. Wildcards
are supported.

```yaml
Type: System.String
Parameter Sets: DefinitionName
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
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

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

You can pipe a scheduled job to `Enable-ScheduledJob`.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

When you use the **PassThru** parameter, this cmdlet returns the scheduled job that it enabled.

## NOTES

- `Enable-ScheduledJob` does not generate warnings or errors if you use it to enable a scheduled job
  that is already enabled.

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
