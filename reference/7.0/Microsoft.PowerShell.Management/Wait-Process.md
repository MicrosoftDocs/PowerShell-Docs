---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/11/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/wait-process?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Wait-Process
---
# Wait-Process

## SYNOPSIS
Waits for the processes to be stopped before accepting more input.

## SYNTAX

### Name (Default)

```
Wait-Process [-Name] <String[]> [[-Timeout] <Int32>] [<CommonParameters>]
```

### Id

```
Wait-Process [-Id] <Int32[]> [[-Timeout] <Int32>] [<CommonParameters>]
```

### InputObject

```
Wait-Process [[-Timeout] <Int32>] -InputObject <Process[]> [<CommonParameters>]
```

## DESCRIPTION

The `Wait-Process` cmdlet waits for one or more running processes to be stopped before accepting
input. In the PowerShell console, this cmdlet suppresses the command prompt until the processes are
stopped. You can specify a process by process name or process ID (PID), or pipe a process object to
`Wait-Process`.

`Wait-Process` works only on processes running on the local computer.

## EXAMPLES

### Example 1: Stop a process and wait

This example stops the **Notepad** process and then waits for the process to be stopped before it
continues with the next command.

```powershell
$nid = (Get-Process notepad).id
Stop-Process -Id $nid
Wait-Process -Id $nid
```

The `Get-Process` cmdlet gets the process ID of the **Notepad** process and stores it in the `$nid`
variable. `Stop-Process` stops the process with the ID stored in `$nid`. `Wait-Process` waits until
the **Notepad** process is stopped.

### Example 2: Specifying a process

This example shows three different methods of specifying a process to `Wait-Process`. The first
command gets the Notepad process and stores it in the `$p` variable. The second command uses the
**Id** parameter, the third command uses the **Name** parameter, and the fourth command uses the
**InputObject** parameter.

```powershell
$p = Get-Process notepad
Wait-Process -Id $p.id
Wait-Process -Name "notepad"
Wait-Process -InputObject $p
```

These commands have the same results and can be used interchangeably.

### Example 3: Wait for processes for a specified time

In this example, `Wait-Process` waits 30 seconds for the **Outlook** and **Winword** processes to
stop. If both processes are not stopped, the cmdlet displays a non-terminating error and the command
prompt.

```powershell
Wait-Process -Name outlook, winword -Timeout 30
```

## PARAMETERS

### -Id

Specifies the process IDs of the processes. To specify multiple IDs, use commas to separate the IDs.
To find the PID of a process, type `Get-Process`.

```yaml
Type: System.Int32[]
Parameter Sets: Id
Aliases: PID, ProcessId

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

Specifies the processes by submitting process objects. Enter a variable that contains the process
objects, or type a command or expression that gets the process objects, such as the `Get-Process`
cmdlet.

```yaml
Type: System.Diagnostics.Process[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the process names of the processes. To specify multiple names, use commas to separate the
names. Wildcard characters are not supported.

```yaml
Type: System.String[]
Parameter Sets: Name
Aliases: ProcessName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout

Specifies the maximum time, in seconds, that this cmdlet waits for the specified processes to stop.
When this interval expires, the command displays a non-terminating error that lists the processes
that are still running, and ends the wait. By default, there is no time-out.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: 1
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

### System.Diagnostics.Process

You can pipe a process object to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- The cmdlet is only supported on Windows platforms.

- This cmdlet uses the **WaitForExit** method of the **System.Diagnostics.Process** class.

- Unlike `Start-Process -Wait`, `Wait-Process` only waits for the processes identified.
  `Start-Process -Wait` waits for the process tree (the process and all its descendants) to exit
  before returning control.

## RELATED LINKS

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Process](Start-Process.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)
