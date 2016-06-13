---
external help file: PSITPro4_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294046
schema: 2.0.0
---

# Test-WSMan
## SYNOPSIS
Tests whether the WinRM service is running on a local or remote computer.

## SYNTAX

```
Test-WSMan [[-ComputerName] <String>] [-ApplicationName <String>] [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [-Credential <PSCredential>] [-Port <Int32>] [-UseSSL]
```

## DESCRIPTION
The Test-WSMan cmdlet submits an identification request that determines whether the WinRM service is running on a local or remote computer.
If the tested computer is running the service, the cmdlet displays the WS-Management identity schema, the protocol version, the product vendor, and the product version of the tested service.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>test-wsman

wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
```

This command determines whether the WinRM service is running on the local computer or on a remote computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>test-wsman -computername server01

wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
```

This command determines whether the WinRM service is running on the server01 computer named.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>test-wsman -authentication default

wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 6.0.6001 SP: 1.0 Stack: 2.0
```

This command tests to see if the WS-Management (WinRM) service is running on the local computer using the authentication parameter.

Using the authentication parameter allows the Test-WSMan cmdlet to return the Operating System version.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>test-wsman -computername server01 -authentication default

wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 6.1.7021 SP: 0.0 Stack: 2.0
```

This command tests to see if the WS-Management (WinRM) service is running on the computer named server01 using the authentication parameter.

Using the authentication parameter allows the Test-WSMan cmdlet to return the operating system version.

## PARAMETERS

### -ApplicationName
Specifies the application name in the connection.
The default value of the ApplicationName parameter is "WSMAN".
The complete identifier for the remote endpoint is in the following format:

\<transport\>://\<server\>:\<port\>/\<ApplicationName\>

For example:

http://server01:8080/WSMAN

Internet Information Services (IIS), which hosts the session, forwards requests with this endpoint to the specified application.
This default setting of "WSMAN" is appropriate for most uses.
This parameter is designed to be used when numerous computers establish remote connections to one computer that is running Windows PowerShell.
In this case, IIS hosts Web Services for Management (WS-Management)  for efficiency.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication
Specifies the authentication mechanism to be used at the server. 
Possible values are:

- Basic: Basic is a scheme in which the user name and password are sent in clear text to the server or proxy.
- Default : Use the authentication method implemented by the WS-Management protocol.
- Digest: Digest is a challenge-response scheme that uses a server-specified data string for the challenge.
- Kerberos: The client computer and the server mutually authenticate by using Kerberos certificates.
- Negotiate: Negotiate is a challenge-response scheme that negotiates with the server or proxy to determine the scheme to use for authentication. For example, this parameter value allows negotiation to determine whether the Kerberos protocol or NTLM is used.
- CredSSP: Use Credential Security Support Provider (CredSSP) authentication, which allows the user to delegate credentials. This option is designed for commands that run on one remote computer but collect data from or run additional commands on other remote computers.

Caution: CredSSP delegates the user's credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

Important: If the authentication parameter is not specified, then the Test-WSMan request will be sent to the remote machine anonymously (without using authentication). 
If the Test-WSMan request is made anonymously, it does not return any information that is specific to the operating-system version. 
Instead, Test-WSMan displays null values for the operating system version and service pack level (OS: 0.0.0 SP: 0.0).

```yaml
Type: AuthenticationMechanism
Parameter Sets: (All)
Aliases: auth,am

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint
Specifies the digital public key certificate (X509) of a user account that has permission to perform this action.
Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication. 
They can be mapped only to local user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use the Get-Item or Get-ChildItem command in the Windows PowerShell Cert: drive.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies the computer against which you want to run the management operation.
The value can be a fully qualified domain name, a NetBIOS name, or an IP address.
Use the local computer name, use localhost, or use a dot (.) to specify the local computer.
The local computer is the default.
When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: cn

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as "User01", "Domain01\User01", or User@Domain.com.
Or, enter a PSCredential object, such as one returned by the Get-Credential cmdlet.
When you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: cred,c

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port
Specifies the port to use when the client connects to the WinRM service.
When the transport is HTTP, the default port is 80.
When the transport is HTTPS, the default port is 443.
When you use HTTPS as the transport, the value of the ComputerName parameter must match the server's certificate common name (CN).

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

### -UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol should be used to establish a connection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all the Windows PowerShell content  that is transmitted over the network.
The UseSSL parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port that is used for the connection and you specify this parameter, the command fails.

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

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output object.

## NOTES
By default, the Test-WSMan cmdlet queries the WinRM service without using authentication, and it does not return any information that is specific to the operating-system version.
Instead, it displays null values for the operating system version and service pack level (OS: 0.0.0 SP: 0.0).

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

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

