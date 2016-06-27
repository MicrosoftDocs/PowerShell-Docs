---
external help file: Microsoft.WSMan.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294045
schema: 2.0.0
---

# Set-WSManQuickConfig
## SYNOPSIS
Configures the local computer for remote management.

## SYNTAX

```
Set-WSManQuickConfig [-UseSSL] [-Force] [-SkipNetworkProfileCheck]
```

## DESCRIPTION
The Set-WSManQuickConfig cmdlet configures the computer to receive Windows PowerShell remote commands that are sent by using the Web Services for Management (WS-Management) technology.

The cmdlet performs the following:

-- Checks whether the WinRM service is running. If the WinRM service is not running, the service is started.
-- Sets the WinRM service startup type to automatic.
-- Creates a listener to accept requests on any IP address. By default, the transport is HTTP.
-- Enables a firewall exception for WinRM traffic .

To run this cmdlet, start Windows PowerShell with the "Run as administrator" option.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Set-WSManQuickConfig
```

This command sets the required configuration to enable remote management of the local computer.
By default, this command creates a WS-Management listener on HTTP.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Set-WSManQuickConfig -UseSSL
```

The command sets the required configuration to enable remote management of the local computer.
The UseSSL parameter makes the command create a WS-Management listener on HTTPS.

## PARAMETERS

### -Force
Sets the configuration without first prompting the user.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipNetworkProfileCheck
Configures client versions of Windows for remoting when the computer is on a public network.
This parameter enables a firewall rule for public networks that allows remote access only from computers in the same local subnet.

This parameter has no effect on server versions of Windows, which, by default, have a local subnet firewall rule for public networks.
If the local subnet firewall rule is disabled on a server version of Windows, Enable-PSRemoting re-enables it, regardless of the value of this parameter.

To remove the local subnet restriction and enable remote access from all locations on public networks, use the Set-NetFirewallRule cmdlet in the NetSecurity module.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol should be used to establish a connnection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all Windows PowerShell content transmitted over the network.
The UseSSL parameter lets you specify that the additional protection of using HTTPS instead of HTTP should be used.
If you specify this parameter, but SSL is not available on the port used for the connection, the command fails.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Enable-PSRemoting]()

[New-PSSession]()

[Connect-WSMan]()

[Disable-WSManCredSSP]()

[Disconnect-WSMan]()

[Enable-WSManCredSSP]()

[Get-WSManCredSSP]()

[Get-WSManInstance]()

[Invoke-WSManAction]()

[New-WSManInstance]()

[New-WSManSessionOption]()

[Test-WSMan]()

