---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821475
external help file:  System.Management.Automation.dll-Help.xml
title:  Enable-PSRemoting
---

# Enable-PSRemoting

## SYNOPSIS
Configures the computer to receive remote commands.

## SYNTAX

```
Enable-PSRemoting [-Force] [-SkipNetworkProfileCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Enable-PSRemoting** cmdlet configures the computer to receive Windows PowerShell remote commands that are sent by using the WS-Management technology.

By default, on Windows Server® 2012, Windows PowerShell remoting is enabled.
You can use **Enable-PSRemoting** to enable Windows PowerShell remoting on other supported versions of Windows and to re-enable remoting on Windows Server 2012 if it becomes disabled.

You have to run this command only one time on each computer that will receive commands.
You do not have to run it on computers that only send commands.
Because the configuration starts listeners, it is prudent to run it only where it is needed.

Beginning in Windows PowerShell 3.0, the **Enable-PSRemoting** cmdlet can enable Windows PowerShell remoting on client versions of Windows when the computer is on a public network.
For more information, see the description of the *SkipNetworkProfileCheck* parameter.

The **Enable-PSRemoting** cmdlet performs the following operations:

- Runs the [Set-WSManQuickConfig](http://go.microsoft.com/fwlink/?LinkID=141463) cmdlet, which performs the following tasks:
 - Starts the WinRM service.
 - Sets the startup type on the WinRM service to Automatic.
 - Creates a listener to accept requests on any IP address.
 - Enables a firewall exception for WS-Management communications.
 - Registers the Microsoft.PowerShell and Microsoft.PowerShell.Workflow session configurations, if it they are not already registered.
 - Registers the Microsoft.PowerShell32 session configuration on 64-bit computers, if it is not already registered.
 - Enables all session configurations.
 - Changes the security descriptor of all session configurations to allow remote access.
- Restarts the WinRM service to make the preceding changes effective.

To run this cmdlet, start Windows PowerShell by using the Run as administrator option.

CAUTION: On systems that have both Windows PowerShell 3.0 and Windows PowerShell 2.0, do not use Windows PowerShell 2.0 to run the **Enable-PSRemoting** and Disable-PSRemoting cmdlets.
The commands might appear to succeed, but the remoting is not configured correctly.
Remote commands and later attempts to enable and disable remoting, are likely to fail.

## EXAMPLES

### Example 1: Configure a computer to receive remote commands
```
PS C:\> Enable-PSRemoting
```

This command configures the computer to receive remote commands.

### Example 2: Configure a computer to receive remote commands without a confirmation prompt
```
PS C:\> Enable-PSRemoting -Force
```

This command configures the computer to receive remote commands.
It uses the *Force* parameter to suppress the user prompts.

### Example 3: Allow remote access on clients
```
PS C:\> Enable-PSRemoting -SkipNetworkProfileCheck -Force
PS C:\> Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
```

This example shows how to allow remote access from public networks on client versions of the Windows operating system.
Before using these commands, analyze the security setting and verify that the computer network will be safe from harm.

The first command enables remoting in Windows PowerShell.
By default, this creates network rules that allow remote access from private and domain networks.
The command uses the *SkipNetworkProfileCheck* parameter to allow remote access from public networks in the same local subnet.
The command specifies the *Force* parameter to suppress confirmation messages.

The *SkipNetworkProfileCheck* parameter does not affect server version of the Windows operating system, which allow remote access from public networks in the same local subnet by default.

The second command eliminates the subnet restriction.
The command uses the **Set-NetFirewallRule** cmdlet in the **NetSecurity** module to add a firewall rule that allows remote access from public networks from any remote location.
This includes locations in different subnets.

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

### -SkipNetworkProfileCheck
Indicates that this cmdlet enables remoting on client versions of the Windows operating system when the computer is on a public network.
This parameter enables a firewall rule for public networks that allows remote access only from computers in the same local subnet.

This parameter does not affect server versions of the Windows operating system, which, by default, have a local subnet firewall rule for public networks.
If the local subnet firewall rule is disabled on a server version, **Enable-PSRemoting** re-enables it, regardless of the value of this parameter.

To remove the local subnet restriction and enable remote access from all locations on public networks, use the **Set-NetFirewallRule** cmdlet in the **NetSecurity** module.

This parameter was introduced in Windows PowerShell 3.0.

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
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String
This cmdlet returns strings that describe its results.

## NOTES
* In Windows PowerShell 3.0, **Enable-PSRemoting** creates the following firewall exceptions for WS-Management communications.

  On server versions of the Windows operating system, **Enable-PSRemoting** creates firewall rules for private and domain networks that allow remote access, and creates a firewall rule for public networks that allows remote access only from computers in the same local subnet.

  On client versions of the Windows operating system, **Enable-PSRemoting** in Windows PowerShell 3.0 creates firewall rules for private and domain networks that allow unrestricted remote access.
To create a firewall rule for public networks that allows remote access from the same local subnet, use the *SkipNetworkProfileCheck* parameter.

  On client or server versions of the Windows operating system, to create a firewall rule for public networks that removes the local subnet restriction and allows remote access , use the **Set-NetFirewallRule** cmdlet in the NetSecurity module to run the following command: `Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any`

* In Windows PowerShell 2.0, **Enable-PSRemoting** creates the following firewall exceptions for WS-Management communications.

  On server versions of the Windows operating system, it creates firewall rules for all networks that allow remote access.

  On client versions of the Windows operating system, **Enable-PSRemoting** in Windows PowerShell 2.0 creates a firewall exception only for domain and private network locations.
To minimize security risks, **Enable-PSRemoting** does not create a firewall rule for public networks on client versions of Windows.
When the current network location is public, **Enable-PSRemoting** returns the following message: Unable to check the status of the firewall.

* Starting in Windows PowerShell 3.0, **Enable-PSRemoting** enables all session configurations by setting the value of the **Enabled** property of all session configurations (WSMan:\\\<ComputerName\>\Plugin\\\<SessionConfigurationName\>\Enabled) to True ($True).
* In Windows PowerShell 2.0, **Enable-PSRemoting** removes the Deny_All setting from the security descriptor of session configurations. In Windows PowerShell 3.0, **Enable-PSRemoting** removes the Deny_All and Network_Deny_All settings. This provides remote access to session configurations that were reserved for local use.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Disable-PSRemoting](Disable-PSRemoting.md)

[WSMan Provider](../Microsoft.WsMan.Management/Providers/WSMan-Provider.md)

[about_Remote](About/about_Remote.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

