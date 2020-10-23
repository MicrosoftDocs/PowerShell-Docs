---
ms.date:  11/13/2018
keywords:  powershell,cmdlet
title:  Decode a PowerShell command from a running process
author: randomnote1
description: This article shows how to decode a script block that a PowerShell process is currently running.
---

# Decode a PowerShell command from a running process

At times, you may have a PowerShell process running that is taking up a large amount of resources.
This process could be running in the context of a [Task Scheduler][] job or a [SQL Server Agent][]
job. Where there are multiple PowerShell processes running, it can be difficult to know
which process represents the problem. This article shows how to decode a script block that a
PowerShell process is currently running.

## Create a long running process

To demonstrate this scenario, open a new PowerShell window and run the following code. It
executes a PowerShell command that outputs a number every minute for 10 minutes.

```powershell
powershell.exe -Command {
    $i = 1
    while ( $i -le 10 )
    {
        Write-Output -InputObject $i
        Start-Sleep -Seconds 60
        $i++
    }
}
```

## View the process

The body of the command which PowerShell is executing is stored in the **CommandLine** property
of the [Win32_Process][] class. If the command is an encoded command, the **CommandLine**
property contains the string "EncodedCommand". Using this information, the encoded command can
be de-obfuscated via the following process.

Start PowerShell as Administrator. It is vital that PowerShell is running as administrator,
otherwise no results are returned when querying the running processes.

Execute the following command to get all of the PowerShell processes that have an encoded
command:

```powershell
$powerShellProcesses = Get-CimInstance -ClassName Win32_Process -Filter 'CommandLine LIKE "%EncodedCommand%"'
```

The following command creates a custom PowerShell object that contains the process ID and the
encoded command.

```powershell
$commandDetails = $powerShellProcesses | Select-Object -Property ProcessId,
@{
    name       = 'EncodedCommand'
    expression = {
        if ( $_.CommandLine -match 'encodedCommand (.*) -inputFormat' )
        {
            return $matches[1]
        }
    }
}
```

Now the encoded command can be decoded. The following snippet iterates over the command details
object, decodes the encoded command, and adds the decoded command back to the object for further
investigation.

```powershell
$commandDetails | ForEach-Object -Process {
    # Get the current process
    $currentProcess = $_

    # Convert the Base 64 string to a Byte Array
    $commandBytes = [System.Convert]::FromBase64String($currentProcess.EncodedCommand)

    # Convert the Byte Array to a string
    $decodedCommand = [System.Text.Encoding]::Unicode.GetString($commandBytes)

    # Add the decoded command back to the object
    $commandDetails |
        Where-Object -FilterScript { $_.ProcessId -eq $_.ProcessId } |
        Add-Member -MemberType NoteProperty -Name DecodedCommand -Value $decodedCommand
}
$commandDetails[0]
```

The decoded command can now be reviewed by selecting the decoded command property.

```Output
ProcessId      : 8752
EncodedCommand : IAAKAAoACgAgAAoAIAAgACAAIAAkAGkAIAA9ACAAMQAgAAoACgAKACAACgAgACAAIAAgAHcAaABpAGwAZQAgACgAIAAkAGkAIAAtAG
                 wAZQAgADEAMAAgACkAIAAKAAoACgAgAAoAIAAgACAAIAB7ACAACgAKAAoAIAAKACAAIAAgACAAIAAgACAAIABXAHIAaQB0AGUALQBP
                 AHUAdABwAHUAdAAgAC0ASQBuAHAAdQB0AE8AYgBqAGUAYwB0ACAAJABpACAACgAKAAoAIAAKACAAIAAgACAAIAAgACAAIABTAHQAYQ
                 ByAHQALQBTAGwAZQBlAHAAIAAtAFMAZQBjAG8AbgBkAHMAIAA2ADAAIAAKAAoACgAgAAoAIAAgACAAIAAgACAAIAAgACQAaQArACsA
                 IAAKAAoACgAgAAoAIAAgACAAIAB9ACAACgAKAAoAIAAKAA==
DecodedCommand :
                     $i = 1

                     while ( $i -le 10 )

                     {

                         Write-Output -InputObject $i

                         Start-Sleep -Seconds 60

                         $i++

                     }
```

[Task Scheduler]: /windows/desktop/TaskSchd/task-scheduler-start-page
[SQL Server Agent]: /sql/ssms/agent/sql-server-agent
[Win32_Process]: /windows/desktop/CIMWin32Prov/win32-process
