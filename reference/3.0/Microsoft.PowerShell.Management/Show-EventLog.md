---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Show EventLog
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=135257
external help file:   Microsoft.PowerShell.Commands.Management.dll-Help.xml
---


# Show-EventLog
## SYNOPSIS
Displays the event logs of the local or a remote computer in Event Viewer.
## SYNTAX

```
Show-EventLog [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Show-EventLog cmdlet opens Event Viewer on the local computer and displays in it all of the classic event logs on the local computer or a remote computer.

To open Event Viewer on Windows Vista and later versions of Windows, the current user must be a member of the Administrators group on the local computer.

The cmdlets that contain the EventLog noun (the EventLog cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of Windows, use Get-WinEvent.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> show-eventlog
```

This command opens Event Viewer and displays in it the classic event logs on the local computer.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> show-eventlog -computername Server01
```

This command opens Event Viewer and displays in it the classic event logs on the Server01 computer.
## PARAMETERS

### -ComputerName
Specifies a remote computer.
Show-EventLog displays the event logs from the specified computer in Event Viewer on the local computer.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of a remote computer.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-EventLog even if your computer is not configured to run remote commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CN

Required: False
Position: 1
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe input to this cmdlet.
## OUTPUTS

### None
This cmdlet does not generate any output.
## NOTES
* The Windows PowerShell command prompt returns as soon as Event Viewer opens. You can work in the current session while Event Viewer is open.

  Because this cmdlet requires a user interface, it does not work on Server Core installations of Windows Server.

*
## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Get-WinEvent](../Microsoft.PowerShell.Diagnostics/Get-WinEvent.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Write-EventLog](Write-EventLog.md)

