---
description: Provides information about how PowerShell background jobs run a command or expression in the background without interacting with the current session.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 11/11/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_jobs?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Jobs
---
# About Jobs

## Short description
Provides information about how PowerShell background jobs run a command or
expression in the background without interacting with the current session.

## Long description

PowerShell concurrently runs commands and scripts through jobs. There are three
jobs types provided by PowerShell to support concurrency.

- `RemoteJob` - Commands and scripts run on a remote session. For information,
  see [about_Remote_Jobs](about_Remote_Jobs.md).
- `BackgroundJob` - Commands and scripts run in a separate process on the local
  machine.
- `PSTaskJob` or `ThreadJob` - Commands and scripts run in a separate thread
  within the same process on the local machine. For more information, see
  [about_Thread_Jobs](/powershell/module/ThreadJob/about_Thread_Jobs).

Running scripts remotely, on a separate machine or in a separate process,
provides great isolation. Any errors that occur in the remote job do not affect
other running jobs or the parent session that started the job. However, the
remoting layer adds overhead, including object serialization. All objects are
serialized and deserialized as they are passed between the parent session and
the remote (job) session. Serialization of large complex data objects can
consume large amounts of compute and memory resources and transfer large
amounts of data across the network.

Thread-based jobs are not as robust as remote and background jobs, because they
run in the same process on different threads. If one job has a critical error
that crashes the process, then all other jobs in the process are terminated.

However, thread-based jobs require less overhead. They don't use the remoting
layer or serialization. The result objects are returned as references to live
objects in the current session. Without this overhead, thread-based jobs run
faster and use fewer resources than the other job types.

> [!IMPORTANT]
> The parent session that created the job also monitors the job status and
> collects pipeline data. The job child process is terminated by the parent
> process once the job reaches a finished state. If the parent session is
> terminated, all running child jobs are terminated along with their child
> processes.

There are two ways work around this situation:

1. Use `Invoke-Command` to create jobs that run in disconnected sessions. For
   more information, see [about_Remote_Jobs](about_Remote_Jobs.md).
1. Use `Start-Process` to create a new process rather than a job. For more
   information, see
   [Start-Process](xref:Microsoft.PowerShell.Management.Start-Process).

## The job cmdlets

|Cmdlet          |Description                                            |
|----------------|-------------------------------------------------------|
|`Start-Job`     |Starts a background job on a local computer.           |
|`Get-Job`       |Gets the background jobs that were started in the      |
|                |current session.                                       |
|`Receive-Job`   |Gets the results of background jobs.                   |
|`Stop-Job`      |Stops a background job.                                |
|`Wait-Job`      |Suppresses the command prompt until one or all jobs are|
|                |complete.                                              |
|`Remove-Job`    |Deletes a background job.                              |
|`Invoke-Command`|The **AsJob** parameter creates a background job on a  |
|                |remote computer. You can use `Invoke-Command` to run   |
|                |any job command remotely, including `Start-Job`.       |

## How to start a job on the local computer

To start a background job on the local computer, use the `Start-Job` cmdlet.

To write a `Start-Job` command, enclose the command that the job runs in curly
braces (`{}`). Use the **ScriptBlock** parameter to specify the command.

The following command starts a background job that runs a `Get-Process` command
on the local computer.

```powershell
Start-Job -ScriptBlock {Get-Process}
```

When you start a background job, the command prompt returns immediately, even
if the job takes an extended time to complete. You can continue to work in the
session without interruption while the job runs.

The `Start-Job` command returns an object that represents the job. The job
object contains useful information about the job, but it does not contain the
job results.

You can save the job object in a variable and then use it with the other
**Job** cmdlets to manage the background job. The following command starts a
job object and saves the resulting job object in the `$job` variable.

```powershell
$job = Start-Job -ScriptBlock {Get-Process}
```

## Getting job objects

The `Get-Job` cmdlet returns objects that represent the background jobs that
were started in the current session. Without parameters, `Get-Job` returns all
of the jobs that were started in the current session.

```powershell
Get-Job
```

The job object contains the state of the job, which indicates whether the job
has finished. A finished job has a state of **Complete** or **Failed**. A job
might also be **Blocked** or **Running**.

```Output
Id  Name  PSJobTypeName State      HasMoreData  Location   Command
--  ----  ------------- -----      -----------  --------   -------
1   Job1  BackgroundJob Complete   True         localhost  Get-Process
```

You can save the job object in a variable and use it to represent the job in a
later command. The following command gets the job with ID 1 and saves it in the
`$job` variable.

```powershell
$job = Get-Job -Id 1
```

## Getting the results of a job

When you run a background job, the results do not appear immediately. To get
the results of a background job, use the `Receive-Job` cmdlet.

The following example, the `Receive-Job` cmdlet gets the results of the job
using job object in the `$job` variable.

```powershell
Receive-Job -Job $job
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)    Id ProcessName
-------  ------    -----      ----- -----   ------    -- -----------
    103       4    11328       9692    56           1176 audiodg
    804      14    12228      14108   100   101.74  1740 CcmExec
    668       7     2672       6168   104    32.26   488 csrss
...
```

You can save the results of a job in a variable. The following command saves
the results of the job in the `$job` variable to the `$results` variable.

```powershell
$results = Receive-Job -Job $job
```

### Getting and keeping partial job results

The `Receive-Job` cmdlet gets the results of a background job. If the job is
complete, `Receive-Job` gets all job results. If the job is still running,
`Receive-Job` gets the results that have been generated thus far. You can run
`Receive-Job` commands again to get the remaining results.

By default, `Receive-Job` deletes the results from the cache where job results
are stored. When you run `Receive-Job` again, you get only the new
results that arrived after the first run.

The following commands show the results of `Receive-Job` commands run
before the job is complete.

```powershell
C:\PS> Receive-Job -Job $job

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    103       4    11328       9692    56            1176 audiodg
    804      14    12228      14108   100   101.74   1740 CcmExec

C:\PS> Receive-Job -Job $job

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    68       3     2632        664    29     0.36   1388 ccmsetup
   749      22    21468      19940   203   122.13   3644 communicator
   905       7     2980       2628    34   197.97    424 csrss
  1121      25    28408      32940   174   430.14   3048 explorer
```

Use the **Keep** parameter to prevent `Receive-Job` from deleting the job
results that are returned. The following commands show the effect of using the
**Keep** parameter on a job that is not yet complete.

```powershell
C:\PS> Receive-Job -Job $job -Keep

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    103       4    11328       9692    56            1176 audiodg
    804      14    12228      14108   100   101.74   1740 CcmExec

C:\PS> Receive-Job -Job $job -Keep

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    103       4    11328       9692    56            1176 audiodg
    804      14    12228      14108   100   101.74   1740 CcmExec
     68       3     2632        664    29     0.36   1388 ccmsetup
    749      22    21468      19940   203   122.13   3644 communicator
    905       7     2980       2628    34   197.97    424 csrss
   1121      25    28408      32940   174   430.14   3048 explorer
```

### Waiting for the results

If you run a command that takes a long time to complete, you can use the
properties of the job object to determine when the job is complete. The
following command uses the `Get-Job` object to get all of the background jobs
in the current session.

```powershell
Get-Job
```

The results appear in a table. The status of the job appears in the **State**
column.

```Output
Id Name  PSJobTypeName State    HasMoreData Location  Command
-- ----  ------------- -----    ----------- --------  -------
1  Job1  BackgroundJob Complete True        localhost Get-Process
2  Job2  BackgroundJob Running  True        localhost Get-EventLog -Log ...
3  Job3  BackgroundJob Complete True        localhost dir -Path C:\* -Re...
```

In this case, the **State** property reveals that Job 2 is still running. If
you were to use the `Receive-Job` cmdlet to get the job results now, the
results would be incomplete. You can use the `Receive-Job` cmdlet repeatedly to
get all of the results. Use the **State** property to determine when the job is
complete.

You can also use the **Wait** parameter of the `Receive-Job` cmdlet. When use
use this parameter, the cmdlet does not return the command prompt until the job
is completed and all results are available.

You can also use the `Wait-Job` cmdlet to wait for any or all of the results of
the job. `Wait-Job` lets you wait for one or more specific job or for all jobs.
The following command uses the `Wait-Job` cmdlet to wait for a job with **ID**
10.

```powershell
Wait-Job -ID 10
```

As a result, the PowerShell prompt is suppressed until the job is completed.

You can also wait for a predetermined period of time. This command uses the
**Timeout** parameter to limit the wait to 120 seconds. When the time expires,
the command prompt returns, but the job continues to run in the background.

```powershell
Wait-Job -ID 10 -Timeout 120
```

## Stopping a job

To stop a background job, use the `Stop-Job` cmdlet. The following command
starts a job to get every entry in the System event log. It saves the job
object in the `$job` variable.

```powershell
$job = Start-Job -ScriptBlock {Get-EventLog -Log System}
```

The following command stops the job. It uses a pipeline operator (`|`) to send
the job in the `$job` variable to `Stop-Job`.

```powershell
$job | Stop-Job
```

## Deleting a job

To delete a background job, use the `Remove-Job` cmdlet. The following command
deletes the job in the `$job` variable.

```powershell
Remove-Job -Job $job
```

## Investigating a failed job

Jobs can fail for many reasons. the job object contains a **Reason** property
that contains information about the cause of the failure.

The following example starts a job without the required credentials.

```powershell
$job = Start-Job -ScriptBlock {New-Item -Path HKLM:\Software\MyCompany}
Get-Job $job

Id Name  PSJobTypeName State  HasMoreData  Location  Command
-- ----  ------------- -----  -----------  --------  -------
1  Job1  BackgroundJob Failed False        localhost New-Item -Path HKLM:...
```

Inspect the **Reason** property to find the error that caused the job to fail.

```powershell
$job.ChildJobs[0].JobStateInfo.Reason
```

In this case, the job failed because the remote computer required explicit
credentials to run the command. The **Reason** property contains the following
message:

> Connecting to remote server failed with the following error message: "Access
> is denied".

## See also

- [about_Remote_Jobs](about_Remote_Jobs.md)
- [about_Thread_Jobs](/powershell/module/microsoft.powershell.core/about/about_Thread_Jobs)
- [about_Job_Details](about_Job_Details.md)
- [about_Remote](about_Remote.md)
- [about_PSSessions](about_PSSessions.md)
- [Start-Job](xref:Microsoft.PowerShell.Core.Start-Job)
- [Get-Job](xref:Microsoft.PowerShell.Core.Get-Job)
- [Receive-Job](xref:Microsoft.PowerShell.Core.Receive-Job)
- [Stop-Job](xref:Microsoft.PowerShell.Core.Stop-Job)
- [Wait-Job](xref:Microsoft.PowerShell.Core.Wait-Job)
- [Remove-Job](xref:Microsoft.PowerShell.Core.Remove-Job)
- [Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
