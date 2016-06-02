---
external help file: PSITPro3_Core.xml
schema: 2.0.0
---

# Disable-PSSessionConfiguration
## SYNOPSIS
Disables session configurations on the local computer.

## SYNTAX

```
Disable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Disable-PSSessionConfiguration cmdlet disables session configurations on the local computer, thereby preventing all users from using the session configurations to create a user-managed sessions \("PSSessions"\) on the local computer.
This is an advanced cmdlet that is designed to be used by system administrators to manage customized session configurations for their users.

Beginning in Windows PowerShell 3.0, the Disable-PSSessionConfiguration cmdlet sets the Enabled setting of the session configuration \(WSMan:\localhost\Plugins\\\<SessionConfiguration\>\Enabled\) to "False".

In Windows PowerShell 2.0, the Disable-PSSessionConfiguration cmdlet adds a "Deny_All" entry to the security descriptor of one or more registered session configurations.

Without parameters, Disable-PSSessionConfiguration disables the Microsoft.PowerShell configuration, which is the default configuration that is used for sessions.
Unless the user specifies a different configuration, both local and remote users are effectively prevented from creating any sessions that connect to the computer.

To disable all session configurations on the computer, use Disable-PSRemoting.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Disable-PSSessionConfiguration
```

This command disables the Microsoft.PowerShell session configuration.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Disable-PSSessionConfiguration -Name *
```

This command disables all registered session configurations on the computer.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Disable-PSSessionConfiguration -Name Microsoft* -Force
```

This command disables all session configurations that have names that begin with "Microsoft".
The command uses the Force parameter to suppress all user prompts from the command.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Get-PSSessionConfiguration -Name MaintenanceShell, AdminShell | Disable-PSSessionConfiguration
```

This command disables the MaintenanceShell and AdminShell session configurations.

The command uses a pipeline operator \(|\) to send the results of a Get-PSSessionConfiguration command to Disable-PSSessionConfiguration.

### -------------------------- EXAMPLE 5 --------------------------
```
The first command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display only the Name and Permission properties of the session configuration objects. This table format makes it easier to see the values of the objects. The results show that members of the Administrators group are permitted to use the session configurations.
PS C:\>Get-PSSessionConfiguration | format-table -property Name, Permission -auto

Name                   Permission
----                   ----------
MaintenanceShell       BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The second command uses the Disable-PSSessionConfiguration cmdlet to disable the MaintenanceShell session configuration. The command uses the Force parameter to suppress all user prompts.
PS C:\>Disable-PSSessionConfiguration -name MaintenanceShell -force

The third command repeats the first command. The results show that you can still get the object that represents the MaintenanceShell session configuration even though everyone is denied access to it. The "AccessDenied" entry takes precedence over all other entries in the security descriptor.
PS C:\>Get-PSSessionConfiguration | format-table -property Name, Permission -auto

Name                   Permission
----                   ----------
MaintenanceShell       Everyone AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The fourth command uses the Set-PSSessionConfiguration cmdlet to increase the MaximumDataSizePerCommandMB setting on the MaintenanceShell session configuration to 60. The results show that the command was successful even though everyone is denied access to the configuration.
PS C:\>Set-PSSessionConfiguration -name MaintenanceShell -MaximumReceivedDataSizePerCommandMB 60

ParamName            ParamValue
---------            ----------
psmaximumreceived... 60
"Restart WinRM service"
WinRM service need to be restarted to make the changes effective. Do you want to run the command "restart-service winrm"?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y


The fifth command attempts to use the MaintenanceShell session configuration in a session. It uses the New-PSSession cmdlet to create a new session and the ConfigurationName parameter to specify the MaintenanceShell configuration.The results show that the  New-PSSession command fails because the user is denied access to the configuration. 
PS C:\>new-pssession -computername localhost -configurationName MaintenanceShell
[localhost] Connecting to remote server failed with the following error message : Access is denied. For more information, see the about_Remote_Troubl
eshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of disabling a session configuration.

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
Accept pipeline input: false
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
Position: 1
Default value: Microsoft.PowerShell
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: True
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration, System.String
You can pipe a session configuration object or a string that contains the name of a session configuration to Disable-PSSessionConfiguration.

## OUTPUTS

### None
This cmdlet does not return any objects.

## NOTES
To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of Windows, you must start Windows PowerShell with the "Run as administrator" option.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=144299)

[Disable-PSSessionConfiguration](63ca7455-b2bc-42ba-b127-d0f1c0babc6a)

[Enable-PSSessionConfiguration](58d537b4-8735-437d-a573-aa5744725b4a)

[Get-PSSessionConfiguration](a71f9e56-0de4-4ffc-a40d-7c3c38cea22a)

[New-PSSessionConfigurationFile](5f3e3633-6e90-479c-aea9-ba45a1954866)

[New-PSSessionConfigurationOption](00000000-0000-0000-0000-000000000000)

[Register-PSSessionConfiguration](e9152ae2-bd6d-4056-9bc7-dc1893aa29ea)

[Set-PSSessionConfiguration](b21fbad3-1759-4260-b206-dcb8431cd6ea)

[Test-PSSessionConfigurationFile](5f4a016a-f962-4cb5-9fa9-53b173b70056)

[Unregister-PSSessionConfiguration](f8d6efd7-be65-42ea-9ed5-02453f5201c4)

[WSMan Provider](00000000-0000-0000-0000-000000000000)

[about_Session_Configurations](d7c44f7f-a63b-4aeb-9081-1b64585b1259)

[about_Session_Configuration_Files](c7217447-1ebf-477b-a8ef-4dbe9a1473b8)


