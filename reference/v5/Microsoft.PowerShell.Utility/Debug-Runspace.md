---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=403731
schema: 2.0.0
---

# Debug-Runspace
## SYNOPSIS
Starts an interactive debugging session with a runspace.

## SYNTAX

### RunspaceParameterSet (Default)
```
Debug-Runspace [-Runspace] <Runspace> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

### NameParameterSet
```
Debug-Runspace [-Name] <String> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

### IdParameterSet
```
Debug-Runspace [-Id] <Int32> [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf]
 [-Confirm]
```

### InstanceIdParameterSet
```
Debug-Runspace [-InstanceId] <Guid> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

## DESCRIPTION
Debug-Runspace starts an interactive debugging session with a local or remote active runspace.
You can find a runspace that you want to debug by first running Get-Process to find processes associated with Windows PowerShell, then Enter-PSHostProcess with the process ID specified in the Id parameter to attach to the process, and then Get-Runspace to list runspaces within the Windows PowerShell host process.

After you have selected a runspace to debug, if the runspace is currently running a command or script, or if the script has stopped at a breakpoint, Windows PowerShell opens a remote debugger session for the runspace.
You can debug the runspace script in the same way remote session scripts are debugged.

You can only attach to a Windows PowerShell host process if you are an administrator on the computer that is running the process, or you are running the script that you want to debug.
Also, you cannot enter the host process that is running the current Windows PowerShell session; you can only enter a host process that is running a different Windows PowerShell session.
For example, if you are working in a PowerShell.exe session, you can't enter the host process for that session, but you can enter the host process of a running Windows PowerShell ISE session.

## EXAMPLES

### Example 1: Debug a remote runspace
```
PS C:\>Get-Process -ComputerName WS10TestServer -Name *powershell*

Handles      WS(K)   VM(M)      CPU(s)    Id  ProcessName
-------      -----   -----      ------    --  -----------
    377      69912     63     2.09      2420  powershell
    399     123396    829     4.48      1152  powershell_ise

PS C:\> Enter-PSSession -ComputerName WS10TestServer

[WS10TestServer]:PS C:\> Enter-PSHostProcess -Id 1152

[WS10TestServer:][Process:1152]: PS C:\Users\Test\Documents> Get-Runspace

Id Name            ComputerName    Type          State         Availability
-- ----            ------------    ----          -----         ------------
 1 Runspace1       WS10TestServer  Remote        Opened        Available
 2 RemoteHost      WS10TestServer  Remote        Opened        Busy

[WS10TestServer][Process:1152]: PS C:\Users\Test\Documents> Debug-Runspace -Id 2

Hit Line breakpoint on 'C:\TestWFVar1.ps1:83'

At C:\TestWFVar1.ps1:83 char:1
+ $scriptVar = "Script Variable"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[Process:1152]: [RSDBG: 2]: PS C:\>>
```

In this example, you debug a runspace that is open on a remote computer, WS10TestServer.
In the first line of the command, you run Get-Process on the remote computer, and filter for Windows PowerShell host processes.
In this example, you want to debug process ID 1152, the Windows PowerShell ISE host process.

In the second command, you run Enter-PSSession to open a remote session on WS10TestServer.
In the third command, you attach to the Windows PowerShell ISE host process running on the remote server by running Enter-PSHostProcess, and specifying the ID of the host process that you obtained in the first command, 1152.

In the fourth command, you list available runspaces for process ID 1152 by running Get-Runspace.
You note the ID number of the Busy runspace; it is running a script that you want to debug.

In the last command, you start debugging an opened runspace that is running a script, TestWFVar1.ps1, by running Debug-Runspace, and identifying the runspace by its ID, 2, by adding the Id parameter.
Because there's a breakpoint in the script, the debugger opens.

## PARAMETERS

### -Id
Specifies the ID number of a runspace.
You can run Get-Runspace to show runspace IDs.

```yaml
Type: Int32
Parameter Sets: IdParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
Specifies a runspace by its instance ID, a GUID that you can show by running Get-Runspace.

```yaml
Type: Guid
Parameter Sets: InstanceIdParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a runspace by its name.
You can run Get-Runspace to show the names of runspaces.

```yaml
Type: String
Parameter Sets: NameParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Runspace
Specifies a runspace object.
The simplest way to provide a value for this parameter is to specify a variable that contains the results of a filtered Get-Runspace command.

```yaml
Type: Runspace
Parameter Sets: RunspaceParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

## INPUTS

### System.Management.Automation.Runspaces.Runspace
You can pipe the results of a Get-Runspace command to Debug-Runspace.

## OUTPUTS

## NOTES
Debug-Runspace works on runspaces that are in the Opened state.
If a runspace state changes from Opened to another state, that runspace is automatically removed from the running list.
A runspace is added to the running list only if it meets the following criteria.

-- If it is coming from Invoke-Command; that is, it has an Invoke-Command GUID Id.
-- If it is coming from Debug-Runspace; that is, it has a Debug-Runspace GUID Id.
-- If it is coming from a Windows PowerShell workflow, and its workflow job ID is the same as the current active debugger workflow job ID.

## RELATED LINKS

[about_Debuggers]()

[Get-Process]()

[Enter-PSHostProcess]()

[Get-Runspace]()

[Debug-Job]()

