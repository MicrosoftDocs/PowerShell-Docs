---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Limit EventLog
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=290509
schema:  2.0.0
---


# Limit-EventLog
## SYNOPSIS
Sets the event log properties that limit the size of the event log and the age of its entries.

## SYNTAX

```
Limit-EventLog [-LogName] <String[]> [-ComputerName <String[]>] [-MaximumSize <Int64>]
 [-OverflowAction <OverflowAction>] [-RetentionDays <Int32>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Limit-EventLog cmdlet sets the maximum size of a classic event log, how long each event must be retained, and what happens when the log reaches its maximum size.
You can use it to limit the event logs on local or remote computers.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>limit-eventLog -logname "Windows PowerShell" -MaximumSize 20KB
```

This command increases the maximum size of the Windows PowerShell event log on the local computer to 20480 bytes (20 KB).

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>limit-eventlog -logname Security -comp Server01, Server02 -retentionDays 7
```

This command ensures that events in the Security log on the Server01 and Server02 computers are retained for at least 7 days.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$logs = get-eventlog -list | foreach {$_.log}
PS C:\>limit-eventlog -overflowaction OverwriteOlder -logname $logs
PS C:\>get-eventlog -list

Max(K) Retain OverflowAction     Entries  Log
------ ------ --------------     -------  ---
15,168      0 OverwriteOlder       3,412  Application
512      0 OverwriteOlder           0  DFS Replication
512      0 OverwriteOlder          17  DxStudio
10,240      7 OverwriteOlder           0  HardwareEvents
512      0 OverwriteOlder           0  Internet Explorer
512      0 OverwriteOlder           0  Key Management Service
16,384      0 OverwriteOlder           4  ODiag
16,384      0 OverwriteOlder         389  OSession Security
15,168      0 OverwriteOlder      19,360  System
15,360      0 OverwriteOlder      15,828  Windows PowerShell
```

These commands change the overflow action of all event logs on the local computer to "OverwriteOlder".

The first command gets the log names of all of the logs on the local computer.
The second command sets the overflow action.
The third command displays the results.

## PARAMETERS

### -ComputerName
Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Limit-EventLog even if your computer is not configured to run remote commands.

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

### -LogName
Specifies the event logs.
Enter the log name (the value of the Log property; not the LogDisplayName) of one or more event logs , separated by commas. 
Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -MaximumSize
Specifies the maximum size of the event logs in bytes.
Enter a value between 64 kilobytes (KB) and 4 gigabytes (GB).
The value must be divisible by 64 KB (65536).

This parameter specifies the value of the MaximumKilobytes property of the System.Diagnostics.EventLog object that represents a classic event log.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OverflowAction
Specifies what happens when the event log reaches its maximum size.

Valid values are:

- DoNotOverwrite:  Existing entries are retained and new entries are discarded.
- OverwriteAsNeeded:  Each new entry overwrites the oldest entry.
- OverwriteOlder:  New events overwrite events older than the value specified by the MinimumRetentionDays property. If there are no events older than specified by the MinimumRetentionDays property value, new events are discarded.

This parameter specifies the value of the OverflowAction property of the System.Diagnostics.EventLog object that represents a classic event log.

```yaml
Type: OverflowAction
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetentionDays
Specifies the minimum number of days that an event must remain in the event log.

This parameter specifies the value of the MinimumRetentionDays property of the System.Diagnostics.EventLog object that represents a classic event log.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
None

## OUTPUTS

### None
None

## NOTES
* To use Limit-EventLog on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

  Limit-EventLog changes the properties of the System.Diagnostics.EventLog object that represents a classic event log.
To see the current settings of the event log properties, type "get-eventlog -list".

*

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)

