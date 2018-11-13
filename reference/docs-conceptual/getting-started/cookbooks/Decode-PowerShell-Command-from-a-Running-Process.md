# Decode PowerShell Command from a Running Process

At times you may have a PowerShell process running that is taking up a large amount of resources. This process could be running in the context of a [Task Scheduler](https://docs.microsoft.com/windows/desktop/TaskSchd/task-scheduler-start-page
) job or a [SQL Server Agent](https://docs.microsoft.com/sql/ssms/agent/sql-server-agent
) job. Because multiple PowerShell processes can be running at a time, it can be difficult to know what the offending process is. The following method can be used to decode a script block that a PowerShell process is currently running.

## Create a Long Running Process

To demonstrate this capability, open a new PowerShell window and run the following code. It executes a PowerShell command that outputs a number every minute for 10 minutes.

```PowerShell
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

## View the Process

The body of the command which PowerShell is executing is stored the in the `CommandLine` property of the [Win32_Process](https://docs.microsoft.com/windows/desktop/CIMWin32Prov/win32-process
) class. If the command is an [encoded command](https://docs.microsoft.com/powershell/scripting/core-powershell/console/powershell.exe-command-line-help?#-encodedcommand-
), the `CommandLine` property will contain the string `EncodedCommand`. Using this information, the [encoded command](https://docs.microsoft.com/powershell/scripting/core-powershell/console/powershell.exe-command-line-help?#-encodedcommand-
) can be de-obfuscated via the following process.

Start PowerShell as Administrator. It is vital that PowerShell is running as administrator, otherwise no results will be returned when querying the running processes.

Execute the following command to obtain all of the PowerShell processes that have an encoded command:

```PowerShell
$powerShellProcesses = Get-CimInstance -ClassName Win32_Process -Filter 'CommandLine LIKE "%EncodedCommand%"'
```

The following command creates a custom PowerShell object that contains the process ID and the encoded command.

```PowerShell
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

Now the encoded command can be decoded. The following snippet iterates over the command details object, decodes the encoded command, and adds the decoded command back to the object for further investigation.

```PowerShell
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
```

The decoded command can now be reviewed by selecting the decoded command property.

```PowerShell
$commandDetails[0].DecodedCommand
```
