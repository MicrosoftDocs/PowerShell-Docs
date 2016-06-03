---
external help file: PSITPro3_Management.xml
schema: 2.0.0
---

# Remove-Computer
## SYNOPSIS
Removes the local computer from its domain.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-Computer [[-UnjoinDomainCredential] <PSCredential>] [-Force] [-PassThru] [-Restart]
 [-Workgroup <String>]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-Computer [-ComputerName <String[]>] [-Force] [-LocalCredential <PSCredential>] [-PassThru] [-Restart]
 [-Workgroup <String>] [-UnjoinDomainCredential] <PSCredential>
```

## DESCRIPTION
The Remove-Computer cmdlet removes the local computer and remote computers from their current domains.

When you remove a computer from a domain, Remove-Computer also disables the computer's domain account.
You must provide explicit credentials to unjoin the computer from its domain, even when they are the credentials of the current user, and you must restart the computer to make the change effective.
Also, when you remove a computer from a domain, you must move it to a workgroup.
Use the WorkgroupName parameter to specify the workgroup.

To move a computer from a workgroup to a domain, from one workgroup to another, or from one domain to another, use the Add-Computer cmdlet.

To get the results of the command, use the Verbose and PassThru parameters.
To suppress the user prompt, use the Force parameter.

Beginning in Windows PowerShell 3.0, Remove-Computer removes the local computer and remote computers from domains.
It includes new credential parameters that specify alternate credentials for connecting to remote computers, and unjoining from a domain, a new Restart parameter for restarting the affected computers, and a Workgroup parameter for specifying the name of the workgroup to which computers are added.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Remove-Computer -UnjoinDomaincredential Domain01\Admin01 -Passthru -Verbose -Restart
```

This command removes the local computer from the domain to which it is joined.

The command uses the UnjoinDomainCredential parameter to supply the credentials of a domain administrator.
It uses the PassThru parameter and the Verbose common parameter to display information about the success or failure of the command and the Restart parameter restart the computer, which is required to complete the remove operation.

Because the command does not specify a workgroup name, the local computer is moved to the "WORKGROUP" workgroup after it is removed from its domain.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Remove-Computer -ComputerName (Get-Content OldServers.txt) -LocalCredential Domain01\Admin01 -UnJoinDomainCredential Domain01\Admin01 -Workgroup Legacy -Force -Restart
```

This command removes all of the computers that are listed in the OldServers.txt file from their domains and places them in the Legacy workgroup.

The command uses the LocalCredential parameter to supply the credentials of a user who has permission to connect to remote computers and the UnjoinDomainCredential parameter to supply the credentials of a user who has permission to remove the computers from their domains.
It uses the Force parameter to suppress the confirmation prompts for each computer and the Restart parameter to restart each of the computers after it is removed from its domain.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Remove-Computer -ComputerName Server01, localhost -UnjoinDomainCredential Domain01\Admin01 -Workgroup Local -Restart -Force
```

This command removes the Server01 remote computer and the local computer from their domains and adds them to the Local workgroup.
It uses the Force parameter to suppress the confirmation prompt for each computer and the Restart parameter to restart the computers to make the change effective.

## PARAMETERS

### -ComputerName
Specifies the computers to be removed from their domains.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol \(IP\) address, or a fully qualified domain name of the remote computers.
To specify the local computer, type the computer name, a dot \(.\), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Remove-Computer even if your computer is not configured to run remote commands.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: LLocal computer
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Force
Suppresses the user prompt.
By default, Remove-Computer prompts you for confirmation before removing each computer.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -LocalCredential
Specifies a user account that has permission to connect to the computers that are specified by the ComputerName parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

To specify a user account that has permission to remove the computer from its current domain, use the UnjoinDomainCredential parameter.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: false
Accept wildcard characters: False
```

### -PassThru
Returns the results of the command.
Otherwise, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -Restart
Restarts the computers that were removed after the removal is complete.
A restart is often required to make the change effective.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -UnjoinDomainCredential
Specifies a user account that has permission to remove the computers from their current domains.
Explicit credentials, as provided by this parameter, are required to remove remote computers from a domain, even when the value is the credentials of the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.
You can refer to this parameter by its name, UnjoinDomainCredential, or its alias, Credential.

To specify a user account that has permission to connect to the remote computers, use the LocalCredential parameter.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -Workgroup
Specifies the name of a workgroup to which the computers are added when they are removed from their domains.
The default value is "WORKGROUP".
When you remove a computer from a domain, you must add it to a workgroup.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: WORKGROUP
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe computer names to the Remove-Computer cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ComputerChangeInfo
When you use the PassThru parameter, Remove-Computer returns a ComputerChangeInfo object.
Otherwise, this cmdlet does not generate any output.

## NOTES
This cmdlet does not remove computers from workgroups.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=135246)

[Add-Computer](712f3460-c5d0-4af8-8de6-6d06e4a1a838)

[Checkpoint-Computer](9ef7dd97-dbd9-43de-8988-9ab85e7827ad)

[Remove-Computer](89871167-713a-4f43-af35-e2891b8849e6)

[Rename-Computer](60054009-a41f-468d-91d9-815b63dbdf48)

[Restart-Computer](ba50f64c-866e-4315-91c7-0ce16b44c47e)

[Restore-Computer](c570f18d-f1dd-462a-b00b-3eb1d2a81dfc)

[Stop-Computer](bae0484a-418a-432c-a172-34b5165dd0b1)

[Test-Connection](7c54e3a1-8d8c-44ad-9056-ef0514c158d6)


