---
external help file: PSITPro5_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294035
schema: 2.0.0
---

# Disable-WSManCredSSP
## SYNOPSIS
Disables CredSSP authentication on a computer.

## SYNTAX

```
Disable-WSManCredSSP [-Role] <String>
```

## DESCRIPTION
The Disable-WSManCredSSP cmdlet disables Credential Security Support Provider (CredSSP) authentication on a client or on a server computer.
When CredSSP authentication is used, the user credentials are passed to a remote computer to be authenticated.

Use this cmdlet to disable CredSSP on the client by specifying Client in the Role parameter.
This cmdlet performs the following actions:

- Disables CredSSP on the client. This cmdlet sets the WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP to false.
- Removes any WSMan/* setting from the Windows CredSSP policy AllowFreshCredentials on the client.

Use this cmdlet to disable CredSSP on the server by specifying Server in Role.
This cmdlet performs the following action:

- Disables CredSSP on the server. This cmdlet sets the WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP to false.

Caution: CredSSP authentication delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

## EXAMPLES

### Example 1: Disable CredSSP on a client
```
PS C:\>Disable-WSManCredSSP -Role Client
```

This command disables CredSSP on the client, which prevents delegation to servers.

### Example 2: Disable CredSSP on a server
```
PS C:\>Disable-WSManCredSSP -Role Server
```

This command disables CredSSP on the server, which prevents delegation from clients.

## PARAMETERS

### -Role
Specifies whether to disable CredSSP as a client or as a server.
The acceptable values for this parameter are: Client and Server.

If you specify Client, this cmdlet performs the following actions:

- Disables CredSSP on the client. This cmdlet sets WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP to false.
- Removes any WSMan/* setting from the Windows CredSSP policy AllowFreshCredentials on the client.

If you specify Server, this cmdlet performs the following action:

- Disables CredSSP on the server. This cmdlet sets the WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP to false.

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
* To enable CredSSP authentication, use the Enable-WSManCredSSP cmdlet.

*

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

