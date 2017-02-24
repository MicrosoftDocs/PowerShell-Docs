---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Clear EventLog
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=135198
external help file:   Microsoft.PowerShell.Commands.Management.dll-Help.xml
---


# Clear-EventLog
## SYNOPSIS
Deletes all entries from specified event logs on the local or remote computers.
## SYNTAX

```
Clear-EventLog [-LogName] <String[]> [[-ComputerName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Clear-EventLog cmdlet deletes all of the entries from the specified event logs on the local computer or on remote computers.
To use Clear-EventLog, you must be a member of the Administrators group on the affected computer.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.
## EXAMPLES

### Example 1
```
PS C:\> clear-eventlog "Windows PowerShell"
```

This command deletes the entries from the "Windows PowerShell" event log on the local computer.
### Example 2
```
PS C:\> clear-eventlog -logname ODiag, OSession -computername localhost, Server02
```

This command deletes all of the entries in the Microsoft Office Diagnostics (ODiag) and Microsoft Office Sessions (OSession) logs on the local computer and the Server02 remote computer.
### Example 3
```
PS C:\> clear-eventlog -log application, system -confirm
```

This command prompts you for confirmation before deleting the entries in the specified event logs.
### Example 4
```
PS C:\> function clear-all-event-logs ($computerName="localhost")
{
   $logs = get-eventlog -computername $computername -list | foreach {$_.Log}
   $logs | foreach {clear-eventlog -comp $computername -log $_ }
   get-eventlog -computername $computername -list
}

PS C:\> clear-all-event-logs -comp Server01

Max(K) Retain OverflowAction        Entries Log
------ ------ --------------        ------- ---
15,168      0 OverwriteAsNeeded           0 Application
15,168      0 OverwriteAsNeeded           0 DFS Replication
512      7 OverwriteOlder              0 DxStudio
20,480      0 OverwriteAsNeeded           0 Hardware Events
512      7 OverwriteOlder              0 Internet Explorer
20,480      0 OverwriteAsNeeded           0 Key Management Service
16,384      0 OverwriteAsNeeded           0 Microsoft Office Diagnostics
16,384      0 OverwriteAsNeeded           0 Microsoft Office Sessions
30,016      0 OverwriteAsNeeded           1 Security
15,168      0 OverwriteAsNeeded           2 System
15,360      0 OverwriteAsNeeded           0 Windows PowerShell
```

This function clears all event logs on the specified computers and then displays the resulting event log list.

Notice that a few entries were added to the System and Security logs after the logs were cleared but before they were displayed.
## PARAMETERS

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
Aliases: Cn

Required: False
Position: 2
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LogName
Specifies the event logs.
Enter the log name (the value of the Log property; not the LogDisplayName) of one or more event logs, separated by commas. 
Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: LN

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe objects to Clear-EventLog.
## OUTPUTS

### None
This cmdlet does not generate any output.
## NOTES
* To use Clear-EventLog on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.

*
## RELATED LINKS

[Get-EventLog](Get-EventLog.md)

[Get-WinEvent](../Microsoft.PowerShell.Diagnostics/Get-WinEvent.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)

