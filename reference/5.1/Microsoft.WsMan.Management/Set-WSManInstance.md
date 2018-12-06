---
external help file: Microsoft.WSMan.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821736
schema: 2.0.0
title: Set-WSManInstance
---

# Set-WSManInstance

## SYNOPSIS
Modifies the management information that is related to a resource.

## SYNTAX

### ComputerName (Default)
```
Set-WSManInstance [-ApplicationName <String>] [-ComputerName <String>] [-Dialect <Uri>] [-FilePath <String>]
 [-Fragment <String>] [-OptionSet <Hashtable>] [-Port <Int32>] [-ResourceURI] <Uri>
 [[-SelectorSet] <Hashtable>] [-SessionOption <SessionOption>] [-UseSSL] [-ValueSet <Hashtable>]
 [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [<CommonParameters>]
```

### URI
```
Set-WSManInstance [-ConnectionURI <Uri>] [-Dialect <Uri>] [-FilePath <String>] [-Fragment <String>]
 [-OptionSet <Hashtable>] [-ResourceURI] <Uri> [[-SelectorSet] <Hashtable>] [-SessionOption <SessionOption>]
 [-ValueSet <Hashtable>] [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Set-WSManInstance** cmdlet modifies the management information that is related to a resource.

This cmdlet uses the WinRM connection/transport layer to modify the information.

## EXAMPLES

### Example 1: Disable a listener on the local computer
```
PS C:\> set-wsmaninstance -ResourceUri winrm/config/listener -SelectorSet @{address="*";transport="https"} -ValueSet @{Enabled="false"}
cfg                   : http://schemas.microsoft.com/wbem/wsman/1/config/listener
xsi                   : http://www.w3.org/2001/XMLSchema-instance
lang                  : en-US
Address               : *
Transport             : HTTPS
Port                  : 443
Hostname              :
Enabled               : false
URLPrefix             : wsman
CertificateThumbprint :
ListeningOn           : {127.0.0.1, 172.30.168.171, ::1, 2001:4898:0:fff:0:5efe:172.30.168.171...}
```

This command disables the https listener on the local computer.

Important: The *ValueSet* parameter is case-sensitive when matching the properties specified.

For example, in this command,

This fails: `-ValueSet @{enabled="False"}`

This succeeds: `-ValueSet @{Enabled="False"}`

### Example 2: Set the maximum envelope size on the local computer
```
PS C:\> Set-WSManInstance -ResourceUri winrm/config -ValueSet @{MaxEnvelopeSizekb = "200"}
cfg                 : http://schemas.microsoft.com/wbem/wsman/1/config
lang                : en-US
MaxEnvelopeSizekb   : 200
MaxTimeoutms        : 60000
MaxBatchItems       : 32000
MaxProviderRequests : 4294967295
Client              : Client
Service             : Service
Winrs               : Winrs
```

This command sets the MaxEnvelopeSizekb value to 200 on the local computer.

Important: *ValueSet* is case-sensitive when matching the properties specified.

### Example 3: Disable a listener on a remote computer
```
PS C:\> Set-WSManInstance -ResourceUri winrm/config/listener -ComputerName "SERVER02" -SelectorSet @{address="*";transport="https"} -ValueSet @{Enabled="false"}
cfg                   : http://schemas.microsoft.com/wbem/wsman/1/config/listener
xsi                   : http://www.w3.org/2001/XMLSchema-instance
lang                  : en-US
Address               : *
Transport             : HTTPS
Port                  : 443
Hostname              :
Enabled               : false
URLPrefix             : wsman
CertificateThumbprint :
ListeningOn           : {127.0.0.1, 172.30.168.172, ::1, 2001:4898:0:fff:0:5efe:172.30.168.172...}
```

This command disables the https listener on the remote computer SERVER02.

Important: *ValueSet* is case-sensitive when matching the properties specified.

## PARAMETERS

### -ApplicationName
Specifies the application name in the connection.
The default value of the *ApplicationName* parameter is WSMAN.
The complete identifier for the remote endpoint is in the following format:

\<transport\>://\<server\>:\<port\>/\<ApplicationName\>

For example: `http://server01:8080/WSMAN`

Internet Information Services (IIS), which hosts the session, forwards requests with this endpoint to the specified application.
This default setting of WSMAN is appropriate for most uses.
This parameter is designed to be used if many computers establish remote connections to one computer that is running Windows PowerShell.
In this case, IIS hosts Web Services for Management (WS-Management) for efficiency.

```yaml
Type: String
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication
Specifies the authentication mechanism to be used at the server.
The acceptable values for this parameter are:

- Basic.
Basic is a scheme in which the user name and password are sent in clear text to the server or proxy.
- Default.
Use the authentication method implemented by the WS-Management protocol.
This is the default.
- Digest.
Digest is a challenge-response scheme that uses a server-specified data string for the challenge.
- Kerberos.
The client computer and the server mutually authenticate by using Kerberos certificates.
- Negotiate.
Negotiate is a challenge-response scheme that negotiates with the server or proxy to determine the scheme to use for authentication.
For example, this parameter value allows for negotiation to determine whether the Kerberos protocol or NTLM is used.
- CredSSP.
Use Credential Security Support Provider (CredSSP) authentication, which lets the user delegate credentials.
This option is designed for commands that run on one remote computer but collect data from or run additional commands on other remote computers.

Caution: CredSSP delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: (All)
Aliases: auth, am
Accepted values: None, Default, Digest, Negotiate, Basic, Kerberos, ClientCertificate, Credssp

Required: False
Position: Named
Default value: None
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies the computer against which to run the management operation.
The value can be a fully qualified domain name, a NetBIOS name, or an IP address.
Use the local computer name, use localhost, or use a dot (.) to specify the local computer.
The local computer is the default.
When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.
You can pipe a value for this parameter to the cmdlet.

```yaml
Type: String
Parameter Sets: ComputerName
Aliases: cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionURI
Specifies the connection endpoint.
The format of this string is as follows:

\<Transport\>://\<Server\>:\<Port\>/\<ApplicationName\>

The following string is a correctly formatted value for this parameter:

`http://Server01:8080/WSMAN`

The URI must be fully qualified.

```yaml
Type: Uri
Parameter Sets: URI
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as User01, Domain01\User01, or User@Domain.com.
Or, enter a **PSCredential** object, such as one returned by the Get-Credential cmdlet.
When you type a user name, this cmdlet prompts you for a password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: cred, c

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Dialect
Specifies the dialect to use in the filter predicate.
This can be any dialect that is supported by the remote service.
The following aliases can be used for the dialect URI:

- WQL.
http://schemas.microsoft.com/wbem/wsman/1/WQL
- Selector.
http://schemas.microsoft.com/wbem/wsman/1/wsman/SelectorFilter
- Association.
http://schemas.dmtf.org/wbem/wsman/1/cimbinding/associationFilter

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies the path of a file that is used to create a management resource.
You specify the management resource by using the *ResourceURI* parameter and the *SelectorSet* parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Fragment
Specifies a section inside the instance that is to be updated or retrieved for the specified operation.
For example, to get the status of a spooler service, specify the following:

`-Fragment Status`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptionSet
Specifies a set of switches to a service to modify or refine the nature of the request.
These resemble switches used in command-line shells because they are service specific.
Any number of options can be specified.

The following example demonstrates the syntax that passes the values 1, 2, and 3 for the a, b, and c parameters:

`-OptionSet @{a=1;b=2;c=3}`

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: os

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specifies the port to use when the client connects to the WinRM service.
When the transport is HTTP, the default port is 80.
When the transport is HTTPS, the default port is 443.

When you use HTTPS as the transport, the value of the *ComputerName* parameter must match the server's certificate common name (CN).
However, if the *SkipCNCheck* parameter is specified as part of the *SessionOption* parameter, the certificate common name of the server does not have to match the host name of the server.
The *SkipCNCheck* parameter should be used only for trusted computers.

```yaml
Type: Int32
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceURI
Specifies the URI of the resource class or instance.
The URI is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path of a resource.
For example:

`http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk`

`http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor`

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: ruri

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SelectorSet
Specifies a set of value pairs that are used to select particular management resource instances.
*SelectorSet* is used when more than one instance of the resource exists.
The value of *SelectorSet* must be a hash table.

The following example shows how to enter a value for this parameter:

`-SelectorSet @{Name="WinRM";ID="yyy"}`

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SessionOption
Specifies extended options for the WS-Management session.
Enter a **SessionOption** object that you create by using the New-WSManSessionOption cmdlet.
For more information about the options that are available, type `Get-Help New-WSManSessionOption`.

```yaml
Type: SessionOption
Parameter Sets: (All)
Aliases: so

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol is used to establish a connection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all the Windows PowerShell content that is transmitted over the network.
The *UseSSL* parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port that is used for the connection, and you specify this parameter, the command fails.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerName
Aliases: ssl

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueSet
Specifies a hash table that helps modify a management resource.
You specify the management resource by using *ResourceURI* and *SelectorSet*.
The value of the *ValueSet* parameter must be a hash table.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)