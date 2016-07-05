---
external help file: PSITPro5_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294042
schema: 2.0.0
---

# New-WSManSessionOption
## SYNOPSIS
Creates session option hash table to use as input parameters for WS-Management cmdlets.

## SYNTAX

```
New-WSManSessionOption [-NoEncryption] [-OperationTimeout <Int32>] [-ProxyAccessType <ProxyAccessType>]
 [-ProxyAuthentication <ProxyAuthentication>] [-ProxyCredential <PSCredential>] [-SkipCACheck] [-SkipCNCheck]
 [-SkipRevocationCheck] [-SPNPort <Int32>] [-UseUTF16]
```

## DESCRIPTION
The New-WSManSessionOption cmdlet creates a WSMan Session option hash table which can be passed to WSMan cmdlets: 

- Get-WSManInstance
- Set-WSManInstance
- Invoke-WSManAction
- Connect-WSMan

## EXAMPLES

### Example 1: Create a connection that uses connection options
```
PS C:\>$a = New-WSManSessionOption -OperationTimeout 30000
PS C:\> Connect-WSMan -ComputerName "server01" -SessionOption $a
PS C:\> cd wsman:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan
ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01                                      Container
```

This example creates a connection to the remote server01 computer by using the connection options that are defined by New-WSManSessionOption.

The first command uses New-WSManSessionOption to store a set of connection setting options in the $a variable.
In this case, the session options set a connection time out of 30 seconds (30,000 milliseconds).

The second command uses the SessionOption parameter to pass the credentials that are stored in the $a variable to Connect-WSMan.
Then, Connect-WSMan connects to the remote server01 computer by using the specified session options.

Connect-WSMan is generally used in the context of the WSMan provider to connect to a remote computer, in this case the server01 computer.
However, you can use the cmdlet to establish connections to remote computers before you change to the WSMan provider.
Those connections appear in the ComputerName list.

## PARAMETERS

### -NoEncryption
Indicates that the connection does not use encryption for remote operations over HTTP.

By default, unencrypted traffic is not enabled.
It must be enabled in the local configuration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -OperationTimeout
Specifies the time-out, in milliseconds, for the WS-Management operation.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyAccessType
Specifies the mechanism by which the proxy server is located.
The acceptable values for this parameter are:

- ProxyIEConfig.
Use the Internet Explorer proxy configuration for the current user. 
- ProxyWinHttpConfig.
The WSMan client uses the proxy settings configured for WinHTTP, using the ProxyCfg.exe utility. 
- ProxyAutoDetect.
Force auto-detection of a proxy server. 
- ProxyNoProxyServer.
Do not use a proxy server.
Resolve all host names locally. 

The default value is ProxyIEConfig.

```yaml
Type: ProxyAccessType
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyAuthentication
Specifies the authentication method to use at the proxy.
The acceptable values for this parameter are:

- Basic.
Basic is a scheme in which the user name and password are sent in clear-text to the server or proxy. 
- Digest.
Digest is a challenge-response scheme that uses a server-specified data string for the challenge. 
- Negotiate.
Negotiate is a challenge-response scheme that negotiates with the server or proxy to determine which scheme to use for authentication.
Examples are the Kerberos protocol and NTLM. 

The default value is Negotiate.

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
Specifies a user account that has permission to gain access through an intermediate Web proxy.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SPNPort
Specifies a port number to append to the connection Service Principal Name (SPN) of the remote server.
An SPN is used when the authentication mechanism is Kerberos or Negotiate.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCACheck
Specifies that, when it connects over HTTPS, the client does not validate that the server certificate is signed by a trusted certification authority (CA).
Use this option only when the remote computer is trusted by another method, for example, if the remote computer is part of a network that is physically secure and isolated or the remote computer is listed as a trusted host in the WS-Management configuration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCNCheck
Specifies that the certificate common name (CN) of the server does not have to match the host name of the server.
This is used only in remote operations using HTTPS.
This option should only be used for trusted computers.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipRevocationCheck
Indicates that the connection does not validate the revocation status on the server certificate.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseUTF16
Indicates that the connection encodes the request in UTF16 format instead of UTF8 format.
The default is UTF8 encoding.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### SessionOption

## NOTES

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

