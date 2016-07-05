---
external help file: PSITPro5_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294041
schema: 2.0.0
---

# New-WSManInstance
## SYNOPSIS
Creates a new instance of a management resource.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
New-WSManInstance [-ResourceURI] <Uri> [-SelectorSet] <Hashtable> [-ApplicationName <String>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-ComputerName <String>]
 [-Credential <PSCredential>] [-FilePath <String>] [-OptionSet <Hashtable>] [-Port <Int32>]
 [-SessionOption <SessionOption>] [-UseSSL] [-ValueSet <Hashtable>]
```

### UNNAMED_PARAMETER_SET_2
```
New-WSManInstance [-ResourceURI] <Uri> [-SelectorSet] <Hashtable> [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [-ConnectionURI <Uri>] [-Credential <PSCredential>] [-FilePath <String>]
 [-OptionSet <Hashtable>] [-SessionOption <SessionOption>] [-ValueSet <Hashtable>]
```

## DESCRIPTION
The New-WSManInstance cmdlet creates a new instance of a management resource.
It uses a resource Uniform Resource Identifier (URI) and a value set or input file to create the new instance of the management resource.

This cmdlet uses the WinRM connection/transport layer to create the management resource instance.

## EXAMPLES

### Example 1: Create a HTTPS listener
```
PS C:\>New-WSManInstance - ResourceURI winrm/config/Listener -SelectorSet @{Transport=HTTPS} -ValueSet @{Hostname="HOST";CertificateThumbprint="XXXXXXXXXX"}
```

This command creates an instance of a WS-Management HTTPS listener on all IP addresses.

## PARAMETERS

### -ApplicationName
Specifies the application name in the connection.
The default value of the ApplicationName parameter is WSMAN.
The complete identifier for the remote endpoint is in the following format: 

\<transport\>://\<server\>:\<port\>/\<ApplicationName\>

For example: http://server01:8080/WSMAN

Internet Information Services (IIS), which hosts the session, forwards requests with this endpoint to the specified application.
This default setting of WSMAN is appropriate for most uses.
This parameter is designed to be used if many computers establish remote connections to one computer that is running Windows PowerShell.
In this case, IIS hosts Web Services for Management (WS-Management) for efficiency.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: Wsman
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
Specifies the computer against which to run the management operation.
The value can be a fully qualified domain name, a NetBIOS name, or an IP address.
Use the local computer name, use localhost, or use a dot (.) to specify the local computer.
The local computer is the default.
When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.
You can pipe a value for this parameter to the cmdlet.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: cn

Required: False
Position: Named
Default value: Localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionURI
Specifies the connection endpoint.
The format of this string is as follows: 

\<Transport\>://\<Server\>:\<Port\>/\<ApplicationName\>

The following string is a correctly formatted value for this parameter: 

http://Server01:8080/WSMAN

The URI must be fully qualified.

```yaml
Type: Uri
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: CURI,CU

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as User01, Domain01\User01, or User@Domain.com.
Or, enter a PSCredential object, such as one returned by the Get-Credential cmdlet.
When you type a user name, this cmdlet prompts you for a password.

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

### -FilePath
Specifies the path of a file that is used to create a management resource.
You specify the management resource by using the ResourceURI parameter and the SelectorSet parameter.

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

### -OptionSet
Specifies a set of switches to a service to modify or refine the nature of the request.
These resemble switches used in command-line shells because they are service specific.
Any number of options can be specified.

The following example demonstrates the syntax that passes the values 1, 2, and 3 for the a, b, and c parameters:

-OptionSet @{a=1;b=2;c=3}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: os

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specifies the port to use when the client connects to the WinRM service.
When the transport is HTTP, the default port is 80.
When the transport is HTTPS, the default port is 443.

When you use HTTPS as the transport, the value of the ComputerName parameter must match the server's certificate common name (CN).
However, if the SkipCNCheck parameter is specified as part of the SessionOption parameter, the certificate common name of the server does not have to match the host name of the server.
The SkipCNCheck parameter should be used only for trusted computers.

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceURI
Specifies the URI of the resource class or instance.
The URI is used to identify a specific type of resource, such as disks or processes, on a computer.

A URI consists of a prefix and a path of a resource.
For example:

http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk

http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: ruri

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SelectorSet
Specifies a set of value pairs that are used to select particular management resource instances.
SelectorSet is used when more than one instance of the resource exists.
The value of SelectorSet must be a hash table.

The following example shows how to enter a value for this parameter:

-SelectorSet @{Name="WinRM";ID="yyy"}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SessionOption
Specifies extended options for the WS-Management session.
Enter a SessionOption object that you create by using the New-WSManSessionOption cmdlet.
For more information about the options that are available, type Get-Help New-WSManSessionOption.

```yaml
Type: SessionOption
Parameter Sets: (All)
Aliases: so

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol is used to establish a connection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all the Windows PowerShell content that is transmitted over the network.
The UseSSL parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port that is used for the connection, and you specify this parameter, the command fails.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueSet
Specifies a hash table that helps modify a management resource.
You specify the management resource by using ResourceURI and SelectorSet.
The value of the ValueSet parameter must be a hash table.

```yaml
Type: Hashtable
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
This cmdlet does not generate any output.

## NOTES
* The Set-WmiInstance cmdlet, a Windows Management Instrumentation (WMI) cmdlet, is similar. Set-WmiInstance uses the DCOM connection/transport layer to create or update WMI instances.

*

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

