---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821645
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Test-ComputerSecureChannel
---
# Test-ComputerSecureChannel

## SYNOPSIS
Tests and repairs the secure channel between the local computer and its domain.

## SYNTAX

```
Test-ComputerSecureChannel [-Repair] [-Server <String>] [-Credential <PSCredential>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The **Test-ComputerSecureChannel** cmdlet verifies that the channel between the local computer and its domain is working correctly by checking the status of its trust relationships.
If a connection fails, you can use the *Repair* parameter to try to restore it.

**Test-ComputerSecureChannel** returns $True if the channel is working correctly and $False if it is not.
This result lets you use the cmdlet in conditional statements in functions and scripts.
To get more detailed test results, use the *Verbose* parameter.

This cmdlet works much like NetDom.exe.
Both NetDom and **Test-ComputerSecureChannel** use the **NetLogon** service to perform the actions.

## EXAMPLES

### Example 1: Test a channel between the local computer and its domain

```
PS C:\> Test-ComputerSecureChannel
True
```

This command tests the channel between the local computer and the domain to which it is joined.

### Example 2: Test a channel between the local computer and a domain controller

```
PS C:\> Test-ComputerSecureChannel -Server "DCName.fabrikam.com"
True
```

This command specifies a preferred domain controller for the test.

### Example 3: Reset the channel between the local computer and its domain

```
PS C:\> Test-ComputerSecureChannel -Repair
True
```

This command resets the channel between the local computer and its domain.

### Example 4: Display detailed information about the test

```
PS C:\> Test-ComputerSecureChannel -verbose
VERBOSE: Performing operation "Test-ComputerSecureChannel" on Target "SERVER01".
True
VERBOSE: "The secure channel between 'SERVER01' and 'net.fabrikam.com' is alive and working correctly."
```

This command uses the *Verbose* common parameter to request detailed messages about the operation.
For more information about *Verbose*, see about_CommonParameters.

### Example 5: Test a connection before you run a script

```
PS C:\> Set-Alias tcsc Test-ComputerSecureChannel
if (!(tcsc))
{Write-Host "Connection failed. Reconnect and retry."}
else { &(.\Get-Servers.ps1) }
```

This example shows how to use **Test-ComputerSecureChannel** to test a connection before you run a script that requires the connection.

The first command uses the Set-Alias cmdlet to create an alias for the cmdlet name.
This saves space and prevents typing errors.

The **If** statement checks the value that **Test-ComputerSecureChannel** returns before it runs a script.

## PARAMETERS

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

Specifies a user account that has permission to perform this action.
Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one that the Get-Credential cmdlet returns.
By default, the cmdlet uses the credentials of the current user.

The *Credential* parameter is designed for use in commands that use the *Repair* parameter to repair the channel between the computer and the domain.

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

### -Repair

Indicates that this cmdlet removes and then rebuilds the channel established by the NetLogon service.
Use this parameter to try to restore a connection that has failed the test.

To use this parameter, the current user must be a member of the Administrators group on the local computer.

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

Specifies the domain controller to run the command.
If this parameter is not specified, this cmdlet selects a default domain controller for the operation.

```yaml
Type: String
Parameter Sets: (All)
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Boolean

This cmdlet returns $True if the connection is working correctly and $False if it is not.

## NOTES

* To run a **Test-ComputerSecureChannel** command on Windows Vista and later versions of the Windows operating system, open Windows PowerShell by using the Run as administrator option.
* **Test-ComputerSecureChannel** is implemented by using the **I_NetLogonControl2** function, which controls various aspects of the Netlogon service.

## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Reset-ComputerMachinePassword](Reset-ComputerMachinePassword.md)

[Restart-Computer](Restart-Computer.md)

[Stop-Computer](Stop-Computer.md)