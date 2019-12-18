---
external help file: ThreadJob.dll-Help.xml
Module Name: threadjob
ms.date: 11/04/2019
online version: https://docs.microsoft.com/powershell/module/threadjob/start-threadjob?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-ThreadJob
---
# Start-ThreadJob

## SYNOPSIS
Creates background jobs similar to the `Start-Job` cmdlet.

## SYNTAX

### ScriptBlock

```
Start-ThreadJob [-ScriptBlock] <ScriptBlock> [-Name <String>] [-InitializationScript <ScriptBlock>]
 [-InputObject <PSObject>] [-ArgumentList <Object[]>] [-ThrottleLimit <Int32>] [<CommonParameters>]
```

### FilePath

```
Start-ThreadJob [-FilePath] <String> [-Name <String>] [-InitializationScript <ScriptBlock>]
 [-InputObject <PSObject>] [-ArgumentList <Object[]>] [-ThrottleLimit <Int32>] [<CommonParameters>]
```

## DESCRIPTION

`Start-ThreadJob` creates background jobs similar to the `Start-Job` cmdlet. The main difference is
that the jobs which are created run in separate threads within the local process. By default, the
jobs use the current working directory of the caller that started the job.

The cmdlet also supports a **ThrottleLimit** parameter to limit the number of jobs running at one
time. As more jobs are started, they are queued and wait until the current number of jobs drops
below the throttle limit.

## EXAMPLES

### Example 1 - Create background jobs with a thread limit of 2

```powershell
Start-ThreadJob -ScriptBlock { 1..100 | % { sleep 1; "Output $_" } } -ThrottleLimit 2
Start-ThreadJob -ScriptBlock { 1..100 | % { sleep 1; "Output $_" } }
Start-ThreadJob -ScriptBlock { 1..100 | % { sleep 1; "Output $_" } }
Get-Job
```

```Output
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      Job1            ThreadJob       Running       True            PowerShell            1..100 | % { sleep 1;...
2      Job2            ThreadJob       Running       True            PowerShell            1..100 | % { sleep 1;...
3      Job3            ThreadJob       NotStarted    False           PowerShell            1..100 | % { sleep 1;...
```

### Example 2 - Compare the performance of Start-Job and Start-ThreadJob

This example shows the difference between `Start-Job` and `Start-ThreadJob`.

```powershell
# start five background jobs each running 1 second
Measure-Command {1..5 | % {Start-Job {Sleep 1}} | Wait-Job} | Select TotalSeconds
Measure-Command {1..5 | % {Start-ThreadJob {Sleep 1}} | Wait-Job} | Select TotalSeconds
```

```Output
TotalSeconds
------------
   5.7665849 # jobs creation time > 4.7 sec; results may vary
   1.5735008 # jobs creation time < 0.6 sec (8 times less!)
```

## PARAMETERS

### -ArgumentList

Specifies an array of arguments, or parameter values, for the script that is specified by the
**FilePath** parameter.

**ArgumentList** must be the last parameter on the command line. All the values that follow the
parameter name are interpreted values in the argument list.

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies a script file to run as a background job. Enter the path and filename of the script. The
script must be on the local computer or in a folder that the local computer can access.

When you use this parameter, PowerShell converts the contents of the specified script file to a
script block and runs the script block as a background job.

```yaml
Type: System.String
Parameter Sets: FilePath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InitializationScript

Specifies commands that run before the job starts. Enclose the commands in braces (`{}`) to create
a script block.

Use this parameter to prepare the session in which the job runs. For example, you can use it to add
functions and modules to the session.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies input to the command. Enter a variable that contains the objects, or type a command or
expression that generates the objects.

In the value of the **ScriptBlock** parameter, use the `$Input` automatic variable to represent the
input objects.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies a friendly name for the new job. You can use the name to identify the job to other job
cmdlets, such as the `Stop-Job` cmdlet.

The default friendly name is "Job#", where "#" is an ordinal number that is incremented for each
job.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

Specifies the commands to run in the background job. Enclose the commands in braces (`{}`) to create
a script block. Use the `$Input` automatic variable to access the value of the **InputObject**
parameter. This parameter is required.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlock
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

This parameter limits the number of jobs running at one time. As more jobs are started, they are
queued and wait until the current number of jobs drops below the throttle limit.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### ThreadJob.ThreadJob

## NOTES

## RELATED LINKS

[Start-Job](../Microsoft.PowerShell.Core/Start-Job.md)

[Stop-Job](../Microsoft.PowerShell.Core/Stop-Job.md)

[Receive-Job](../Microsoft.PowerShell.Core/Receive-Job.md)
