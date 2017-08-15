---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=144301
external help file:  System.Management.Automation.dll-Help.xml
title:  Enable-PSSessionConfiguration
---

# Enable-PSSessionConfiguration
## SYNOPSIS
Enables the session configurations on the local computer.
## SYNTAX

```
Enable-PSSessionConfiguration [[-Name] <String[]>] [-Force] [-SecurityDescriptorSddl <String>]
 [-SkipNetworkProfileCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Enable-PSSessionConfiguration** cmdlet enables registered session configurations that have been disabled, such as by using the Disable-PSSessionConfiguration or Disable-PSRemoting cmdlets, or the **AccessMode** parameter of Register-PSSessionConfiguration.
This is an advanced cmdlet that is designed to be used by system administrators to manage customized session configurations for their users.

Without parameters, **Enable-PSSessionConfiguration** enables the Microsoft.PowerShell configuration, which is the default configuration that is used for sessions.

**Enable-PSSessionConfiguration** removes the "Deny_All" setting from the security descriptor of the affected session configurations, turns on the listener that accepts requests on any IP address, and restarts the WinRM service.
Beginning in Windows PowerShell 3.0, **Enable-PSSessionConfiguration** also sets the value of the **Enabled** property of the session configuration (WSMan:\\\<computer\>\PlugIn\\\<SessionConfigurationName\>\Enabled) to "True".
However,  **Enable-PSSessionConfiguration** does not remove or change the "Network_Deny_All" (AccessMode=Local) security descriptor setting that allows only users of the local computer to use to the session configuration.

The **Enable-PSSessionConfiguration** cmdlet calls the **Set-WSManQuickConfig** cmdlet.
However, it should not be used to enable remoting on the computer.
Instead, use the more comprehensive cmdlet, Enable-PSRemoting.
## EXAMPLES

### Example 1
```
PS C:\> Enable-PSSessionConfiguration
```

This command re-enables the Microsoft.PowerShell default session configuration on the computer.
### Example 2
```
PS C:\> Enable-PSSessionConfiguration -name MaintenanceShell, AdminShell
```

This command re-enables the MaintenanceShell and AdminShell session configurations on the computer.
### Example 3
```
PS C:\> Enable-PSSessionConfiguration -name *
PS C:\> Get-PSSessionConfiguration | Enable-PSSessionConfiguration
```

These commands re-enable all session configurations on the computer.
The commands are equivalent, so you can use either one.

Enable-PSSessionConfiguration does not generate an error if you enable a session configuration that is already enabled.
### Example 4
```
PS C:\> Enable-PSSessionConfiguration -name MaintenanceShell -securityDescriptorSDDL "O:NSG:BAD:P(A;;GXGWGR;;;BA)(A;;GAGR;;;S-1-5-21-123456789-188441444-3100496)S:P"
```

This command re-enables the MaintenanceShell session configuration and specifies a new security descriptor for the configuration.
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the names of session configurations to enable.
Enter one or more configuration names.
Wildcards are permitted.

You can also pipe a string that contains a configuration name or a session configuration object to Enable-PSSessionConfiguration.

If you omit this parameter, Enable-PSSessionConfiguration enables the Microsoft.PowerShell session configuration.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -SecurityDescriptorSddl
Replaces the security descriptor on the session configuration with the specified security descriptor.

If you omit this parameter, Enable-PSSessionConfiguration just deletes the "deny all" item from the security descriptor.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipNetworkProfileCheck
Enables the session configuration when the computer is on a public network.
This parameter enables a firewall rule for public networks that allows remote access only from computers in the same local subnet.
By default, **Enable-PSSessionConfiguration** fails on a public network.

This parameter is designed for client versions of Windows.
Server versions of Windows have a local subnet firewall rule for public networks by default.
However, if the local subnet firewall rule is disabled on a server version of Windows, this parameter re-enables it.

To remove the local subnet restriction and enable remote access from all locations on public networks, use the Set-NetFirewallRule cmdlet in the NetSecurity module.
For more information, see Enable-PSRemoting.

This parameter is introduced in Windows PowerShell 3.0.

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
You can pipe a session configuration object or a string that contains the name of a session configuration to Enable-PSSessionConfiguration.
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

