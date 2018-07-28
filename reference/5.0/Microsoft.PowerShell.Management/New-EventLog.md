---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821603
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  New-EventLog
---

# New-EventLog

## SYNOPSIS
Creates a new event log and a new event source on a local or remote computer.

## SYNTAX

```
New-EventLog [-CategoryResourceFile <String>] [[-ComputerName] <String[]>] [-LogName] <String>
 [-MessageResourceFile <String>] [-ParameterResourceFile <String>] [-Source] <String[]> [<CommonParameters>]
```

## DESCRIPTION
The **New-EventLog** cmdlet creates a new classic event log on a local or remote computer.
It can also register an event source that writes to the new log or to an existing log.

The cmdlets that contain the **EventLog** noun (the **EventLog** cmdlets) work only on classic event logs.
To get events from logs that use the Windows Event Log technology in Windows Vista and later versions of the Windows operating system, use the Get-WinEvent cmdlet.

## EXAMPLES

### Example 1: Create an event log and register its source
```
PS C:\> New-EventLog -Source "TestApp" -LogName "TestLog" -MessageResourceFile "C:\Test\TestApp.dll"
```

This command creates the TestLog event log on the local computer and registers a new source for it.

### Example 2: Add an event source to the Application log
```
PS C:\> $file = "C:\Program Files\TestApps\NewTestApp.dll"
PS C:\> New-EventLog -ComputerName "Server01" -Source "NewTestApp" -LogName "Application" -MessageResourceFile $file -CategoryResourceFile $file
```

This command adds a new event source, NewTestApp, to the Application log on the Server01 remote computer.

The command requires that the NewTestApp.dll file is located on the Server01 computer.

## PARAMETERS

### -CategoryResourceFile
Specifies the path of the file that contains category strings for the source events.
This file is also known as the Category Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CRF

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies the computers on which this cmdlet creates new event logs.
The default is the local computer.

Type the NetBIOS name, an IP address or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or localhost.

This parameter does not rely on Windows PowerShell remoting.
You can use the *ComputerName* parameter of **New-EventLog** even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Specifies the name of the event log.

If the log does not exist, **New-EventLog** creates the log and uses this value for the **Log** and **LogDisplayName** properties of the new event log.
If the log exists, **New-EventLog** registers a new source for the event log.

```yaml
Type: String
Parameter Sets: (All)
Aliases: LN

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MessageResourceFile
Specifies the path of the file that contains message formatting strings for the source events.
This file is also known as the Event Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: MRF

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterResourceFile
Specifies the path of the file that contains strings used for parameter substitutions in event descriptions.
This file is also known as the Parameter Message File.

The file must be present on the computer on which the event log is being created.
This parameter does not create or move files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PRF

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies the names of the event log sources, such as application programs that write to the event log.
This parameter is required.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: SRC

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Diagnostics.EventLogEntry

## NOTES
* To use **New-EventLog** on Windows Vista and later versions of the Windows operating system, open Windows PowerShell by using Run as administrator option.

  To create an event source in Windows Vista, Windows XP Professional, or Windows Server 2003, you must be a member of the Administrators group on the computer.

  When you create a new event log and a new event source, the system registers the new source for the new log, but the log is not created until the first entry is written to it.

  The operating system stores event logs as files.
When you create a new event log, the associated file is stored in the %SystemRoot%\System32\Config directory on the specified computer.
The file name is the first eight characters of the Log property that has an .evt file name extension.

*

## RELATED LINKS

[Clear-EventLog](Clear-EventLog.md)

[Get-EventLog](Get-EventLog.md)

[Limit-EventLog](Limit-EventLog.md)

[New-EventLog](New-EventLog.md)

[Remove-EventLog](Remove-EventLog.md)

[Show-EventLog](Show-EventLog.md)

[Write-EventLog](Write-EventLog.md)