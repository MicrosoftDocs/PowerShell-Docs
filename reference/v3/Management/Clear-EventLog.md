---
external help file: PSITPro3_Management.xml
schema: 2.0.0
---

# Clear-EventLog
## SYNOPSIS
Deletes all entries from specified event logs on the local or remote computers.

## SYNTAX

```
Clear-EventLog [-LogName] <String[]> [[-ComputerName] <String[]>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Clear-EventLog cmdlet deletes all of the entries from the specified event logs on the local computer or on remote computers.
To use Clear-EventLog, you must be a member of the Administrators group on the affected computer.

The cmdlets that contain the EventLog noun \(the EventLog cmdlets\) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>clear-eventlog "Windows PowerShell"
```

This command deletes the entries from the "Windows PowerShell" event log on the local computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>clear-eventlog -logname ODiag, OSession -computername localhost, Server02
```

This command deletes all of the entries in the Microsoft Office Diagnostics \(ODiag\) and Microsoft Office Sessions \(OSession\) logs on the local computer and the Server02 remote computer.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>clear-eventlog -log application, system -confirm
```

This command prompts you for confirmation before deleting the entries in the specified event logs.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>function clear-all-event-logs ($computerName="localhost")
{
   $logs = get-eventlog -computername $computername -list | foreach {$_.Log}
   $logs | foreach {clear-eventlog -comp $computername -log $_ }
   get-eventlog -computername $computername -list
}

PS C:\>clear-all-event-logs -comp Server01

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

Type the NetBIOS name, an Internet Protocol \(IP\) address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot \(.\), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: Local computer
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: False
```

### -LogName
Specifies the event logs.
Enter the log name \(the value of the Log property; not the LogDisplayName\) of one or more event logs, separated by commas. 
Wildcard characters are not permitted.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByPropertyName)
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
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe objects to Clear-EventLog.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
To use Clear-EventLog on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=135198)

[Get-EventLog](b4985b11-82bf-487d-928d-becd96fc0419)

[Get-WinEvent](00000000-0000-0000-0000-000000000000)

[Limit-EventLog](c3c3797c-e5d2-494b-b9c8-170999440385)

[New-EventLog](21e8f496-8f5b-4b79-9393-f16c86287e67)

[Remove-EventLog](487325e7-2a78-49fe-9126-c56222a8fa58)

[Show-EventLog](a3b0f5ad-0438-42c7-915b-d1b4793a431c)

[Write-EventLog](c93c4cd3-028f-4343-bfe6-b70f8f249290)


