---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=294037
external help file:  Microsoft.WSMan.Management.dll-Help.xml
title:  Enable-WSManCredSSP
---

# Enable-WSManCredSSP

## SYNOPSIS
Enables Credential Security Support Provider (CredSSP) authentication on a client or on a server computer.

## SYNTAX

```
Enable-WSManCredSSP [[-DelegateComputer] <String[]>] [-Force] [-Role] <String> [<CommonParameters>]
```

## DESCRIPTION
The Enable-WSManCredSPP cmdlet enables CredSSP authentication on a client or on a server computer.
When CredSSP authentication is used, the user's credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from within another remote session.
For example, you use this type of authentication if you want to run a background job on a remote computer.

This cmdlet is used to enable CredSSP on the client by specifying Client in the Role parameter.
The cmdlet then performs the following:

- Enables CredSSP on the client. The WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP is set to true.
- Sets the Windows CredSSP policy AllowFreshCredentials to WSMan/Delegate on the client.
- Note: These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

This cmdlet is used to enable CredSSP on the server by specifying Server in the Role parameter.
The cmdlet then performs the following:

- Enables CredSSP on the server. The WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP is set to true.
- Note: This policy setting allows the server to act as a delegate for clients.

Caution: CredSSP authentication delegates the user's credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet.

## EXAMPLES

### Example 1
```
PS C:\> enable-wsmancredssp -role client -delegatecomputer server02.accounting.fabrikam.com
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

### Example 2
```
PS C:\> enable-wsmancredssp -role client -delegatecomputer *.accounting.fabrikam.com
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

### Example 3
```
PS C:\> enable-wsmancredssp -role client -delegatecomputer server02.accounting.fabrikam.com, server03.accounting.fabrikam.com, server04.accounting.fabrikam.com
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

### Example 4
```
PS C:\> enable-wsmancredssp -role server
```

This command allows a computer to act as a delegate for another.
The Enable-WSManCredSSP cmdlet (shown in the earlier examples) only enables CredSSP authentication on the client, and specifies the remote computers that can act on it's behalf.
In order for the remote computer to act as a delegate for the client, the CredSSP item in the Service node of WSMan must be set to true.
This example sets the CredSSP item in the Service node of WSMan to true.

### Example 5
```
PS C:\> connect-wsman server02
set-item wsman:\server02\service\auth\credSSP -value $true
```

This command allows a computer to act as a delegate for another computer.
The Enable-WSManCredSSP commands that are shown in the earlier examples enable CredSSP authentication only on the client computer, and they specify the remote computers that can act on behalf of the client computer.
For the remote computer to act as a delegate for the client computer, the CredSSP item in the Service directory of the WSMan provider must be set to true.

In this example, the first command creates a connection to the remote server02 computer.

The second command sets the credSSP value on the remote server02 computer, which allows the remote computer to act as a delegate.

## PARAMETERS

### -DelegateComputer
Allows the client credentials to be delegated to the server or servers that are specified by this parameter.
The value of this parameter should be a fully qualified domain name.

If the Role parameter specifies Client, the DelegateComputer parameter is mandatory.

If the Role parameter specifies Server, the DelegateComputer parameter is not allowed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Enables CredSSP without first prompting the user.

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
Accepts one of two possible values: Client or Server.
These values specify whether CredSSP should be enabled as a client or as a server.

If the Role parameter specifies Client, the cmdlet performs the following:

- Enables CredSSP on the client. The WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP is set to true.
- Sets the Windows CredSSP policy AllowFreshCredentials to WSMan/Delegate on the client.
- Note: These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

If the Role parameter specifies the Server, the cmdlet performs the following:

- Enables CredSSP on the server. The WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP is set to true.
- Note: This policy setting allows the server to act as a delegate for clients.

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

### System.Xml.XmlElement
If CredSSP authentication is successfully enabled, this cmdlet generates an XMLElement object.

## NOTES

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