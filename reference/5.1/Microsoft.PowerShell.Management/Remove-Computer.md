---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 05/17/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/remove-computer?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Computer
---
# Remove-Computer

## SYNOPSIS
Removes the local computer from its domain.

## SYNTAX

### Local (Default)

```
Remove-Computer [[-UnjoinDomainCredential] <PSCredential>] [-Restart] [-Force] [-PassThru]
 [-WorkgroupName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Remote

```
Remove-Computer -UnjoinDomainCredential <PSCredential> [-LocalCredential <PSCredential>] [-Restart]
 [-ComputerName <String[]>] [-Force] [-PassThru] [-WorkgroupName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Computer` cmdlet removes the local computer and remote computers from their current
domains.

When you remove a computer from a domain, `Remove-Computer` also disables the domain account of the
computer. You must provide explicit credentials to unjoin the computer from its domain, even when
they are the credentials of the current user. You must restart the computer to make the change
effective. Also, when you remove a computer from a domain, you must move it to a workgroup. Use the
**WorkgroupName** parameter to specify the workgroup.

To move a computer from a workgroup to a domain, from one workgroup to another, or from one domain
to another, use the `Add-Computer` cmdlet.

To get the results of the command, use the **Verbose** and **PassThru** parameters. To suppress the
user prompt, use the **Force** parameter.

`Remove-Computer` removes the local computer and remote computers from domains. It includes
credential parameters that specify alternate credentials for connecting to remote computers, and
unjoining from a domain, a **Restart** parameter for restarting the affected computers, and a
**WorkgroupName** parameter for specifying the name of the workgroup to which computers are added.

## EXAMPLES

### Example 1: Remove the local computer from its domain

This example removes the local computer from the domain to which it is joined.

```powershell
Remove-Computer -UnjoinDomaincredential Domain01\Admin01 -PassThru -Verbose -Restart
```

The **UnjoinDomainCredential** parameter provides the credentials of a domain administrator. The
**PassThru** and the **Verbose** common parameters display information about the success or failure
of the command. The **Restart** parameter restarts the computer to complete the remove operation.

When no workgroup name is specified, the computer is moved to the workgroup named after it is
removed from its domain.

### Example 2: Move several computers to a legacy workgroup

This example removes all the computers listed in the `OldServers.txt` file from their domains and
moves them into the **Legacy** workgroup.

```powershell
Remove-Computer -ComputerName (Get-Content OldServers.txt) -LocalCredential Domain01\Admin01 -UnJoinDomainCredential Domain01\Admin01 -WorkgroupName "Legacy" -Force -Restart
```

The **LocalCredential** parameter provides the credentials of a user who has permission to connect
to remote computers. The **UnjoinDomainCredential** parameter provides the credentials of a user who
has permission to remove the computers from their domains. The **Force** parameter suppresses the
confirmation prompts for each computer. The **Restart** parameter restarts each of the computers
after it is removed from its domain.

### Example 3: Remove computers from a workgroup without confirmation

This example removes the remote computer, Server01, and the local computer from their domains and
adds them to the **Local** workgroup.

```powershell
Remove-Computer -ComputerName "Server01", "localhost" -UnjoinDomainCredential Domain01\Admin01 -WorkgroupName "Local" -Restart -Force
```

The **Force** parameter suppresses the confirmation prompt for each computer. The **Restart**
parameter restarts the computers to make the change effective.

## PARAMETERS

### -ComputerName

Specifies the computers to be removed from their domains. The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name (FQDN) of the remote
computers. To specify the local computer, type the computer name, a dot (`.`), or `localhost`.

This parameter does not rely on PowerShell remoting. You can use the **ComputerName**
parameter of `Remove-Computer` even if your computer is not configured to run remote commands.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.String[]
Parameter Sets: Remote
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force

Suppresses the user prompt. By default, `Remove-Computer` prompts you for confirmation before
removing each computer.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalCredential

Specifies a user account that has permission to connect to the computers that the **ComputerName**
parameter specifies. The default is the current user.

Type a user name, such as `User01` or `Domain01\User01`, or enter a **PSCredential** object, such as
one generated by the `Get-Credential` cmdlet. If you type a user name, the cmdlet prompts you for a
password. To specify a user account that has permission to remove the computer from its current
domain, use the **UnjoinDomainCredential** parameter.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Remote
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns the results of the command. Otherwise, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Restart

Indicates that this cmdlet restarts the computers that are being removed. A restart is often
required to make the change effective.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnjoinDomainCredential

Specifies a user account that has permission to remove the computers from their current domains.
Explicit credentials, as provided by this parameter, are required to remove remote computers from a
domain, even when the value is the credentials of the current user.

Type a user name, such as `User01` or `Domain01\User01`, or enter a **PSCredential** object, such as
one generated by `Get-Credential`. If you type a user name, this cmdlet prompts you for a password.

To specify a user account that has permission to connect to the remote computers, use the
**LocalCredential** parameter.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Local, Remote
Aliases: Credential

Required: False (Local), True (Remote)
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkgroupName

Specifies the name of a workgroup to which the computers are added when they are removed from their
domains. The default value is **WORKGROUP**. When you remove a computer from a domain, you must add
it to a workgroup.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe computer names to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ComputerChangeInfo

When you use the **PassThru** parameter, `Remove-Computer` returns a **ComputerChangeInfo** object.
Otherwise, this cmdlet does not generate any output.

## NOTES

This cmdlet does not remove computers from workgroups.

## RELATED LINKS

[Add-Computer](Add-Computer.md)

[Checkpoint-Computer](Checkpoint-Computer.md)

[Remove-Computer](Remove-Computer.md)

[Rename-Computer](Rename-Computer.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)

[Stop-Computer](Stop-Computer.md)

[Test-Connection](Test-Connection.md)
