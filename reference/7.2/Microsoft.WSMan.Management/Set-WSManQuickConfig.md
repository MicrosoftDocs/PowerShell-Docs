---
external help file: Microsoft.WSMan.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.WSMan.Management
ms.date: 10/02/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/set-wsmanquickconfig?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-WSManQuickConfig
---

# Set-WSManQuickConfig

## SYNOPSIS
Configures the local computer for remote management.

## SYNTAX

### All

```
Set-WSManQuickConfig [-UseSSL] [-Force] [-SkipNetworkProfileCheck] [<CommonParameters>]
```

## DESCRIPTION

The `Set-WSManQuickConfig` cmdlet configures the computer to receive PowerShell remote commands that
are sent by using the Web Services for Management (WS-Management) technology.

`Set-WSManQuickConfig` performs the following actions:

- Checks whether the WinRM service is running. If the WinRM service isn't running, the service is
  started.
- Sets the WinRM service startup type to automatic.
- Creates a listener to accept requests on any IP address. The default transport is **HTTP**.
- Enables a firewall exception for WinRM traffic.

To run `Set-WSManQuickConfig`, start PowerShell with the **Run as Administrator** option.

## EXAMPLES

### Example 1: Enable remote management of the local computer over HTTP

This example sets the required configuration to enable remote management of the local computer. By
default, this command creates a WS-Management listener on **HTTP**.

```powershell
Set-WSManQuickConfig
```

### Example 2: Enable remote management of the local computer over HTTPS

This example sets the required configuration to enable remote management of the local computer. The
**UseSSL** parameter specifies that **HTTPS** is used to communicate with the computer.

```powershell
Set-WSManQuickConfig -UseSSL
```

> [!NOTE]
> **HTTPS** requires manual configuration. For more information, see the **UseSSL** parameter's
> description.

## PARAMETERS

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipNetworkProfileCheck

Configures Windows client versions for remoting when the computer is on a public network. This
parameter enables a firewall rule for public networks that allows remote access only from computers
in the same local subnet.

This parameter has no effect on server versions of Windows, that by default, have a local subnet
firewall rule for public networks. If the local subnet firewall rule is disabled on the server
version of Windows, `Enable-PSRemoting` re-enables it, regardless of this parameter's value.

To remove the local subnet restriction and enable remote access from all locations on public
networks, use the `Set-NetFirewallRule` cmdlet in the **NetSecurity** module.

This parameter was introduced in PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL

Specifies that the Secure Sockets Layer (SSL) protocol is used to establish a connection to the
remote computer. By default, SSL isn't used.

WS-Management encrypts all the PowerShell content that is transmitted over the network. The
**UseSSL** parameter lets you specify the additional protection of HTTPS instead of HTTP. If you use
this parameter and SSL isn't available on the port that's used for the connection, the command
fails.

**HTTPS** requires manual configuration of WinRM and firewall rules. For more information, see
[How To: Configure WINRM for HTTPS](https://support.microsoft.com/help/2019527/how-to-configure-winrm-for-https).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

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

### None

This cmdlet doesn't accept any input.

## OUTPUTS

### None

This cmdlet doesn't generate any output.

## NOTES

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-PSRemoting](../Microsoft.PowerShell.Core/Enable-PSRemoting.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[How To: Configure WINRM for HTTPS](https://support.microsoft.com/help/2019527/how-to-configure-winrm-for-https)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-PSSession](../Microsoft.PowerShell.Core/New-PSSession.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Test-WSMan](Test-WSMan.md)

