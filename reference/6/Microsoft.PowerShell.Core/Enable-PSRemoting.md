---
ms.date:  2018-12-14
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
The **Enable-PSRemoting** cmdlet configures the computer to receive PowerShell remote commands that are sent by using the WS-Management technology.  

The remote commands run in configurable PowerShell Core sessions.
PowerShell Core is designed to run side by side with Windows PowerShell and consequently creates session configurations that are separate from Windows PowerShell session configurations.  

**Enable-PSRemoting** will create two PowerShell Core session configurations if they do not exist on the computer, or re-enable them if they exist but were disabled.
The first session configuration is given a simple name to allow generic remote connections to a PowerShell Core configured session.
The second session has a fully qualified name denoting its version and commit id.
Since PowerShell Core is Open Source Software, any number of build versions can run side by side on a given computer.
The fully qualified named session configuration allows a client to connect to a specific PowerShell Core build version.  

For example:
```
Name  : PowerShell.6-preview
Name  : PowerShell.6.2.0-preview.2-68-gc9fc4ef4ec1256ac7082f55c45d4e400cc642767
```

You have to run this command only one time on each computer that will receive commands.
You do not have to run it on computers that only send commands.
Because the configuration starts listeners, it is prudent to run it only where it is needed.  

The **Enable-PSRemoting** cmdlet performs the following operations:

- Runs the [Set-WSManQuickConfig](http://go.microsoft.com/fwlink/?LinkID=141463) cmdlet, which performs the following tasks:
 - Starts the WinRM service.
 - Sets the startup type on the WinRM service to Automatic.
 - Creates a listener to accept requests on any IP address.
 - Enables a firewall exception for WS-Management communications.
- Registers the simple name and fully qualified name session configurations, if they are not already registered.
- Enables all PowerShell Core session configurations.
- Changes the security descriptor of all session configurations to allow remote access.
- Restarts the WinRM service to make the preceding changes effective.

To run this cmdlet, start PowerShell Core by using the Run as administrator option.

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

The first command enables remoting in PowerShell Core.
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
* **Enable-PSRemoting** creates the following firewall exceptions for WS-Management communications.

  On server versions of the Windows operating system, **Enable-PSRemoting** creates firewall rules for private and domain networks that allow remote access, and creates a firewall rule for public networks that allows remote access only from computers in the same local subnet.

  On client versions of the Windows operating system, **Enable-PSRemoting** creates firewall rules for private and domain networks that allow unrestricted remote access.
To create a firewall rule for public networks that allows remote access from the same local subnet, use the *SkipNetworkProfileCheck* parameter.

  On client or server versions of the Windows operating system, to create a firewall rule for public networks that removes the local subnet restriction and allows remote access , use the **Set-NetFirewallRule** cmdlet in the NetSecurity module to run the following command: `Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any`

* **Enable-PSRemoting** enables all session configurations by setting the value of the **Enabled** property of all session configurations (WSMan:\\\<ComputerName\>\Plugin\\\<SessionConfigurationName\>\Enabled) to True ($True).

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Disable-PSRemoting](Disable-PSRemoting.md)
