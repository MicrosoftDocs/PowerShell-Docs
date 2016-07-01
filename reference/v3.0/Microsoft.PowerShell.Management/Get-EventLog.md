---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get EventLog
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113314
schema:  2.0.0
---


# Get-EventLog
## SYNOPSIS
Gets the events in an event log, or a list of the event logs, on the local or remote computers.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-EventLog [-LogName] <String> [[-InstanceId] <Int64[]>] [-After <DateTime>] [-AsBaseObject]
 [-Before <DateTime>] [-ComputerName <String[]>] [-EntryType <String[]>] [-Index <Int32[]>] [-Message <String>]
 [-Newest <Int32>] [-Source <String[]>] [-UserName <String[]>]
```

### UNNAMED_PARAMETER_SET_2
```
Get-EventLog [-AsString] [-ComputerName <String[]>] [-List]
```

## DESCRIPTION
The Get-EventLog cmdlet gets events and event logs on the local and remote computers.

Use the parameters of Get-EventLog to search for events by using their property values.
Get-EventLog gets only the events that match all of the specified property values.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-eventlog -list
```

This command gets the event logs on the computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-eventlog -newest 5 -logname application
```

This command gets the five most recent entries from the Application event log.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$events = get-eventlog -logname system -newest 1000
PS C:\>$events | group-object -property source -noelement | sort-object -property count -descending

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

The first command gets the 1,000 most recent entries from the System event log and stores them in the $events variable.

The second command uses a pipeline operator (|) to send the events in $events to the Group-Object cmdlet, which groups the entries by the value of the Source property.
The command uses a second pipeline operator to send the grouped events to the Sort-Object cmdlet, which sorts them in descending order, so the most frequently appearing source is listed first.

Source is just one property of event log entries.
To see all of the properties of an event log entry, pipe the event log entries to the Get-Member cmdlet.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-eventlog -logname System -EntryType Error
```

This command gets only error events from the System event log.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-eventlog -logname System -instanceID 3221235481 -Source "DCOM"
```

This command gets events from the System log that have an InstanceID of 3221235481 and a Source value of "DCOM."

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-eventlog -logname "Windows PowerShell" -computername localhost, Server01, Server02
```

This command gets the events from the "Windows PowerShell" event log on three computers, Server01, Server02, and the local computer, known as "localhost".

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>get-eventlog -logname "Windows PowerShell" -message "*failed*"
```

This command gets all the events in the Windows PowerShell event log that have a message value that includes the word "failed".

### -------------------------- EXAMPLE 8 --------------------------
```
PS C:\>$a = get-eventlog -log System -newest 1
PS C:\>$a | format-list -property *

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

The first command gets the newest event from the System event log and saves it in the $a variable.

The second command uses a pipeline operator (|) to send the event in $a to the Format-List command, which displays all (*) of the event properties.

### -------------------------- EXAMPLE 9 --------------------------
```
PS C:\>get-eventlog -log application -source outlook | where {$_.eventID -eq 34}
```

This command gets events in the Application event log where the source is Outlook and the event ID is 34.
Even though Get-EventLog does not have an EventID parameter, you can use the Where-Object cmdlet to select events based on the value of any event property.

### -------------------------- EXAMPLE 10 --------------------------
```
PS C:\>get-eventlog -log system -username NT* | group-object -property username -noelement | format-table Count, Name -auto

Count Name
----- ----
6031  NT AUTHORITY\SYSTEM
42    NT AUTHORITY\LOCAL SERVICE
4     NT AUTHORITY\NETWORK SERVICE
```

This command returns the events in the system log grouped by the value of  their UserName property.
The Get-EventLog command uses the UserName parameter to get only events in which the user name begins with "NT*".

### -------------------------- EXAMPLE 11 --------------------------
```
PS C:\>$May31 = get-date 5/31/08
PS C:\>$July1 = get-date 7/01/08
PS C:\>get-eventlog -log "Windows PowerShell" -entrytype Error -after $may31 -before $july1
```

This command gets all of the errors in the Windows PowerShell event log that occurred in June 2008.

## PARAMETERS

### -After
Gets only the events that occur after the specified date and time.
Enter a DateTime object, such as the one returned by the Get-Date cmdlet.

```yaml
Type: DateTime
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsBaseObject
Returns a standard System.Diagnostics.EventLogEntry object for each event.
Without this parameter, Get-EventLog returns an extended PSObject object with additional EventLogName, Source, and InstanceId properties.

To see the effect of this parameter, pipe the events to the Get-Member cmdlet and examine the TypeName value in the result.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsString
Returns the output as strings, instead of objects.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before
Gets only the events that occur before the specified date and time.
Enter a DateTime object, such as the one returned by the Get-Date cmdlet.

```yaml
Type: DateTime
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies a remote computer.
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
Position: Named
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntryType
Gets only events with the specified entry type.
Valid values are Error, Information, FailureAudit, SuccessAudit, and Warning.
The default is all events.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: All events
Accept pipeline input: False
Accept wildcard characters: False
```

### -Index
Gets only events with the specified index values.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: All events
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Gets only events with the specified instance IDs.

```yaml
Type: Int64[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -List
Gets a list of event logs on the computer.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: False
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Gets events that have the specified string in their messages.
You can use this property to search for messages that contain certain words or phrases.
Wildcards are permitted.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Newest
Specifies the maximum number of events retrieved.
Get-EventLog gets the specified number of events, beginning with the newest event in the log.

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Gets events that were written to the log by the specified sources.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -UserName
Gets only the events that are associated with the specified user names.
Enter names or name patterns, such as User01, User*, or Domain01\User*.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

## INPUTS

### None.
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry. System.Diagnostics.EventLog. System.String
If the LogName parameter is specified, the output is a collection of EventLogEntry objects (System.Diagnostics.EventLogEntry).

If only the List parameter is specified, the output is a collection of EventLog objects (System.Diagnostics.EventLog).

If both the List and AsString parameters are specified, the output is a collection of Strings (System.String).

## NOTES
* The Get-EventLog and Get-WinEvent cmdlets are not supported in Windows Preinstallation Environment (Windows PE).

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-WinEvent](../Microsoft.PowerShell.Diagnostics/Get-WinEvent.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)

