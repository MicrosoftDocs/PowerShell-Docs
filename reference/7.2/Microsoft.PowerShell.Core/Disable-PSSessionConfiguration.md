---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/disable-pssessionconfiguration?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-PSSessionConfiguration
---
# Disable-PSSessionConfiguration

## SYNOPSIS
Disables session configurations on the local computer.

## SYNTAX

```
Disable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-NoServiceRestart] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Disable-PSSessionConfiguration` cmdlet disables session configurations on the local computer,
which prevents all users from using the session configurations to create a user-managed sessions
(**PSSessions**) on the local computer. This is an advanced cmdlet that is designed to be used by
system administrators to manage customized session configurations for their users.

Starting in PowerShell 3.0, the `Disable-PSSessionConfiguration` cmdlet sets the **Enabled** setting
of the session configuration (`WSMan:\localhost\Plugins\<SessionConfiguration>\Enabled`) to False.

In PowerShell 2.0, the `Disable-PSSessionConfiguration` cmdlet adds a **Deny_All** entry to the
security descriptor of one or more registered session configurations.

Without parameters, `Disable-PSSessionConfiguration` disables the **Microsoft.PowerShell**
configuration, the default configuration used for sessions. Unless the user specifies a different
configuration, both local and remote users are effectively prevented from creating any sessions that
connect to the computer.

To disable all session configurations on the computer, use `Disable-PSRemoting`.

## EXAMPLES

### Example 1: Disable the default configuration

This example disables the Microsoft.PowerShell session configuration.

```powershell
Disable-PSSessionConfiguration
```

### Example 2: Disable all registered session configurations

This example disables all registered session configurations on the computer.

```powershell
Disable-PSSessionConfiguration -Name *
```

### Example 3: Disable session configurations by name

This example disables all session configurations that have names that begin with Microsoft. The
**Force** parameter suppresses all user prompts from the cmdlet.

```powershell
Disable-PSSessionConfiguration -Name Microsoft* -Force
```

### Example 4: Disable session configurations by using the pipeline

This example disables the **MaintenanceShell** and **AdminShell** session configurations. The
pipeline operator (|) sends the results of a `Get-PSSessionConfiguration` to
`Disable-PSSessionConfiguration`.

```powershell
Get-PSSessionConfiguration -Name MaintenanceShell, AdminShell | Disable-PSSessionConfiguration
```

### Example 5: Effects of disabling a session configuration

This example shows the permissions before and after running `Disable-PSSessionConfiguration` and the
effect of disabling a session configuration.

```
PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                   Permission
----                   ----------
MaintenanceShell       BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed

PS> Disable-PSSessionConfiguration -Name MaintenanceShell -Force
PS> Get-PSSessionConfiguration | Format-Table -Property Name, Permission -Auto

Name                   Permission
----                   ----------
MaintenanceShell       Everyone AccessDenied, BUILTIN\Administrators AccessAllowed
microsoft.powershell   BUILTIN\Administrators AccessAllowed
microsoft.powershell32 BUILTIN\Administrators AccessAllowed

PS> New-PSSession -ComputerName localhost -ConfigurationName MaintenanceShell

[localhost] Connecting to remote server failed with the following error message : Access is denied.
For more information, see the about_Remote_Troubleshooting Help topic.
+ CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

> [!NOTE]
> Disabling the configuration does not prevent you from changing the configuration using the
> `Set-PSSessionConfiguration` cmdlet. It only prevents use of the configuration.

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

### -Name

Specifies an array of names of session configurations to disable. Enter one or more configuration
names. Wildcard characters are permitted. You can also pipe a string that contains a configuration
name or a session configuration object to `Disable-PSSessionConfiguration`.

If you omit this parameter, `Disable-PSSessionConfiguration` disables the Microsoft.PowerShell
session configuration.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -NoServiceRestart

Used to prevent the restart of the WSMan service. It is not necessary to restart the service to
disable the configuration.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration, System.String

You can pipe a session configuration object or a string that contains the name of a session
configuration to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any objects.

## NOTES

This cmdlet is only available on Windows platforms.

To run this cmdlet you must start PowerShell by using the **Run as administrator** option.

## RELATED LINKS

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSessionConfigurationFile](New-PSSessionConfigurationFile.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)
