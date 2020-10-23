---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Managing Processes with Process Cmdlets
description: PowerShell provides several cmdlets that help manage processes on local and remote computers.
---
# Managing Processes with Process Cmdlets

You can use the Process cmdlets in Windows PowerShell to manage local and remote processes in
Windows PowerShell.

## Getting Processes (Get-Process)

To get the processes running on the local computer, run a **Get-Process** with no parameters.

You can get particular processes by specifying their process names or process IDs. The following
command gets the Idle process:

```
PS> Get-Process -id 0

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
      0       0        0         16     0               0 Idle
```

Although it is normal for cmdlets to return no data in some situations, when you specify a process
by its ProcessId, **Get-Process** generates an error if it finds no matches, because the usual
intent is to retrieve a known running process. If there is no process with that Id, it is likely
that the Id is incorrect or that the process of interest has already exited:

```
PS> Get-Process -Id 99

Get-Process : No process with process ID 99 was found.
At line:1 char:12
+ Get-Process  <<<< -Id 99
```

You can use the Name parameter of the Get-Process cmdlet to specify a subset of processes based on
the process name. The Name parameter can take multiple names in a comma-separated list and it
supports the use of wildcards, so you can type name patterns.

For example, the following command gets process whose names begin with "ex."

```
PS> Get-Process -Name ex*

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    234       7     5572      12484   134     2.98   1684 EXCEL
    555      15    34500      12384   134   105.25    728 explorer
```

Because the .NET System.Diagnostics.Process class is the foundation for Windows PowerShell
processes, it follows some of the conventions used by System.Diagnostics.Process. One of those
conventions is that the process name for an executable never includes the ".exe" at the end of the
executable name.

**Get-Process** also accepts multiple values for the Name parameter.

```
PS> Get-Process -Name exp*,power*

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    540      15    35172      48148   141    88.44    408 explorer
    605       9    30668      29800   155     7.11   3052 powershell
```

You can use the ComputerName parameter of Get-Process to get processes on remote computers. For
example, the following command gets the PowerShell processes on the local computer (represented by
"localhost") and on two remote computers.

```
PS> Get-Process -Name PowerShell -ComputerName localhost, Server01, Server02

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    258       8    29772      38636   130            3700 powershell
    398      24    75988      76800   572            5816 powershell
    605       9    30668      29800   155     7.11   3052 powershell
```

The computer names are not evident in this display, but they are stored in the MachineName property
of the process objects that Get-Process returns. The following command uses the Format-Table cmdlet
to display the process ID, ProcessName and MachineName (ComputerName) properties of the process
objects.

```
PS> Get-Process -Name PowerShell -ComputerName localhost, Server01, Server01 |
  Format-Table -Property ID, ProcessName, MachineName

  Id ProcessName MachineName
  -- ----------- -----------
3700 powershell  Server01
3052 powershell  Server02
5816 powershell  localhost
```

This more complex command adds the MachineName property to the standard Get-Process display.

```
PS> Get-Process powershell -ComputerName localhost, Server01, Server02 |
    Format-Table -Property Handles,
        @{Label="NPM(K)";Expression={[int]($_.NPM/1024)}},
        @{Label="PM(K)";Expression={[int]($_.PM/1024)}},
        @{Label="WS(K)";Expression={[int]($_.WS/1024)}},
        @{Label="VM(M)";Expression={[int]($_.VM/1MB)}},
        @{Label="CPU(s)";Expression={if ($_.CPU -ne $()){$_.CPU.ToString("N")}}},
        Id, ProcessName, MachineName -auto

Handles  NPM(K)  PM(K) WS(K) VM(M) CPU(s)  Id ProcessName  MachineName
-------  ------  ----- ----- ----- ------  -- -----------  -----------
    258       8  29772 38636   130         3700 powershell Server01
    398      24  75988 76800   572         5816 powershell localhost
    605       9  30668 29800   155 7.11    3052 powershell Server02
```

## Stopping Processes (Stop-Process)

Windows PowerShell gives you flexibility for listing processes, but what about stopping a process?

The **Stop-Process** cmdlet takes a Name or Id to specify a process you want to stop. Your ability
to stop processes depends on your permissions. Some processes cannot be stopped. For example, if you
try to stop the idle process, you get an error:

```
PS> Stop-Process -Name Idle
Stop-Process : Process 'Idle (0)' cannot be stopped due to the following error:
 Access is denied
At line:1 char:13
+ Stop-Process  <<<< -Name Idle
```

You can also force prompting with the **Confirm** parameter. This parameter is particularly useful
if you use a wildcard when specifying the process name, because you may accidentally match some
processes you do not want to stop:

```
PS> Stop-Process -Name t*,e* -Confirm
Confirm
Are you sure you want to perform this action?
Performing operation "Stop-Process" on Target "explorer (408)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):n
Confirm
Are you sure you want to perform this action?
Performing operation "Stop-Process" on Target "taskmgr (4072)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):n
```

Complex process manipulation is possible by using some of the object filtering cmdlets. Because a
Process object has a Responding property that is true when it is no longer responding, you can stop
all nonresponsive applications with the following command:

```powershell
Get-Process | Where-Object -FilterScript {$_.Responding -eq $false} | Stop-Process
```

You can use the same approach in other situations. For example, suppose a secondary notification
area application automatically runs when users start another application. You may find that this
does not work correctly in Terminal Services sessions, but you still want to keep it in sessions
that run on the physical computer console. Sessions connected to the physical computer desktop
always have a session ID of 0, so you can stop all instances of the process that are in other
sessions by using **Where-Object** and the process, **SessionId**:

```powershell
Get-Process -Name BadApp | Where-Object -FilterScript {$_.SessionId -neq 0} | Stop-Process
```

The Stop-Process cmdlet does not have a ComputerName parameter. Therefore, to run a stop process
command on a remote computer, you need to use the Invoke-Command cmdlet. For example, to stop the
PowerShell process on the Server01 remote computer, type:

```powershell
Invoke-Command -ComputerName Server01 {Stop-Process Powershell}
```

## Stopping All Other Windows PowerShell Sessions

It may occasionally be useful to be able to stop all running Windows PowerShell sessions other than
the current session. If a session is using too many resources or is inaccessible (it may be running
remotely or in another desktop session), you may not be able to directly stop it. If you try to stop
all running sessions, however, the current session may be terminated instead.

Each Windows PowerShell session has an environment variable PID that contains the Id of the Windows
PowerShell process. You can check the $PID against the Id of each session and terminate only Windows
PowerShell sessions that have a different Id. The following pipeline command does this and returns
the list of terminated sessions (because of the use of the **PassThru** parameter):

```
PS> Get-Process -Name powershell | Where-Object -FilterScript {$_.Id -ne $PID} | Stop-Process -PassThru

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    334       9    23348      29136   143     1.03    388 powershell
    304       9    23152      29040   143     1.03    632 powershell
    302       9    20916      26804   143     1.03   1116 powershell
    335       9    25656      31412   143     1.09   3452 powershell
    303       9    23156      29044   143     1.05   3608 powershell
    287       9    21044      26928   143     1.02   3672 powershell
```

## Starting, Debugging, and Waiting for Processes

Windows PowerShell also comes with cmdlets to start (or restart), debug a process, and wait for a
process to complete before running a command. For information about these cmdlets, see the cmdlet
help topic for each cmdlet.

## See Also

- [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process)
- [Stop-Process](/powershell/module/Microsoft.PowerShell.Management/Stop-Process)
- [Start-Process](/powershell/module/Microsoft.PowerShell.Management/Start-Process)
- [Wait-Process](/powershell/module/Microsoft.PowerShell.Management/Wait-Process)
- [Debug-Process](/powershell/module/Microsoft.PowerShell.Management/Debug-Process)
- [Invoke-Command](/powershell/module/Microsoft.PowerShell.Core/Invoke-Command)
