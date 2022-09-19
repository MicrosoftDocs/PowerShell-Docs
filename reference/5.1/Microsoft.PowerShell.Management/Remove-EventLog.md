---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/remove-eventlog?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-EventLog
---

# Remove-EventLog

## SYNOPSIS
Deletes an event log or unregisters an event source.

## SYNTAX

### Default (Default)

```
Remove-EventLog [[-ComputerName] <String[]>] [-LogName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Source

```
Remove-EventLog [[-ComputerName] <String[]>] [-Source <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EventLog`cmdlet deletes an event log file from a local or remote computer and
unregisters all its event sources for the log. You can also use this cmdlet to unregister event
sources without deleting any event logs.

The cmdlets that contain the **EventLog** noun, the **EventLog** cmdlets, work only on classic event
logs. To get events from logs that use the Windows Event Log technology in Windows Vista and later
versions of the Windows operating system, use Get-WinEvent.

> [!WARNING]
> This cmdlet can delete operating system event logs, which might cause application failures and
> unexpected system behavior.

## EXAMPLES

### Example 1: Remove an event log from the local computer

```powershell
Remove-EventLog -LogName "MyLog"
```

This command deletes the MyLog event log from the local computer and unregisters its event sources.

### Example 2: Remove an event log from several computers

```powershell
Remove-EventLog -LogName "MyLog", "TestLog" -ComputerName "Server01", "Server02", "localhost"
```

This command deletes the MyLog and TestLog event logs from the local computer and the Server01 and Server02 remote computers.
The command also unregisters the event sources for these logs.

### Example 3: Delete an event source

```powershell
Remove-EventLog -Source "MyApp"
```

This command deletes the MyApp event source from the logs on the local computer. When the command
finishes, the MyApp program cannot write to any event logs.

### Example 4: Remove an event log and confirm the action

These commands show how to list the event logs on a computer and verify that a
`Remove-EventLog`command was successful.

```powershell
Get-EventLog -List
```

```Output
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
```

```powershell
Remove-EventLog -LogName "ZapLog"
Get-EventLog -List
```

```Output
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

The first command lists the event logs on the local computer.

The second command deletes the ZapLog event log.

The third command lists the event logs again. The ZapLog event log no longer appears in the list.

### Example 5: Remove an event source and confirm the action

```powershell
Get-WmiObject win32_nteventlogfile -Filter "logfilename='TestLog'" | foreach {$_.sources}
```

```Output
MyApp
TestApp
```

```powershell
Remove-Eventlog -Source "MyApp"
Get-WmiObject win32_nteventlogfile -Filter "logfilename='TestLog'"} | foreach {$_.sources}
```

```Output
TestApp
```

These commands use the `Get-WmiObject` cmdlet to list the event sources on the local computer. You
can these commands to verify the success of a command or to delete an event source.

The first command gets the event sources of the TestLog event log on the local computer. MyApp is
one of the sources.

The second command uses the **Source** parameter of `Remove-EventLog`to delete the MyApp event
source.

The third command is identical to the first. It shows that the MyApp event source was deleted.

## PARAMETERS

### -ComputerName

Specifies a remote computer. The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer. To
specify the local computer, type the computer name, a dot (*.*), or localhost.

This parameter does not rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter of `Remove-EventLog`even if your computer is not configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: CN

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName

Specifies the event logs. Enter the log name of one or more event logs, separated by commas. The log
name is the value of the **Log** property, not the **LogDisplayName**, Wildcard characters are not
permitted. This parameter is required.

```yaml
Type: System.String[]
Parameter Sets: Default
Aliases: LN

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies the event sources that this cmdlet unregisters. Enter the source names, not the executable
name, separated by commas.

```yaml
Type: System.String[]
Parameter Sets: Source
Aliases: SRC

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

- To use `Remove-EventLog`on Windows Vista and later versions of the Windows operating system, start
  Windows PowerShell by using the Run as administrator option.

  If you remove an event log and then re-create the log, you will not be able to register the same
  event sources. Applications that used the events sources to write entries to the original log will
  not be able to write to the new log.

- When you unregister an event source for a particular log, the event source might be prevented from
  writing entries in other event logs.

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)
