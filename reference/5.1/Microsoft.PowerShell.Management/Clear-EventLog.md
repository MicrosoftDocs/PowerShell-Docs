---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 05/17/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/clear-eventlog?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Clear-EventLog
---
# Clear-EventLog

## SYNOPSIS
Clears all entries from specified event logs on the local or remote computers.

## SYNTAX

```
Clear-EventLog [-LogName] <String[]> [[-ComputerName] <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Clear-EventLog` cmdlet deletes all of the entries from the specified event logs on the local
computer or on remote computers. To use `Clear-EventLog`, you must be a member of the Administrators
group on the affected computer.

The cmdlets that contain the `EventLog` noun (the `EventLog` cmdlets) work only on classic event
logs. To get events from logs that use the Windows Event Log technology in Windows Vista and later
versions of Windows, use the `Get-WinEvent` cmdlet.

## EXAMPLES

### Example 1: Clear specific event log types from the local computer

```powershell
Clear-EventLog "Windows PowerShell"
```

This command clears the entries from the Windows PowerShell event log on the local computer.

### Example 2: Clear specific multiple log types from the local and remote computers

```powershell
Clear-EventLog -LogName ODiag, OSession -ComputerName localhost, Server02
```

This command clears all of the entries in the Microsoft Office Diagnostics (ODiag) and Microsoft
Office Sessions (OSession) logs on the local computer and the Server02 remote computer.

### Example 3: Clear all logs on the specified computers then display the event log list

```powershell
Clear-EventLog -LogName application, system -confirm
```

This command prompts you for confirmation before deleting the entries in the specified event logs.

### Example 4: Clear all logs on the specified computers then display the event log list

```powershell
function clear-all-event-logs ($computerName="localhost")
{
   $logs = Get-EventLog -ComputerName $computername -List | ForEach-Object {$_.Log}
   $logs | ForEach-Object {Clear-EventLog -ComputerName $computername -LogName $_ }
   Get-EventLog -ComputerName $computername -list
}

clear-all-event-logs -ComputerName Server01
```

```Output
Max(K) Retain OverflowAction        Entries Log
------ ------ --------------        ------- ---
15,168      0 OverwriteAsNeeded           0 Application
15,168      0 OverwriteAsNeeded           0 DFS Replication
512         7 OverwriteOlder              0 DxStudio
20,480      0 OverwriteAsNeeded           0 Hardware Events
512         7 OverwriteOlder              0 Internet Explorer
20,480      0 OverwriteAsNeeded           0 Key Management Service
16,384      0 OverwriteAsNeeded           0 Microsoft Office Diagnostics
16,384      0 OverwriteAsNeeded           0 Microsoft Office Sessions
30,016      0 OverwriteAsNeeded           1 Security
15,168      0 OverwriteAsNeeded           2 System
15,360      0 OverwriteAsNeeded           0 Windows PowerShell
```

This function clears all event logs on the specified computers and then displays the resulting event
log list.

Notice that a few entries were added to the System and Security logs after the logs were cleared but
before they were displayed.

## PARAMETERS

### -ComputerName

Specifies a remote computer. The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a
remote computer. To specify the local computer, type the computer name, a dot (`.`), or `localhost`.

This parameter does not rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter of `Get-EventLog` even if your computer is not configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: 1
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -LogName

Specifies the event logs. Enter the log name (the value of the **Log** property not the
**LogDisplayName**) of one or more event logs, separated by commas. Wildcard characters are not
permitted. This parameter is required.

> [!IMPORTANT]
> This parameter is supposed to accept values from the pipeline by property name. However, there is
> a bug that prevents this from working. You must pass a value using the parameter directly.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: LN

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to `Clear-EventLog`.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- To use `Clear-EventLog` on Windows Vista and later versions of Windows, start Windows PowerShell
  with the **Run as administrator** option.

## RELATED LINKS

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)
