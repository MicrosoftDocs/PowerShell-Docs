---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/remove-pssession?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-PSSession
---
# Remove-PSSession

## SYNOPSIS
Closes one or more PowerShell sessions (PSSessions).

## SYNTAX

### Id (Default)

```
Remove-PSSession [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Session

```
Remove-PSSession [-Session] <PSSession[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ContainerId

```
Remove-PSSession -ContainerId <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### VMId

```
Remove-PSSession -VMId <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### VMName

```
Remove-PSSession -VMName <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceId

```
Remove-PSSession -InstanceId <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Name

```
Remove-PSSession -Name <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerName

```
Remove-PSSession [-ComputerName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Remove-PSSession** cmdlet closes PowerShell sessions (**PSSessions**) in the current session.
It stops any commands that are running in the **PSSessions**, ends the **PSSession**, and releases the resources that the **PSSession** was using.
If the **PSSession** is connected to a remote computer, this cmdlet also closes the connection between the local and remote computers.

To remove a **PSSession**, enter the *Name*, *ComputerName*, *ID*, or *InstanceID* of the session.

If you have saved the *PSSession* in a variable, the session object remains in the variable, but the state of the *PSSession* is Closed.

## EXAMPLES

### Example 1: Remove sessions by using IDs

```powershell
Remove-PSSession -Id 1, 2
```

This command removes the **PSSessions** that have IDs 1 and 2.

### Example 2: Remove all the sessions in the current session

```powershell
Get-PSSession | Remove-PSSession
Remove-PSSession -Session (Get-PSSession)
$s = Get-PSSession
Remove-PSSession -Session $s
```

These commands remove all of the **PSSessions** in the current session.
Although the three command formats look different, they have the same effect.

### Example 3: Close sessions by using names

```powershell
$r = Get-PSSession -ComputerName Serv*
$r | Remove-PSSession
```

These commands close the **PSSessions** that are connected to computers that have names that begin with Serv.

### Example 4: Close sessions connected to a port

```powershell
Get-PSSession | where {$_.port -eq 90} | Remove-PSSession
```

This command closes the **PSSessions** that are connected to port 90.
You can use this command format to identify **PSSessions** by properties other than *ComputerName*, *Name*, *InstanceID*, and *ID*.

### Example 5: Close a session based on instance ID

```powershell
Get-PSSession | Format-Table ComputerName, InstanceID  -AutoSize
```

```Output
ComputerName InstanceId
------------ ----------------
Server01     875d231b-2788-4f36-9f67-2e50d63bb82a
localhost    c065ffa0-02c4-406e-84a3-dacb0d677868
Server02     4699cdbc-61d5-4e0d-b916-84f82ebede1f
Server03     4e5a3245-4c63-43e4-88d0-a7798bfc2414
TX-TEST-01   fc4e9dfa-f246-452d-9fa3-1adbdd64ae85 PS C:\> Remove-PSSession -InstanceID fc4e9dfa-f246-452d-9fa3-1adbdd64ae85
```

These commands show how to close a **PSSession** based on its instance ID, or **RemoteRunspaceID**.

The first command uses the **Get-PSSession** cmdlet to get the **PSSessions** in the current session.
It uses a pipeline operator (|) to send the **PSSessions** to the Format-Table cmdlet, which formats their **ComputerName** and **InstanceID** properties in a table.
The *AutoSize* parameter compresses the columns for display.

From the resulting display, you can identify the **PSSession** to be closed, and copy and paste the *InstanceID* of that **PSSession** into the second command.

The second command uses the **Remove-PSSession** cmdlet to remove the *PSSession* with the specified instance ID.

### Example 6: Create a function that deletes all sessions in the current session

```powershell
Function EndPSS { Get-PSSession | Remove-PSSession }
```

This function deletes all of the **PSSessions** in the current session.
After you add this function to your PowerShell profile, to delete all sessions, type `EndPSS`.

## PARAMETERS

### -ComputerName

Specifies an array of names of computers.
This cmdlet closes the **PSSessions** that are connected to the specified computers.
Wildcard characters are permitted.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more remote computers.
To specify the local computer, type the computer name, localhost, or a dot (.).

```yaml
Type: System.String[]
Parameter Sets: ComputerName
Aliases: Cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -ContainerId

Specifies an array of IDs of containers. This cmdlet removes sessions for each of the specified
containers. Use the `docker ps` command to get a list of container IDs. For more information, see
the help for the [docker ps](https://docs.docker.com/engine/reference/commandline/ps/) command.

```yaml
Type: System.String[]
Parameter Sets: ContainerId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id

Specifies an array of IDs of sessions.
This cmdlet closes the *PSSessions* with the specified IDs.
Type one or more IDs, separated by commas, or use the range operator (..) to specify a range of IDs.

An ID is an integer that uniquely identifies the **PSSession** in the current session.
It is easier to remember and type than the *InstanceId*, but it is unique only in the current session.
To find the ID of a **PSSession**, run the Get-PSSession cmdlet without parameters.

```yaml
Type: System.Int32[]
Parameter Sets: Id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies an array of instance IDs.
This cmdlet closes the **PSSessions** that have the specified instance IDs.

The instance ID is a GUID that uniquely identifies a **PSSession** in the current session.
The instance ID is unique, even when you have multiple sessions running on a single computer.

The instance ID is stored in the **InstanceID** property of the object that represents a **PSSession**.
To find the **InstanceID** of the **PSSessions** in the current session, type `Get-PSSession | Format-Table Name, ComputerName, InstanceId`.

```yaml
Type: System.Guid[]
Parameter Sets: InstanceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies an array of friendly names of sessions.
This cmdlet closes the **PSSessions** that have the specified friendly names.
Wildcard characters are permitted.

Because the friendly name of a **PSSession** might not be unique, when you use the *Name* parameter, consider also using the *WhatIf* or *Confirm* parameter in the **Remove-PSSession** command.

```yaml
Type: System.String[]
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Session

Specifies the session objects of the **PSSessions** to close.
Enter a variable that contains the **PSSessions** or a command that creates or gets the **PSSessions**, such as a New-PSSession or **Get-PSSession** command.
You can also pipe one or more session objects to **Remove-PSSession**.

```yaml
Type: System.Management.Automation.Runspaces.PSSession[]
Parameter Sets: Session
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -VMId

Specifies an array of ID of virtual machines.
This cmdlet starts an interactive session with each of the specified virtual machines.
To see the virtual machines that are available to you, use the following command:

`Get-VM | Select-Object -Property Name, ID`

```yaml
Type: System.Guid[]
Parameter Sets: VMId
Aliases: VMGuid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -VMName

Specifies an array of names of virtual machines.
This cmdlet starts an interactive session with each of the specified virtual machines.
To see the virtual machines that are available to you, use the **Get-VM** cmdlet.

```yaml
Type: System.String[]
Parameter Sets: VMName
Aliases:

Required: True
Position: Named
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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Runspaces.PSSession

You can pipe a session object to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any objects.

## NOTES

* The *Id* parameter is mandatory. To delete all the **PSSessions** in the current session, type `Get-PSSession | Remove-PSSession`.
* A **PSSession** uses a persistent connection to a remote computer. Create a **PSSession** to run a series of commands that share data. For more information, type `Get-Help about_PSSessions`.
* **PSSessions** are specific to the current session. When you end a session, the **PSSessions** that you created in that session are forcibly closed.

## RELATED LINKS

[Connect-PSSession](Connect-PSSession.md)

[Disconnect-PSSession](Disconnect-PSSession.md)

[Enter-PSSession](Enter-PSSession.md)

[Exit-PSSession](Exit-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Invoke-Command](Invoke-Command.md)

[New-PSSession](New-PSSession.md)

[Receive-PSSession](Receive-PSSession.md)

[about_PSSessions](About/about_PSSessions.md)

[about_Remote](About/about_Remote.md)

