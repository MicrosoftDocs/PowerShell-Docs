---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Remove EventLog
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=135248
schema:  2.0.0
---


# Remove-EventLog
## SYNOPSIS
Deletes an event log or unregisters an event source.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-EventLog [-LogName] <String[]> [[-ComputerName] <String[]>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-EventLog [[-ComputerName] <String[]>] [-Source <String[]>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-EventLog cmdlet deletes an event log file from a local or remote computer and unregisters all of its event sources for the log.
You can also use this cmdlet to unregister event sources without deleting any event logs.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

CAUTION:  This cmdlet can delete operating system event logs, which might result in application failures and unexpected system behavior.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>remove-eventlog -logname MyLog
```

This command deletes the MyLog event log from the local computer and unregisters its event sources.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>remove-eventlog -logname MyLog, TestLog -computername Server01, Server02, localhost
```

This command deletes the MyLog and TestLog event logs from the local computer ("localhost") and the Server01 and Server02 remote computers.
The command also unregisters the event sources for these logs.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>remove-eventlog -source MyApp
```

This command deletes the MyApp event source from the logs on the local computer.
When the command completes, the MyApp program cannot write to any event logs.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-eventlog -list

Max(K) Retain OverflowAction        Entries Log
------ ------ --------------        ------- ---
15,168      0 OverwriteAsNeeded      22,923 Application
15,168      0 OverwriteAsNeeded          53 DFS Replication
15,168      7 OverwriteOlder              0 Hardware Events
512      7 OverwriteOlder              0 Internet Explorer
20,480      0 OverwriteAsNeeded           0 Key Management Service
30,016      0 OverwriteAsNeeded      50,060 Security
15,168      0 OverwriteAsNeeded      27,592 System
15,360      0 OverwriteAsNeeded      18,355 Windows PowerShell
15,168      7 OverwriteAsNeeded          12 ZapLog
PS C:\>remove-eventlog -logname ZapLog
PS C:\>get-eventlog -list
Max(K) Retain OverflowAction        Entries Log
------ ------ --------------        ------- ---
15,168      0 OverwriteAsNeeded      22,923 Application
15,168      0 OverwriteAsNeeded          53 DFS Replication
15,168      7 OverwriteOlder              0 Hardware Events
512      7 OverwriteOlder              0 Internet Explorer
20,480      0 OverwriteAsNeeded           0 Key Management Service
30,016      0 OverwriteAsNeeded      50,060 Security
15,168      0 OverwriteAsNeeded      27,592 System
15,360      0 OverwriteAsNeeded      18,355 Windows PowerShell
```

These commands show how to list the event logs on a computer and verify that a Remove-EventLog command was successful.

The first command lists the event logs on the local computer.

The second command deletes the ZapLog event log.

The third command lists the event logs again.
The ZapLog event log no longer appears in the list.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-wmiobject win32_nteventlogfile -filter "logfilename='TestLog'" | foreach {$_.sources}
MyApp
TestApp
PS C:\>remove-eventlog -source MyApp
PS C:\>get-wmiobject win32_nteventlogfile -filter "logfilename='TestLog'"} | foreach {$_.sources}
TestApp
```

These commands use the Get-WmiObject cmdlet to list the event sources on the local computer.
You can these commands to verify the success of a command or to delete an event source.

The first command gets the event sources of the TestLog event log on the local computer.
MyApp is one of the sources.

The second command uses the Source parameter of Remove-EventLog to delete the MyApp event source.

The third command is identical to the first.
It shows that the MyApp event source was deleted.

## PARAMETERS

### -ComputerName
Specifies a remote computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Remove-EventLog even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Unregisters the specified event sources.
Enter the source names (not the executable name), separated by commas.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
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
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* To use Remove-EventLog on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.

  If you remove an event log and then re-create the log, you will not be able to register the same event sources.
Applications that used the events sources to write entries to the original log will not be able to write to the new log.

  When you unregister an event source for a particular log, the event source might be prevented from writing entries in other event logs.

*

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Get-WinEvent](../Microsoft.PowerShell.Diagnostics/Get-WinEvent.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)

