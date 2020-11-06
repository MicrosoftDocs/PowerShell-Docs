---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/unregister-pssessionconfiguration?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Unregister-PSSessionConfiguration
---
# Unregister-PSSessionConfiguration

## SYNOPSIS
Deletes registered session configurations from the computer.

## SYNTAX

```
Unregister-PSSessionConfiguration [-Name] <String> [-Force] [-NoServiceRestart] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Unregister-PSSessionConfiguration` cmdlet deletes registered session configurations from the
computer. This cmdlet is designed for system administrators to manage customized session
configurations for users.

To make the change effective, `Unregister-PSSessionConfiguration` restarts the **WinRM** service. To
prevent the restart, specify the **NoServiceRestart** parameter.

If you accidentally delete the default **Microsoft.PowerShell** or **Microsoft.PowerShell32**
session configurations, use the `Enable-PSRemoting` cmdlet to restore them. For more information,
see [about_Session_Configurations](About/about_Session_Configurations.md).

## EXAMPLES

### Example 1: Delete a session configuration

This example deletes the **MaintenanceShell** session configuration from the computer.

```powershell
Unregister-PSSessionConfiguration -Name "MaintenanceShell"
```

### Example 2: Delete a session configuration and restart the WinRM service

In this example, we delete the **MaintenanceShell** configuration and restart the WinRM service. The
**Force** parameter suppresses all user messages to restart the **WinRM** service without prompting.

```powershell
Unregister-PSSessionConfiguration -Name MaintenanceShell -Force
```

### Example 3: Delete all session configurations

This examples show two ways to delete all the session configurations on the computer. Both
commands have the same effect and can be used interchangeably.

```
Unregister-PSSessionConfiguration -Name *
Get-PSSessionConfiguration -Name * | Unregister-PSSessionConfiguration
```

### Example 4: Unregister without a restart

This example shows the effect of using the **NoServiceRestart** parameter to prevent a service
restart that would disrupt any sessions on the computer.

```
PS> Unregister-PSSessionConfiguration -Name "MaintenanceShell" -NoServiceRestart
PS> Get-PSSessionConfiguration -Name "MaintenanceShell"

Get-PSSessionConfiguration -Name MaintenanceShell : No Session Configuration matches criteria "MaintenanceShell".
+ CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
+ FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException

PS> New-PSSession -ConfigurationName "MaintenanceShell"

Id Name      ComputerName    State    Configuration         Availability
-- ----      ------------    -----    -------------         ------------
1 Session1  localhost       Opened   MaintenanceShell      Available

PS> Restart-Service winrm
PS> New-PSSession -ConfigurationName MaintenanceShell

[localhost] Connecting to remote server failed with the following error message :
 The WS-Management service cannot process the request.
 The resource URI (http://schemas.microsoft.com/powershell/MaintenanceShell) was not found in the WS-Management catalog.
 The catalog contains the metadata that describes resources, or logical endpoints.
 For more information, see the about_Remote_Troubleshooting Help topic.
 + CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
 + FullyQualifiedErrorId : PSSessionOpenFailed
```

The `Unregister-PSSessionConfiguration` deletes the **MaintenanceShell** session configuration.
However, because the command uses the **NoServiceRestart** parameter, the **WinRM** service is not
restarted and the change is not yet completely effective.

Next, the `Get-PSSessionConfiguration` tries to get the **MaintenanceShell** session. Because
the session has been removed from the WS-Management resource table, `Get-PSSessionConfiguration`
cannot return it.

The `New-PSSession` cmdlet creates a session using the **MaintenanceShell** configuration. The
command succeeds. Next, we restart the **WinRM** service.

Finally, the `New-PSSession` cmdlet tries to create a session that uses the **MaintenanceShell**
configuration. This time, the session fails because the **MaintenanceShell** configuration was
deleted when the WinRM service restarted.

## PARAMETERS

### -Force

Indicates that the cmdlet does not prompt you for confirmation, and restarts the **WinRM** service
without prompting. Restarting the service makes the configuration change effective.

To prevent a restart and suppress the restart prompt, use the **NoServiceRestart** parameter.

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

### -Name

Specifies the names of the session configurations to delete. Enter one session configuration name or
a configuration name pattern. Wildcard characters are permitted. This parameter is required.

You can also pipe a session configurations to `Unregister-PSSessionConfiguration`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -NoServiceRestart

Indicates that this cmdlet does not restart the **WinRM** service, and suppresses the prompt to
restart the service.

By default, when you run an `Unregister-PSSessionConfiguration` command, you are prompted to restart
the **WinRM** service to make the change effective. Until the **WinRM** service is restarted, users
can still use the unregistered session configuration, even though `Get-PSSessionConfiguration` does
not find it.

To restart the **WinRM** service without prompting, specify the **Force** parameter. To restart the
**WinRM** service manually, use the `Restart-Service` cmdlet.

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration

You can pipe a session configuration object from `Get-PSSessionConfiguration` to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any objects.

## NOTES

This cmdlet is only available on Windows platforms.

To run this cmdlet you must start PowerShell by using the **Run as administrator** option.

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

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)
