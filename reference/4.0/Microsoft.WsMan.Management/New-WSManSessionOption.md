---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=294042
external help file:  Microsoft.WSMan.Management.dll-Help.xml
title:  New-WSManSessionOption
---

# New-WSManSessionOption

## SYNOPSIS
Creates a WS-Management session option hash table to use as input parameters to the following WS-Management cmdlets: Get-WSManInstance Set-WSManInstance Invoke-WSManAction Connect-WSMan

## SYNTAX

```
New-WSManSessionOption [-ProxyAccessType <ProxyAccessType>] [-ProxyAuthentication <ProxyAuthentication>]
 [-ProxyCredential <PSCredential>] [-SkipCACheck] [-SkipCNCheck] [-SkipRevocationCheck] [-SPNPort <Int32>]
 [-OperationTimeout <Int32>] [-NoEncryption] [-UseUTF16] [<CommonParameters>]
```

## DESCRIPTION
Creates a WSMan Session option hashtable which can be passed into WSMan cmdlets:

Get-WSManInstance

Set-WSManInstance

Invoke-WSManAction

Connect-WSMan

## EXAMPLES

### Example 1
```
PS C:\> $a = New-WSManSessionOption -operationtimeout 30000
Connect-WSMan -computer server01 -sessionoption $a
PS C:\Users\testuser> cd wsman:
PS WSMan:\>
PS WSMan:\> dir

WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan
ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01                                      Container
```

This command creates a connection to the remote server01 computer by using the connection options that are defined in the New-WSManSessionOption command.

The first command uses the New-WSManSessionOption cmdlet to store a set of connection setting options in the $a variable.
In this case, the session options set a connection time out of 30 seconds (30,000 milliseconds).

The second command uses the SessionOption parameter to pass the credentials that are stored in the $a variable to Connect-WSMan.
Then, Connect-WSMan connects to the remote server01 computer by using the specified session options.

The Connect-WSMan cmdlet is generally used within the context of the WSMan provider to connect to a remote computer, in this case the server01 computer.
However, you can use the cmdlet to establish connections to remote computers before you change to the WSMan provider.
Those connections will appear in the ComputerName list.

## PARAMETERS

### -NoEncryption
Do not use encryption when doing remote operations over HTTP.

Note: Unencrypted traffic is not allowed by default and must be enabled in the local configuration.

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

### -OperationTimeout
Defines the timeout in milliseconds for the WS-Management operation.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: OperationTimeoutMSec

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyAccessType
Specifies the mechanism by which the proxy server is located.
Possible values are:

ProxyIEConfig - Use the Internet Explorer proxy configuration for the current user.
This is the default setting.

ProxyWinHttpConfig - The WSMan client uses the proxy settings configured for WinHTTP, using the ProxyCfg.exe utility.

ProxyAutoDetect - Force auto-detection of a proxy server.

ProxyNoProxyServer - Do not use a proxy server.
All all host names will be resolved locally.

```yaml
Type: ProxyAccessType
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyAuthentication
Specifies the authentication method to use at the proxy.
Possible values are:

- Basic: Basic is a scheme in which the user name and password are sent in clear-text to the server or proxy.
- Digest: Digest is a challenge-response scheme that uses a server-specified data string for the challenge.
- Negotiate (the default): Negotiate is a challenge-response scheme that negotiates with the server or proxy to determine which scheme to use for authentication. Examples are the Kerberos protocol and NTLM.

```yaml
Type: ProxyAuthentication
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Negotiate
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyCredential
Specifies a user account that has permission to gain access through an intermediate web proxy.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SPNPort
Specifies a port number to append to the connection Service Principal Name \<SPN\> of the remote server.
An SPN is used when the authentication mechanism is Kerberos or Negotiate.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCACheck
Specifies that when connecting over HTTPS, the client does not validate that the server certificate is signed by a trusted certificate authority (CA).
Use this option only when the remote computer is trusted by other means, for example, if the remote computer is part of a network that is physically secure and isolated or the remote computer is listed as a trusted host in the WS-Management configuration.

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

### -SkipCNCheck
Specifies that the certificate common name (CN) of the server does not need to match the hostname of the server.
This is used only in remote operations using HTTPS.
This option should only be used for trusted computers.

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

### -SkipRevocationCheck
Do not validate the revocation status on the server certificate.

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

### -UseUTF16
Encode the request in UTF16 format rather than UTF8 format.
The default is UTF8 encoding.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### SessionOption

## NOTES

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)
