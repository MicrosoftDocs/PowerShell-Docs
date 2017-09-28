---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821564
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Add-Computer
---

# Add-Computer

## SYNOPSIS
Add the local computer to a domain or workgroup.

## SYNTAX

### Domain (Default)
```
Add-Computer [-ComputerName <String[]>] [-LocalCredential <PSCredential>]
 [-UnjoinDomainCredential <PSCredential>] -Credential <PSCredential> [-DomainName] <String> [-OUPath <String>]
 [-Server <String>] [-Unsecure] [-Options <JoinOptions>] [-Restart] [-PassThru] [-NewName <String>] [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Workgroup
```
Add-Computer [-ComputerName <String[]>] [-LocalCredential <PSCredential>] [-Credential <PSCredential>]
 [-WorkgroupName] <String> [-Restart] [-PassThru] [-NewName <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Add-Computer** cmdlet adds the local computer or remote computers to a domain or workgroup, or moves them from one domain to another.
It also creates a domain account if the computer is added to the domain without an account.

You can use the parameters of this cmdlet to specify an organizational unit (OU) and domain controller or to perform an unsecure join.

To get the results of the command, use the *Verbose* and *PassThru* parameters.

## EXAMPLES

### Example 1: Add a local computer to a domain then restart the computer
```
PS C:\> Add-Computer -DomainName "Domain01" -Restart
```

This command adds the local computer to the Domain01 domain and then restarts the computer to make the change effective.

### Example 2: Add a local computer to a workgroup
```
PS C:\> Add-Computer -WorkGroupName "WORKGROUP-A"
```

This command adds the local computer to the Workgroup-A workgroup.

### Example 3: Add a local computer to a domain
```
PS C:\> Add-Computer -DomainName "Domain01" -Server "Domain01\DC01" -Passthru -Verbose
```

This command adds the local computer to the Domain01 domain by using the Domain01\DC01 domain controller.

The command uses the *PassThru* and *Verbose* parameters to get detailed information about the results of the command.

### Example 4: Add a local computer to a domain using the OUPath parameter
```
PS C:\> Add-Computer -DomainName "Domain02" -OUPath "OU=testOU,DC=domain,DC=Domain,DC=com"
```

This command adds the local computer to the Domain02 domain.
It uses the OUPath parameter to specify the organizational unit for the new accounts.

### Example 5: Add a local computer to a domain using credentials
```
PS C:\> Add-Computer -ComputerName "Server01" -LocalCredential "Server01\Admin01" -DomainName "Domain02" -Credential Domain02\Admin02 -Restart -Force
```

This command adds the Server01 computer to the Domain02 domain.
It uses the *LocalCredential* parameter to specify a user account that has permission to connect to the Server01 computer.
It uses the *Credential* parameter to specify a user account that has permission to join computers to the domain.
It uses the *Restart* parameter to restart the computer after the join operation completes and the *Force* parameter to suppress user confirmation messages.

### Example 6: Move a group of computers to a new domain
```
PS C:\> Add-Computer -ComputerName "Server01", "Server02", "localhost" -Domain "Domain02" -LocalCredential Domain01\User01 -UnjoinDomainCredential Domain01\Admin01 -Credential Domain02\Admin01 -Restart
```

This command moves the Server01 and Server02 computers, and the local computer, from Domain01 to Domain02.

It uses the *LocalCredential* parameter to specify a user account that has permission to connect to the three affected computers.
It uses the *UnjoinDomainCredential* parameter to specify a user account that has permission to unjoin the computers from the Domain01 domain and the *Credential* parameter to specify a user account that has permission to join the computers to the Domain02 domain.
It uses the *Restart* parameter to restart all three computers after the move is complete.

### Example 7: Move a computer to a new domain and change the name of the computer
```
PS C:\> Add-Computer -ComputerName "Server01" -Domain "Domain02" -NewName "Server044" -Credential Domain02\Admin01 -Restart
```

This command moves the Server01 computer to the Domain02 and changes the machine name to Server044.

The command uses the credential of the current user to connect to the Server01 computer and unjoin it from its current domain.
It uses the *Credential* parameter to specify a user account that has permission to join the computer to the Domain02 domain.

### Example 8: Add computers listed in a file to a new domain
```
PS C:\> Add-Computer -ComputerName (Get-Content Servers.txt) -Domain "Domain02" -Credential Domain02\Admin02 -Options Win9xUpgrade -Restart
```

This command adds the computers that are listed in the Servers.txt file to the Domain02 domain.
It uses the *Options* parameter to specify the **Win9xUpgrade** option.
The *Restart* parameter restarts all of the newly added computers after the join operation completes.

## PARAMETERS

### -ComputerName
Specifies the computers to add to a domain or workgroup.
The default is the local computer.

Type the NetBIOS name, an Internet Protocol (IP) address, or a fully qualified domain name of each of the remote computers.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the *ComputerName* parameter of **Add-Computer** even if your computer is not configured to run remote commands.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
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

### -Credential
Specifies a user account that has permission to join the computers to a new domain.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you are prompted for a password.

To specify a user account that has permission to remove the computer from its current domain, use the *UnjoinDomainCredential* parameter.
To specify a user account that has permission to connect to a remote computer, use the *LocalCredential* parameter.

```yaml
Type: PSCredential
Parameter Sets: Domain
Aliases: DomainCredential

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: Workgroup
Aliases: DomainCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainName
Specifies the domain to which the computers are added.
This parameter is required when adding the computers to a domain.

```yaml
Type: String
Parameter Sets: Domain
Aliases: DN, Domain

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.
Without this parameter, **Add-Computer** requires you to confirm the addition of each computer.

This parameter was introduced in Windows PowerShell 3.0.

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

### -LocalCredential
Specifies a user account that has permission to connect to the computers that are specified by the *ComputerName* parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you are prompted for a password.

To specify a user account that has permission to add the computers to a new domain, use the *Credential* parameter.
To specify a user account that has permission to remove the computers from their current domain, use the *UnjoinDomainCredential* parameter.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
Specifies a new name for the computer in the new domain.
This parameter is valid only when one computer is being added or moved.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OUPath
Specifies an organizational unit (OU) for the domain account.
Enter the full distinguished name of the OU in quotation marks. 
The default value is the default OU for machine objects in the domain.

```yaml
Type: String
Parameter Sets: Domain
Aliases: OU

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Options
Specifies advanced options for the **Add-Computer** join operation.
Enter one or more values in a comma-separated string.

The acceptable values for this parameter are:

- **AccountCreate**: Creates a domain account. The **Add-Computer** cmdlet automatically creates a domain account when it adds a computer to a domain. This option is included for completeness.

- **Win9XUpgrade**: Indicates that the join operation is part of a Windows operating system upgrade.

- **UnsecuredJoin**: Performs an unsecured join. To request an unsecured join, use the *Unsecure* parameter or this option.

- **PasswordPass**: Sets the machine password to the value of the *Credential*(DomainCredential) parameter after performing an unsecured join. This option also indicates that the value of the *Credential* (DomainCredential) parameter is a machine password, not a user password. This option is valid only when the UnsecuredJoin option is specified.

 -- **JoinWithNewName**: Renames the computer name in the new domain to the name specified by the *NewName* parameter. When you use the *NewName* parameter, this option is set automatically. This option is designed to be used with the Rename-Computer cmdlet. If you use the **Rename-Computer** cmdlet to rename the computer, but do not restart the computer to make the change effective, you can use this parameter to join the computer to a domain with its new name.

- **JoinReadOnly**: Uses an existing machine account to join the computer to a read-only domain controller. The machine account must be added to the allowed list for password replication policy and the account password must be replicated to the read-only domain controller prior to the join operation.

- **InstallInvoke**: Sets the create (0x2) and delete (0x4) flags of the **FJoinOptions** parameter of the **JoinDomainOrWorkgroup** method. For more information about the **JoinDomainOrWorkgroup** method, see [JoinDomainOrWorkgroup method of the Win32_ComputerSystem class](https://msdn.microsoft.com/library/aa392154) in the MSDN library. For more information about these options, see [NetJoinDomain function](https://msdn.microsoft.com/library/aa370433) in the MSDN library.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: JoinOptions
Parameter Sets: Domain
Aliases: 
Accepted values: AccountCreate, Win9XUpgrade, UnsecuredJoin, PasswordPass, DeferSPNSet, JoinWithNewName, JoinReadOnly, InstallInvoke

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
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

### -Restart
Indicates that this cmdlet restarts the computers that were added to the domain or workgroup.
A restart is often required to make the change effective.

This parameter was introduced in Windows PowerShell 3.0.

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

### -Server
Specifies the name of a domain controller that adds the computer to the domain.
Enter the name in DomainName\ComputerName format.
By default, no domain controller is specified.

```yaml
Type: String
Parameter Sets: Domain
Aliases: DC

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnjoinDomainCredential
Specifies a user account that has permission to remove the computers from their current domains.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you are prompted for a password.

Use this parameter when you are moving computers to a different domain.
To specify a user account that has permission to join the new domain, use the *Credential* parameter.
To specify a user account that has permission to connect to a remote computer, use the *LocalCredential* parameter.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSCredential
Parameter Sets: Domain
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unsecure
Indicates that this cmdlet performs an unsecured join to the specified domain.

```yaml
Type: SwitchParameter
Parameter Sets: Domain
Aliases: 

Required: False
Position: Named
Default value: None
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

### -WorkgroupName
Specifies the name of a workgroup to which the computers are added.
The default value is "WORKGROUP".

```yaml
Type: String
Parameter Sets: Workgroup
Aliases: WGN

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe computer names and new names to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ComputerChangeInfo
When you use the *PassThru* parameter, **Add-Computer** returns a **ComputerChangeInfo** object.
Otherwise, this cmdlet does not generate any output.

## NOTES
* In Windows PowerShell 2.0, the *Server* parameter of **Add-Computer** fails even when the server is present. In Windows PowerShell 3.0, the implementation of the *Server* parameter is changed so that it works reliably.

## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Remove-Computer](Remove-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Rename-Computer](Rename-Computer.md)

[Restore-Computer](Restore-Computer.md)

[Stop-Computer](Stop-Computer.md)

[Test-Connection](Test-Connection.md)

