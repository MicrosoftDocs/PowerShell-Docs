---
external help file: PSITPro3_Core.xml
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
This is an advanced cmdlet that is designed to be used by system administrators to manage customized session configurations for their users.

To make the change effective, Unregister-PSSessionConfiguration restarts the WinRM service.
To prevent the restart, use the NoServiceRestart parameter.

If you accidentally delete the default Microsoft.PowerShell or Microsoft.PowerShell32 session configurations, use the Enable-PSRemoting function to restore them.
For more information, see about_Session_Configurations.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>unregister-pssessionconfiguration -name MaintenanceShell
```

This command deletes the MaintenanceShell session configuration from the computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>unregister-pssessionconfiguration -name MaintenanceShell -force
```

This command deletes the MaintenanceShell session configuration from the computer.
The command uses the Force parameter to suppress all user messages and to restart the WinRM service without prompting.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>unregister-pssessionconfiguration -name *
PS C:\>get-pssessionconfiguration -name * | unregister-pssessionconfiguration
```

These commands delete all of the session configurations on the computer.
The commands have the same effect and can be used interchangeably.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>unregister-pssessionconfiguration -name maintenanceShell -noServiceRestart
PS C:\>get-pssessionconfiguration -name maintenanceShell

Get-PSSessionConfiguration -name maintenanceShell : No Session Configuration matches criteria "maintenanceShell".
+ CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
+ FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException

PS C:\>new-pssession -configurationName MaintenanceShell

Id Name      ComputerName    State    Configuration         Availability
-- ----      ------------    -----    -------------         ------------
1 Session1  localhost       Opened   MaintenanceShell      Available

PS C:\>restart-service winrm
PS C:\>new-pssession -configurationName MaintenanceShell

[localhost] Connecting to remote server failed with the following error message : The WS-Management service cannot process the request. The resource URI (http://schemas.microsoft.com/powershell/MaintenanceShell) was not found in the WS-Management catalog. The catalog contains the metadata that describes resources, or logical endpoints. For more information, see the about_Remote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

This example shows the effect of using the NoServiceRestart parameter of Unregister-PSSessionConfiguration.
This parameter is designed to prevent a service restart, which would disrupt any sessions on the computer.

The first command uses the Unregister-PSSessionConfiguration cmdlet to deletes the MaintenanceShell session configuration.
However, because the command uses the NoServiceRestart parameter, the WinRM service is not restarted and the change is not yet completely effective.

The second command uses the Get-PSSessionConfiguration cmdlet to get the MaintenanceShell session.
Because the session has been removed from the WS-Management resource table, Get-PSSession cannot return it.

The third command uses the New-PSSession cmdlet to create a session on the local computer that uses the MaintenanceShell configuration.
The command succeeds.

The fourth command uses the Restart-Service cmdlet to restart the WinRM service.

The fifth command again uses the New-PSSession cmdlet to create a session that uses the MaintenanceShell configuration.
This time, the session fails because the MaintenanceShell configuration has been deleted.

## PARAMETERS

### -Force
Suppresses all user prompts, and restarts the WinRM service without prompting.
Restarting the service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, use the NoServiceRestart parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -Name
Specifies the names of the session configurations to delete.
Enter one session configuration name or a configuration name pattern.
Wildcards are permitted.
This parameter is required.

You can also pipe a session configurations to Unregister-PSSessionConfiguration.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: True
```

### -NoServiceRestart
Does not restart the WinRM service, and suppresses the prompt to restart the service.

By default, when you enter an Unregister-PSSessionConfiguration command, you are prompted to restart the WinRM service to make the change effective. 
Until the WinRM service is restarted, users can still use the unregistered session configuration, even though Get-PSSessionConfiguration does not find it.

To restart the WinRM service without prompting, use the Force parameter.
To restart the WinRM service manually, use the Restart-Service cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
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

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration
You can pipe a session configuration object from Get-PSSessionConfiguration to Unregister-PSSessionConfiguration.

## OUTPUTS

### None
This cmdlet does not return any objects.

## NOTES
To run this cmdlet on Windows Vista, Windows Server 2008, and later versions of Windows, you must start Windows PowerShell with the "Run as administrator" option.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=144308)

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


