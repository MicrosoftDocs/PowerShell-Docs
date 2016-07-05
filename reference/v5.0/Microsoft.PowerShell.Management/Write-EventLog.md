---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293931
schema: 2.0.0
---

# Write-EventLog
## SYNOPSIS
Writes an event to an event log.

## SYNTAX

```
Write-EventLog [-LogName] <String> [-Source] <String> [-EventId] <Int32> [-EntryType] [-Message] <String>
 [-Category <Int16>] [-ComputerName <String>] [-RawData <Byte[]>]
```

## DESCRIPTION
The Write-EventLog cmdlet writes an event to an event log.

To write an event to an event log, the event log must exist on the computer and the source must be registered for the event log.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of the Windows operating system, use the Get-WinEvent cmdlet.

## EXAMPLES

### Example 1: Write an event to the Application event log
```
PS C:\>Write-EventLog -LogName "Application" -Source "MyApp" -EventID 3001 -EntryType Information -Message "MyApp added a user-requested feature to the display." -Category 1 -RawData 10,20
```

This command writes an event from the MyApp source to the Application event log.

### Example 2: Write an event to the Application event log of a remote computer
```
PS C:\>Write-EventLog -ComputerName "Server01" -LogName Application -Source "MyApp" -EventID 3001 -Message "MyApp added a user-requested feature to the display."
```

This command writes an event from the MyApp source to the Application event log on the Server01 remote computer.

## PARAMETERS

### -Category
Specifies a task category for the event.
Enter an integer that is associated with the strings in the category message file for the event log.

```yaml
Type: Int16
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of the Get-EventLog cmdlet even if your computer is not configured to run remote commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntryType
Specifies the entry type of the event.
The acceptable values for this parameter are: Error, Warning, Information, SuccessAudit, and FailureAudit.
The default value is Information.

For a description of the values, see System.Diagnostics.EventLogEntryTypehttp://go.microsoft.com/fwlink/?LinkId=143599 (http://go.microsoft.com/fwlink/?LinkId=143599) in the Microsoft Developer Network (MSDN) library.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ET
Accepted values: Error, Warning, Information, SuccessAudit, FailureAudit

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventId
Specifies the event identifier.
This parameter is required.
The maximum value for the EventId parameter is 65535.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ID,EID

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Specifies the name of the log to which the event is written.
Enter the log name.
The log name is the value of the Log property, not the LogDisplayName.
Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: LN

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Specifies the event message.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: MSG

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RawData
Specifies the binary data that is associated with the event, in bytes.

```yaml
Type: Byte[]
Parameter Sets: (All)
Aliases: RD

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies the event source, which is typically the name of the application that is writing the event to the log.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SRC

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry
This cmdlet returns objects that represents the events in the logs.

## NOTES
* To use Write-EventLog, start Windows PowerShell by using the Run as administrator option.

*

## RELATED LINKS

[Clear-EventLog](525ef611-6484-4088-887c-e084f3f5763b)

[Get-EventLog](b4985b11-82bf-487d-928d-becd96fc0419)

[Limit-EventLog](c3c3797c-e5d2-494b-b9c8-170999440385)

[New-EventLog](21e8f496-8f5b-4b79-9393-f16c86287e67)

[Remove-EventLog](487325e7-2a78-49fe-9126-c56222a8fa58)

[Show-EventLog](a3b0f5ad-0438-42c7-915b-d1b4793a431c)

[Write-EventLog](c93c4cd3-028f-4343-bfe6-b70f8f249290)

