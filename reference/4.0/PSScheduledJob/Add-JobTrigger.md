---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=290620
external help file:  Microsoft.PowerShell.ScheduledJob.dll-Help.xml
title:  Add-JobTrigger
---
# Add-JobTrigger

## SYNOPSIS
Adds job triggers to scheduled jobs

## SYNTAX

### JobDefinition (Default)

```
Add-JobTrigger [-Trigger] <ScheduledJobTrigger[]> [-InputObject] <ScheduledJobDefinition[]>
 [<CommonParameters>]
```

### JobDefinitionName

```
Add-JobTrigger [-Trigger] <ScheduledJobTrigger[]> [-Name] <String[]> [<CommonParameters>]
```

### JobDefinitionId

```
Add-JobTrigger [-Trigger] <ScheduledJobTrigger[]> [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION

The `Add-JobTrigger` cmdlet adds job triggers to scheduled jobs.
You can use it to add multiple triggers to multiple scheduled jobs.

A "job trigger" starts a scheduled job on a one-time or recurring schedule or when an event occurs.

Use the **Trigger** parameter of `Add-JobTrigger` to identify the job triggers to add.
Use the **Name**, **ID**, or **InputObject** parameters of `Add-JobTrigger` to identify the
scheduled job to which the triggers are added.

To create job triggers for the value of the **Trigger** parameter, use the `New-JobTrigger` cmdlet
or use a hash table to specify the job trigger.

`Add-JobTrigger` is one of a collection of job scheduling cmdlets in the **PSScheduledJob** module
that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see
[about_Scheduled_Jobs](./About/about_Scheduled_Jobs.md).

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Add a job trigger to a scheduled job

```powershell
$Daily = New-JobTrigger -Daily -At 3AMPS C:\> Add-JobTrigger -Trigger $Daily -Name TestJob
```

These commands add the Daily job trigger to the TestJob scheduled job.

The first command uses the `New-JobTrigger` cmdlet to create a job trigger that starts a scheduled
job every day at 3:00 a.m. The command saves the job trigger in the $Daily variable.

The second command uses the `Add-JobTrigger` cmdlet to add the job trigger in the $Startup variable
to the TestJob scheduled job.

### Example 2: Add a job trigger to many scheduled jobs

```powershell
Get-ScheduledJob | Add-JobTrigger -Trigger (New-JobTrigger -AtStartup)
```

This command adds an AtStartup job trigger to all scheduled jobs on the local computer.
It uses the `Get-ScheduledJob` to get all of the scheduled jobs on the computer.
It uses a pipeline operator (|) to send the jobs to the `Add-JobTrigger` cmdlet, which adds the job
trigger to each of the scheduled jobs.
The value of the **Trigger** parameter is a `New-JobTrigger` command that creates the AtStartup job
trigger.

### Example 3: Copy a job trigger

```powershell
$t = Get-JobTrigger -Name BackupArchives

Add-JobTrigger -Name TestBackup, BackupLogs -Trigger $t
```

These commands copy the job trigger from the BackupArchives scheduled job and add it to the
TestBackup and BackupLogs scheduled jobs.

The first command uses the `Get-JobTrigger` cmdlet to get the job trigger of the BackupArchives
scheduled job. The command saves the trigger in the $t variable.

The second command uses the `Add-JobTrigger` cmdlet to add the job trigger in $t to the TestBackup
and BackupLogs scheduled jobs.

## PARAMETERS

### -Id

Specifies the identification numbers of the scheduled jobs.
`Add-JobTrigger` adds the job trigger to the specified scheduled jobs.

To get the identification number of scheduled jobs on the local computer or a remote computer, use
the `Get-ScheduledJob` cmdlet.

```yaml
Type: Int32[]
Parameter Sets: JobDefinitionId
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the scheduled jobs.
Enter a variable that contains **ScheduledJob** objects or type a command or expression that gets
**ScheduledJob** objects, such as a `Get-ScheduledJob` command.
You can also pipe **ScheduledJob** objects to `Add-JobTrigger`.

```yaml
Type: ScheduledJobDefinition[]
Parameter Sets: JobDefinition
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the names of the scheduled jobs.
`Add-JobTrigger` adds the job triggers to the specified scheduled jobs.
Wildcards are supported.

To get the names of scheduled jobs on the local computer or a remote computer, use the
`Get-ScheduledJob` cmdlet.

```yaml
Type: String[]
Parameter Sets: JobDefinitionName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trigger

Specifies the job triggers to add.
Enter a hash table that specifies job triggers or a variable that contains **ScheduledJobTrigger**
objects, or type a command or expression that gets **ScheduledJobTrigger** objects, such as a
`Get-JobTrigger` command. You can also pipe **ScheduledJobTrigger** objects to `Add-JobTrigger`.

```yaml
Type: ScheduledJobTrigger[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger, Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

You can pipe job triggers or scheduled jobs to `Add-JobTrigger`.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

## RELATED LINKS

[about_Scheduled_Jobs](About/about_Scheduled_Jobs.md)

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
