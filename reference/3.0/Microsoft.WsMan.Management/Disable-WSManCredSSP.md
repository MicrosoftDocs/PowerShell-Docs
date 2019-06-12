---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=141438
external help file:  Microsoft.WSMan.Management.dll-Help.xml
title:  Disable-WSManCredSSP
---
# Disable-WSManCredSSP

## SYNOPSIS

Disables Credential Security Support Provider (CredSSP) authentication on a client computer.

## SYNTAX

```
Disable-WSManCredSSP [-Role] <String> [<CommonParameters>]
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

### Example 1

```powershell
Disable-WSManCredSSP -Role Client
```

This command disables CredSSP on the client, which prevents delegation to servers.

### Example 2

```powershell
Disable-WSManCredSSP -Role Server
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

- To enable CredSSP authentication, use the Enable-WSManCredSSP cmdlet.
## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)
