---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 03/26/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/enable-pssessionconfiguration?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Enable-PSSessionConfiguration
---
# Enable-PSSessionConfiguration

## SYNOPSIS
Enables the session configurations on the local computer.

## SYNTAX

```
Enable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-SecurityDescriptorSddl <String>]
 [-SkipNetworkProfileCheck] [-NoServiceRestart] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Enable-PSSessionConfiguration` cmdlet enables registered session configurations that have been
disabled, such as by using the `Disable-PSSessionConfiguration` or `Disable-PSRemoting` cmdlets, or
the **AccessMode** parameter of `Register-PSSessionConfiguration`. This is an advanced cmdlet that
is designed to be used by system administrators to manage customized session configurations for
their users.

Without parameters, `Enable-PSSessionConfiguration` enables the **Microsoft.PowerShell**
configuration, which is the default configuration that is used for sessions.

`Enable-PSSessionConfiguration` removes the **Deny_All** setting from the security descriptor of the
affected session configurations, turns on the listener that accepts requests on any IP address, and
restarts the WinRM service. Beginning in PowerShell 3.0, `Enable-PSSessionConfiguration`
also sets the value of the **Enabled** property of the session configuration
(`WSMan:\<computer>\PlugIn\<SessionConfigurationName>\Enabled`) to True. However,
`Enable-PSSessionConfiguration` does not remove or change the **Network_Deny_All**
(`AccessMode=Local`) security descriptor setting that allows only users of the local computer to use
to the session configuration.

## EXAMPLES

### Example 1: Re-enable the default session

This example re-enables the **Microsoft.PowerShell** default session configuration on the computer.

```powershell
Enable-PSSessionConfiguration
```

### Example 2: Re-enable specified sessions

This example re-enables the **MaintenanceShell** and **AdminShell** session configurations on the
computer.

```powershell
Enable-PSSessionConfiguration -Name MaintenanceShell, AdminShell
```

### Example 3: Re-enable the all sessions

This example re-enables all session configurations on the computer. These commands are equivalent.
Therefore, you can use either.

```powershell
Enable-PSSessionConfiguration -Name *
Get-PSSessionConfiguration | Enable-PSSessionConfiguration
```

`Enable-PSSessionConfiguration` does not generate an error if you enable a session configuration
that is already enabled.

### Example 4: Re-enable a session and specify a new security descriptor

This example re-enables the **MaintenanceShell** session configuration and specifies a new security
descriptor for the configuration.

```powershell
$sddl = "O:NSG:BAD:P(A;;GXGWGR;;;BA)(A;;GAGR;;;S-1-5-21-123456789-188441444-3100496)S:P"
Enable-PSSessionConfiguration -Name MaintenanceShell -SecurityDescriptorSDDL $sddl
```

## PARAMETERS

### -Force

Indicates that the cmdlet does not prompt you for confirmation, and restarts the WinRM service
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

Specifies the names of session configurations to enable. Enter one or more configuration names.
Wildcard characters are permitted.

You can also pipe a string that contains a configuration name or a session configuration object to
`Enable-PSSessionConfiguration`.

If you omit this parameter, `Enable-PSSessionConfiguration` enables the **Microsoft.PowerShell**
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

Indicates that the cmdlet does not restart the service.

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

### -SecurityDescriptorSddl

Specifies a security descriptor with which this cmdlet replaces the security descriptor on the
session configuration.

If you omit this parameter, `Enable-PSSessionConfiguration` only deletes the deny all item from the
security descriptor.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipNetworkProfileCheck

Indicates that this cmdlet enables the session configuration when the computer is on a public
network. This parameter enables a firewall rule for public networks that allows remote access only
from computers in the same local subnet. By default, `Enable-PSSessionConfiguration` fails on a
public network.

This parameter is designed for client versions of the Windows operating system. Server versions of
the Windows operating system have a local subnet firewall rule for public networks. However, if the
local subnet firewall rule is disabled on a server version of the Windows operating system, this
parameter re-enables it.

To remove the local subnet restriction and enable remote access from all locations on public
networks, use the `Set-NetFirewallRule` cmdlet in the NetSecurity module. For more information, see
`Enable-PSRemoting`.

This parameter was introduced in PowerShell 3.0.

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

To use this cmdlet, you must start PowerShell by using the **Run as administrator** option.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

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
