---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289620
schema: 2.0.0
---

# Unregister-PSSessionConfiguration
## SYNOPSIS
Deletes registered session configurations from the computer.

## SYNTAX

```
Unregister-PSSessionConfiguration [-Name] <String> [-Force] [-NoServiceRestart] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Unregister-PSSessionConfiguration cmdlet deletes registered session configurations from the computer.
This is an advanced cmdlet that is designed for system administrators to manage customized session configurations for users.

To make the change effective, Unregister-PSSessionConfiguration restarts the WinRM service.
To prevent the restart, specify the NoServiceRestart parameter.

If you accidentally delete the default Microsoft.PowerShell or Microsoft.PowerShell32 session configurations, use the Enable-PSRemoting cmdlet to restore them.
For more information, see about_Session_Configurations.

## EXAMPLES

### Example 1: Delete a session configuration
```
PS C:\>Unregister-PSSessionConfiguration -Name "MaintenanceShell"
```

This command deletes the MaintenanceShell session configuration from the computer.

### Example 2: Delete a session configuration and restart the WinRM service
```
PS C:\>Unregister-PSSessionConfiguration -Name MaintenanceShell -Force
```

This command deletes the MaintenanceShell session configuration from the computer.
The command specifies the Force parameter to suppress all user messages, and to restart the WinRM service without prompting.

### Example 3: Delete all session configurations
```
PS C:\>Unregister-PSSessionConfiguration -Name *
PS C:\> Get-PSSessionConfiguration -Name * | Unregister-PSSessionConfiguration
```

These commands delete all of the session configurations on the computer.
The commands have the same effect and can be used interchangeably.

### Example 4: Unregister without a restart
```
PS C:\>Unregister-PSSessionConfiguration -Name "MaintenanceShell" -NoServiceRestart
PS C:\> Get-PSSessionConfiguration -Name "MaintenanceShell"

Get-PSSessionConfiguration -Name MaintenanceShell : No Session Configuration matches criteria "MaintenanceShell".
+ CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
+ FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException

PS C:\> New-PSSession -ConfigurationName "MaintenanceShell"

Id Name      ComputerName    State    Configuration         Availability
-- ----      ------------    -----    -------------         ------------
1 Session1  localhost       Opened   MaintenanceShell      Available

PS C:\> Restart-Service winrm
PS C:\> New-PSSession -ConfigurationName MaintenanceShell

[localhost] Connecting to remote server failed with the following error message : The WS-Management service cannot process the request. The resource URI (http://schemas.microsoft.com/powershell/MaintenanceShell) was not found in the WS-Management catalog. The catalog contains the metadata that describes resources, or logical endpoints. For more information, see the about_Remote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of using the NoServiceRestart parameter of Unregister-PSSessionConfiguration.
This parameter is designed to prevent a service restart, which would disrupt any sessions on the computer.

The first command uses Unregister-PSSessionConfiguration to deletes the MaintenanceShell session configuration.
However, because the command uses the NoServiceRestart parameter, the WinRM service is not restarted and the change is not yet completely effective.

The second command uses Get-PSSessionConfiguration to get the MaintenanceShell session.
Because the session has been removed from the WS-Management resource table, Get-PSSessionConfiguration cannot return it.

The third command uses the New-PSSession cmdlet to create a session on the local computer that uses the MaintenanceShell configuration.
The command succeeds.

The fourth command uses the Restart-Service cmdlet to restart the WinRM service.

The fifth command again uses the New-PSSession cmdlet to create a session that uses the MaintenanceShell configuration.
This time, the session fails because the MaintenanceShell configuration has been deleted.

## PARAMETERS

### -Force
Indicates that the cmdlet does not prompt you for confirmation, and restarts the WinRM service without prompting.
Restarting the service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, use the NoServiceRestart parameter.

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
Specifies the names of the session configurations to delete.
Enter one session configuration name or a configuration name pattern.
Wildcard characters are permitted.
This parameter is required.

You can also pipe a session configurations to Unregister-PSSessionConfiguration.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoServiceRestart
Indicates that this cmdlet does not restart the WinRM service, and suppresses the prompt to restart the service.

By default, when you run an Unregister-PSSessionConfiguration command, you are prompted to restart the WinRM service to make the change effective.
Until the WinRM service is restarted, users can still use the unregistered session configuration, even though Get-PSSessionConfiguration does not find it.

To restart the WinRM service without prompting, specify the Force parameter.
To restart the WinRM service manually, use the Restart-Service cmdlet.

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

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration
You can pipe a session configuration object from Get-PSSessionConfiguration to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any objects.

## NOTES
To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of the Windows operating system, you must start Windows PowerShell by using the Run as administrator option.

## RELATED LINKS

[Disable-PSSessionConfiguration](63ca7455-b2bc-42ba-b127-d0f1c0babc6a)

[Enable-PSSessionConfiguration](58d537b4-8735-437d-a573-aa5744725b4a)

[Get-PSSessionConfiguration](a71f9e56-0de4-4ffc-a40d-7c3c38cea22a)

[New-PSSessionConfigurationFile](5f3e3633-6e90-479c-aea9-ba45a1954866)

[Register-PSSessionConfiguration](e9152ae2-bd6d-4056-9bc7-dc1893aa29ea)

[Set-PSSessionConfiguration](b21fbad3-1759-4260-b206-dcb8431cd6ea)

[Test-PSSessionConfigurationFile](5f4a016a-f962-4cb5-9fa9-53b173b70056)

[WSMan Provider](4c3d8d36-4f7a-4211-996f-64110e4b2eb7)

[about_Session_Configurations](d7c44f7f-a63b-4aeb-9081-1b64585b1259)

[about_Session_Configuration_Files](c7217447-1ebf-477b-a8ef-4dbe9a1473b8)

