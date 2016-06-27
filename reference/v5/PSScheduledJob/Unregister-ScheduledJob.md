---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=287623
schema: 2.0.0
---

# Unregister-ScheduledJob
## SYNOPSIS
Deletes scheduled jobs on the local computer.

## SYNTAX

### Definition (Default)
```
Unregister-ScheduledJob [-InputObject] <ScheduledJobDefinition[]> [-Force] [-WhatIf] [-Confirm]
```

### DefinitionId
```
Unregister-ScheduledJob [-Id] <Int32[]> [-Force] [-WhatIf] [-Confirm]
```

### DefinitionName
```
Unregister-ScheduledJob [-Name] <String[]> [-Force] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Unregister-ScheduledJob cmdlet deletes scheduled jobs from the local computer.

When it deletes or "unregisters" a scheduled job, Unregister-ScheduledJob deletes the directory for the scheduled job (in the $home\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs directory), which contains the XML file that defines the scheduled job, the job execution history, and all job results.
This action also deletes the job from Task Scheduler.

Unregister-ScheduledJob deletes only the scheduled jobs that are created by using the Register-ScheduledJob cmdlet.
It does not delete scheduled jobs that are created in Task Scheduler.

You can use the parameters of Unregister-ScheduledJob to delete scheduled jobs by ID or name, or pipe scheduled jobs from Get-ScheduledJob to Unregister-ScheduledJob.

Unregister-ScheduledJob is one of a collection of job scheduling cmdlets in the PSScheduledJob module that is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module.
Import the PSScheduledJob module and then type: Get-Help about_Scheduled* or see about_Scheduled_Jobs.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Delete a scheduled job
```
PS C:\>Unregister-ScheduledJob TestJob
```

This command deletes the TestJob scheduled job on the local computer.

### Example 2: Delete all scheduled jobs
```
PS C:\>Get-ScheduledJob | Unregister-ScheduledJob -Force
 
                      
PS C:\>Unregistered-ScheduledJob -Name * -Force
```

This examples shows two different commands that delete all scheduled jobs on the local computer.

The first command uses the Get-ScheduledJob cmdlet to get all scheduled jobs on the local computer.
A pipeline operator (|) sends the scheduled jobs to Unregister-ScheduleJob, which deletes them.

The second command uses the Name parameter of Unregister-ScheduledJob with a value of all (*) to delete all scheduled jobs.

Both commands use the Force parameter, which deletes a scheduled job even if an instance of the job is running.

### Example 3: Delete a scheduled job on a remote computer
```
PS C:\>Invoke-Command -ComputerName Server01 { Unregister-ScheduledJob -Name Test*}
```

This command deletes scheduled jobs with names that begin with "Test" on the Server01 remote computer.
The command uses the Invoke-Command cmdlet to run the Unregister-ScheduledJob command on the Server02 computer.

## PARAMETERS

### -Force
Deletes the scheduled job even if an instance of the job is running.
By default, Unregister-ScheduledJob does not interrupt running jobs.

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

### -Id
Deletes the scheduled jobs with the specified identification numbers (ID).
Enter the IDs of scheduled jobs on the computer.

```yaml
Type: Int32[]
Parameter Sets: DefinitionId
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a scheduled job.
Enter a variable that contains  ScheduledJob objects or type a command or expression that gets ScheduledJob objects, such as a Get-ScheduledJob command.
You can also pipe ScheduledJob objects to Unregister-JobTrigger.

```yaml
Type: ScheduledJobDefinition[]
Parameter Sets: Definition
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Deletes the scheduled jobs with the specified names.
Enter the names of one or more scheduled jobs on the computer.
Wildcards are supported.

```yaml
Type: String[]
Parameter Sets: DefinitionName
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
You can pipe scheduled jobs to Unregister-ScheduledJob

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[about_Scheduled_Jobs]()

[Add-JobTrigger]()

[Disable-JobTrigger]()

[Disable-ScheduledJob]()

[Enable-JobTrigger]()

[Enable-ScheduledJob]()

[Get-JobTrigger]()

[Get-ScheduledJob]()

[Get-ScheduledJobOption]()

[New-JobTrigger]()

[New-ScheduledJobOption]()

[Register-ScheduledJob]()

[Remove-JobTrigger]()

[Set-JobTrigger]()

[Set-ScheduledJob]()

[Set-ScheduledJobOption]()

[Unregister-ScheduledJob]()

