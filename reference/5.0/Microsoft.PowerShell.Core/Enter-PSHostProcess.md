---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=403736
external help file:  System.Management.Automation.dll-Help.xml
title:  Enter-PSHostProcess
---

# Enter-PSHostProcess

## SYNOPSIS
Connects to and enters into an interactive session with a local process.

## SYNTAX

### ProcessIdParameterSet (Default)
```
Enter-PSHostProcess [-Id] <Int32> [[-AppDomainName] <String>] [<CommonParameters>]
```

### ProcessParameterSet
```
Enter-PSHostProcess [-Process] <Process> [[-AppDomainName] <String>] [<CommonParameters>]
```

### ProcessNameParameterSet
```
Enter-PSHostProcess [-Name] <String> [[-AppDomainName] <String>] [<CommonParameters>]
```

### PSHostProcessInfoParameterSet
```
Enter-PSHostProcess [-HostProcessInfo] <PSHostProcessInfo> [[-AppDomainName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Enter-PSHostProcess** cmdlet connects to and enters into an interactive session with a local process.

Instead of creating a new process to host Windows PowerShell and run a remote session, the remote, interactive session is run in an existing process that is already running Windows PowerShell.
When you are interacting with a remote session on a specified process, you can enumerate running runspaces, and then select a runspace to debug by running either Debug-Runspace or Enable-RunspaceDebug.

The process that you want to enter must be hosting Windows PowerShell (System.Management.Automation.dll).
You must be either a member of the Administrators group on the computer on which the process is found, or you must be the user who is running the script that started the process.

After you have selected a runspace to debug, a remote debug session is opened for the runspace if it is either currently running a command or is stopped in the debugger.
You can then debug the runspace script in the same way you would debug other remote session scripts.

Detach from a debugging session, and then the interactive session with the process, by running exit twice, or stop script execution by running the existing debugger quit command.

If you specify a process by using the *Name* parameter, and there is only one process found with the specified name, the process is entered.
If more than one process with the specified name is found, Windows PowerShell returns an error, and lists all processes found with the specified name.

To support attaching to processes on remote computers, the **Enter-PSHostProcess** cmdlet is enabled in a specified remote computer, so that you can attach to a local process within a remote Windows PowerShell session.

## EXAMPLES

### Example 1: Start debugging a runspace within the Windows PowerShell ISE process
```
In this example, you run **Enter-PSHostProcess** from within the Windows PowerShell console to enter the Windows PowerShell ISE process. In the resulting interactive session, you can find a runspace that you want to debug by running Get-Runspace, and then debug the runspace.
PS C:\> Enter-PSHostProcess -Name powershell_ise
[Process:1520]: PS C:\Test\Documents>

Next, get available runspaces within the process you have entered.
PS C:\> [Process:1520]: PS C:\>  Get-Runspace
Id    Name          InstanceId                               State           Availability
--    -------       -----------                              ------          -------------
1     Runspace1     2d91211d-9cce-42f0-ab0e-71ac258b32b5     Opened          Available
2     Runspace2     a3855043-cb16-424a-a616-685360c3763b     Opened          RemoteDebug
3     MyLocalRS     2236dbd8-2105-4dec-a15a-a27d0bfaacb5     Opened          LocalDebug
4     MyRunspace    771356e9-8c44-4b70-9de5-dd17cb41e48e     Opened          Busy
5     Runspace8     3e517382-a97a-49ba-9c3c-fd21f6664288     Broken          None

The runspace objects returned by **Get-Runspace** also have a NoteProperty called **ScriptStackTrace** of the running command stack, if available.Next, debug runspace ID 4, that is running another user's long-running script. From the list returned from **Get-Runspace**, note that the runspace state is **Opened**, and **Availability** is **Busy**, meaning that the runspace is still running the long-running script.
PS C:\> [Process:1520]: PS C:\>  (Get-Runspace -Id 4).ScriptStackTrace
Command                    Arguments                           Location
-------                    ---------                           --------
MyModuleWorkflowF1         {}                                  TestNoFile3.psm1: line 6
WFTest1                    {}                                  TestNoFile2.ps1: line 14
TestNoFile2.ps1            {}                                  TestNoFile2.ps1: line 22
<ScriptBlock>              {}                                  <No file>

Start an interactive debugging session with this runspace by running the Debug-Runspace cmdlet.
PS C:\> [Process: 1520]: PS C:\>  Debug-Runspace -Id 4
Hit Line breakpoint on 'C:\TestWFVar1.ps1:83'

At C:\TestWFVar1.ps1:83 char:1
+ $scriptVar = "Script Variable"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[Process: 1520]: [RSDBG: 4]: PS C:\> >

After you are finished debugging, allow the script to continue running without the debugger attached by running the **exit** debugger command. Alternatively, you can quit the debugger with the **q** or **Stop** commands.
PS C:\> [Process:346]: [RSDBG: 3]: PS C:\> > exit
[Process:1520]: PS C:\>

When you are finished working in the process, exit the process by running the Exit-PSHostProcess cmdlet. This returns you to the PS C:\> prompt.
PS C:\> [Process:1520]: PS C:\>  Exit-PSHostProcess
PS C:\>
```

## PARAMETERS

### -AppDomainName


```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostProcessInfo


```yaml
Type: PSHostProcessInfo
Parameter Sets: PSHostProcessInfoParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Specifies a process by the process ID.
To get a process ID, run the Get-Process cmdlet.

```yaml
Type: Int32
Parameter Sets: ProcessIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies a process by the process name.
To get a process name, run the Get-Process cmdlet.
You can also get process names from the Properties dialog box of a process in Task Manager.

```yaml
Type: String
Parameter Sets: ProcessNameParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Process
Specifies a process by the process object.
The simplest way to use this parameter is to save the results of a **Get-Process** command that returns process that you want to enter in a variable, and then specify the variable as the value of this parameter.

```yaml
Type: Process
Parameter Sets: ProcessParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Diagnostics.Process

## OUTPUTS

## NOTES
* **Enter-PSHostProcess** cannot enter the process of the Windows PowerShell session in which you are running the command. You can, however, enter the process of another Windows PowerShell session, or a Windows PowerShell ISE session that is running at the same time as the session in which you are running **Enter-PSHostProcess**.

  **Enter-PSHostProcess** can enter only those processes that are hosting Windows PowerShell.
That is, they have loaded the Windows PowerShell engine.

  To exit a process from within the process, type exit, and then press Enter.

## RELATED LINKS

[Get-Process](../Microsoft.PowerShell.Management/Get-Process.md)

[Exit-PSHostProcess](Exit-PSHostProcess.md)

[Debug-Runspace](../Microsoft.PowerShell.Utility/Debug-Runspace.md)

[Enable-RunspaceDebug](../Microsoft.PowerShell.Utility/Enable-RunspaceDebug.md)

[about_Debuggers](About/about_Debuggers.md)

