---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 01/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/disable-psremoting?view=powershell-7&WT.mc_id=ps-gethelp
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

The `Disable-PSRemoting` cmdlet blocks remote access to all PowerShell version 6 and greater session
endpoint configurations on the local computer. It does not affect Windows PowerShell endpoint
configurations. To disable Windows PowerShell session endpoint configurations, run
`Disable-PSRemoting` command from within a Windows PowerShell session.

To re-enable remote access to all PowerShell version 6 and greater session endpoint configurations,
use the `Enable-PSRemoting` cmdlet. To re-enable remote access to all Windows PowerShell session
endpoint configurations, run `Enable-PSRemoting` from within a Windows PowerShell session.

> [!NOTE]
> If you want to disable all PowerShell remote access to a local Windows machine, you must run this
> command both from a within PowerShell version 6 or greater session and from within a Windows
> PowerShell session. Windows PowerShell is installed on all Windows machines by default.

To disable and re-enable remote access to specific session endpoint configurations, use the
`Enable-PSSessionConfiguration` and `Disable-PSSessionConfiguration` cmdlets. To set specific access
configurations of individual endpoints, use the `Set-PSSessionConfiguration` cmdlet along with the
**AccessMode** parameter. For more information about session configurations, see
[about_Session_Configurations](About/about_Session_Configurations.md).

> [!NOTE]
> Even after running `Disable-PSRemoting` you can still make loopback connections on the local
> machine. A loopback connection is a PowerShell remote session that originates from and connects to
> the same local machine. Remote sessions from external sources remain blocked. For loopback
> connections you must use implicit credentials along the **EnableNetworkAccess** parameter. For
> more information about loopback connections, see [New-PSSession](New-PSSession.md).

This cmdlet is only available on the Windows platform. It is not available on Linux or macOS
versions of PowerShell. To run this cmdlet, start PowerShell with the **Run as administrator**
option.

## EXAMPLES

### Example 1: Prevent remote access to all PowerShell session configurations

This example prevents remote access to all PowerShell session endpoint configurations on the computer.

```powershell
Disable-PSRemoting
```

```Output
WARNING: PowerShell remoting has been disabled only for PowerShell 6+ configurations and does not affect
 Windows PowerShell remoting configurations. Run this cmdlet in Windows PowerShell to affect all PowerShell
 remoting configurations.

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.
```

### Example 2: Prevent remote access to all PowerShell session configurations without confirmation prompt

This example prevents remote access all PowerShell session endpoint configurations on the computer
without prompting.

```powershell
Disable-PSRemoting -Force
```

```Output
WARNING: PowerShell remoting has been disabled only for PowerShell 6+ configurations and does not affect
 Windows PowerShell remoting configurations. Run this cmdlet in Windows PowerShell to affect all PowerShell
 remoting configurations.

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
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
New-PSSession -ComputerName localhost -ConfigurationName PowerShell.6
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
Disable-PSRemoting -force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Enable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto
```

```Output
Name               Permission
----               ----------
PowerShell.6       NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
PowerShell.6.2.0   NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...

Name               Permission
----               ----------
PowerShell.6       NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
PowerShell.6.2.0   NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
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
```

```Output
WARNING: PowerShell remoting has been disabled only for PowerShell 6+ configurations and does not affect
 Windows PowerShell remoting configurations. Run this cmdlet in Windows PowerShell to affect all PowerShell
 remoting configurations.

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.
```

```powershell
New-PSSession -ComputerName localhost -ConfigurationName powershell.6 -Credential (Get-Credential)
```

```Output
PowerShell credential request
Enter your credentials.
User: UserName
Password for user UserName: ************

New-PSSession: [localhost] Connecting to remote server localhost failed with the following error message
 : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
```

```powershell
New-PSSession -ComputerName localhost -ConfigurationName powershell.6 -EnableNetworkAccess
```

```Output
 Id Name       Transport ComputerName  ComputerType   State   ConfigurationName   Availability
 -- ----       --------- ------------  ------------   -----   -----------------   ------------
 1  Runspace1  WSMan     localhost     RemoteMachine  Opened  powershell.6           Available
```

The first use of `New-PSSession` attempts to create a remote session to the local machine. The
**ConfigurationName** parameter is used to specify a disabled PowerShell endpoint. Credentials are
explicitly passed to the command through the **Credential** parameter. This type of connection goes
through the network stack and is not a loopback. Consequently, the connection attempt to the
disabled endpoint fails with an **Access is denied** error.

The second use of `New-PSSession` also attempts to create a remote session to the local machine.
In this case, it succeeds because it is a loopback connection that bypasses the network stack.

A loopback connection is created when the following conditions are met:

- The computer name to connect to is 'localhost'.
- No credentials are passed in. Current logged in user (implicit credentials) is used for the
  connection.
- The **EnableNetworkAccess** switch parameter is used.

For more information on loopback connections, see [New-PSSession](New-PSSession.md) document.

### Example 6: Disabling all PowerShell remoting endpoint configurations

This example demonstrates how running the `Disable-PSRemoting` command does not affect Windows
PowerShell endpoint configurations. `Get-PSSessionConfiguration` run within Windows PowerShell shows
all endpoint configurations. We see that the Windows PowerShell endpoint configurations are not
disabled.

```powershell
Disable-PSRemoting -Force
powershell.exe -command 'Get-PSSessionConfiguration'
```

```Output
WARNING: PowerShell remoting has been disabled only for PowerShell 6+ configurations and does not affect
 Windows PowerShell remoting configurations. Run this cmdlet in Windows PowerShell to affect all PowerShell
 remoting configurations.

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

Name          : microsoft.powershell
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote
                Management Users AccessAllowed

Name          : microsoft.powershell.workflow
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : microsoft.powershell32
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote
                Management Users AccessAllowed

Name          : PowerShell.6
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : PowerShell.6.2.2
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
```

```powershell
powershell.exe -command 'Disable-PSRemoting -Force'
powershell.exe -command 'Get-PSSessionConfiguration'
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting or
Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to members of the
Administrators group on the computer.

Name          : microsoft.powershell
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : microsoft.powershell.workflow
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management
                Users AccessAllowed

Name          : microsoft.powershell32
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : PowerShell.6
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed

Name          : PowerShell.6.2.2
PSVersion     : 6.2
StartupScript :
RunAsUser     :
Permission    : NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators
                AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
```

To disable these endpoint configurations, the `Disable-PSRemoting` command must be run from within a
Windows PowerShell session. Now, `Get-PSSessionConfiguration` run from within Windows PowerShell
shows that all endpoint configurations are disabled.

### Example 7: Prevent remote access to session configurations that have custom security descriptors

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
Name               Permission
----               ----------
PowerShell.6       NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed,
                   BUILTIN\Remote Management Users AccessAllowed
PowerShell.6.2.0   NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed,
                   BUILTIN\Remote Management Users AccessAllowed
Test               NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed,
                   User01 AccessAllowed

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

Name               Permission
----               ----------
PowerShell.6       NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed,
                   BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
PowerShell.6.2.0   NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed,
                   BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
Test               NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed,
                   BUILTIN\Administrators AccessAllowed, User01 AccessAllowed

New-PSSession : [localhost] Connecting to remote server localhost failed with the following error message
 : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:1
+ New-PSSession -ComputerName localhost -ConfigurationName Test
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (System.Management.A\u2026tion.RemoteRunspace:RemoteRunspace)
 [New-PSSession], PSRemotingTransportException
+ FullyQualifiedErrorId : AccessDenied,PSSessionOpenFailed
```

Now the `Get-PSSessionConfiguration` and `Format-Table` cmdlets shows that an **AccessDenied**
security descriptor for all network users is added to all session configurations, including the
**Test** session configuration. Although the other security descriptors are not changed, the
"network_deny_all" security descriptor takes precedence. This is illustrated by the attempt to use
`New-PSSession` to connect to the **Test** session configuration.

### Example 8: Re-enable remote access to selected session configurations

This example shows how to re-enable remote access only to selected session configurations. After
disabling all session configurations, we re-enable a specific session.

The `Set-PSSessionConfiguration` cmdlet is used to change the **PowerShell.6** session
configuration. The **AccessMode** parameter with a value of **Remote** re-enables remote access to
the configuration.

```powershell
Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Set-PSSessionConfiguration -Name PowerShell.6 -AccessMode Remote -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting
 or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
       members of the Administrators group on the computer.

Name                 Permission
----                 ----------
PowerShell.6         NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...
PowerShell.6.2.0     NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...

Name                 Permission
----                 ----------
PowerShell.6         NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\ ...
PowerShell.6.2.0     NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...
```

## PARAMETERS

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

You cannot pipe any objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

This cmdlet is only available on Windows platforms.

- Disabling the session configurations does not undo all the changes that were made by the
  `Enable-PSRemoting` or `Enable-PSSessionConfiguration` cmdlets. You might have to undo the
  following changes manually.

  1. Stop and disable the WinRM service.
  2. Delete the listener that accepts requests on any IP address.
  3. Disable the firewall exceptions for WS-Management communications.
  4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
     members of the Administrators group on the computer.

- A session endpoint configuration is a group of settings that define the environment for a session.
  Every session that connects to the computer must use one of the session endpoint configurations
  that are registered on the computer. By denying remote access to all session endpoint
  configurations, you effectively prevent remote users from establishing sessions that connect to
  the computer.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSRemoting](Enable-PSRemoting.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSession](New-PSSession.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)
