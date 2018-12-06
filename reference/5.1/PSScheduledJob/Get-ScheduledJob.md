---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSScheduledJob
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821686
schema: 2.0.0
title: Get-ScheduledJob
---

# Get-ScheduledJob

## SYNOPSIS
Gets scheduled jobs on the local computer.

## SYNTAX

### DefinitionId (Default)
```
Get-ScheduledJob [[-Id] <Int32[]>] [<CommonParameters>]
```

### DefinitionName
```
Get-ScheduledJob [-Name] <String[]> [<CommonParameters>]
```

## DESCRIPTION
The **Get-ScheduledJob** cmdlet gets scheduled jobs on the local computer.
**Get-ScheduledJob** gets only scheduled jobs that are created by the current user using the Register-ScheduledJob cmdlet.

Although jobs that are created by using the **Register-ScheduledJob** cmdlet appear in Task Scheduler, **Get-ScheduledJob** gets only scheduled jobs.
It does not get scheduled tasks created in Task Scheduler.

Without parameters, **Get-ScheduledJob** gets all scheduled jobs on the computer.
You can use the parameters of **Get-ScheduledJob** to get scheduled jobs by ID or name and examine them or pipe them to other cmdlets.

**Get-ScheduledJob** is one of a collection of job scheduling cmdlets in the **PSScheduledJob** module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see about_Scheduled_Jobs.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Get all scheduled jobs
```
PS C:\> Get-ScheduledJob
```

This command gets all scheduled jobs on the local computer.

### Example 2: Get scheduled jobs by name
```
PS C:\> Get-ScheduledJob -Name *Backup*, *Archive*
```

This command gets all scheduled jobs on the computer that have names that include Backup or Archive.
This command format lets you search for particular jobs.

### Example 3: Get scheduled jobs on remote computers
```
PS C:\> Invoke-Command -ComputerName (Get-Content Servers.txt) {Get-ScheduledJob}
```

This command gets all scheduled jobs on the computers that are listed in the Servers.txt file.
The command uses the Invoke-Command cmdlet to run a **Get-ScheduleJob** command on each computer.

### Example 4: Pipe scheduled jobs to other cmdlets
```
PS C:\> Get-ScheduledJob DailyBackup, WeeklyBackup | Get-JobTrigger
```

This command gets the job triggers of the DailyBackup and WeeklyBackup scheduled jobs.
It uses the **Get-ScheduledJob** cmdlet to get the scheduled jobs and the Get-JobTrigger cmdlet to get the job triggers of the scheduled jobs.

## PARAMETERS

### -Id
Gets only the scheduled jobs with the specified identification number (ID).
Enter one or more IDs of scheduled jobs on the computer.
By default, **Get-ScheduledJob** gets all scheduled jobs on the computer.

```yaml
Type: Int32[]
Parameter Sets: DefinitionId
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Gets only the scheduled jobs with the specified names.
Enter one or more names of scheduled jobs on the computer.
Wildcards are supported.
By default, **Get-ScheduledJob** gets all scheduled jobs on the computer.

```yaml
Type: String[]
Parameter Sets: DefinitionName
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to **Get-ScheduledJob**.

## OUTPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition

## NOTES
* Each scheduled job is saved in a subdirectory of the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory on the local computer. The subdirectory is named for the scheduled job and contains the XML file for the scheduled job and records of its execution history. For more information about scheduled jobs on disk, see about_Scheduled_Jobs_Advanced.
* Scheduled jobs that you create in Windows PowerShell appear in Task Scheduler in the Task Scheduler Library\Microsoft\Windows\PowerShell\ScheduledJobs folder. You can use Task Scheduler to view and edit the scheduled job.
* You can use Task Scheduler, the SchTasks.exe command-line tool, and the Task Scheduler cmdlets to manage scheduled jobs that you create with the Scheduled Job cmdlets. However, you cannot use the Scheduled Job cmdlets to manage tasks that you create in Task Scheduler.

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