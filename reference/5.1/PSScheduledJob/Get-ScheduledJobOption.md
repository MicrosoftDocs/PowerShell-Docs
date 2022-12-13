---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/get-scheduledjoboption?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ScheduledJobOption
---

# Get-ScheduledJobOption

## SYNOPSIS
Gets the job options of scheduled jobs.

## SYNTAX

### JobDefinition (Default)

```
Get-ScheduledJobOption [-InputObject] <ScheduledJobDefinition> [<CommonParameters>]
```

### JobDefinitionId

```
Get-ScheduledJobOption [-Id] <Int32> [<CommonParameters>]
```

### JobDefinitionName

```
Get-ScheduledJobOption [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION

The `Get-ScheduledJobOption` cmdlet gets the job options of scheduled jobs. You can use this command
to examine the job options or to pipe the job options to other cmdlets.

Job options are not saved to disk independently; they are part of a scheduled job. To get the job
options of a scheduled job, specify the scheduled job.

Use the parameters of the `Get-ScheduledJobOption` cmdlet to identify the scheduled job. You can
identify scheduled jobs by their names or identification numbers, or by entering or piping
**ScheduledJob** objects, such as those that are returned by the `Get-ScheduledJob` cmdlet, to
`Get-ScheduledJobOption`.

`Get-ScheduledJobOption` is one of a collection of job scheduling cmdlets in the PSScheduledJob
module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see [about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Get job options

This example gets the job options of scheduled jobs matching a specified name.

```powershell
Get-ScheduledJobOption -Name "*Backup*"
```

### Example 2: Get all job options

This example gets the job options of all scheduled jobs on the local computer.

```powershell
Get-ScheduledJob | Get-ScheduledJobOption
```

The example uses the `Get-ScheduledJob` cmdlet to get the scheduled jobs on the local computer. A
pipeline operator (`|`) sends the scheduled jobs to the `Get-ScheduledJobOption` cmdlet, which gets
the job options of each scheduled job.

### Example 3: Get selected job options

This example shows how to find job options object with particular values.

```powershell
Get-ScheduledJob | Get-ScheduledJobOption | Where {$_.RunElevated -and !$_.WaketoRun}

Get-ScheduledJob | Get-ScheduledJobOption | Where {$_.RunElevated -and !$_.WaketoRun} |
    ForEach-Object {$_.JobDefinition}
```

The first command gets job options in which the RunElevated property has a value of $True and the
**RunWithoutNetwork** property has a value of `$false`. The output shows the **JobOptions** object
that was selected.

The second command shows how to find to which scheduled job the job options belong. This command
uses a pipeline operator (`|`) to send the selected job options to the `ForEach-Object` cmdlet,
which gets the **JobDefinition** property of each options object. The JobDefinition property
contains the originating job object.

### Example 4: Use job options to create a new job


This example shows how to use the job options that `Get-ScheduledJobOption` gets in a new scheduled
job.

```powershell
$Opts = Get-ScheduledJobOption -Name "BackupTestLogs"
Register-ScheduledJob -Name "Archive-Scripts" -FilePath "\\Srv01\Scripts\ArchiveScripts.ps1" -ScheduledJobOption $Opts
```

The first command uses `Get-ScheduledJobOption` to get the jobs options of the BackupTestLogs
scheduled job. The command saves the options in the `$Opts` variable.

The second command uses `Register-ScheduledJob` cmdlet to create a new scheduled job.
The value of the **ScheduledJobOption** parameter is the options object in the `$Opts` variable.

### Example 5: Get job options from a remote computer

```powershell
$O = Invoke-Command -ComputerName "Srv01" -ScriptBlock {Get-ScheduledJob -Name "DataDemon" }
```

This command uses the `Invoke-Command` cmdlet to get the scheduled job options of the DataDemon job
on the Srv01 computer. The command saves the options in the `$O` variable.

## PARAMETERS

### -Id

Specifies the identification number of a scheduled job. `Get-ScheduledJobOption` gets the job
options of the specified scheduled job.

To get the identification numbers of scheduled jobs on the local computer or a remote computer, use
the `Get-ScheduledJob` cmdlet.

```yaml
Type: System.Int32
Parameter Sets: JobDefinitionId
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a scheduled job. Enter a variable that contains a **ScheduledJob** object or type a
command or expression that gets a **ScheduledJob** object, such as a `Get-ScheduledJob` command. You
can also pipe a **ScheduledJob** object to `Get-ScheduledJobOption`.

```yaml
Type: Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
Parameter Sets: JobDefinition
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the names of scheduled jobs. `Get-ScheduledJobOption` gets the job options of the
specified scheduled job. Wildcards are supported.

To get the names of scheduled jobs on the local computer or a remote computer, use the
`Get-ScheduledJob` cmdlet.

```yaml
Type: System.String
Parameter Sets: JobDefinitionName
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

You can pipe a scheduled job object to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobOptions

This cmdlet returns a **ScheduledJobOptions** object.

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
