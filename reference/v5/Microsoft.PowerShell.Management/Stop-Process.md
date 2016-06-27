---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293922
schema: 2.0.0
---

# Stop-Process
## SYNOPSIS
Stops one or more running processes.

## SYNTAX

### Id (Default)
```
Stop-Process [-Id] <Int32[]> [-PassThru] [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### Name
```
Stop-Process -Name <String[]> [-PassThru] [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### InputObject
```
Stop-Process [-InputObject] <Process[]> [-PassThru] [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Stop-Process cmdlet stops one or more running processes.
You can specify a process by process name or process ID (PID), or pass a process object to Stop-Process. 
Stop-Process works only on processes running on the local computer.

On Windows Vista and later versions of Windows, to stop a process that is not owned by the current user, you must start Windows PowerShell with the "Run as administrator" option. 
Also, you are prompted for confirmation unless you use the Force parameter.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>stop-process -name notepad
```

This command stops all instances of the Notepad process on the computer.
(Each instance of Notepad runs in its own process.) It uses the Name parameter to specify the processes, all of which have the same name.
If you were to use the ID parameter to stop the same processes, you would have to list the process IDs of each instance of Notepad.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>stop-process -id 3952 -confirm -passthru
Confirm
Are you sure you want to perform this action?
Performing operation "Stop-Process" on Target "notepad (3952)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):y
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
41       2      996       3212    31            3952 notepad
```

This command stops a particular instance of the Notepad process.
It uses the process ID, 3952, to identify the process.
The Confirm parameter directs Windows PowerShell to prompt the user before stopping the process.
Because the prompt includes the process name, as well as its ID, this is best practice.
The PassThru parameter passes the process object to the formatter for display.
Without this parameter, there would be no display after a Stop-Process command.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>calc
PS C:\>$p = get-process calc
PS C:\>stop-process -inputobject $p
PS C:\>get-process | where-object {$_.HasExited}
```

This series of commands starts and stops the Calc process and then detects processes that have stopped.

The first command ("calc") starts an instance of the calculator.
The second command ("$p = get-process calc"), uses the Get-Process cmdlet to get an object representing the Calc process and store it in the $p variable.
The third command ("stop-process -inputobject $p") uses the Stop-Process cmdlet to stop the Calc process.
It uses the InputObject parameter to pass the object to Stop-Process.

The last command gets all of the processes on the computer that were running but that are now stopped.
It uses the Get-Process cmdlet to get all of the processes on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects the ones where the value of the HasExited property is TRUE.
HasExited is just one property of process objects.
To find all the properties, type "get-process | get-member".

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-process lsass | stop-process

Stop-Process : Cannot stop process 'lsass (596)' because of the following error: Access is denied
At line:1 char:34
+ get-process lsass  | stop-process <<<<

[ADMIN]: PS C:\>get-process lsass | stop-process

Warning!
Are you sure you want to perform this action?
Performing operation 'Stop-Process' on Target 'lsass(596)'
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
[ADMIN]: PS C:\>get-process lsass | stop-process -force
[ADMIN]: PS C:\>
```

These commands show the effect of using the Force parameter to stop a process that is not owned by the user.

The first command uses the Get-Process cmdlet to get the Lsass process.
A pipeline operator sends the process to the Stop-Process cmdlet to stop it.
As shown in the sample output, the first command fails with an "Access denied" message, because this process can be stopped only by a member of the Administrator's group on the computer.

When Windows PowerShell is opened with the "Run as administrator" option, and the command is repeated, Windows PowerShell prompts you for confirmation.

The second command uses the Force parameter to suppress the prompt.
As a result, the process is stopped without confirmation.

## PARAMETERS

### -Force
Stops the specified processes without prompting for confirmation.
By default, Stop-Process prompts for confirmation before stopping any process that is not owned by the current user.

To find the owner of a process, use the Get-WmiMethod cmdlet to get a Win32_Process object that represents the process, and then use the GetOwner method of the object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the process IDs of the processes to be stopped.
To specify multiple IDs, use commas to separate the IDs.
To find the PID of a process, type "get-process".
The parameter name ("Id") is optional.

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InformationAction
To find the owner of a process, use the Get-WmiMethod cmdlet to get a Win32_Process object that represents the process, and then use the GetOwner method of the object.

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
To find the owner of a process, use the Get-WmiMethod cmdlet to get a Win32_Process object that represents the process, and then use the GetOwner method of the object.

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

### -InputObject
Stops the processes represented by the specified process objects.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: Process[]
Parameter Sets: InputObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the process names of the processes to be stopped.
You can type multiple process names (separated by commas) or use wildcard characters.

```yaml
Type: String[]
Parameter Sets: Name
Aliases: ProcessName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the process.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### System.Diagnostics.Process
You can pipe a process object to Stop-Process.

## OUTPUTS

### None or System.Diagnostics.Process
When you use the PassThru parameter, Stop-Process returns a System.Diagnostics.Process object that represents the stopped process.
Otherwise, this cmdlet does not generate any output.

## NOTES
You can also refer to Stop-Process by its built-in aliases, "kill" and "spps".
For more information, see about_Aliases.

You can also use the properties and methods of the Windows Management Instrumentation (WMI) Win32_Process object in Windows PowerShell.
For more information, see Get-WmiObject and the WMI SDK.

When stopping processes, be aware that stopping a process can stop process and services that depend on the process.
In an extreme case, stopping a process can stop Windows.

## RELATED LINKS

[Debug-Process]()

[Get-Process]()

[Start-Process]()

[Stop-Process]()

[Wait-Process]()

