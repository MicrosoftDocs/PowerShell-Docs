---
description: Provides information about how PowerShell background jobs run a command or expression in the background without interacting with the current session.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/16/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_jobs?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Jobs
---
# About Jobs

## Short description
Provides information about how PowerShell background jobs run a command or
expression in the background without interacting with the current session.

## Long description

PowerShell concurrently runs commands and script through jobs. There are three
jobs-based solutions provided by PowerShell to support concurrency.

|Job            |Description                                                  |
|---------------|-------------------------------------------------------------|
|`RemoteJob`    |Command and script run on a remote computer.                 |
|`BackgroundJob`|Command and script run in a separate process on the local    |
|               |machine.                                                     |
|`ThreadJob`    |Command and script run in a separate thread within the same  |
|               |process on the local machine.                                |

Each type of job has benefits and drawbacks. Running script remotely on a
separate machine or in a separate process has great isolation. Any errors won't
affect other running jobs or the client that started the job. But the remoting
layer adds overhead, including object serialization. All objects passed to and
from the remote session must be serialized and then deserialized as it passes
between the client and the target session. The serialization operation can use
many compute and memory resources for large complex data objects.

This topic explains how to run background jobs in PowerShell on a local
computer. For information about running background jobs on remote computers,
see [about_Remote_Jobs](about_Remote_Jobs.md). For more information about
thread jobs, see [about_Thread_Jobs](about_Thread_Jobs.md).

When you start a background job, the command prompt returns immediately, even
if the job takes an extended time to complete. You can continue to work in the
session without interruption while the job runs.

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

The following command starts a background job that runs a `Get-Process`
command on the local computer.

```powershell
Start-Job -ScriptBlock {Get-Process}
```

The `Start-Job` command returns an object that represents the job. The job
object contains useful information about the job, but it does not contain the
job results.

Save the job object in a variable, and then use it with the other Job cmdlets
to manage the background job. The following command starts a job object and
saves the resulting job object in the `$job` variable.

```powershell
$job = Start-Job -ScriptBlock {Get-Process}
```

Beginning in PowerShell 6.0, you can use an amersand (`&`) at the end of a
pipeline to start a background job. The following command is functionally
equivalent to the command above.

```powershell
$job = Get-Process &
```

The ampersand (`&`) is called the background operator. For more information,
see [background operator](about_Operators.md#background-operator-).

You can also use the `Get-Job` cmdlet to get objects that represent the jobs
started in the current session. `Get-Job` returns the same job object that
`Start-Job` returns.

## Getting job objects

To get object that represent the background jobs that were started in the
current session, use the `Get-Job` cmdlet. Without parameters, `Get-Job`
returns all of the jobs that were started in the current session.

For example, the following command gets the jobs in the current session.

```powershell
PS C:> Get-Job

Id  Name  PSJobTypeName State      HasMoreData  Location   Command
--  ----  ------------- -----      -----------  --------   -------
1   Job1  BackgroundJob Running    True         localhost  Get-Process
```

You can also save the job object in a variable and use it to represent the job
in a later command. The following command gets the job with ID 1 and saves it
in the `$job` variable.

```powershell
$job = Get-Job -Id 1
```

The job object contains the state of the job, which indicates whether the job
has finished. A finished job has a state of **Complete** or **Failed**. A job
might also be **blocked** or **running**.

```powershell
Get-Job

Id  Name  PSJobTypeName State      HasMoreData  Location   Command
--  ----  ------------- -----      -----------  --------   -------
1   Job1  BackgroundJob Complete   True         localhost  Get-Process
```

## Getting the results of a job

When you run a background job, the results do not appear immediately. Instead,
the `Start-Job` cmdlet returns a job object that represents the job, but it
does not contain the results. To get the results of a background job, use the
`Receive-Job` cmdlet.

The following command uses the `Receive-Job` cmdlet to get the results of the
job. It uses a job object saved in the `$job` variable to identify the job.

```powershell
Receive-Job -Job $job
```

The `Receive-Job` cmdlet returns the results of the job.

```
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)    Id ProcessName
-------  ------    -----      ----- -----   ------    -- -----------
    103       4    11328       9692    56           1176 audiodg
    804      14    12228      14108   100   101.74  1740 CcmExec
    668       7     2672       6168   104    32.26   488 csrss
# ...
```

You can also save the results of a job in a variable. The following command
saves the results of the job in the `$job` variable to the `$results` variable.

```powershell
$results = Receive-Job -Job $job
```

And, you can save the results of the job in a file by using the redirection
operator (`>`) or the `Out-File` cmdlet. The following command uses the
redirection operator to save the results of the job in the `$job` variable in
the `Results.txt` file.

```powershell
Receive-Job -Job $job > results.txt
```

## Getting and keeping partial job results

The `Receive-Job` cmdlet gets the results of a background job. If the job is
complete, `Receive-Job` gets all job results. If the job is still running,
`Receive-Job` gets the results that have been generated thus far. You can run
`Receive-Job` commands again to get the remaining results.

When `Receive-Job` returns results, by default, it deletes those results from
the cache where job results are stored. If you run another `Receive-Job`
command, you get only the results that are not yet received.

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

To prevent `Receive-Job` from deleting the job results that it has returned,
use the **Keep** parameter. As a result, `Receive-Job` returns all of the
results that have been generated until that time.

The following commands show the effect of using the **Keep** parameter on a job
that is not yet complete.

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

## Waiting for the results

If you run a command that takes a long time to complete, you can use the
properties of the job object to determine when the job is complete. The
following command uses the `Get-Job` object to get all of the background jobs
in the current session.

```powershell
Get-Job
```

The results appear in a table. The status of the job appears in the **State**
column.

```
Id Name  PSJobTypeName State    HasMoreData Location  Command
-- ----  ------------- -----    ----------- --------  -------
1  Job1  BackgroundJob Complete True        localhost Get-Process
2  Job2  BackgroundJob Running  True        localhost Get-EventLog -Log ...
3  Job3  BackgroundJob Complete True        localhost dir -Path C:\* -Re...
```

In this case, the State property reveals that Job 2 is still running. If you
were to use the `Receive-Job` cmdlet to get the job results now, the results
would be incomplete. You can use the `Receive-Job` cmdlet repeatedly to get all
of the results. By default, each time you use it, you get only the results that
were not already received, but you can use the **Keep** parameter of the
`Receive-Job` cmdlet to retain the results, even though they were already
received.

You can write the partial results to a file and then append newer results as
they arrive or you can wait and check the state of the job later.

You can use the **Wait** parameter of the `Receive-Job` cmdlet, which does not
return the command prompt until the job is complete and all results are
available.

You can also use the `Wait-Job` cmdlet to wait for any or all of the results of
the job. `Wait-Job` lets you wait for a particular job, for all jobs, or for
any of the jobs to be completed.

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

To find out why a job failed, use the **Reason** property of the job object.

The following command starts a job without the required credentials. It saves
the job object in the `$job` variable.

```powershell
$job = Start-Job -ScriptBlock {New-Item -Path HKLM:\Software\MyCompany}

Id Name  PSJobTypeName State  HasMoreData  Location  Command
-- ----  ------------- -----  -----------  --------  -------
1  Job1  BackgroundJob Failed False        localhost New-Item -Path HKLM:...
```

The following command uses the Reason property to find the error that caused
the job to fail.

```powershell
$job.ChildJobs[0].JobStateInfo.Reason
```

In this case, the job failed because the remote computer required explicit
credentials to run the command. The value of the **Reason** property is:

Connecting to remote server failed with the following error message: "Access is
denied".

## See also

- [about_Remote_Jobs](about_Remote_Jobs.md)
- [about_Thread_Jobs](about_Thread_Jobs.md)
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
