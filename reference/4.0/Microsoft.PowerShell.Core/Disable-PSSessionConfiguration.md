---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289574
external help file:  System.Management.Automation.dll-Help.xml
title:  Disable-PSSessionConfiguration
---

# Disable-PSSessionConfiguration

## SYNOPSIS
Disables session configurations on the local computer.

## SYNTAX

```
Disable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Disable-PSSessionConfiguration** cmdlet disables session configurations on the local computer, thereby preventing all users from using the session configurations to create a user-managed sessions ("PSSessions") on the local computer.
This is an advanced cmdlet that is designed to be used by system administrators to manage customized session configurations for their users.

Beginning in Windows PowerShell 3.0, the **Disable-PSSessionConfiguration** cmdlet sets the **Enabled** setting of the session configuration (WSMan:\localhost\Plugins\\\<SessionConfiguration\>\Enabled) to "False".

In Windows PowerShell 2.0, the **Disable-PSSessionConfiguration** cmdlet adds a "Deny_All" entry to the security descriptor of one or more registered session configurations.

Without parameters, **Disable-PSSessionConfiguration** disables the Microsoft.PowerShell configuration, which is the default configuration that is used for sessions.
Unless the user specifies a different configuration, both local and remote users are effectively prevented from creating any sessions that connect to the computer.

To disable all session configurations on the computer, use Disable-PSRemoting.

## EXAMPLES

### Example 1
```
PS C:\> Disable-PSSessionConfiguration
```

This command disables the Microsoft.PowerShell session configuration.

### Example 2
```
PS C:\> Disable-PSSessionConfiguration -Name *
```

This command disables all registered session configurations on the computer.

### Example 3
```
PS C:\> Disable-PSSessionConfiguration -Name Microsoft* -Force
```

This command disables all session configurations that have names that begin with "Microsoft".
The command uses the **Force** parameter to suppress all user prompts from the command.

### Example 4
```
PS C:\> Get-PSSessionConfiguration -Name MaintenanceShell, AdminShell | Disable-PSSessionConfiguration
```

This command disables the MaintenanceShell and AdminShell session configurations.

The command uses a pipeline operator (|) to send the results of a Get-PSSessionConfiguration command to Disable-PSSessionConfiguration.

### Example 5
```
The first command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display only the **Name** and **Permission** properties of the session configuration objects. This table format makes it easier to see the values of the objects. The results show that members of the Administrators group are permitted to use the session configurations.
PS C:\> Get-PSSessionConfiguration | format-table -property Name, Permission -auto

Name                   Permission
----                   ----------
MaintenanceShell       BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The second command uses the **Disable-PSSessionConfiguration** cmdlet to disable the MaintenanceShell session configuration. The command uses the **Force** parameter to suppress all user prompts.
PS C:\> Disable-PSSessionConfiguration -name MaintenanceShell -force

The third command repeats the first command. The results show that you can still get the object that represents the MaintenanceShell session configuration even though everyone is denied access to it. The "AccessDenied" entry takes precedence over all other entries in the security descriptor.
PS C:\> Get-PSSessionConfiguration | format-table -property Name, Permission -auto

Name                   Permission
----                   ----------
MaintenanceShell       Everyone AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The fourth command uses the Set-PSSessionConfiguration cmdlet to increase the MaximumDataSizePerCommandMB setting on the MaintenanceShell session configuration to 60. The results show that the command was successful even though everyone is denied access to the configuration.
PS C:\> Set-PSSessionConfiguration -name MaintenanceShell -MaximumReceivedDataSizePerCommandMB 60

ParamName            ParamValue
---------            ----------
psmaximumreceived... 60
"Restart WinRM service"
WinRM service need to be restarted to make the changes effective. Do you want to run the command "restart-service winrm"?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y


The fifth command attempts to use the MaintenanceShell session configuration in a session. It uses the New-PSSession cmdlet to create a new session and the ConfigurationName parameter to specify the MaintenanceShell configuration.The results show that the  **New-PSSession** command fails because the user is denied access to the configuration. 
PS C:\> new-pssession -computername localhost -configurationName MaintenanceShell
[localhost] Connecting to remote server failed with the following error message : Access is denied. For more information, see the about_Remote_Troubl
eshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of disabling a session configuration.

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

### -Name
Specifies the names of session configurations to disable.
Enter one or more configuration names.
Wildcards are permitted.
You can also pipe a string that contains a configuration name or a session configuration object to Disable-PSSessionConfiguration.

If you omit this parameter, Disable-PSSessionConfiguration disables the Microsoft.PowerShell session configuration.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: Microsoft.PowerShell
Accept pipeline input: True (ByPropertyName, ByValue)
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

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration, System.String
You can pipe a session configuration object or a string that contains the name of a session configuration to Disable-PSSessionConfiguration.

## OUTPUTS

### None
This cmdlet does not return any objects.

## NOTES
* To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of Windows, you must start Windows PowerShell with the "Run as administrator" option.

*

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[New-PSSessionOption](New-PSSessionOption.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../microsoft.wsman.management/provider/wsman-provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)

