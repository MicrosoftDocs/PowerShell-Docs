---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/show-eventlog?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Show-EventLog
---

# Show-EventLog

## SYNOPSIS
Displays the event logs of the local or a remote computer in Event Viewer.

## SYNTAX

```
Show-EventLog [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Show-EventLog` cmdlet opens Event Viewer on the local computer and displays in it all of the
classic event logs on the local computer or a remote computer.

The cmdlets that contain the **EventLog** noun work only on classic event logs. To get events from
logs that use the Windows Event Log technology, use the `Get-WinEvent` cmdlet.

## EXAMPLES

### Example 1: Display event logs for the local computer

```powershell
Show-EventLog
```

This command opens Event Viewer and displays in it the classic event logs on the local computer.

### Example 2: Display event logs for a remote computer

```powershell
Show-EventLog -ComputerName "Server01"
```

This command opens Event Viewer and displays in it the classic event logs on the Server01 computer.

## PARAMETERS

### -ComputerName

Specifies a remote computer. `Show-EventLog` displays the event logs from the specified computer in
Event Viewer on the local computer. The default is the local computer. When you use this parameter,
the command runs `eventvwr.exe` and passes the value of this parameter.

> [!IMPORTANT]
> Using this parameter with untrusted data is a security risk. Only use trusted data with this
> parameter. For more information, see
> [Validate All Inputs](https://top10proactive.owasp.org/archive/2024/the-top-10/c3-validate-input-and-handle-exceptions/).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: CN

Required: False
Position: 0
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

You can't pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet doesn't generate any output.

## NOTES

- The Windows PowerShell command prompt returns as soon as Event Viewer opens. You can work in the
  current session while Event Viewer is open.

  Because this cmdlet requires a user interface, it doesn't work on Server Core installations of
  Windows Server.

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Write-EventLog](Write-EventLog.md)
