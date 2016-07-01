---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289574
schema: 2.0.0
---

# Disable-PSSessionConfiguration
## SYNOPSIS
Disables session configurations on the local computer.

## SYNTAX

```
Disable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-NoServiceRestart] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Disable-PSSessionConfiguration cmdlet disables session configurations on the local computer, which prevents all users from using the session configurations to create a user-managed sessions (PSSessions) on the local computer.
This is an advanced cmdlet that is designed to be used by system administrators to manage customized session configurations for their users.

Starting in Windows PowerShell 3.0, the Disable-PSSessionConfiguration cmdlet sets the Enabled setting of the session configuration (WSMan:\localhost\Plugins\\\<SessionConfiguration\>\Enabled) to False.

In Windows PowerShell 2.0, the Disable-PSSessionConfiguration cmdlet adds a Deny_All entry to the security descriptor of one or more registered session configurations.

Without parameters, Disable-PSSessionConfiguration disables the Microsoft.PowerShell configuration, which is the default configuration that is used for sessions.
Unless the user specifies a different configuration, both local and remote users are effectively prevented from creating any sessions that connect to the computer.

To disable all session configurations on the computer, use Disable-PSRemoting.

## EXAMPLES

### Example 1: Disable the default configuration
```
PS C:\>Disable-PSSessionConfiguration
```

This command disables the Microsoft.PowerShell session configuration.

### Example 2: Disable all registered session configurations
```
PS C:\>Disable-PSSessionConfiguration -Name *
```

This command disables all registered session configurations on the computer.

### Example 3: Disable session configurations by name
```
PS C:\>Disable-PSSessionConfiguration -Name Microsoft* -Force
```

This command disables all session configurations that have names that begin with Microsoft.
The command uses the Force parameter to suppress all user prompts from the command.

### Example 4: Disable session configurations by using the pipeline
```
PS C:\>Get-PSSessionConfiguration -Name MaintenanceShell, AdminShell | Disable-PSSessionConfiguration
```

This command disables the MaintenanceShell and AdminShell session configurations.

The command uses a pipeline operator (|) to send the results of a Get-PSSessionConfiguration command to Disable-PSSessionConfiguration.

### Example 5: Effects of disabling a session configuration
```
The first command uses the Get-PSSessionConfiguration and Format-Table cmdlets to display only the Name and Permission properties of the session configuration objects. This table format makes it easier to see the values of the objects. The results show that members of the Administrators group are permitted to use the session configurations.
PS C:\>Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                   Permission
----                   ----------
MaintenanceShell       BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The second command uses the Disable-PSSessionConfiguration cmdlet to disable the MaintenanceShell session configuration. The command uses the Force parameter to suppress all user prompts.
PS C:\>Disable-PSSessionConfiguration -Name MaintenanceShell -Force

The third command repeats the first command. The results show that you can still get the object that represents the MaintenanceShell session configuration even though everyone is denied access to it. The "AccessDenied" entry takes precedence over all other entries in the security descriptor.
PS C:\>Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                   Permission
----                   ----------
MaintenanceShell       Everyone AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed


The fourth command uses the Set-PSSessionConfiguration cmdlet to increase the MaximumDataSizePerCommandMB setting on the MaintenanceShell session configuration to 60. The results show that the command was successful even though everyone is denied access to the configuration.
PS C:\>Set-PSSessionConfiguration -Name MaintenanceShell -MaximumReceivedDataSizePerCommandMB 60

ParamName            ParamValue
---------            ----------
psmaximumreceived... 60
"Restart WinRM service"
WinRM service need to be restarted to make the changes effective. Do you want to run the command "restart-service winrm"?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y


The fifth command attempts to use the MaintenanceShell session configuration in a session. It uses the New-PSSession cmdlet to create a new session and the ConfigurationName parameter to specify the MaintenanceShell configuration.The results show that the New-PSSession command fails because the user is denied access to the configuration. 
PS C:\>New-PSSession -ComputerName localhost -ConfigurationName MaintenanceShell
[localhost] Connecting to remote server failed with the following error message : Access is denied. For more information, see the about_Remote_Troubl
eshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of disabling a session configuration.

## PARAMETERS

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

### -Name
Specifies an array of names of session configurations to disable.
Enter one or more configuration names.
Wildcard characters are permitted.
You can also pipe a string that contains a configuration name or a session configuration object to Disable-PSSessionConfiguration.

If you omit this parameter, Disable-PSSessionConfiguration disables the Microsoft.PowerShell session configuration.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -NoServiceRestart
@{Text=}

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

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration, System.String
You can pipe a session configuration object or a string that contains the name of a session configuration to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any objects.

## NOTES
To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of the Windows operating system, you must start Windows PowerShell by using the Run as administrator option.

## RELATED LINKS

[Enable-PSSessionConfiguration](58d537b4-8735-437d-a573-aa5744725b4a)

[Get-PSSessionConfiguration](a71f9e56-0de4-4ffc-a40d-7c3c38cea22a)

[New-PSSessionConfigurationFile](5f3e3633-6e90-479c-aea9-ba45a1954866)

[Register-PSSessionConfiguration](e9152ae2-bd6d-4056-9bc7-dc1893aa29ea)

[Set-PSSessionConfiguration](b21fbad3-1759-4260-b206-dcb8431cd6ea)

[Test-PSSessionConfigurationFile](5f4a016a-f962-4cb5-9fa9-53b173b70056)

[Unregister-PSSessionConfiguration](f8d6efd7-be65-42ea-9ed5-02453f5201c4)

[WSMan Provider](4c3d8d36-4f7a-4211-996f-64110e4b2eb7)

[about_Session_Configurations](d7c44f7f-a63b-4aeb-9081-1b64585b1259)

[about_Session_Configuration_Files](c7217447-1ebf-477b-a8ef-4dbe9a1473b8)

