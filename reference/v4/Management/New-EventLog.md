---
external help file: PSITPro4_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293885
schema: 2.0.0
---

# New-EventLog
## SYNOPSIS
Creates a new event log and a new event source on a local or remote computer.

## SYNTAX

```
New-EventLog [-LogName] <String> [-Source] <String[]> [[-ComputerName] <String[]>]
 [-CategoryResourceFile <String>] [-MessageResourceFile <String>] [-ParameterResourceFile <String>]
```

## DESCRIPTION
This cmdlet creates a new classic event log on a local or remote computer.
It can also register an event source that writes to the new log or to an existing log.

The cmdlets that contain the EventLog noun (the Event log cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>new-eventlog -source TestApp -logname TestLog -MessageResourceFile C:\Test\TestApp.dll
```

This command creates the TestLog event log on the local computer and registers a new source for it.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$file = "C:\Program Files\TestApps\NewTestApp.dll"
PS C:\>new-eventlog -computername Server01 -source NewTestApp -logname Application -MessageResourceFile $file -CategoryResourceFile $file
```

This command adds a new event source, NewTestApp, to the Application log on the Server01 remote computer.

The command requires that the NewTestApp.dll file is located on the Server01 computer.

## PARAMETERS

### -CategoryResourceFile
Specifies the path to the file that contains category strings for the source events. 
This file is also known as the Category Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Creates the new event logs on the specified computers.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Specifies the name of the event log.

If the log does not exist, New-EventLog creates the log and uses this value for the Log and LogDisplayName properties of the new event log.
If the log exists, New-EventLog registers a new source for the event log.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -MessageResourceFile
Specifies the path to the file that contains message formatting strings for the source events.
This file is also known as the Event Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterResourceFile
Specifies the path to the file that contains strings used for parameter substitutions in event descriptions.
This file is also known as the Parameter Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies the names of the event log sources, such as application programs that write to the event log.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry

## NOTES
To use New-EventLog on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To create an event source in Windows Vista, Windows XP Professional, or Windows Server 2003, you must be a member of the Administrators group on the computer.

When you create a new event log and a new event source, the system registers the new source for the new log, but the log is not created until the first entry is written to it.

The operating system stores event logs as files.
When you create a new event log, the associated file is stored in the %SystemRoot%\System32\Config directory on the specified computer.
The file name is the first eight characters of the Log property with an .evt file name extension.

## RELATED LINKS

[Clear-EventLog](525ef611-6484-4088-887c-e084f3f5763b)

[Get-EventLog](b4985b11-82bf-487d-928d-becd96fc0419)

[Limit-EventLog](c3c3797c-e5d2-494b-b9c8-170999440385)

[New-EventLog](21e8f496-8f5b-4b79-9393-f16c86287e67)

[Remove-EventLog](487325e7-2a78-49fe-9126-c56222a8fa58)

[Show-EventLog](a3b0f5ad-0438-42c7-915b-d1b4793a431c)

[Write-EventLog](c93c4cd3-028f-4343-bfe6-b70f8f249290)

