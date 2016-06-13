---
external help file: PSITPro3_WSMan.xml
online version: http://go.microsoft.com/fwlink/?LinkId=141443
schema: 2.0.0
---

# Get-WSManCredSSP
## SYNOPSIS
Gets the Credential Security Support Provider-related configuration for the client.

## SYNTAX

```
Get-WSManCredSSP
```

## DESCRIPTION
The Get-WSManCredSSP cmdlet gets the Credential Security Support Provider-related configuration of the client and the server.
The output indicates whether Credential Security Support Provider (CredSSP) authentication is enabled or disabled.
It also displays configuration information for the AllowFreshCredentials policy of CredSSP.
When you use CredSSP authentication, the user's credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from within another remote session.
For example, you use this type of authentication if you want to run a background job on a remote computer.

The cmdlet performs the following actions:

- Gets the WS-Management CredSSP setting on the client (\<localhost|computername\>\Client\Auth\CredSSP).
- Gets the Windows CredSSP policy setting AllowFreshCredentials.
- Gets the WS-Management CredSSP setting on the server (\<localhost|computername\>\Service\Auth\CredSSP).

Caution: CredSSP authentication delegates the user's credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet.
To enable CredSSP authentication, use the Enable-WSManCredSSP cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-wsmancredssp
```

This command displays CredSSP configuration information for both the client and server.

The output identifies that this computer is or is not configured for CredSSP.

If the computer is configured for CredSSP, this is the output:

"The machine is configured to allow delegating fresh credentials to the following target(s): wsman/server02.accounting.fabrikam.com"

If the computer is not configured for CredSSP, this is the output:

"The machine is not configured to allow delegating fresh credentials."

## PARAMETERS

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

