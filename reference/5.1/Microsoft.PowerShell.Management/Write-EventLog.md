---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/write-eventlog?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-EventLog
---

# Write-EventLog

## SYNOPSIS
Writes an event to an event log.

## SYNTAX

```
Write-EventLog [-LogName] <String> [-Source] <String> [[-EntryType] <EventLogEntryType>] [-Category <Int16>]
 [-EventId] <Int32> [-Message] <String> [-RawData <Byte[]>] [-ComputerName <String>] [<CommonParameters>]
```

## DESCRIPTION
The `Write-EventLog` cmdlet writes an event to an event log.

To write an event to an event log, the event log must exist on the computer and the source must be
registered for the event log.

The cmdlets that contain the **EventLog** noun (the **EventLog** cmdlets) work only on classic event
logs. To get events from logs that use the Windows Event Log technology in Windows Vista and later
versions of the Windows operating system, use the `Get-WinEvent` cmdlet.

## EXAMPLES

### Example 1: Write an event to the Application event log

```
PS C:\> Write-EventLog -LogName "Application" -Source "MyApp" -EventID 3001 -EntryType Information -Message "MyApp added a user-requested feature to the display." -Category 1 -RawData 10,20
```

This command writes an event from the MyApp source to the Application event log.

### Example 2: Write an event to the Application event log of a remote computer

```
PS C:\> Write-EventLog -ComputerName "Server01" -LogName Application -Source "MyApp" -EventID 3001 -Message "MyApp added a user-requested feature to the display."
```

This command writes an event from the MyApp source to the Application event log on the Server01
remote computer.

## PARAMETERS

### -Category

Specifies a task category for the event. Enter an integer that is associated with the strings in the
category message file for the event log.

```yaml
Type: System.Int16
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies a remote computer. The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter of the `Get-EventLog` cmdlet even if your computer is not configured to run remote
commands.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: CN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntryType

Specifies the entry type of the event. The acceptable values for this parameter are: Error, Warning,
Information, SuccessAudit, and FailureAudit. The default value is Information.

For a description of the values, see
[EventLogEntryType Enumeration](/dotnet/api/system.diagnostics.eventlogentrytype).

```yaml
Type: System.Diagnostics.EventLogEntryType
Parameter Sets: (All)
Aliases: ET
Accepted values: Error, Information, FailureAudit, SuccessAudit, Warning

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventId

Specifies the event identifier. This parameter is required. The maximum value for the **EventId**
parameter is 65535.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ID, EID

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName

Specifies the name of the log to which the event is written. Enter the log name. The log name is the
value of the **Log** property, not the **LogDisplayName**. Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: LN

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message

Specifies the event message. This parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: MSG

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RawData

Specifies the binary data that is associated with the event, in bytes.

```yaml
Type: System.Byte[]
Parameter Sets: (All)
Aliases: RD

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies the event source, which is typically the name of the application that is writing the event
to the log.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SRC

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry
This cmdlet returns objects that represents the events in the logs.

## NOTES

To use `Write-EventLog`, start Windows PowerShell by using the Run as administrator option.

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)
