---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=512991
schema: 2.0.0
---

# Debug-Job
## SYNOPSIS
Debugs a running background, remote, or Windows PowerShell Workflow job.

## SYNTAX

### JobParameterSet (Default)
```
Debug-Job [-Job] <Job> [-WhatIf] [-Confirm]
```

### JobNameParameterSet
```
Debug-Job [-Name] <String> [-WhatIf] [-Confirm]
```

### JobIdParameterSet
```
Debug-Job [-Id] <Int32> [-WhatIf] [-Confirm]
```

### JobInstanceIdParameterSet
```
Debug-Job [-InstanceId] <Guid> [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Debug-Job cmdlet lets you debug scripts that are running within jobs.
The cmdlet is designed to debug Windows PowerShell Workflow jobs, background jobs, and jobs running in remote sessions.
Debug-Job accepts a running job object, name, ID, or InstanceId as input, and starts a debugging session on the script it is running.
The debugger quit command stops the job and running script.
Starting in Windows PowerShell 5.0, the exit command detaches the debugger, and allows the job to continue running.

## EXAMPLES

### Example 1: Debug a job by job ID
```
PS C:\>Debug-Job -ID 3
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
3      Job3            RemoteJob       Running       True            PowerShellIx         TestWFDemo1.ps1
          Entering debug mode. Use h or ? for help.

          Hit Line breakpoint on 'C:\TestWFDemo1.ps1:8'

          At C:\TestWFDemo1.ps1:8 char:5
          +     Write-Output -InputObject "Now writing output:" 
          +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          [DBG:PowerShellIx]: PS C:\>> list

              3: 
              4:  workflow SampleWorkflowTest
              5:  {
              6:      param ($MyOutput) 
              7: 
              8:*     Write-Output -InputObject "Now writing output:" 
              9:      Write-Output -Input $MyOutput
             10: 
             11:      Write-Output -InputObject "Get PowerShell process:" 
             12:      Get-Process -Name powershell
             13: 
             14:      Write-Output -InputObject "Workflow function complete." 
             15:  }
             16: 
             17:  # Call workflow function
             18:  SampleWorkflowTest -MyOutput "Hello"
```

In this example, the debugger breaks into a running job with an ID of 3.

## PARAMETERS

### -Id
Specifies the ID number of a running job.
To get the ID number of a job, run the Get-Job cmdlet.

```yaml
Type: Int32
Parameter Sets: JobIdParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Specifies the InstanceId GUID of a running job.
To get the InstanceId of a job, run the Get-Job cmdlet, piping the results into a Format-* cmdlet, as shown in this example:  Get-Job | Format-List -Property Id,Name,InstanceId,State.

```yaml
Type: Guid
Parameter Sets: JobInstanceIdParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Job
Specifies a running job object.
The simplest way to use this parameter is to save the results of a Get-Job command that returns the running job that you want to debug in a variable, and then specify the variable as the value of this parameter.

```yaml
Type: Job
Parameter Sets: JobParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Specifies a job by the job's friendly name.
When you start a job, you can specify a job name by adding the JobName parameter, in cmdlets such as Invoke-Command and Start-Job.

```yaml
Type: String
Parameter Sets: JobNameParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

### System.Management.Automation.RemotingJob

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Job]()

[Receive-Job]()

[Remove-Job]()

[Resume-Job]()

[Start-Job]()

[Stop-Job]()

[Suspend-Job]()

[Wait-Job]()

[about_Debuggers]()

[about_Jobs]()

[about_Job_Details]()

[about_Remote_Jobs]()

[about_Scheduled_Jobs]()

