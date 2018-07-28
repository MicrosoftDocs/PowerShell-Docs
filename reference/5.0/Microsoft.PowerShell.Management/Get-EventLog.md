---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821585
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-EventLog
---

# Get-EventLog

## SYNOPSIS
Gets the events in an event log, or a list of the event logs, on the local or remote computers.

## SYNTAX

### LogName (Default)
```
Get-EventLog [-LogName] <String> [-ComputerName <String[]>] [-Newest <Int32>] [-After <DateTime>]
 [-Before <DateTime>] [-UserName <String[]>] [[-InstanceId] <Int64[]>] [-Index <Int32[]>]
 [-EntryType <String[]>] [-Source <String[]>] [-Message <String>] [-AsBaseObject] [<CommonParameters>]
```

### List
```
Get-EventLog [-ComputerName <String[]>] [-List] [-AsString] [<CommonParameters>]
```

## DESCRIPTION
The **Get-EventLog** cmdlet gets events and event logs on the local and remote computers.

You can use the parameters of this cmdlet to search for events by using their property values.
This cmdlet gets only the events that match all of the specified property values.

The cmdlets that contain the EventLog noun work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## EXAMPLES

### Example 1: Get event logs on a computer
```
PS C:\> Get-EventLog -List
```

This command gets the event logs on the computer.

### Example 2: Get the five most recent entries from a specific event log
```
PS C:\> Get-EventLog -Newest 5 -LogName "Application"
```

This command gets the five most recent entries from the Application event log.

### Example 3: Find all sources that are represented in a specific number of entries in an event log
```
PS C:\> $Events = Get-Eventlog -LogName system -Newest 1000
PS C:\> $Events | Group-Object -Property source -noelement | Sort-Object -Property count -Descending











Count Name
----- ----
75    Service Control Manager
12    Print
6     UmrdpService
2     DnsApi
2     DCOM
1     Dhcp
1     TermDD
1     volsnap
```

This example shows how to find all of the sources that are represented in the 1000 most recent entries in the System event log.

The first command gets the 1,000 most recent entries from the System event log and stores them in the $Events variable.

The second command uses a pipeline operator (|) to send the events in $Events to the Group-Object cmdlet, which groups the entries by the value of the Source property.
The command uses a second pipeline operator to send the grouped events to the Sort-Object cmdlet, which sorts them in descending order, so the most frequently appearing source is listed first.

Source is just one property of event log entries.
To see all of the properties of an event log entry, pipe the event log entries to the Get-Member cmdlet.

### Example 4: Get error events from a specific event log
```
PS C:\> Get-EventLog -LogName System -EntryType Error
```

This command gets only error events from the System event log.

### Example 5: Get events from a specific event log with an Instance ID and Source value
```
PS C:\> Get-EventLog -LogName System -InstanceID 3221235481 -Source "DCOM"
```

This command gets events from the System log that have an InstanceID of 3221235481 and a Source value of DCOM.

### Example 6: Get event log events from multiple computers
```
PS C:\> Get-EventLog -LogName "Windows PowerShell" -ComputerName "localhost", "Server01", "Server02"
```

This command gets the events from the Windows PowerShell event log on three computers, Server01, Server02, and the local computer, known as localhost.

### Example 7: Get all events in an event log that have include a specific word in the message value
```
PS C:\> Get-EventLog -LogName "Windows PowerShell" -Message "*failed*"
```

This command gets all the events in the Windows PowerShell event log that have a message value that includes the word failed.

### Example 8: Display the property values of an event in a list
```
PS C:\> $A = Get-EventLog -Log System -Newest 1
PS C:\> $A | Format-List -Property *

















EventID            : 7036
MachineName        : Server01
Data               : {}
Index              : 10238
Category           : (0)
CategoryNumber     : 0
EntryType          : Information
Message            : The description for Event ID
Source             : Service Control Manager
ReplacementStrings : {WinHTTP Web Proxy Auto-Disco
InstanceId         : 1073748860
TimeGenerated      : 4/11/2008 9:56:05 PM
TimeWritten        : 4/11/2008 9:56:05 PM
UserName           :
Site               :
Container          :
```

This example shows how to display the property values of an event in a list.

The first command gets the newest event from the System event log and saves it in the $A variable.

The second command uses a pipeline operator (|) to send the event in $a to the Format-List command, which displays all (*) of the event properties.

### Example 9: Get events from an event log with using a source and event ID
```
PS C:\> Get-EventLog -Log "Application" -Source "Outlook" | where {$_.eventID -eq 34}
```

This command gets events in the Application event log where the source is Outlook and the event ID is 34.
Even though this cmdlet does not have an *EventID* parameter, you can use the Where-Object cmdlet to select events based on the value of any event property.

### Example 10: Get event in an event log that is grouped by a property
```
PS C:\> Get-EventLog -Log System -UserName "NT*" | Group-Object -Property "UserName" -noelement | Format-Table Count, Name -Auto






Count Name
----- ----
6031  NT AUTHORITY\SYSTEM
42    NT AUTHORITY\LOCAL SERVICE
4     NT AUTHORITY\NETWORK SERVICE
```

This command returns the events in the system log grouped by the value of their UserName property.
This command uses the *UserName* parameter to get only events in which the user name begins with NT*.

### Example 11: Get all errors in an event log that occurred during a specific time frame
```
PS C:\> $May31 = Get-Date 5/31/08
PS C:\> $July1 = Get-Date 7/01/08
PS C:\> Get-EventLog -Log "Windows PowerShell" -EntryType Error -After $May31 -before $July1
```

This command gets all of the errors in the Windows PowerShell event log that occurred in June 2008.

## PARAMETERS

### -After
Specifies the data and time that this cmdlet get events that occur after.
Enter a **DateTime** object, such as the one returned by the Get-Date cmdlet.

```yaml
Type: DateTime
Parameter Sets: LogName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsBaseObject
Indicates that this cmdlet returns a standard **System.Diagnostics.EventLogEntry** object for each event.
Without this parameter, this cmdlet returns an extended **PSObject** object with additional **EventLogName**, **Source**, and **InstanceId** properties.

To see the effect of this parameter, pipe the events to the Get-Member cmdlet and examine the TypeName value in the result.

```yaml
Type: SwitchParameter
Parameter Sets: LogName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsString
Indicates that this cmdlet returns the output as strings, instead of objects.

```yaml
Type: SwitchParameter
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before
Specifies the data and time that this cmdlet get events that occur before.
Enter a **DateTime** object, such as the one returned by the **Get-Date** cmdlet.

```yaml
Type: DateTime
Parameter Sets: LogName
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

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name (FQDN) of a remote computer.
To specify the local computer, type the computer name, a dot (.), or localhost.

This parameter does not rely on Windows PowerShell remoting.
You can use the *ComputerName* parameter of **Get-EventLog** even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntryType
Specifies, as a string array, the entry type of the events that this cmdlet gets.

The acceptable values for this parameter are:

- Error
- Information
- FailureAudit
- SuccessAudit
- Warning.
The default is all events.

```yaml
Type: String[]
Parameter Sets: LogName
Aliases: ET
Accepted values: Error, Information, FailureAudit, SuccessAudit, Warning

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Index
Specifies the index values that this cmdlet gets events from.

```yaml
Type: Int32[]
Parameter Sets: LogName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Specifies the instance IDs that this cmdlet gets events from.

```yaml
Type: Int64[]
Parameter Sets: LogName
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -List
Indicates that this cmdlet gets a list of event logs on the computer.

```yaml
Type: SwitchParameter
Parameter Sets: List
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Specifies the event log.
Enter the log name (the value of the Log property; not the LogDisplayName) of one event log.
Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: String
Parameter Sets: LogName
Aliases: LN

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Specifies a string in the event message that this cmdlet gets event information from.
You can use this property to search for messages that contain certain words or phrases.
Wildcards are permitted.

```yaml
Type: String
Parameter Sets: LogName
Aliases: MSG

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Newest
Specifies the maximum number of events that this cmdlet gets.
This cmdlet gets the specified number of events, beginning with the newest event in the log.

```yaml
Type: Int32
Parameter Sets: LogName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies, as a string array, sources that were written to the log that this cmdlet gets.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: LogName
Aliases: ABO

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -UserName
Specifies, as a string array, user names that are associated with events.
Enter names or name patterns, such as User01, User*, or Domain01\User*.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: LogName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None.
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry. System.Diagnostics.EventLog. System.String
If the *LogName* parameter is specified, the output is a collection of **System.Diagnostics.EventLogEntry** objects.

If only the *List* parameter is specified, the output is a collection of **System.Diagnostics.EventLog** objects.

If both the *List* and *AsString* parameters are specified, the output is a collection of **System.String** objects.

## NOTES
* This cmdlet and the Get-WinEvent cmdlet are not supported in Windows Preinstallation Environment (Windows PE).

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)