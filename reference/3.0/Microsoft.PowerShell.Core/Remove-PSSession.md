---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=135250
external help file:  System.Management.Automation.dll-Help.xml
title:  Remove-PSSession
---
# Remove-PSSession

## SYNOPSIS

Closes one or more Windows PowerShell sessions (PSSessions).

## SYNTAX

### Id (Default)

```
Remove-PSSession [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Session

```
Remove-PSSession [-Session] <PSSession[]> [-WhatIf] [-Confirm] [<CommonParameters>]
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

The Remove-PSSession cmdlet closes Windows PowerShell sessions (PSSessions) in the current session.
It stops any commands that are running in the PSSessions, ends the PSSession, and releases the resources that the PSSession was using.
If the PSSession is connected to a remote computer, Remove-PSSession also closes the connection between the local and remote computers.

To remove a PSSession, enter the Name, ComputerName, ID, or InstanceID of the session.

If you have saved the PSSession in a variable, the session object remains in the variable, but the state of the PSSession is "Closed."

## EXAMPLES

### Example 1

```
PS> remove-pssession -id 1, 2
```

This command removes the PSSessions that have IDs 1 and 2.

### Example 2

```
PS> get-pssession | remove-pssession

- or -

PS> remove-pssession -session (get-pssession)

- or -

PS> $s = get-pssession
PS> remove-pssession -session $s
```

These commands remove all of the PSSessions in the current session.
Although the three command formats look different, they have the same effect.

### Example 3

```
PS> $r = get-pssession -computername Serv*
$r | remove-pssession
```

These commands close the PSSessions that are connected to computers that have names that begin with "Serv".

### Example 4

```
PS> get-pssession | where {$_.port -eq 90} | remove-pssession
```

This command closes the PSSessions that are connected to port 90.
You can use this command format to identify PSSessions by properties other than ComputerName, Name, InstanceID, and ID.

### Example 5

```
PS> get-pssession | ft computername, instanceID  -auto

ComputerName InstanceId
------------ ----------------
Server01     875d231b-2788-4f36-9f67-2e50d63bb82a
localhost    c065ffa0-02c4-406e-84a3-dacb0d677868
Server02     4699cdbc-61d5-4e0d-b916-84f82ebede1f
Server03     4e5a3245-4c63-43e4-88d0-a7798bfc2414
TX-TEST-01   fc4e9dfa-f246-452d-9fa3-1adbdd64ae85

PS> remove-pssession -InstanceID fc4e9dfa-f246-452d-9fa3-1adbdd64ae85
```

These commands show how to close a PSSession based on its instance ID (RemoteRunspaceID).

The first command uses the Get-PSSession cmdlet to get the PSSessions in the current session.
It uses a pipeline operator (|) to send the PSSessions to the Format-Table cmdlet (alias: ft), which formats their ComputerName and InstanceID properties in a table.
The AutoSize parameter ("auto") compresses the columns for display.

From the resulting display, the administrator can identify the PSSession to be closed, and copy and paste the InstanceID of that PSSession into the second command.

The second command uses the Remove-PSSession cmdlet to remove the PSSession with the specified instance ID.

### Example 6

```
PS> function EndPSS { get-pssession | remove-pssession }
```

This function deletes all of the PSSessions in the current session.
After you add this function to your Windows PowerShell profile, to delete all sessions, just type "endpss".

## PARAMETERS

### -ComputerName

Closes the PSSessions that are connected to the specified computers.
Wildcards are permitted.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more remote computers.
To specify the local computer, type the computer name, "localhost", or a dot (.).

```yaml
Type: String[]
Parameter Sets: ComputerName
Aliases: Cn

Required: True
Position: 1
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Id

Closes the PSSessions with the specified IDs.
Type one or more IDs (separated by commas) or use the range operator (..) to specify a range of IDs

An ID is an integer that uniquely identifies the PSSession in the current session.
It is easier to remember and type than the InstanceId, but it is unique only within the current session.
To find the ID of a PSSession, use Get-PSSession without parameters.

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

### -InstanceId

Closes the PSSessions with the specified instance IDs.

The instance ID is a GUID that uniquely identifies a PSSession in the current session.
The InstanceID is unique, even when you have multiple sessions running on a single computer.

The InstanceID is stored in the InstanceID property of the object that represents a PSSession.
To find the InstanceID of the PSSessions in the current session, type "get-pssession | format-table Name, ComputerName, InstanceId".

```yaml
Type: Guid[]
Parameter Sets: InstanceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Closes the PSSessions with the specified friendly names.
Wildcards are permitted.

Because the friendly name of a PSSession might not be unique, when using the Name parameter, consider also using the WhatIf  or Confirm parameter in the Remove-PSSession command.

```yaml
Type: String[]
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Session

Specifies the session objects of the PSSessions to close.
Enter a variable that contains the PSSessions or a command that creates or gets the PSSessions, such as a New-PSSession or Get-PSSession command.
You can also pipe one or more session objects to Remove-PSSession.

```yaml
Type: PSSession[]
Parameter Sets: Session
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.Runspaces.PSSession

You can pipe a session object to Remove-PSSession.

## OUTPUTS

### None

Remove-PSSession does not return any objects.

## NOTES

- The ID parameter is mandatory. You cannot type "remove-pssession" without parameters. To delete all the PSSessions in the current session, type "get-pssession | remove-pssession".

  A PSSession uses a persistent connection to a remote computer.
Create a PSSession to run a series of commands that share data.
For more information, see [about_PSSessions](./About/about_PSSessions.md).

  PSSessions are specific to the current session.
When you end a session, the PSSessions that you created in that session are forcibly closed.

- 

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