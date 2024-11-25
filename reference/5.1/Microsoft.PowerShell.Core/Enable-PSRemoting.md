---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 11/25/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Enable-PSRemoting
---
# Enable-PSRemoting

## SYNOPSIS
Configures the computer to receive remote commands.

## SYNTAX

```
Enable-PSRemoting [-Force] [-SkipNetworkProfileCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Enable-PSRemoting` cmdlet configures the computer to receive PowerShell remote commands that
are sent by using the WS-Management technology.

PowerShell remoting is enabled by default on Windows Server 2012 and higher. You can use
`Enable-PSRemoting` to enable PowerShell remoting on other supported versions of Windows and to
re-enable remoting if it becomes disabled.

You need to run this command only one time on each computer that receive commands. You don't need to
run it on computers that only send commands. Because the configuration starts listeners, it's
prudent to run it only where it's needed.

Beginning in PowerShell 3.0, the `Enable-PSRemoting` cmdlet can enable PowerShell remoting on client
versions of Windows when the computer is on a public network. For more information, see the
description of the **SkipNetworkProfileCheck** parameter.

The `Enable-PSRemoting` cmdlet performs the following operations:

- Runs the [Set-WSManQuickConfig](../Microsoft.WSMan.Management/Set-WSManQuickConfig.md) cmdlet,
  which performs the following tasks:
  - Starts the WinRM service.
  - Sets the startup type on the WinRM service to Automatic.
  - Creates a listener to accept requests on any IP address.
  - Enables a firewall exception for WS-Management communications.
  - Registers the **Microsoft.PowerShell** and **Microsoft.PowerShell.Workflow** session
    configurations, if it they're not already registered.
  - Registers the **Microsoft.PowerShell32** session configuration on 64-bit computers, if it's
    not already registered.
  - Enables all session configurations.
  - Changes the security descriptor of all session configurations to allow remote access.
- Restarts the WinRM service to make the preceding changes effective.

To run this cmdlet on the Windows platform, start PowerShell by using the Run as administrator
option.

For more information about using PowerShell remoting, see the following articles:

- [about_Remote_Requirements](about/about_Remote_Requirements.md)
- [about_Remote](about/about_Remote.md)

## EXAMPLES

### Example 1: Configure a computer to receive remote commands

This command configures the computer to receive remote commands.

```powershell
Enable-PSRemoting
```

### Example 2: Configure a computer to receive remote commands without a confirmation prompt

This command configures the computer to receive remote commands.
The **Force** parameter suppresses the user prompts.

```powershell
Enable-PSRemoting -Force
```

### Example 3: Allow remote access on clients

This example shows how to allow remote access from public networks on client versions of the Windows
operating system. The name of the firewall rule can be different for different versions of Windows.
Use `Get-NetFirewallRule` to see a list of rules. Before enabling the firewall rule, view the
security settings in the rule to verify that the configuration is appropriate for your environment.

```powershell
Get-NetFirewallRule -Name 'WINRM*' | Select-Object -Property Name
```

```Output
Name
----
WINRM-HTTP-In-TCP-NoScope
WINRM-HTTP-In-TCP
WINRM-HTTP-Compat-In-TCP-NoScope
WINRM-HTTP-Compat-In-TCP
```

```powershell
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Set-NetFirewallRule -Name 'WINRM-HTTP-In-TCP' -RemoteAddress Any
```

By default, `Enable-PSRemoting` creates network rules that allow remote access from private and
domain networks. The command uses the **SkipNetworkProfileCheck** parameter to allow remote access
from public networks in the same local subnet. The command specifies the **Force** parameter to
suppress confirmation messages.

The **SkipNetworkProfileCheck** parameter doesn't affect server versions of the Windows operating
system, which allow remote access from public networks in the same local subnet by default.

The `Set-NetFirewallRule` cmdlet in the **NetSecurity** module adds a firewall rule that allows
remote access from public networks from any remote location. This includes locations in different
subnets.

> [!NOTE]
> The name of the firewall rule can be different depending on the version of Windows. Use the
> `Get-NetFirewallRule` cmdlet to list the names of the rules on your system.

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

### -SkipNetworkProfileCheck

Indicates that this cmdlet enables remoting on client versions of the Windows operating system when
the computer is on a public network. This parameter enables a firewall rule for public networks that
allows remote access only from computers in the same local subnet.

This parameter doesn't affect server versions of the Windows operating system, which, by default,
have a local subnet firewall rule for public networks. If the local subnet firewall rule is disabled
on a server version, `Enable-PSRemoting` re-enables it, regardless of the value of this parameter.

To remove the local subnet restriction and enable remote access from all locations on public
networks, use the `Set-NetFirewallRule` cmdlet in the **NetSecurity** module.

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

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.String

This cmdlet returns strings that describe its results.

## NOTES

Starting in PowerShell 3.0, `Enable-PSRemoting` enables all session configurations by setting the
value of the **Enabled** property of all session configurations to `$True`.

- On server versions of the Windows operating system, `Enable-PSRemoting` creates firewall rules for
  private and domain networks that allow remote access, and creates a firewall rule for public
  networks that allows remote access only from computers in the same local subnet.

- On client versions of the Windows operating system, `Enable-PSRemoting` in PowerShell 3.0 creates
  firewall rules for private and domain networks that allow unrestricted remote access. To create a
  firewall rule for public networks that allows remote access from the same local subnet, use the
  **SkipNetworkProfileCheck** parameter.

- On client or server versions of the Windows operating system, to create a firewall rule for public
  networks that removes the local subnet restriction and allows remote access , use the
  `Set-NetFirewallRule` cmdlet in the NetSecurity module to run the following command:
  `Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any`

`Enable-PSRemoting` enables all session configurations by setting the value of the **Enabled**
property of all session configurations to `$True`.

`Enable-PSRemoting` removes the **Deny_All** and **Network_Deny_All** settings. This provides remote
access to session configurations that were reserved for local use.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Disable-PSRemoting](Disable-PSRemoting.md)

[WSMan Provider](../Microsoft.WsMan.Management/About/about_WSMan_Provider.md)

[about_Remote](About/about_Remote.md)

[about_Session_Configurations](About/about_Session_Configurations.md)
