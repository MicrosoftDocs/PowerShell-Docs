---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/?LinkId=512991
schema: 2.0.0
---

# Debug-Job
## SYNOPSIS
Debugs a running background, remote, or Windows PowerShell Workflow job.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Debug-Job [-Job] <Job> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Debug-Job [-Id] <Int32> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Debug-Job [-InstanceId] <Guid> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Debug-Job [-Name] <String> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Debug-Job cmdlet lets you debug scripts that are running within jobs.
The cmdlet is designed to debug Windows PowerShell Workflow jobs, background jobs, and jobs running in remote sessions.
Debug-Job accepts a running job object, name, ID, or instance ID as input, and starts a debugging session on the script it is running.
The debugger quit command stops the job and running script.
Starting in Windows PowerShell 5.0, the exit command detaches the debugger, and allows the job to continue to run.

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

This command breaks into a running job with an ID of 3.

## PARAMETERS

### -Id
Specifies the ID number of a running job.
To get the ID number of a job, run the Get-Job cmdlet.

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Specifies the instance ID GUID of a running job.
To get the InstanceId of a job, run the Get-Job cmdlet, piping the results into a Format-* cmdlet, as shown in the following example: 

Get-Job | Format-List -Property Id,Name,InstanceId,State

```yaml
Type: Guid
Parameter Sets: UNNAMED_PARAMETER_SET_3
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByValue,ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies a job by the friendly name of the job.
When you start a job, you can specify a job name by adding the JobName parameter, in cmdlets such as Invoke-Command and Start-Job.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_4
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
Aliases: 

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
Aliases: 

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

[Get-Job](1352c534-7193-46ca-9ab1-0c5219a661ad)

[Receive-Job](78fcc10b-5cde-4bf2-a901-33f8237f87fe)

[Remove-Job](eaa911ae-3a84-4279-a9db-fead1dfdb8bb)

[Resume-Job](3a22c75a-f0bd-4afd-ac3c-da7ccd22ec45)

[Start-Job](2bc04935-0deb-4ec0-b856-d7290cca6442)

[Stop-Job](b998b518-121a-48f4-b062-2b388069de18)

[Suspend-Job](3496f930-2c84-4a90-9c65-ad562f0dc4cf)

[Wait-Job](cb8a2c67-f8a5-45a8-a27f-2ec028c9da8f)

[about_Debuggers](2b2ce8b3-f881-4528-bd30-f453dea06755)

[about_Jobs](7362512a-8a4e-4575-b2ea-a740e5c4f002)

[about_Job_Details](87511f90-984f-44d1-b869-8671b4181717)

[about_Remote_Jobs](b68c635f-5ee0-44fd-8693-28f8f4ca9fa0)

[about_Scheduled_Jobs](3b546629-703c-4939-b44f-52dd567bce92)

