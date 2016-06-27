---
external help file: Microsoft.WSMan.Management.dll-Help.xml
online version: http://technet.microsoft.com/library/hh849871.aspx
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

[Connect-WSMan]()

[Disable-WSManCredSSP]()

[Disconnect-WSMan]()

[Enable-WSManCredSSP]()

[Get-WSManInstance]()

[Invoke-WSManAction]()

[New-WSManInstance]()

[New-WSManSessionOption]()

[Remove-WSManInstance]()

[Set-WSManInstance]()

[Set-WSManQuickConfig]()

[Test-WSMan]()

