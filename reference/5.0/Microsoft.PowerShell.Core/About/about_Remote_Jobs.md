---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Remote_Jobs
---
# About Remote Jobs

## SHORT DESCRIPTION
Describes how to run background jobs on remote computers.

## DETAILED DESCRIPTION

A background job is a command that runs asynchronously without interacting
with the current session. The command prompt returns immediately, and you can
continue to use the session while the job runs.

By default, background jobs run on the local computer. However, you can use
several different procedures to run background jobs on remote computers.

This topic explains how to run a background job on a remote computer. For
information about how to run background jobs on a local computer, see
[about_Jobs](about_Jobs.md). For more information about background jobs, see
[about_Job_Details](about_Job_Details.md).

## REMOTE BACKGROUND JOBS

You can run background jobs on remote computers by using three different
methods.

- Start an interactive session with a remote computer, and start a job in the
  interactive session. The procedures are the same as running a local job,
  although all actions are performed on the remote computer.

- Run a background job on a remote computer that returns its results to the
  local computer. Use this method when you want to collect the results of
  background jobs and maintain them in a central location on the local computer.

- Run a background job on a remote computer that maintains its results on the
  remote computer. Use this method when the job data is more securely maintained
  on the originating computer.

### START A BACKGROUND JOB IN AN INTERACTIVE SESSION

You can start an interactive session with a remote computer and then start a
background job during the interactive session. For more information about
interactive sessions, see about_Remote, and see Enter-PSSession.

The procedure for starting a background job in an interactive session is
almost identical to the procedure for starting a background job on the local
computer. However, all of the operations occur on the remote computer, not the
local computer.

#### STEP 1: ENTER-PSSESSION

Use the Enter-PSSession cmdlet to start an interactive session with a remote
computer. You can use the ComputerName parameter of Enter-PSSession to
establish a temporary connection for the interactive session. Or, you can use
the Session parameter to run the interactive session in a Windows PowerShell
session (PSSession).

The following command starts an interactive session on the Server01 computer.

```powershell
C:\PS> Enter-PSSession -computername Server01
```

The command prompt changes to show that you are now connected to the Server01
computer.

```
Server01\C:>
```

#### STEP 2: START-JOB

To start a background job in the session, use the Start-Job cmdlet.

The following command runs a background job that gets the events in the
Windows PowerShell event log on the Server01 computer. The Start-Job cmdlet
returns an object that represents the job.

This command saves the job object in the \$job variable.

```powershell
Server01\C:> $job = start-job -scriptblock {
  get-eventlog "Windows PowerShell"
}
```

While the job runs, you can use the interactive session to run other commands,
including other background jobs. However, you must keep the interactive
session open until the job is completed. If you end the session, the job is
interrupted, and the results are lost.

#### STEP 3: GET-JOB

To find out if the job is complete, display the value of the \$job variable,
or use the Get-Job cmdlet to get the job. The following command uses the
Get-Job cmdlet to display the job.

```powershell
Server01\C:> get-job $job

SessionId  Name  State      HasMoreData  Location   Command
---------  ----  -----      -----------  --------   -------
1          Job1  Complete   True         localhost  get-eventlog "Windows...
```

The Get-Job output shows that job is running on the "localhost" computer
because the job was started on and is running on the same computer (in this
case, Server01).

#### STEP 4: RECEIVE-JOB

To get the results of the job, use the Receive-Job cmdlet. You can display the
results in the interactive session or save them to a file on the remote
computer. The following command gets the results of the job in the $job
variable. The command uses the redirection operator (>) to save the results of
the job in the PsLog.txt file on the Server01 computer.

```powershell
Server01\C:> receive-job $job > c:\logs\PsLog.txt
```

#### STEP 5: EXIT-PSSESSION

To end the interactive session, use the Exit-PSSession cmdlet. The command
prompt changes to show that you are back in the original session on the local
computer.

```powershell
Server01\C:> Exit-PSSession
C:\PS>
```

#### STEP 6: INVOKE-COMMAND: GET-CONTENT

To view the contents of the PsLog.txt file on the Server01 computer at any
time, start another interactive session, or run a remote command. This type of
command is best run in a PSSession (a persistent connection) in case you want
to use several commands to investigate and manage the data in the PsLog.txt
file. For more information about PSSessions, see about_PSSessions.

The following commands use the New-PSSession cmdlet to create a PSSession that
is connected to the Server01 computer, and they use the Invoke-Command cmdlet
to run a Get-Content command in the PSSession to view the contents of the
file.

```powershell
$s = new-pssession -computername Server01
invoke-command -session $s -scriptblock {
  get-content c:\logs\pslog.txt}
```

### START A REMOTE JOB THAT RETURNS THE RESULTS TO THE LOCAL COMPUTER \(ASJOB\)

To start a background job on a remote computer that returns the command
results to the local computer, use the AsJob parameter of a cmdlet such as the
Invoke-Command cmdlet.

When you use the AsJob parameter, the job object is actually created on the
local computer even though the job runs on the remote computer. When the job
is completed, the results are returned to the local computer.

You can use the cmdlets that contain the Job noun (the Job cmdlets) to manage
any job created by any cmdlet. Many of the cmdlets that have AsJob parameters
do not use Windows PowerShell remoting, so you can use them even on computers
that are not configured for remoting and that do not meet the requirements for
remoting.

#### STEP 1: INVOKE-COMMAND -ASJOB

The following command uses the AsJob parameter of Invoke-Command to start a
background job on the Server01 computer. The job runs a Get-Eventlog command
that gets the events in the System log. You can use the JobName parameter to
assign a display name to the job.

```powershell
invoke-command -computername Server01 -scriptblock {
  get-eventlog system} -asjob
```

The results of the command resemble the following sample output.

```Output
SessionId   Name   State    HasMoreData   Location   Command
---------   ----   -----    -----------   --------   -------
1           Job1   Running  True          Server01   get-eventlog system
```

When the AsJob parameter is used, Invoke-Command returns the same type of job
object that Start-Job returns. You can save the job object in a variable, or
you can use a Get-Job command to get the job.

Note that the value of the Location property shows that the job ran on the
Server01 computer.

#### STEP 2: GET-JOB

To manage a job started by using the AsJob parameter of the Invoke-Command
cmdlet, use the Job cmdlets. Because the job object that represents the remote
job is on the local computer, you do not need to run remote commands to manage
the job.

To determine whether the job is complete, use a Get-Job command. The following
command gets all of the jobs that were started in the current session.

```powershell
get-job
```

Because the remote job was started in the current session, a local Get-Job
command gets the job. The State property of the job object shows that the
command was completed successfully.

```Output
SessionId   Name   State      HasMoreData   Location   Command
---------   ----   -----      -----------   --------   -------
1           Job1   Completed  True          Server01   get-eventlog system
```

#### STEP 3: RECEIVE-JOB

To get the results of the job, use the Receive-Job cmdlet. Because the job
results are automatically returned to the computer where the job object
resides, you can get the results with a local Receive-Job command.

The following command uses the Receive-Job cmdlet to get the results of the
job. It uses the session ID to identify the job. This command saves the job
results in the $results variable. You can also redirect the results to a file.

```powershell
$results = receive-job -id 1
```

### START A REMOTE JOB THAT KEEPS THE RESULTS ON THE REMOTE COMPUTER

To start a background job on a remote computer that keeps the command results
on the remote computer, use the Invoke-Command cmdlet to run a Start-Job
command on a remote computer. You can use this method to run background jobs
on multiple computers.

When you run a Start-Job command remotely, the job object is created on the
remote computer, and the job results are maintained on the remote computer.
From the perspective of the job, all operations are local. You are just
running commands remotely to manage a local job on the remote computer.

#### STEP 1: INVOKE-COMMAND START-JOB

Use the Invoke-Command cmdlet to run a Start-Job command on a remote computer.

This command requires a PSSession (a persistent connection). If you use the
ComputerName parameter of Invoke-Command to establish a temporary connection,
the Invoke-Command command is considered to be complete when the job object is
returned. As a result, the temporary connection is closed, and the job is
canceled.

The following command uses the New-PSSession cmdlet to create a PSSession that
is connected to the Server01 computer. The command saves the PSSession in the
\$s variable.

```powershell
$s = new-pssession -computername Server01
```

The next command uses the Invoke-Command cmdlet to run a Start-Job command in
the PSSession. The Start-Job command and the Get-Eventlog command are enclosed
in braces.

```powershell
invoke-command -session $s -scriptblock {
  start-job -scriptblock {get-eventlog system}}
```

The results resemble the following sample output.

```Output
Id       Name    State      HasMoreData     Location   Command
--       ----    -----      -----------     --------   -------
2        Job2    Running    True            Localhost  get-eventlog system
```

When you run a Start-Job command remotely, Invoke-Command returns the same
type of job object that Start-Job returns. You can save the job object in a
variable, or you can use a Get-Job command to get the job.

Note that the value of the Location property shows that the job ran on the
local computer, known as "LocalHost", even though the job ran on the Server01
computer. Because the job object is created on the Server01 computer and the
job runs on the same computer, it is considered to be a local background job.

#### STEP 2: INVOKE-COMMAND GET-JOB

To manage a remote background job, use the Job cmdlets. Because the job object
is on the remote computer, you need to run remote commands to get, stop, wait
for, or retrieve the job results.

To see if the job is complete, use an Invoke-Command command to run a Get-Job
command in the PSSession that is connected to the Server01 computer.

```powershell
invoke-command -session $s -scriptblock {get-job}
```

The command returns a job object. The State property of the job object shows
that the command was completed successfully.

```Output
SessionId   Name  State      HasMoreData   Location   Command
---------   ----  -----      -----------   --------   -------
2           Job2  Completed  True          LocalHost   get-eventlog system
```

#### STEP 3: INVOKE-COMMAND RECEIVE-JOB

To get the results of the job, use the Invoke-Command cmdlet to run a
Receive-Job command in the PSSession that is connected to the Server01
computer.

The following command uses the Receive-Job cmdlet to get the results of the
job. It uses the session ID to identify the job. This command saves the job
results in the \$results variable. It uses the Keep parameter of Receive-Job
to keep the result in the job cache on the remote computer.

```powershell
$results = invoke-command -session $s -scriptblock {
  receive-job -sessionid 2 -keep}
```

You can also redirect the results to a file on the local or remote computer.
The following command uses a redirection operator to save the results in a
file on the Server01 computer.

```powershell
invoke-command -session $s -command {
  receive-job -sessionid 2 > c:\logs\pslog.txt}
```

## SEE ALSO

[about_Jobs](about_Jobs.md)

[about_Job_Details](about_Job_Details.md)

[about_Remote](about_Remote.md)

[about_Remote_Variables](about_Remote_Variables.md)

[Invoke-Command](../Invoke-Command.md)

[Start-Job](../Start-Job.md)

[Get-Job](../Get-Job.md)

[Wait-Job](../Wait-Job.md)

[Stop-Job](../Stop-Job.md)

[Remove-Job](../Remove-Job.md)

[New-PSSession](../New-PSSession.md)

[Enter-PSSession](../Enter-PSSession.md)

[Exit-PSSession](../Exit-PSSession.md)