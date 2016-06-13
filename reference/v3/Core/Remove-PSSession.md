---
external help file: PSITPro3_Core.xml
online version: http://go.microsoft.com/fwlink/?LinkID=135250
schema: 2.0.0
---

# Remove-PSSession
## SYNOPSIS
Closes one or more Windows PowerShell sessions (PSSessions).

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-PSSession [-Id] <Int32[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-PSSession [-ComputerName] <String[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Remove-PSSession -InstanceId <Guid[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Remove-PSSession -Name <String[]> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Remove-PSSession [-Session] <PSSession[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-PSSession cmdlet closes Windows PowerShell sessions (PSSessions) in the current session.
It stops any commands that are running in the PSSessions, ends the PSSession, and releases the resources that the PSSession was using.
If the PSSession is connected to a remote computer, Remove-PSSession also closes the connection between the local and remote computers.

To remove a PSSession, enter the Name, ComputerName, ID, or InstanceID of the session.

If you have saved the PSSession in a variable, the session object remains in the variable, but the state of the PSSession is "Closed."

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>remove-pssession -id 1, 2
```

This command removes the PSSessions that have IDs 1 and 2.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-pssession | remove-pssession

- or -

PS C:\>remove-pssession -session (get-pssession)

- or -

PS C:\>$s = get-pssession
PS C:\>remove-pssession -session $s
```

These commands remove all of the PSSessions in the current session.
Although the three command formats look different, they have the same effect.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$r = get-pssession -computername Serv*
$r | remove-pssession
```

These commands close the PSSessions that are connected to computers that have names that begin with "Serv".

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-pssession | where {$_.port -eq 90} | remove-pssession
```

This command closes the PSSessions that are connected to port 90.
You can use this command format to identify PSSessions by properties other than ComputerName, Name, InstanceID, and ID.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-pssession | ft computername, instanceID  -auto

ComputerName InstanceId
------------ ----------------
Server01     875d231b-2788-4f36-9f67-2e50d63bb82a
localhost    c065ffa0-02c4-406e-84a3-dacb0d677868
Server02     4699cdbc-61d5-4e0d-b916-84f82ebede1f
Server03     4e5a3245-4c63-43e4-88d0-a7798bfc2414
TX-TEST-01   fc4e9dfa-f246-452d-9fa3-1adbdd64ae85

PS C:\>remove-pssession -InstanceID fc4e9dfa-f246-452d-9fa3-1adbdd64ae85
```

These commands show how to close a PSSession based on its instance ID (RemoteRunspaceID).

The first command uses the Get-PSsession cmdlet to get the PSSessions in the current session.
It uses a pipeline operator (|) to send the PSSessions to the Format-Table cmdlet (alias: ft), which formats their ComputerName and InstanceID properties in a table.
The AutoSize parameter ("auto") compresses the columns for display.

From the resulting display, the administrator can identify the PSSession to be closed, and copy and paste the InstanceID of that PSSession into the second command.

The second command uses the Remove-PSSession cmdlet to remove the PSSession with the specified instance ID.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>function EndPSS { get-pssession | remove-pssession }
```

This function deletes all of the PSSessions in the current session.
After you add this function to your Windows Powershell profile, to delete all sessions, just type "endpss".

## PARAMETERS

### -ComputerName
Closes the PSSessions that are connected to the specified computers.
Wildcards are permitted.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more remote computers.
To specify the local computer, type the computer name, "localhost", or a dot (.).

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
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
Parameter Sets: UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_5
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.Runspaces.PSSession
You can pipe a session object to Remove-PSSession.

## OUTPUTS

### None
Remove-PSSession does not return any objects.

## NOTES
The ID parameter is mandatory.
You cannot type "remove-pssession" without parameters.
To delete all the PSSessions in the current session, type "get-pssession | remove-pssession".

A PSSession uses a persistent connection to a remote computer.
Create a PSSession to run a series of commands that share data.
For more information, see about_PSSessions.

PSSessions are specific to the current session.
When you end a session, the PSSessions that you created in that session are forcibly closed.

## RELATED LINKS

[Connect-PSSession](b803dd29-f208-4079-80d4-db04d778f060)

[Disconnect-PSSession](f8f95111-612f-4cba-9098-77904b0473d8)

[Enter-PSSession](4e1e012b-51df-4fea-9ff2-dc859eee13fe)

[Exit-PSSession](f13cbf38-6bd1-4db3-9ef8-52388237adc7)

[Get-PSSession](b2b10531-d0df-4746-b877-e75c09955cb6)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[New-PSSession](76f6628c-054c-4eda-ba7a-a6f28daaa26f)

[Receive-PSSession](b8ec9e88-aab5-4db8-a4a3-216338d1c9b6)

[about_PSSessions](7a9b4e0e-fa1b-47b0-92f6-6e2995d70acb)

[about_Remote](9b4a5c87-9162-4adf-bdfe-fbc80b9b8970)

