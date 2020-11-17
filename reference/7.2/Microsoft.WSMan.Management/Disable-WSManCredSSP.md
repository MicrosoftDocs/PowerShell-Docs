---
external help file: Microsoft.WSMan.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/disable-wsmancredssp?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-WSManCredSSP
---

# Disable-WSManCredSSP

## SYNOPSIS
Disables CredSSP authentication on a computer.

## SYNTAX

```
Disable-WSManCredSSP [-Role] <String> [<CommonParameters>]
```

## DESCRIPTION
The **Disable-WSManCredSSP** cmdlet disables Credential Security Support Provider (CredSSP) authentication on a client or on a server computer.
When CredSSP authentication is used, the user credentials are passed to a remote computer to be authenticated.

Use this cmdlet to disable CredSSP on the client by specifying Client in the *Role* parameter.
This cmdlet performs the following actions:

- Disables CredSSP on the client. This cmdlet sets the WS-Management setting **\<localhost|computername\>\Client\Auth\CredSSP** to false.
- Removes any WSMan/* setting from the Windows CredSSP policy **AllowFreshCredentials** on the client.

Use this cmdlet to disable CredSSP on the server by specifying Server in *Role*.
This cmdlet performs the following action:

- Disables CredSSP on the server. This cmdlet sets the WS-Management setting **\<localhost|computername\>\Service\Auth\CredSSP** to false.

Caution: CredSSP authentication delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

## EXAMPLES

### Example 1: Disable CredSSP on a client

```
PS C:\> Disable-WSManCredSSP -Role Client
```

This command disables CredSSP on the client, which prevents delegation to servers.

### Example 2: Disable CredSSP on a server

```
PS C:\> Disable-WSManCredSSP -Role Server
```

This command disables CredSSP on the server, which prevents delegation from clients.

## PARAMETERS

### -Role
Specifies whether to disable CredSSP as a client or as a server.
The acceptable values for this parameter are: Client and Server.

If you specify Client, this cmdlet performs the following actions:

- Disables CredSSP on the client. This cmdlet sets WS-Management setting **\<localhost|computername\>\Client\Auth\CredSSP** to false.
- Removes any WSMan/* setting from the Windows CredSSP policy **AllowFreshCredentials** on the client.

If you specify Server, this cmdlet performs the following action:

- Disables CredSSP on the server. This cmdlet sets the WS-Management setting **\<localhost|computername\>\Service\Auth\CredSSP** to false.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Client, Server

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

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

