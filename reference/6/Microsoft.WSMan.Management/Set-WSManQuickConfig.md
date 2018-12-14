---
external help file: Microsoft.WSMan.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821737
schema: 2.0.0
title: Set-WSManQuickConfig
---

# Set-WSManQuickConfig

## SYNOPSIS
Configures the local computer for remote management.

## SYNTAX

```
Set-WSManQuickConfig [-UseSSL] [-Force] [-SkipNetworkProfileCheck] [<CommonParameters>]
```

## DESCRIPTION
The **Set-WSManQuickConfig** cmdlet configures the computer to receive Windows PowerShell remote commands that are sent by using the Web Services for Management (WS-Management) technology.

This cmdlet performs the following actions:

- Checks whether the WinRM service is running.
If the WinRM service is not running, the service is started.
- Sets the WinRM service startup type to automatic.
- Creates a listener to accept requests on any IP address.
By default, the transport is HTTP.
- Enables a firewall exception for WinRM traffic .

To run this cmdlet, start Windows PowerShell by using the Run as administrator option.

## EXAMPLES

### Example 1: Enable remote management of the local computer over HTTP
```
PS C:\> Set-WSManQuickConfig
```

This command sets the required configuration to enable remote management of the local computer.
By default, this command creates a WS-Management listener on HTTP.

### Example 2: Enable remote management of the local computer over HTTPS
```
PS C:\> Set-WSManQuickConfig -UseSSL
```

The command sets the required configuration to enable remote management of the local computer.
The *UseSSL* parameter makes the command create a WS-Management listener on HTTPS.

## PARAMETERS

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
Configures client versions of Windows for remoting when the computer is on a public network.
This parameter enables a firewall rule for public networks that allows remote access only from computers in the same local subnet.

This parameter has no effect on server versions of Windows, which, by default, have a local subnet firewall rule for public networks.
If the local subnet firewall rule is disabled on a server version of Windows, Enable-PSRemoting re-enables it, regardless of the value of this parameter.

To remove the local subnet restriction and enable remote access from all locations on public networks, use the Set-NetFirewallRule cmdlet in the **NetSecurity** module.

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

### -UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol is used to establish a connection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all the Windows PowerShell content that is transmitted over the network.
The *UseSSL* parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port that is used for the connection, and you specify this parameter, the command fails.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Test-WSMan](Test-WSMan.md)