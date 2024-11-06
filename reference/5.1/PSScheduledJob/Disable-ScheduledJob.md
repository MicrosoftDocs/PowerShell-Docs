---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/disable-scheduledjob?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-ScheduledJob
---

# Disable-ScheduledJob

## SYNOPSIS
Disables a scheduled job.

## SYNTAX

### Definition (Default)

```
Disable-ScheduledJob [-InputObject] <ScheduledJobDefinition> [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DefinitionId

```
Disable-ScheduledJob [-Id] <Int32> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DefinitionName

```
Disable-ScheduledJob [-Name] <String> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-ScheduledJob` cmdlet temporarily disables scheduled jobs. Disabling preserves all job
properties and does not disable the job triggers, but it prevents the scheduled jobs from starting
automatically when triggered. You can start a disabled scheduled job by using the `Start-Job` cmdlet
or use a disabled scheduled job as a template.

To disable a scheduled job, the `Disable-ScheduledJob` cmdlet sets the **Enabled** property of the
scheduled job to False. To re-enable the scheduled job, use the `Enable-ScheduledJob` cmdlet.

`Disable-ScheduledJob` is one of a collection of job scheduling cmdlets in the **PSScheduledJob**
module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see [about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Disable a scheduled job

This example disables a scheduled job on the local computer.

```powershell
Disable-ScheduledJob -ID 2 -PassThru
```

This command disables the scheduled job with ID 2 on the local computer.

### Example 2: Disable all scheduled jobs

This example disables all scheduled jobs on the local computer.

```powershell
Get-ScheduledJob | Disable-ScheduledJob -PassThru
```

```Output
Id         Name            Triggers        Command                                  Enabled
--         ----            --------        -------                                  -------
1          ArchiveProje... {}              C:\Scripts\Archive-DxProjects.ps1        False
2          Inventory       {1, 2}          \\Srv01\Scripts\Get-FullInventory.ps1    False
4          Test-HelpFiles  {1}             .\Test-HelpFiles.ps1                     False
5          TestJob         {1, 2}          .\Run-AllTests.ps1                       False
```

The `Get-ScheduledJob` cmdlet to gets all scheduled job and pipes them to the `Disable-ScheduledJob`
cmdlet to disable them.

You can re-enable scheduled job by using the `Enable-ScheduledJob` cmdlet and run a disabled
scheduled job by using the `Start-Job` cmdlet.

`Disable-ScheduledJob` does not generate warnings or errors if you disable a scheduled job that is
already disabled, so you can disable all scheduled jobs without conditions.

### Example 3: Disable selected scheduled jobs

This example disables scheduled job do not include a credential.

```powershell
Get-ScheduledJob | Where-Object {!$_.Credential} | Disable-ScheduledJob
```

Jobs without credentials run with the permission of the user who created them.

The command uses the `Get-ScheduledJob` cmdlet to get all scheduled jobs on the computer. A pipeline
operator sends the scheduled jobs to the `Where-Object` cmdlet, which selects scheduled jobs that do
not have credentials. The command uses the not (`!`) operator and references the Credential property
of the scheduled job. Another pipeline operator sends the selected scheduled jobs to the
`Disable-ScheduledJob` cmdlet, which disables them.

### Example 4: Disable scheduled jobs on a remote computer

This example disables a scheduled job on two remote computers.

```powershell
Invoke-Command -ComputerName Srv01, Srv10 -ScriptBlock {Disable-ScheduledJob -Name TestJob}
```

The command uses the `Invoke-Command` cmdlet to run a `Disable-ScheduledJob` command on the Srv01
and Srv10 computers. The command uses the **Name** parameter of `Disable-ScheduledJob` to select the
TestJob scheduled job on each computer.

### Example 5: Disable a scheduled job by its global ID

This examples shows how to disable a scheduled job by using its global identifier. The value of the
GlobalID property of a scheduled job is a unique identifier (GUID). Use the GlobalID value when
precision is required, such as when you are disabling scheduled jobs on multiple computers.

```powershell
Get-ScheduledJob | Format-Table -Property Name, GlobalID, Command -Autosize
```

```Output
Name             GlobalId                             Command
----             --------                             -------
ArchiveProjects1 a26a0b3d-b4e6-44d3-8b95-8706ef621f7c C:\Scripts\Archive-DxProjects.ps1
Inventory        3ac37e5d-84c0-4a8f-9661-7e88ebb8f914 \\Srv01\Scripts\Get-FullInventory.ps1
Backup-Scripts   4d0cc6be-c082-48d1-baec-1bd8278f3c81  Copy-Item C:\CurrentScripts\*.ps1 -Destination C:\BackupScripts
Test-HelpFiles   d77020ca-f20d-42be-86c8-fc64df97db90 .\Test-HelpFiles.ps1
Test-HelpFiles   2f1606d2-c6cf-4bef-8b1c-ae36a9cc9934 .\Test-DomainHelpFiles.ps1
```

```powershell
Get-ScheduledJob | Where-Object {$_.GlobalID = d77020ca-f20d-42be-86c8-fc64df97db90} | Disable-ScheduledJob
```

The first command demonstrates one way of finding the GlobalID of a scheduled job. The command uses
the `Get-ScheduledJob` cmdlet to get the scheduled jobs on the computer. A pipeline operator (`|`)
sends the scheduled jobs to the `Format-Table` cmdlet, which displays the Name, GlobalID, and
Command properties of each job in a table.

The second command uses the `Get-ScheduledJob` cmdlet to get the scheduled jobs on the computer. A
pipeline operator (`|`) sends the scheduled jobs to the `Where-Object` cmdlet, which selects the
scheduled job with the specified global ID. Another pipeline operator sends the job to the
`Disable-ScheduledJob` cmdlet, which disables it.

## PARAMETERS

### -Id

Disables the scheduled job with the specified identification number (ID).
Enter the ID of a scheduled job.

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

Specifies the scheduled job to be disabled. Enter a variable that contains
**ScheduledJobDefinition** objects or type a command or expression that gets
**ScheduledJobDefinition** objects, such as a `Get-ScheduledJob` command. You can also pipe a
**ScheduledJobDefinition** object to `Disable-ScheduledJob`.

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

Disables the scheduled jobs with the specified names. Enter the name of a scheduled job. Wildcards
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

You can pipe a scheduled job to `Disable-ScheduledJob`.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

When you use the **PassThru** parameter, this cmdlet returns the scheduled job that is disabled.

## NOTES

- `Disable-ScheduledJob` does not generate warnings or errors if you use it to disable a scheduled
  job that is already disabled.

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
