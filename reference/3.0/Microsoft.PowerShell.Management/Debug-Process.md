---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=135206
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Debug-Process
---

# Debug-Process
## SYNOPSIS
Debugs one or more processes running on the local computer.
## SYNTAX

### Name (Default)
```
Debug-Process [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Id
```
Debug-Process [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject
```
Debug-Process -InputObject <Process[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Debug-Process cmdlet attaches a debugger to one or more running processes on a local computer.
You can specify the processes by their process name or process ID (PID), or you can pipe process objects to Debug-Process.

Debug-Process attaches the debugger that is currently registered for the process.
Before using this cmdlet, verify that a debugger is downloaded and correctly configured.
## EXAMPLES

### Example 1
```
PS C:\> debug-process -name powershell
```

This command attaches a debugger to the PowerShell process on the computer.
### Example 2
```
PS C:\> debug-process -name sql*
```

This command attaches a debugger to all processes that have names that begin with "sql".
### Example 3
```
PS C:\> debug-process winlogon, explorer, outlook
```

This command attaches a debugger to the Winlogon, Explorer, and Outlook processes.
### Example 4
```
PS C:\> debug-process -id 1132, 2028
```

This command attaches a debugger to the processes that have process IDs 1132 and 2028.
### Example 5
```
PS C:\> get-process powershell | debug-process
```

This command attaches a debugger to the PowerShell processes on the computer.
It uses the Get-Process cmdlet to get the PowerShell processes on the computer, and it uses a pipeline operator (|) to send the processes to the Debug-Process cmdlet.

To specify a particular PowerShell process, use the ID parameter of Get-Process.
### Example 6
```
PS C:\> $pid | debug-process
```

This command attaches a debugger to the current PowerShell processes on the computer.

It uses the $pid automatic variable, which contains the process ID of the current PowerShell process.
Then, it uses a pipeline operator (|) to send the process ID to the Debug-Process cmdlet.

For more information about the $pid automatic variable, see about_Automatic_Variables.
### Example 7
```
PS C:\> get-process -computername Server01, Server02 -name MyApp | debug-process
```

This command attaches a debugger to the MyApp processes on the Server01 and Server02 computers.

It uses the Get-Process cmdlet to get the MyApp processes on the Server01 and Server02 computers.
It uses a pipeline operator to send the processes to the Debug-Process cmdlet, which attaches the debuggers.
### Example 8
```
PS C:\> $p = get-process powershell
PS C:\> debug-process -inputobject $p
```

This command attaches a debugger to the PowerShell processes on the local computer.

The first command uses the Get-Process cmdlet to get the PowerShell processes on the computer.
It saves the resulting process object in the $p variable.

The second command uses the InputObject parameter of Debug-Process to submit the process object in the $p variable to Debug-Process.
## PARAMETERS

### -Id
Specifies the process IDs of the processes to be debugged.
The parameter name ("-Id") is optional.

To find the process ID of a process, type "get-process".

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases: PID, ProcessId

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject
Specifies the process objects that represent processes to be debugged.
Enter a variable that contains the process objects or a command that gets the process objects, such as a Get-Process command.
You can also pipe process objects to Debug-Process.

```yaml
Type: Process[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the names of the processes to be debugged.
If there is more than one process with the same name, Debug-Process attaches a debugger to all processes with that name.
The parameter name ("Name") is optional.

```yaml
Type: String[]
Parameter Sets: Name
Aliases: ProcessName

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

### System.Int32, System.Diagnostics.Process, System.String
You can pipe a process ID (Int32), a process object (System.Diagnostics.Process), or a process name (String) to Debug-Process.
## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* This cmdlet uses the AttachDebugger method of the Windows Management Instrumentation (WMI) Win32_Process class. For more information about this method, see [AttachDebugger method](http://go.microsoft.com/fwlink/?LinkId=143640) in the MSDN library.

## RELATED LINKS

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Process](Start-Process.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)
