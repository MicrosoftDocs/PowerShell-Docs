---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Wait Process
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=135277
schema:  2.0.0
---


# Wait-Process
## SYNOPSIS
Waits for the processes to be stopped before accepting more input.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Wait-Process [-Name] <String[]> [[-Timeout] <Int32>]
```

### UNNAMED_PARAMETER_SET_2
```
Wait-Process [-Id] <Int32[]> [[-Timeout] <Int32>]
```

### UNNAMED_PARAMETER_SET_3
```
Wait-Process [[-Timeout] <Int32>] -InputObject <Process[]>
```

## DESCRIPTION
The Wait-Process cmdlet waits for one or more running processes to be stopped before accepting input. 
In the Windows PowerShell console, this cmdlet suppresses the command prompt until the processes are stopped.
You can specify a process by process name or process ID (PID), or pipe a process object to Wait-Process.

Wait-Process works only on processes running on the local computer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$nid = (get-process notepad).id
PS C:\>stop-process -id $nid
PS C:\>wait-process -id $nid
```

These commands stop the Notepad process and then wait for the process to be stopped before proceeding with the next command.

The first command uses the Get-Process cmdlet to get the ID of the Notepad process.
It saves it in the $nid variable.

The second command uses the Stop-Process cmdlet to stop the process with the ID saved in $nid.

The third command uses the Wait-Process cmdlet to wait until the Notepad process is stopped.
It uses the ID parameter of Wait-Process to identify the process.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$p = get-process notepad
PS C:\>wait-process -id $p.id
PS C:\>wait-process -name notepad
PS C:\>wait-process -inputobject $p
```

These commands show three different methods of specifying a process to the Wait-Process cmdlet.
The first command gets the Notepad process and saves it in the $p variable.

The second command uses the ID parameter, the third command uses the Name parameter, and the fourth command uses the InputObject parameter.

These commands have the same results and can be used interchangeably.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>wait-process -name outlook, winword -timeout 30
```

This command waits 30 seconds for the Outlook and Winword processes to stop.
If both processes are not stopped, the cmdlet displays a non-terminating error and the command prompt.

## PARAMETERS

### -Id
Specifies the process IDs of the processes.
To specify multiple IDs, use commas to separate the IDs.
To find the PID of a process, type "get-process".
The parameter name ("Id") is optional.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject
Specifies the processes by submitting process objects.
Enter a variable that contains the process objects, or type a command or expression that gets the process objects, such as a Get-Process command.

```yaml
Type: Process[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the process names of the processes.
To specify multiple names, use commas to separate the names.
Wildcards are not supported.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout
Determines the maximum time, in seconds, that Wait-Process waits for the specified processes to stop.
When this interval expires, the command displays a non-terminating error that lists the processes that are still running, and ends the wait.
By default, there is no timeout.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: No timeout
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Diagnostics.Process
You can pipe a process object to Wait-Process.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* This cmdlet uses the WaitForExit method of the System.Diagnostics.Process class. For more information about this method, see the Microsoft .NET Framework SDK.

*

## RELATED LINKS

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Process](Start-Process.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)

