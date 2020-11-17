---
external help file: Microsoft.WSMan.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/get-wsmancredssp?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-WSManCredSSP
---

# Get-WSManCredSSP

## SYNOPSIS
Gets the Credential Security Support Provider-related configuration for the client.

## SYNTAX

```
Get-WSManCredSSP [<CommonParameters>]
```

## DESCRIPTION
The **Get-WSManCredSSP** cmdlet gets the Credential Security Support Provider-related configuration of the client and the server.
The output indicates whether Credential Security Support Provider (CredSSP) authentication is enabled or disabled.
This cmdlet also displays configuration information for the **AllowFreshCredentials** policy of CredSSP.

When you use CredSSP authentication, the user credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from another remote session.
For example, if you want to run a background job on a remote computer, use this kind of authentication.

The cmdlet performs the following actions:

- Gets the WS-Management CredSSP setting on the client (**\<localhost|computername\>\Client\Auth\CredSSP**).
- Gets the Windows CredSSP policy setting **AllowFreshCredentials**.
- Gets the WS-Management CredSSP setting on the server (**\<localhost|computername\>\Service\Auth\CredSSP**).

Caution: CredSSP authentication delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

## EXAMPLES

### Example 1: Display CredSSP configuration

```
PS C:\> Get-WSManCredSSP
```

This command displays CredSSP configuration information for both the client and server.

The output identifies that this computer is or is not configured for CredSSP.

If the computer is configured for CredSSP, this is the output:

`The machine is configured to allow delegating fresh credentials to the following target(s): wsman/server02.accounting.fabrikam.com`

If the computer is not configured for CredSSP, this is the output:

`The machine is not configured to allow delegating fresh credentials.`

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

* To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet. To enable CredSSP authentication, use the Enable-WSManCredSSP cmdlet.

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)

