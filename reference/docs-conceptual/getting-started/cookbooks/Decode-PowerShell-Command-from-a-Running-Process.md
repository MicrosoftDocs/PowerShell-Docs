# Decode PowerShell Command from a Running Process

There are times when I've found a PowerShell process running that is taking up a bunch of resources. Sometimes they've even been my own scripts running in the context of a SQL Server Agent Job with a PowerShell job step. Because I can have multiple PowerShell job steps running at a time, sometimes it's difficult to know what the offending job is. The following method can be used to decode a script block that a PowerShell process is currently running.

## Create a Long Running Process

To demonstrate this capability, create the following Agent Job. It executes a PowerShell job step that outputs a number every minute for 10 minutes.

```SQL
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC msdb.dbo.sp_add_job @job_name=N'PowerShell Job',
    @enabled=1,
    @notify_level_eventlog=0,
    @notify_level_email=2,
    @notify_level_page=2,
    @delete_level=0,
    @category_name=N'[Uncategorized (Local)]',
    @owner_login_name=N'sa'
GO

EXEC msdb.dbo.sp_add_jobserver @job_name=N'PowerShell Job', @server_name = @@SERVERNAME
GO

EXEC msdb.dbo.sp_add_jobstep @job_name=N'PowerShell Job', @step_name=N'PowerShell',
    @step_id=1,
    @cmdexec_success_code=0,
    @on_success_action=1,
    @on_fail_action=2,
    @retry_attempts=0,
    @retry_interval=0,
    @os_run_priority=0,
    @subsystem=N'PowerShell',
    @command=N'
        powershell.exe -Command {
            $i = 1
            while ( $i -le 10 )
            {
                Write-Output -InputObject $i
                Start-Sleep -Seconds 60
                $i++
            }
        }
    ', 
    @database_name=N'master',
    @flags=0
GO

EXEC msdb.dbo.sp_update_job @job_name=N'PowerShell Job',
    @enabled=1,
    @start_step_id=1,
    @notify_level_eventlog=0,
    @notify_level_email=2,
    @notify_level_page=2,
    @delete_level=0,
    @description=N'',
    @category_name=N'[Uncategorized (Local)]',
    @owner_login_name=N'sa',
    @notify_email_operator_name=N'',
    @notify_page_operator_name=N''
GO
Execute the Agent Job that was just created.
USE msdb;
GO
EXEC dbo.sp_start_job N'PowerShell Job';
GO
```

## View the Process

### Using Task Manager

- Launch the Task Manager and select the **Details** tab.
- Scroll down the list to powershell.exe.

  [![Task Manager Details](.\media\DecodeCommandTaskManagerDetails.png)](.\media\DecodeCommandTaskManagerDetails.png "Task Manager Details")

- Right-click the column headers in Task Manager and click **Select Columns**.

  [![Task Manager right-click the column header](.\media\DecodeCommandTaskManagerRightClick.png)](.\media\DecodeCommandTaskManagerRightClick.png "Right-Click the column header")

- Check **Command Line** in the Select columns dialogue and click **OK**.

  [![Task Manager select **Columns**](.\media\DecodeCommandTaskManagerSelectColumns.png)](.\media\DecodeCommandTaskManagerSelectColumns.png "Select Columns")

- Now the parameters that were passed into powershell.exe are visible. However, the command is still obfuscated as an encoded command.

  [![Task Manager with Command Line](.\media\DecodeCommandTaskManagerWithCommandLine.png)](.\media\DecodeCommandTaskManagerWithCommandLine.png "Task Manager with Command Line shown")

### Using PowerShell

- Start PowerShell as Administrator. It is vital that PowerShell is running as administrator, otherwise no results will be returned when querying the running processes.
- Execute the following command to obtain all of the PowerShell processes that have an encoded command:

```PowerShell
$powerShellProcesses = Get-CimInstance -ClassName Win32_Process -Filter 'CommandLine LIKE "%EncodedCommand%"'
```

- The following command creates a custom PowerShell object that contains the process ID and the encoded command.

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

- Now the encoded command can be decoded. The following snippet iterates over the command details object, decodes the encoded command, and adds the decoded command back to the object for further investigation.

```PowerShell
$commandDetails | ForEach-Object -Process {
    $currentProcess = $_
    $decodedCommand = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($currentProcess.EncodedCommand))
    $commandDetails |
        Where-Object -FilterScript { $_.ProcessId -eq $_.ProcessId } |
        Add-Member -MemberType NoteProperty -Name DecodedCommand -Value $decodedCommand
}
```

- The decoded command can now be reviewed by selecting the decoded command property.

```PowerShell
$commandDetails[0].DecodedCommand
```
