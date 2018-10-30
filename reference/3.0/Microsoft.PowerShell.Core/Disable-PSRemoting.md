---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=144298
external help file:  System.Management.Automation.dll-Help.xml
title:  Disable-PSRemoting
---
# Disable-PSRemoting

## SYNOPSIS

Prevents remote users from running commands on the local computer.

## SYNTAX

```
Disable-PSRemoting [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Disable-PSRemoting** cmdlet prevents users on other computers from running commands on the local computer.

**Disable-PSRemoting** blocks remote access to all session configurations on the local computer.
This prevents remote users from creating temporary or persistent sessions to the local computer.
**Disable-PSRemoting** does not prevent users of the local computer from creating sessions ("PSSessions") on the local computer or remote computers.

To re-enable remote access to all session configurations, use the Enable-PSRemoting cmdlet.
To enable remote access to selected session configurations, use the **AccessMode** parameter of the Set-PSSessionConfiguration cmdlet.
You can also use the Enable-PSSessionConfiguration and Disable-PSSessionConfiguration cmdlets to enable and disable session configurations for all users.
For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

In Windows PowerShell 2.0, **Disable-PSRemoting** prevents all users from creating user-managed sessions ("PSSessions") to the local computer.
In Windows PowerShell 3.0, **Disable-PSRemoting** prevents users on other computers from creating user-managed sessions on the local computer, but allows users of the local computer to create user-managed "loopback" sessions.

To run this cmdlet, start Windows PowerShell with the "Run as administrator" option.

CAUTION: On systems that have both Windows PowerShell 3.0 and the Windows PowerShell 2.0 engine, do not use Windows PowerShell 2.0 to run the **Enable-PSRemoting** and Disable-PSRemoting cmdlets.
The commands might appear to succeed, but the remoting is not configured correctly.
Remote commands, and later attempts to enable and disable remoting, are likely to fail.

## EXAMPLES

### Example 1

```
PS>Disable-PSRemoting
```

This command prevents remote access to all session configurations on the computer.

### Example 2

```
PS>Disable-PSRemoting -Force
```

This command prevents remote access all session configurations on the computer without prompting.

### Example 3

```
PS>Disable-PSRemoting -Force


[ADMIN] PS> New-PSSession -ComputerName localhost


Id Name       ComputerName    State    Configuration         Availability
-- ----       ------------    -----    -------------         ------------
1 Session1   Server02...     Opened   Microsoft.PowerShell     Available
# On Server02 remote computer:
PS> New-PSSession -ComputerName Server01

[SERVER01] Connecting to remote server failed with the following error
message : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of using the **Disable-PSRemoting** cmdlet.
To run this command sequence, start Windows PowerShell with the "Run as administrator" option.

The first command uses the **Disable-PSRemoting** cmdlet to disable all registered session configurations on the Server01 computer.

The second command uses the New-PSSession cmdlet to create a remote session to the local computer (also known as a "loopback").
The command succeeds.

The third command is run on the Server02 remote computer.
The command uses the **New-PSSession** cmdlet to create a session to the Server01 remote computer.
Because remote access is disabled, the command fails.

### Example 4

```
PS>Disable-PSRemoting -force

[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed


[ADMIN] PS> Enable-PSRemoting -Force
WinRM already is set up to receive requests on this machine.
WinRM already is set up for remote management on this machine.

[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                          Permission
----                          ----------
microsoft.powershell          BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow BUILTIN\Administrators AccessAllowed
microsoft.powershell32        BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       BUILTIN\Administrators AccessAllowed
WithProfile                   BUILTIN\Administrators AccessAllowed
```

This example shows the effect on the session configurations of using the **Disable-PSRemoting** and Enable-PSRemoting cmdlets.

The first command uses the **Disable-PSRemoting** cmdlet to disable remote access to all session configurations.
The **Force** parameter suppresses all user prompts.

The second command uses the Get-PSSessionConfiguration cmdlet to display the session configurations on the computer.
The command uses a pipeline operator to send the results to a Format-Table command, which displays only the Name and Permission properties of the configurations in a table.

The output shows that only remote users are denied access to the configurations.
Members of the Administrators group on the local computer are allowed to use the session configurations.
The output also shows that the command affects all session configurations, including the user-created "WithProfile" session configuration.

The third command uses the **Enable-PSRemoting** cmdlet to re-enable remote access to all session configurations on the computer.
The command uses the **Force** parameter to suppress all user prompts and to restart the WinRM service without prompting.

The fourth command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display the names and permissions of the session configurations.
The results show that the "AccessDenied" security descriptors have been removed from all session configurations.

### Example 5

```
PS>Register-PSSessionConfiguration -Name Test -FilePath .\TestEndpoint.pssc -ShowSecurityDescriptorUI

[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap

Name                          Permission
----                          ----------
microsoft.powershell          BUILTIN\Administrators AccessAllowed
Test                          NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed,
DOMAIN01\User01 AccessAllowed

[ADMIN] PS> Disable-PSRemoting -Force


[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
Test                          NT AUTHORITY\NETWORK AccessDenied, NTAUTHORITY\INTERACTIVE AccessAllowed,
BUILTIN\Administrators AccessAllowed, DOMAIN01\User01 AccessAllowed

# Domain01\User01

PS> New-PSSession -ComputerName Server01 -ConfigurationName Test
[Server01] Connecting to remote server failed with the following error message : Access is denied. For more information, see the about_Rem
ote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example demonstrates that the **Disable-PSRemoting** cmdlet disables remote access to all session configurations, including session configurations with custom security descriptors.

The first command uses the Register-PSSessionConfiguration cmdlet to create the Test session configuration.
The command uses the **FilePath** parameter to specify a session configuration file that customizes the session and the **ShowSecurityDescriptorUI** parameter to display a dialog box that sets permissions for the session configuration.
In the Permissions dialog box, we create custom full-access permissions for the Domain01\User01 user.

The second command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display the session configurations and their properties.
The output shows that the Test session configuration allows interactive access and special permissions for the Domain01\User01 user.

The third command uses the **Disable-PSRemoting** cmdlet to disable remote access to all session configurations.

The fourth command uses the **Get-PSSessionConfiguration** and **Format-Table** cmdlets to display the session configurations and their properties.
The output shows that an AccessDenied security descriptor for all network users is added to all session configurations, including the Test session configuration.
Although the other security desriptors are not changed, the "network_deny_all" security descriptor takes precedence.

The fifth command shows that the **Disable-PSRemoting** command prevents even the Domain01\User01 user with special permissions to the Test session configuration from using the Test session configuration to connect to the computer remotely.

### Example 6

```
PS>Disable-PSRemoting -Force


[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed

[ADMIN] PS> Set-PSSessionConfiguration -Name Microsoft.ServerManager -AccessMode Remote -Force

[ADMIN] PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
```

This example shows how to re-enable remote access only to selected session configurations.

The first command uses the **Disable-PSRemoting** cmdlet to disable remote access to all session configurations.

The second command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display the session configurations and their properties.
The output shows that an AccessDenied security descriptor for all network users is added to all session configurations.

The third command uses the Set-PSSessionConfiguration cmdlet.
The command uses the **AccessMode** parameter with a value of **Remote** to enable remote access to the Microsoft.ServerManager session configuration.
You can also use the **AccessMode** parameter to enable Local access and to disable session configurations.

The fourth command uses the **Get-PSSessionConfiguration** and **Format-Table** cmdlets to display the session configurations and their properties.
The output shows that the AccessDenied security descriptor for all network users is removed, thereby restoring remote access to the Microsoft.ServerManager session configuration.

## PARAMETERS

### -Force

Suppresses all user prompts.
By default, you are prompted to confirm each operation.

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

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any object.

## NOTES

- Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting or Enable-PSSessionConfiguration cmdlets. You might have to undo the following changes manually.

  1.
Stop and disable the WinRM service.

2.
Delete the listener that accepts requests on any IP address.

3.
Disable the firewall exceptions for WS-Management communications.

4.
Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to members of the Administrators group on the computer.

  A session configuration is a group of settings that define the environment for a session.
Every session that connects to the computer must use one of the session configurations that are registered on the computer.
By denying remote access to all session configurations, you effectively prevent remote users from establishing sessions that connect to the computer.

  In Windows PowerShell 2.0, **Disable-PSRemoting** adds a "Deny_All" entry to the security descriptors of all session configurations.
This setting prevents all users from creating user-managed sessions ("PSSessions") to the local computer.
In Windows PowerShell 3.0, Disable-PSRemoting adds a "Network_Deny_All" entry to the security descriptors of all session configurations.
This setting prevents users on other computers from creating user-managed sessions on the local computer, but allows users of the local computer to create user-managed "loopback" sessions.

  In Windows PowerShell 2.0, **Disable-PSRemoting** is the equivalent of "`Disable-PSSessionConfiguration -name *`".
In Windows PowerShell 3.0, **Disable-PSRemoting** is the equivalent of "`Set-PSSessionConfiguration -Name \<Configuration name\> -AccessMode Local`"

  In Windows PowerShell 2.0, **Disable-PSRemoting** is a function.
Beginning in Windows PowerShell 3.0, it is a cmdlet.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSRemoting](Enable-PSRemoting.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)