---
external help file: PSITPro3_WSMan.xml
online version: http://go.microsoft.com/fwlink/?LinkID=141463
schema: 2.0.0
---

# Set-WSManQuickConfig
## SYNOPSIS
Configures the local computer for remote management.

## SYNTAX

```
Set-WSManQuickConfig [-Force] [-SkipNetworkProfileCheck] [-UseSSL]
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

[Enable-PSRemoting](00000000-0000-0000-0000-000000000000)

[New-PSSession](00000000-0000-0000-0000-000000000000)

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

