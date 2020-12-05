---
external help file: Microsoft.PowerShell.ThreadJob.dll-Help.xml
Locale: en-US
Module Name: ThreadJob
ms.date: 12/05/2020
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
 [-InputObject <PSObject>] [-ArgumentList <Object[]>] [-ThrottleLimit <Int32>]
 [-StreamingHost <PSHost>] [<CommonParameters>]
```

### FilePath

```
Start-ThreadJob [-FilePath] <String> [-Name <String>] [-InitializationScript <ScriptBlock>]
 [-InputObject <PSObject>] [-ArgumentList <Object[]>] [-ThrottleLimit <Int32>]
 [-StreamingHost <PSHost>] [<CommonParameters>]
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
Id   Name   PSJobTypeName   State        HasMoreData   Location     Command
--   ----   -------------   -----        -----------   --------     -------
1    Job1   ThreadJob       Running      True          PowerShell   1..100 | % { sleep 1;...
2    Job2   ThreadJob       Running      True          PowerShell   1..100 | % { sleep 1;...
3    Job3   ThreadJob       NotStarted   False         PowerShell   1..100 | % { sleep 1;...
```

### Example 2 - Compare the performance of Start-Job and Start-ThreadJob

This example shows the difference between `Start-Job` and `Start-ThreadJob`. The jobs run the
`Start-Sleep` cmdlet for 1 second. Since the jobs run in parallel, the total execution time
is about 1 second, plus any time required to create the jobs.

```powershell
# start five background jobs each running 1 second
Measure-Command {1..5 | % {Start-Job {Start-Sleep 1}} | Wait-Job} | Select-Object TotalSeconds
Measure-Command {1..5 | % {Start-ThreadJob {Start-Sleep 1}} | Wait-Job} | Select-Object TotalSeconds
```

```Output
TotalSeconds
------------
   5.7665849
   1.5735008
```

After subtracting 1 second for execution time, you can see that `Start-Job` takes about 4.8 seconds
to create five jobs. `Start-ThreadJob` is 8 times faster, taking about 0.6 seconds to create five
jobs. The results may vary in your environment but the relative improvement should be the same.

### Example 3 - Create jobs using InputObject

In this example, the script block uses the `$input` variable to receive input from the
**InputObject** parameter. This can also be done by piping objects to `Start-ThreadJob`.

```powershell
$j = Start-ThreadJob -InputObject (Get-Process pwsh) -ScriptBlock { $input | Out-String }
$j | Wait-Job | Receive-Job
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     94   145.80     159.02      18.31   18276   1 pwsh
    101   163.30     222.05      29.00   35928   1 pwsh
```

```powershell
$j = Get-Process pwsh | Start-ThreadJob -ScriptBlock { $input | Out-String }
$j | Wait-Job | Receive-Job
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     94   145.80     159.02      18.31   18276   1 pwsh
    101   163.30     222.05      29.00   35928   1 pwsh
```

### Example 4 - Stream job output to parent host

Using the **StreamingHost** parameter you can tell a job to direct all host output to a specific
host. Without this parameter the output goes to the job data stream collection and doesn't appear in
a host console until you receive the output from the job.

For this example, the current host is passed to `Start-ThreadJob` using the `$Host` automatic
variable.

```powershell
PS> Start-ThreadJob -ScriptBlock { Read-Host 'Say hello'; Write-Warning 'Warning output' } -StreamingHost $Host

Id   Name   PSJobTypeName   State         HasMoreData     Location      Command
--   ----   -------------   -----         -----------     --------      -------
7    Job7   ThreadJob       NotStarted    False           PowerShell    Read-Host 'Say hello'; …

PS> Say hello: Hello
WARNING: Warning output
PS> Receive-Job -Id 7
Hello
WARNING: Warning output
PS>
```

Notice that the prompt from `Read-Host` is displayed and you are able to type input. Then, the
message from `Write-Warning` is displayed. The `Receive-Job` cmdlet returns all the output from the
job.

## PARAMETERS

### -ArgumentList

Specifies an array of arguments, or parameter values, for the script that is specified by the
**FilePath** or **ScriptBlock** parameters.

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

Specifies the objects used as input to the script block. It also allows for pipeline input. Use the
`$input` automatic variable in the script block to access the input objects.

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

### -StreamingHost

This parameter provides a thread safe way to allow `Write-Host` output to go directly to the passed
in **PSHost** object. Without it, `Write-Host` output goes to the job information data stream
collection and doesn't appear in a host console until after the jobs finish running.

```yaml
Type: System.Management.Automation.Host.PSHost
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

This parameter limits the number of jobs running at one time. As jobs are started, they are queued
and wait until a thread is available in the thread pool to run the job. The default limit is 5
threads.

The thread pool size is global to the PowerShell session. Specifying a **ThrottleLimit** in one
call sets the limit for subsequent calls in the same session.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5
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
