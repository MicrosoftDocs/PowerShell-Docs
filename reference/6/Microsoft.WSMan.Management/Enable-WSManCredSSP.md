---
external help file: Microsoft.WSMan.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821727
schema: 2.0.0
title: Enable-WSManCredSSP
---

# Enable-WSManCredSSP

## SYNOPSIS
Enables CredSSP authentication on a computer.

## SYNTAX

```
Enable-WSManCredSSP [[-DelegateComputer] <String[]>] [-Force] [-Role] <String> [<CommonParameters>]
```

## DESCRIPTION
The **Enable-WSManCredSSP** cmdlet enables Credential Security Support Provider (CredSSP) authentication on a client or on a server computer.
When CredSSP authentication is used, the user credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from another remote session.
For example, if you want to run a background job on a remote computer, use this kind of authentication.

Use this cmdlet to enable CredSSP on the client by specifying Client in the *Role* parameter.
This cmdlet performs the following actions:

- Enables CredSSP on the client.
This cmdlet sets the WS-Management setting **\<localhost|computername\>\Client\Auth\CredSSP** to true.
- Sets the Windows CredSSP policy **AllowFreshCredentials** to WSMan/Delegate on the client.

These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

Use this cmdlet enable CredSSP on the server by specifying Server in *Role*.
This cmdlet performs the following action:

- Enables CredSSP on the server.
This cmdlet sets the WS-Management setting **\<localhost|computername\>\Service\Auth\CredSSP** to true.

This policy setting allows the server to act as a delegate for clients.

Caution: CredSSP authentication delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

## EXAMPLES

### Example 1: Delegate client credentials
```
PS C:\> Enable-WSManCredSSP -Role "Client" -DelegateComputer "server02.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to the server02 computer.

### Example 2: Delegate client credentials to all computers in a domain
```
PS C:\> Enable-WSManCredSSP -Role "Client" -DelegateComputer "*.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to all the computers in the accounting.fabrikam.com domain.

### Example 3: Delegate client credentials to multiple computers
```
PS C:\> Enable-WSManCredSSP -Role "Client" -DelegateComputer "server02.accounting.fabrikam.com", "server03.accounting.fabrikam.com", "server04.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to multiple computers.

### Example 4: Allow a computer to act as a delegate
```
PS C:\> Enable-WSManCredSSP -Role "Server"
```

This command allows a computer to act as a delegate for another.
The **Enable-WSManCredSSP** cmdlet, shown in the earlier examples, only enables CredSSP authentication on the client, and specifies the remote computers that can act on its behalf.
In order for the remote computer to act as a delegate for the client, the CredSSP item in the Service node of WSMan must be set to true.
This example sets the CredSSP item in the Service node of WSMan to true.

### Example 5: Allow a computer to act as a delegate by using Set-Item
```
PS C:\> Connect-WSMan -ComputerName "server02"
PS C:\> Set-Item -Path "wsman:\server02\service\auth\credSSP" -Value $True
```

This example allows a computer to act as a delegate for another computer.
The Enable-WSManCredSSP commands, shown in the earlier examples, enable CredSSP authentication only on the client computer, and they specify the remote computers that can act on behalf of the client computer.
For the remote computer to act as a delegate for the client computer, the CredSSP item in the Service directory of the WSMan provider must be set to true.

The first command creates a connection to the remote server02 computer by using the Connect-WSMan cmdlet.

The second command sets the credSSP value on the remote server02 computer by using the Set-Item cmdlet.
This value allows the remote computer to act as a delegate.

## PARAMETERS

### -DelegateComputer
Specifies servers to which client credentials are delegated.
Specify fully qualified domain names.

If the *Role* parameter is Client, you must specify this parameter.

If *Role* is Server, do not specify this parameter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Role
Specifies whether to enable CredSSP as a client or as a server.
The acceptable values for this parameter are: Client and Server.

If you specify Client, this cmdlet performs the following actions:

- Enables CredSSP on the client.
This cmdlet sets the WS-Management setting **\<localhost|computername\>\Client\Auth\CredSSP** to true.
- Sets the Windows CredSSP policy **AllowFreshCredentials** to WSMan/Delegate on the client.

These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

If you specify Server, the cmdlet performs the following actions:

- Enables CredSSP on the server.
This cmdlet sets the WS-Management setting **\<localhost|computername\>\Service\Auth\CredSSP** to true.

This policy setting allows the server to act as a delegate for clients.

```yaml
Type: String
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### System.Xml.XmlElement
If CredSSP authentication is successfully enabled, this cmdlet generates an **XMLElement** object.

## NOTES
* To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet.

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)