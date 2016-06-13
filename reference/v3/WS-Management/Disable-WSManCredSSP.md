---
external help file: PSITPro3_WSMan.xml
online version: http://go.microsoft.com/fwlink/?LinkId=141438
schema: 2.0.0
---

# Disable-WSManCredSSP
## SYNOPSIS
Disables Credential Security Support Provider (CredSSP) authentication on a client computer.

## SYNTAX

```
Disable-WSManCredSSP [-Role] <String>
```

## DESCRIPTION
The Disable-WSManCredSPP cmdlet disables CredSSP authentication on a client or on a server computer.
When CredSSP authentication is used, the user's credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from within another remote session.
For example, you use this type of authentication if you want to run a background job on a remote computer.

The cmdlet is used to disable CredSSP on the client by specifying Client in the Role parameter.
The cmdlet then performs the following:

- Disables CredSSP on the client. The WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP is set to false.
- Removes any WSMan/* setting from the Windows CredSSP policy AllowFreshCredentials on the client.

The cmdlet is used to disable CredSSP on the server by specifying Server in the Role parameter.
The cmdlet then performs the following:

- Disables CredSSP on the server. The WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP is set to false.

Caution: CredSSP authentication delegates the user's credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Disable-WSManCredSSP -Role Client
```

This command disables CredSSP on the client, which prevents delegation to servers.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Disable-WSManCredSSP -Role Server
```

This command disables CredSSP on the server, which prevents delegation from clients.

## PARAMETERS

### -Role
Accepts one of two possible values: Client or Server. 
These values specify whether CredSSP should be disabled as a client or as a server.

If the cmdlet is used to disable CredSSP on the client by specifying Client in the Role parameter, then the cmdlet performs the following:

- Disables CredSSP on the client. The WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP is set to false.
- Removes any WSMan/* setting from the Windows CredSSP policy AllowFreshCredentials on the client.

If the cmdlet is used to disable CredSSP on the server by specifying Server in the Role parameter, the cmdlet performs the following:

- Disables CredSSP on the server. The WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP is set to false.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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
To enable CredSSP authentication, use the Enable-WSManCredSSP cmdlet.

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

