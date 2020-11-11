---
description: Describes how to run jobs on remote computers.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 11/11/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_jobs?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Jobs
---
# About Remote Jobs

## Short Description
Describes how to run jobs on remote computers.

## Detailed Description

PowerShell concurrently runs commands and scripts through jobs. There are three
jobs types provided by PowerShell to support concurrency.

- `RemoteJob` - Commands and scripts run in a remote session.
- `BackgroundJob` - Commands and scripts run in a separate process on the local
  machine. For more information, see [about_Jobs](about_Jobs.md).
- `PSTaskJob` or `ThreadJob` - Commands and scripts run in a separate thread
  within the same process on the local machine. For more information, see
  [about_Thread_Jobs](about_Thread_Jobs.md).

Running scripts remotely, on a separate machine or in a separate process,
provide great isolation. Any errors that occur in the remote job do not affect
other running jobs or the parent session that started the job. However, the
remoting layer adds overhead, including object serialization. All objects are
serialized and deserialized as they are passed between the parent session and
the remote (job) session. Serialization of large complex data objects can
consume large amounts of compute and memory resources and transfer large
amounts of data across the network.

> [!IMPORTANT]
> The parent session that created the job also monitors the job status and
> collects pipeline data. The job child process is terminated by the parent
> process once the job reaches a finished state. If the parent session is
> terminated, all running child jobs are terminated along with their child
> processes.

There are two ways work around this situation:

1. Use `Invoke-Command` to create jobs that run in disconnected sessions. See
   the [detached processes](#how-to-run-as-a-detached-process) section of this
   article.
1. Use `Start-Process` to create a new process rather than a job. For more
   information, see
   [Start-Process](xref:Microsoft.PowerShell.Management.Start-Process).

## Remote Jobs

You can run jobs on remote computers by using three different
methods.

- Start an interactive session on a remote computer. Then start a job in the
  interactive session. The procedures are the same as running a local job,
  although all actions are performed on the remote computer.

- Run a job on a remote computer that returns its results to the
  local computer. Use this method when you want to collect the results of
  jobs and maintain them in a central location on the local
  computer.

- Run a job on a remote computer that maintains its results on the
  remote computer. Use this method when the job data is more securely
  maintained on the originating computer.

### Start a job in an interactive session

You can start an interactive session with a remote computer and then start a
job during the interactive session. For more information about interactive
sessions, see about_Remote, and see `Enter-PSSession`.

The procedure for starting a job in an interactive session is almost identical
to the procedure for starting a background job on the local computer. However,
all of the operations occur on the remote computer, not the local computer.

1. Use the `Enter-PSSession` cmdlet to start an interactive session with a
   remote computer. You can use the ComputerName parameter of `Enter-PSSession`
   to establish a temporary connection for the interactive session. Or, you can
   use the Session parameter to run the interactive session in a PowerShell
   session (PSSession).

   The following command starts an interactive session on the Server01 computer.

   ```powershell
   C:\PS> Enter-PSSession -computername Server01
   ```

   The command prompt changes to show that you are now connected to the
   Server01 computer.

   ```
   Server01\C:>
   ```

1. To start a remote job in the session, use the `Start-Job` cmdlet. The
   following command runs a remote job that gets the events in the Windows
   PowerShell event log on the Server01 computer. The `Start-Job` cmdlet
   returns an object that represents the job.

   This command saves the job object in the `$job` variable.

   ```powershell
   Server01\C:> $job = Start-Job -scriptblock {
     Get-Eventlog "Windows PowerShell"
   }
   ```

   While the job runs, you can use the interactive session to run other
   commands, including other jobs. However, you must keep the interactive
   session open until the job is completed. If you end the session, the job is
   interrupted, and the results are lost.

1. To find out if the job is complete, display the value of the `$job`
   variable, or use the `Get-Job` cmdlet to get the job. The following command
   uses the `Get-Job` cmdlet to display the job.

   ```powershell
   Server01\C:> Get-Job $job

   SessionId  Name  State      HasMoreData  Location   Command
   ---------  ----  -----      -----------  --------   -------
   1          Job1  Complete   True         localhost  Get-Eventlog "Windows...
   ```

   The `Get-Job` output shows that job is running on the "localhost" computer
   because the job was started on and is running on the same computer (in this
   case, Server01).

1. To get the results of the job, use the `Receive-Job` cmdlet. You can display
   the results in the interactive session or save them to a file on the remote
   computer. The following command gets the results of the job in the $job
   variable. The command uses the redirection operator (`>`) to save the
   results of the job in the PsLog.txt file on the Server01 computer.

   ```powershell
   Server01\C:> Receive-Job $job > c:\logs\PsLog.txt
   ```

1. To end the interactive session, use the `Exit-PSSession` cmdlet. The command
   prompt changes to show that you are back in the original session on the
   local computer.

   ```powershell
   Server01\C:> Exit-PSSession
   C:\PS>
   ```

1. To view the contents of the `PsLog.txt` file on the Server01 computer at any
   time, start another interactive session, or run a remote command. This type
   of command is best run in a PSSession (a persistent connection) in case you
   want to use several commands to investigate and manage the data in the
   `PsLog.txt` file. For more information about PSSessions, see
   [about_PSSessions](about_PSSessions.md).

   The following commands use the `New-PSSession` cmdlet to create a
   **PSSession** that is connected to the Server01 computer, and they use the
   `Invoke-Command` cmdlet to run a `Get-Content` command in the PSSession to
   view the contents of the file.

   ```powershell
   $s = New-PSSession -computername Server01
   Invoke-Command -session $s -scriptblock {
     Get-Content c:\logs\pslog.txt}
   ```

### Start a remote job that returns the results to the local computer (AsJob)

To start a job on a remote computer that returns the command results to the
local computer, use the **AsJob** parameter of a cmdlet such as the
`Invoke-Command` cmdlet.

When you use the **AsJob** parameter, the job object is actually created on the
local computer even though the job runs on the remote computer. When the job is
completed, the results are returned to the local computer.

You can use the cmdlets that contain the Job noun (the Job cmdlets) to manage
any job created by any cmdlet. Many of the cmdlets that have **AsJob**
parameters do not use PowerShell remoting, so you can use them even on
computers that are not configured for remoting and that do not meet the
requirements for remoting.

1. The following command uses the **AsJob** parameter of `Invoke-Command` to
   start a job on the Server01 computer. The job runs a `Get-Eventlog` command
   that gets the events in the System log. You can use the JobName parameter to
   assign a display name to the job.

   ```powershell
   Invoke-Command -computername Server01 -scriptblock {
     Get-Eventlog system} -AsJob
   ```

   The results of the command resemble the following sample output.

   ```Output
   SessionId   Name   State    HasMoreData   Location   Command
   ---------   ----   -----    -----------   --------   -------
   1           Job1   Running  True          Server01   Get-Eventlog system
   ```

   When the **AsJob** parameter is used, `Invoke-Command` returns the same type
   of job object that `Start-Job` returns. You can save the job object in a
   variable, or you can use a `Get-Job` command to get the job.

   Note that the value of the Location property shows that the job ran on the
   Server01 computer.

1. To manage a job started by using the **AsJob** parameter of the
   `Invoke-Command` cmdlet, use the Job cmdlets. Because the job object that
   represents the remote job is on the local computer, you do not need to run
   remote commands to manage the job.

   To determine whether the job is complete, use a `Get-Job` command. The
   following command gets all of the jobs that were started in the current
   session.

   ```powershell
   Get-Job
   ```

   Because the remote job was started in the current session, a local `Get-Job`
   command gets the job. The State property of the job object shows that the
   command was completed successfully.

   ```Output
   SessionId   Name   State      HasMoreData   Location   Command
   ---------   ----   -----      -----------   --------   -------
   1           Job1   Completed  True          Server01   Get-Eventlog system
   ```

1. To get the results of the job, use the `Receive-Job` cmdlet. Because the job
   results are automatically returned to the computer where the job object
   resides, you can get the results with a local `Receive-Job` command.

   The following command uses the `Receive-Job` cmdlet to get the results of
   the job. It uses the session ID to identify the job. This command saves the
   job results in the $results variable. You can also redirect the results to a
   file.

   ```powershell
   $results = Receive-Job -id 1
   ```

### Start a remote job that keeps the results on the remote computer

To start a job on a remote computer that keeps the command results on the
remote computer, use the `Invoke-Command` cmdlet to run a `Start-Job` command
on a remote computer. You can use this method to run jobs on multiple
computers.

When you run a `Start-Job` command remotely, the job object is created on the
remote computer, and the job results are maintained on the remote computer.
From the perspective of the job, all operations are local. You are just running
commands remotely to manage a local job on the remote computer.

1. Use the `Invoke-Command` cmdlet to run a `Start-Job` command on a remote
   computer.

   This command requires a PSSession (a persistent connection). If you use the
   ComputerName parameter of `Invoke-Command` to establish a temporary
   connection, the `Invoke-Command` command is considered to be complete when
   the job object is returned. As a result, the temporary connection is closed,
   and the job is canceled.

   The following command uses the `New-PSSession` cmdlet to create a PSSession
   that is connected to the Server01 computer. The command saves the PSSession
   in the `$s` variable.

   ```powershell
   $s = New-PSSession -computername Server01
   ```

   The next command uses the `Invoke-Command` cmdlet to run a `Start-Job`
   command in the PSSession. The `Start-Job` command and the `Get-Eventlog`
   command are enclosed in braces.

   ```powershell
   Invoke-Command -session $s -scriptblock {
     Start-Job -scriptblock {Get-Eventlog system}}
   ```

   The results resemble the following sample output.

   ```Output
   Id       Name    State      HasMoreData     Location   Command
   --       ----    -----      -----------     --------   -------
   2        Job2    Running    True            Localhost  Get-Eventlog system
   ```

   When you run a `Start-Job` command remotely, `Invoke-Command` returns the
   same type of job object that `Start-Job` returns. You can save the job
   object in a variable, or you can use a `Get-Job` command to get the job.

   Note that the value of the **Location** property shows that the job ran on
   the local computer, known as "LocalHost", even though the job ran on the
   Server01 computer. Because the job object is created on the Server01
   computer and the job runs on the same computer, it is considered to be a
   local background job.

1. To manage a remote job, use the **Job** cmdlets. Because the job object is
   on the remote computer, you need to run remote commands to get, stop, wait
   for, or retrieve the job results.

   To see if the job is complete, use an `Invoke-Command` command to run a
   `Get-Job` command in the PSSession that is connected to the Server01
   computer.

   ```powershell
   Invoke-Command -session $s -scriptblock {Get-Job}
   ```

   The command returns a job object. The **State** property of the job object
   shows that the command was completed successfully.

   ```Output
   SessionId   Name  State      HasMoreData   Location   Command
   ---------   ----  -----      -----------   --------   -------
   2           Job2  Completed  True          LocalHost   Get-Eventlog system
   ```

1. To get the results of the job, use the `Invoke-Command` cmdlet to run a
   `Receive-Job` command in the PSSession that is connected to the Server01
   computer.

   The following command uses the `Receive-Job` cmdlet to get the results of
   the job. It uses the session ID to identify the job. This command saves the
   job results in the `$results` variable. It uses the Keep parameter of
   `Receive-Job` to keep the result in the job cache on the remote computer.

   ```powershell
   $results = Invoke-Command -session $s -scriptblock {
     Receive-Job -SessionId 2 -Keep
   }
   ```

   You can also redirect the results to a file on the local or remote computer.
   The following command uses a redirection operator to save the results in a
   file on the Server01 computer.

   ```powershell
   Invoke-Command -session $s -command {
     Receive-Job -SessionId 2 > c:\logs\pslog.txt
   }
   ```

## How to run as a detached process

As previously mentioned, when the parent session is terminated, all running
child jobs are terminated along with their child processes. You can use
remoting on the local machine to run jobs that are not attached to the current
PowerShell session.

Create a new PowerShell session on the local machine. The use `Invoke-Command`
to start a job in this session. `Invoke-Command` allows you to disconnect a
remote session and terminate the parent session. Later, you can start a new
PowerShell session and connect to the previously disconnected session to resume
monitoring the job. However, any data that was returned to the original
PowerShell session is lost when that session is terminated. Only new data
objects generated after the disconnect are returned when re-connected.

```powershell
# Create remote session on local machine
PS> $session = New-PSSession -cn localhost

# Start remote job
PS> $job = Invoke-Command -Session $session -ScriptBlock { 1..60 | % { sleep 1; "Output $_" } } -AsJob
PS> $job

Id     Name     PSJobTypeName   State         HasMoreData     Location      Command
--     ----     -------------   -----         -----------     --------      -------
1      Job1     RemoteJob       Running       True            localhost     1..60 | % { sleep 1; ...

# Disconnect the job session
PS> Disconnect-PSSession $session

Id Name         Transport ComputerName    ComputerType    State         ConfigurationName     Availability
-- ----         --------- ------------    ------------    -----         -----------------     ------------
1 Runspace1     WSMan     localhost       RemoteMachine   Disconnected  Microsoft.PowerShell          None

PS> $job

Id     Name     PSJobTypeName   State         HasMoreData     Location      Command
--     ----     -------------   -----         -----------     --------      -------
1      Job1     RemoteJob       Disconnected  True            localhost     1..60 | % { sleep 1;

# Reconnect the session to a new job object
PS> $jobNew = Receive-PSSession -Session $session -OutTarget Job
PS> $job | Wait-Job | Receive-Job
Output 9
Output 10
Output 11
...
```

For this example, the jobs are still attached to a parent PowerShell session.
However, the parent session is not the original PowerShell session where
`Invoke-Command` was run.

## See also

- [about_Jobs](about_Jobs.md)
- [about_Job_Details](about_Job_Details.md)
- [about_Remote](about_Remote.md)
- [about_Remote_Variables](about_Remote_Variables.md)
- [Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
- [Start-Job](xref:Microsoft.PowerShell.Core.Start-Job)
- [Get-Job](xref:Microsoft.PowerShell.Core.Get-Job)
- [Wait-Job](xref:Microsoft.PowerShell.Core.Wait-Job)
- [Stop-Job](xref:Microsoft.PowerShell.Core.Stop-Job)
- [Remove-Job](xref:Microsoft.PowerShell.Core.Remove-Job)
- [New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)
- [Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)
- [Exit-PSSession](xref:Microsoft.PowerShell.Core.Exit-PSSession)
