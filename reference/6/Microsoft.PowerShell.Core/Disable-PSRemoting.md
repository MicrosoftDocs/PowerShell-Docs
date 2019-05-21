---
ms.date:  3/22/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821472
external help file:  System.Management.Automation.dll-Help.xml
title:  Disable-PSRemoting
---
# Disable-PSRemoting

## SYNOPSIS

Prevents remote users from running commands in PowerShell on the local computer.

## SYNTAX

```
Disable-PSRemoting [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-PSRemoting` cmdlet prevents users on other computers from running PowerShell commands
on the local computer.

`Disable-PSRemoting` blocks remote access to all PowerShell session configurations on the local
computer. This prevents remote users from creating temporary or persistent PowerShell sessions to
the local computer. `Disable-PSRemoting` does not prevent remote users from creating PowerShell sessions to the local computer. To disable both PowerShell and PowerShell session
configurations run `Disable-PSRemoting` in PowerShell on the local computer.
`Disable-PSRemoting` does not prevent users of the local computer from creating sessions
(**PSSessions**) on the local computer or remote computers.

To re-enable remote access to all PowerShell session configurations, use the `Enable-PSRemoting`
cmdlet. To re-enable remote access to all session configurations, including PowerShell
configurations, run `Enable-PSRemoting` in PowerShell on the local computer. To enable
remote access to selected session configurations, use the **AccessMode** parameter of the
`Set-PSSessionConfiguration` cmdlet. You can also use the `Enable-PSSessionConfiguration` and
`Disable-PSSessionConfiguration` cmdlets to enable and disable session configurations for all users.
For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

To run this cmdlet, start PowerShell with the Run as administrator option.

> [!NOTE]
> This command appears only on PowerShell running on the Windows platform. It is not
> available on Linux or MacOS versions.

## EXAMPLES

### Example 1: Prevent remote access to all PowerShell session configurations
```powershell
Disable-PSRemoting
```

This command prevents remote access to all session configurations on the computer.

### Example 2: Prevent remote access to all PowerShell session configurations without confirmation prompt
```powershell
Disable-PSRemoting -Force
```

This command prevents remote access all session configurations on the computer without prompting.

### Example 3: Effects of running this cmdlet
```powershell
Disable-PSRemoting -Force
New-PSSession -ComputerName localhost -ConfigurationName PowerShell.6
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to members of the Administrators group on the computer.

New-PSSession : [localhost] Connecting to remote server localhost failed with the following error message : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:1
+ New-PSSession -ComputerName localhost -ConfigurationName PowerShell.6
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (System.Management.A\u2026tion.RemoteRunspace:RemoteRunspace) [New-PSSession], PSRemotingTransportException
+ FullyQualifiedErrorId : AccessDenied,PSSessionOpenFailed
```

This example shows the effect of using the `Disable-PSRemoting` cmdlet.
To run this command sequence, start PowerShell with the Run as administrator option.

The first command uses the `Disable-PSRemoting` cmdlet to disable all registered session
configurations on the local computer.

The second command uses the `New-PSSession` cmdlet to create a remote session to the local computer
(also known as a "loopback"). Because remote access is disabled on the local machine, the command
fails.

### Example 4: Effects of running this cmdlet and Enable-PSRemoting
```powershell
Disable-PSRemoting -force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Enable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto
```

```Output
Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
PowerShell.6.2.0           NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...

Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
PowerShell.6.2.0           NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed ...
```

This example shows the effect on the session configurations of using the `Disable-PSRemoting` and
`Enable-PSRemoting` cmdlets.

The first command uses the `Disable-PSRemoting` cmdlet to disable remote access to all session configurations.
The **Force** parameter suppresses all user prompts.

The second command uses the `Get-PSSessionConfiguration` cmdlet to display the session configurations
on the computer. The command uses a pipeline operator to send the results to a `Format-Table` command,
which displays only the Name and Permission properties of the configurations in a table.

The output shows that only remote users are denied access to the configurations. Members of the
Administrators group on the local computer are allowed to use the session configurations. The output
also shows that the command affects all PowerShell session configurations that includes the
user-created WithProfile session configuration.

The third command uses the `Enable-PSRemoting` cmdlet to re-enable remote access to all session
configurations on the computer. The command uses the **Force** parameter to suppress all user
prompts and to restart the WinRM service without prompting.

The fourth command uses the `Get-PSSessionConfiguration` and `Format-Table` cmdlets to display the
names and permissions of the session configurations. The results show that the **AccessDenied** security
descriptors have been removed from all session configurations.

### Example 5: Prevent remote access to session configurations that have custom security descriptors
```powershell
Register-PSSessionConfiguration -Name Test -FilePath .\TestEndpoint.pssc -ShowSecurityDescriptorUI -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap

Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Wrap
New-PSSession -ComputerName localhost -ConfigurationName Test
```

```Output

Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, ...
PowerShell.6.2.0           NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, ...
Test                       NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, <user> AccessAllowed

WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to members of the Administrators group on the computer.

Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, ...
PowerShell.6.2.0           NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, ...
Test                       NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, ...

New-PSSession : [localhost] Connecting to remote server localhost failed with the following error message : Access is denied. For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:1
+ New-PSSession -ComputerName localhost -ConfigurationName Test
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (System.Management.A\u2026tion.RemoteRunspace:RemoteRunspace) [New-PSSession], PSRemotingTransportException
+ FullyQualifiedErrorId : AccessDenied,PSSessionOpenFailed

```

This example demonstrates that the `Disable-PSRemoting` cmdlet disables remote access to all session
configurations that include session configurations with custom security descriptors.

The first command uses the `Register-PSSessionConfiguration` cmdlet to create the Test session
configuration. The command uses the **FilePath** parameter to specify a session configuration file
that customizes the session and the **ShowSecurityDescriptorUI** parameter to display a dialog box
that sets permissions for the session configuration. In the Permissions dialog box, we create custom
full-access permissions for the indicated user.

The second command uses the `Get-PSSessionConfiguration` and `Format-Table` cmdlets to display the
session configurations and their properties. The output shows that the Test session configuration
allows interactive access and special permissions for the indicated user.

The third command uses the `Disable-PSRemoting` cmdlet to disable remote access to all session
configurations.

The fourth command uses the `Get-PSSessionConfiguration` and `Format-Table` cmdlets to display the
session configurations and their properties. The output shows that an **AccessDenied** security
descriptor for all network users is added to all session configurations that includes the Test
session configuration. Although the other security descriptors are not changed, the
"network_deny_all" security descriptor takes precedence.

The fifth command shows that the `Disable-PSRemoting` command prevents even the user who has special
permissions to the Test session configuration from using the Test session configuration to connect
to the computer remotely.

### Example 6: Re-enable remote access to selected session configurations
```powershell
Disable-PSRemoting -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Set-PSSessionConfiguration -Name PowerShell.6 -AccessMode Remote -Force
Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto
```

```Output
WARNING: Disabling the session configurations does not undo all the changes made by the Enable-PSRemoting or Enable-PSSessionConfiguration cmdlet. You might have to manually undo the changes by following these steps:
    1. Stop and disable the WinRM service.
    2. Delete the listener that accepts requests on any IP address.
    3. Disable the firewall exceptions for WS-Management communications.
    4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to members of the Administrators group on the computer.

Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...
PowerShell.6.2.0           NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...

Name                       Permission
----                       ----------
PowerShell.6               NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\ ...
PowerShell.6.2.0           NT AUTHORITY\NETWORK AccessDenied, NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Adm ...

```

This example shows how to re-enable remote access only to selected session configurations.

The first command uses the `Disable-PSRemoting` cmdlet to disable remote access to all session
configurations.

The second command uses the `Get-PSSessionConfiguration` and `Format-Table` cmdlets to display the
session configurations and their properties. The output shows that an **AccessDenied** security
descriptor for all network users is added to all session configurations.

The third command uses the `Set-PSSessionConfiguration` cmdlet. The command uses the **AccessMode**
parameter with a value of Remote to enable remote access to the PowerShell.6 session configuration.
You can also use the **AccessMode** parameter to enable Local access and to disable session
configurations.

The fourth command uses the `Get-PSSessionConfiguration` and `Format-Table` cmdlets to display the
session configurations and their properties. The output shows that the **AccessDenied** security
descriptor for all network users is removed, thereby restoring remote access to the PowerShell.6
session configuration.

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

### -Force

Forces the command to run without asking for user confirmation.

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

You cannot pipe any objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- Disabling the session configurations does not undo all the changes that were made by the
  `Enable-PSRemoting` or `Enable-PSSessionConfiguration` cmdlets. You might have to undo the
  following changes manually.

  1. Stop and disable the WinRM service.

  2. Delete the listener that accepts requests on any IP address.

  3. Disable the firewall exceptions for WS-Management communications.

  4. Restore the value of the LocalAccountTokenFilterPolicy to 0, which restricts remote access to
     members of the Administrators group on the computer.

- A session configuration is a group of settings that define the environment for a session. Every
  session that connects to the computer must use one of the session configurations that are
  registered on the computer. By denying remote access to all session configurations, you
  effectively prevent remote users from establishing sessions that connect to the computer.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSRemoting](Enable-PSRemoting.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)
