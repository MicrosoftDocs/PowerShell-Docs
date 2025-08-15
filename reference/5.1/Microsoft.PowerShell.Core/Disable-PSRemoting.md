---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 10/06/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/disable-psremoting?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSRemoting
---
# Disable-PSRemoting

## SYNOPSIS
Prevents PowerShell endpoints from receiving remote connections.

## SYNTAX

```
Disable-PSRemoting [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-PSRemoting` cmdlet blocks remote access to all Windows PowerShell session endpoint
configurations on the local computer. This includes any endpoints created by PowerShell 6 or higher.

To re-enable remote access to all session configurations, use the `Enable-PSRemoting` cmdlet. This
includes any endpoints created by PowerShell 6 or higher. To enable remote access to selected
session configurations, use the **AccessMode** parameter of the `Set-PSSessionConfiguration` cmdlet.
You can also use the `Enable-PSSessionConfiguration` and `Disable-PSSessionConfiguration` cmdlets to
enable and disable session configurations for all users. For more information about session
configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

> [!NOTE]
> Even after running `Disable-PSRemoting` you can still make loopback connections on the local
> machine. A loopback connection is a PowerShell remote session that originates from and connects to
> the same local machine. Remote sessions from external sources remain blocked. For loopback
> connections you must use implicit credentials along the **EnableNetworkAccess** parameter. For
> more information about loopback connections, see [New-PSSession](New-PSSession.md).

To run this cmdlet, start Windows PowerShell with the **Run as administrator** option.

## EXAMPLES

### Example 1: Prevent remote access to all session configurations

This example prevents remote access to all PowerShell session endpoint configurations on the computer.

```powershell
Disable-PSRemoting
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these
 steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.
```

### Example 2: Prevent remote access to all session configurations without confirmation prompt

This example prevents remote access all PowerShell session endpoint configurations on the computer
without prompting.

```powershell
Disable-PSRemoting -Force
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these
 steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.
```

### Example 3: Effects of running this cmdlet

This example shows the effect of using the `Disable-PSRemoting` cmdlet. To run this command
sequence, start PowerShell with the **Run as administrator** option.

After disabling the sessions configurations, the `New-PSSession` cmdlet attempts to create a remote
session to the local computer (also known as a "loopback"). Because remote access is disabled on the
local machine, the command fails.

```powershell
Disable-PSRemoting -Force
New-PSSession -ComputerName localhost
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

New-PSSession : [localhost] Connecting to remote server localhost failed with the following error
 message : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:1
+ New-PSSession -ComputerName localhost -ConfigurationName PowerShell.6
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (System.Management.A\u2026tion.RemoteRunspace:RemoteRunspace)
 [New-PSSession], PSRemotingTransportException
+ FullyQualifiedErrorId : AccessDenied,PSSessionOpenFailed
```

### Example 4: Effects of running this cmdlet and Enable-PSRemoting

This example shows the effect on the session configurations of using the `Disable-PSRemoting` and
`Enable-PSRemoting` cmdlets.

`Disable-PSRemoting` is used to disable remote access to all PowerShell session endpoint
configurations. The **Force** parameter suppresses all user prompts. The
`Get-PSSessionConfiguration` and `Format-Table` cmdlets display the session configurations on the
computer.

The output shows that all remote users with a network token are denied access to the endpoint
configurations. Administrators group on the local computer are allowed access to the endpoint
configurations as long as they are connecting locally (also known as loopback) and using implicit
credentials.

```powershell
Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -AutoSize

Enable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -AutoSize
```

```Output
Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed

Name                          Permission
----                          ----------
microsoft.powershell          BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow BUILTIN\Administrators AccessAllowed
microsoft.powershell32        BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       BUILTIN\Administrators AccessAllowed
WithProfile                   BUILTIN\Administrators AccessAllowed
```

The `Enable-PSRemoting` cmdlet re-enables remote access to all PowerShell session endpoint
configurations on the computer. The **Force** parameter suppresses all user prompts and restarts the
WinRM service without prompting. The new output shows that the **AccessDenied** security descriptors
have been removed from all session configurations.

### Example 5: Loopback connections with disabled session endpoint configurations

This example demonstrates how endpoint configurations are disabled, and shows how to make a
successful loopback connection to a disabled endpoint. `Disable-PSRemoting` disables all PowerShell
session endpoint configurations.

```powershell
Disable-PSRemoting -Force
New-PSSession -ComputerName localhost
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

New-PSSession : [localhost] Connecting to remote server localhost failed with the following error message : Access is
denied. For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:1
+ New-PSSession -ComputerName localhost
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [New-PSSession], PSRemotin
   gTransportException
    + FullyQualifiedErrorId : AccessDenied,PSSessionOpenFailed

```

```powershell
New-PSSession -ComputerName localhost -EnableNetworkAccess
```

```Output
 Id Name       Transport ComputerName  ComputerType   State   ConfigurationName   Availability
 -- ----       --------- ------------  ------------   -----   -----------------   ------------
 1  Runspace1  WSMan     localhost     RemoteMachine  Opened  powershell.6           Available
```

The first use of `New-PSSession` attempts to create a remote session to the local machine. This type
of connection goes through the network stack and is not a loopback. Consequently, the connection
attempt to the disabled endpoint fails with an **Access is denied** error.

The second use of `New-PSSession` also attempts to create a remote session to the local machine.
In this case, it succeeds because it is a loopback connection that bypasses the network stack.

A loopback connection is created when the following conditions are met:

- The computer name to connect to is 'localhost'.
- No credentials are passed in. Current logged in user (implicit credentials) is used for the
  connection.
- The **EnableNetworkAccess** switch parameter is used.

For more information on loopback connections, see [New-PSSession](New-PSSession.md) document.

### Example 6: Prevent remote access to session configurations that have custom security descriptors

This example demonstrates that the `Disable-PSRemoting` cmdlet disables remote access to all session
configurations that include session configurations with custom security descriptors.

`Register-PSSessionConfiguration` creates the **Test** session configuration. The **FilePath**
parameter specifies a session configuration file that customizes the session. The
**ShowSecurityDescriptorUI** parameter displays a dialog box that sets permissions for the session
configuration. In the Permissions dialog box, we create custom full-access permissions for the
indicated user.

The `Get-PSSessionConfiguration` and `Format-Table` cmdlets display the session configurations and
their properties. The output shows that the **Test** session configuration allows interactive access
and special permissions for the indicated user.

`Disable-PSRemoting` disables remote access to all session configurations.

```powershell
Register-PSSessionConfiguration -Name Test -FilePath .\TestEndpoint.pssc -ShowSecurityDescriptorUI -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap

Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap
New-PSSession -ComputerName localhost -ConfigurationName Test
```

```Output
Name                          Permission
----                          ----------
microsoft.powershell          BUILTIN\Administrators AccessAllowed
Test                          NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed,
DOMAIN01\User01 AccessAllowed

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
Test                          NT AUTHORITY\NETWORK AccessDenied, NTAUTHORITY\INTERACTIVE AccessAllowed,
BUILTIN\Administrators AccessAllowed, DOMAIN01\User01 AccessAllowed


[Server01] Connecting to remote server failed with the following error message : Access is denied. For more information, see the about_Rem
ote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

Now the `Get-PSSessionConfiguration` and `Format-Table` cmdlets shows that an **AccessDenied**
security descriptor for all network users is added to all session configurations, including the
**Test** session configuration. Although the other security descriptors are not changed, the
"network_deny_all" security descriptor takes precedence. This is illustrated by the attempt to use
`New-PSSession` to connect to the **Test** session configuration.

### Example 7: Re-enable remote access to selected session configurations

This example shows how to re-enable remote access only to selected session configurations. After
disabling all session configurations, we re-enable a specific session.

The `Set-PSSessionConfiguration` cmdlet is used to change the **microsoft.ServerManager** session
configuration. The **AccessMode** parameter with a value of **Remote** re-enables remote access to
the configuration.

```powershell
Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -AutoSize

Set-PSSessionConfiguration -Name Microsoft.ServerManager -AccessMode Remote -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -AutoSize
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed

Name                          Permission
----                          ----------
microsoft.powershell          NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell.workflow NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell32        NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.ServerManager       BUILTIN\Administrators AccessAllowed
WithProfile                   NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed
```

## PARAMETERS

### -Force
Forces the command to run without asking for user confirmation.

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

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

- Disabling the session configurations does not undo all the changes that were made by the
  `Enable-PSRemoting` or `Enable-PSSessionConfiguration` cmdlets. You might have to undo the
  following changes manually.

  1. Stop and disable the WinRM service.
  2. Delete the listener that accepts requests on any IP address.
  3. Disable the firewall exceptions for WS-Management communications.
  4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
     members of the Administrators group on the computer.

  A session configuration is a group of settings that define the environment for a session. Every
  session that connects to the computer must use one of the session configurations that are
  registered on the computer. By denying remote access to all session configurations, you
  effectively prevent remote users from establishing sessions that connect to the computer.

  In Windows PowerShell 2.0, `Disable-PSRemoting` adds a Deny_All entry to the security descriptors
  of all session configurations. This setting prevents all users from creating user-managed sessions
  to the local computer. In Windows PowerShell 3.0, `Disable-PSRemoting` adds a Network_Deny_All
  entry to the security descriptors of all session configurations. This setting prevents users on
  other computers from creating user-managed sessions on the local computer, but allows users of the
  local computer to create user-managed loopback sessions.

  In Windows PowerShell 2.0, `Disable-PSRemoting` is the equivalent of
  `Disable-PSSessionConfiguration -Name *`. In Windows PowerShell 3.0 and later releases,
  `Disable-PSRemoting` is the equivalent of
  `Set-PSSessionConfiguration -Name \<Configuration name\> -AccessMode Local`

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSRemoting](Enable-PSRemoting.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSession](New-PSSession.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)
