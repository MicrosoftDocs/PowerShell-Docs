---
external help file: PSITPro5_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294034
schema: 2.0.0
---

# Connect-WSMan
## SYNOPSIS
Connects to the WinRM service on a remote computer.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Connect-WSMan [[-ComputerName] <String>] [-ApplicationName <String>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-Credential <PSCredential>]
 [-OptionSet <Hashtable>] [-Port <Int32>] [-SessionOption <SessionOption>] [-UseSSL]
```

### UNNAMED_PARAMETER_SET_2
```
Connect-WSMan [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-ConnectionURI <Uri>] [-Credential <PSCredential>] [-OptionSet <Hashtable>] [-Port <Int32>]
 [-SessionOption <SessionOption>]
```

## DESCRIPTION
The Connect-WSMan cmdlet connects to the WinRM service on a remote computer, and it establishes a persistent connection to the remote computer.
You can use this cmdlet in the context of the WSMan provider to connect to the WinRM service on a remote computer.
However, you can also use this cmdlet to connect to the WinRM service on a remote computer before you change to the WSMan provider.
The remote computer appears in the root directory of the WSMan provider.

Explicit credentials are required when the client and server computers are in different domains or workgroups.

For information about how to disconnect from the WinRM service on a remote computer, see the Disconnect-WSMan cmdlet.

## EXAMPLES

### Example 1: Connect to a remote computer
```
PS C:\>Connect-WSMan -ComputerName "server01"
PS C:\> cd wsman:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan

ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01                                      Container
```

This command creates a connection to the remote server01 computer.

The Connect-WSMan cmdlet is generally used in the context of the WSMan provider to connect to a remote computer, in this case the server01 computer.
However, you can use the cmdlet to establish connections to remote computers before you change to the WSMan provider.
Those connections appear in the ComputerName list.

### Example 2: Connect to a remote computer by using Administrator credentials
```
PS C:\>$cred = Get-Credential Administrator
PS C:\> Connect-WSMan -ComputerName "server01" -Credential $cred
PS C:\> cd wsman:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan

ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01                                      Container
```

This command creates a connection to the remote system server01 using the Administrator account credentials.

The first command uses the Get-Credential cmdlet to get the Administrator credentials and then stores them in the $cred variable.
Get-Credential prompts you for a password of username and password through a dialog box or at the command line, depending on system registry settings.

The second command uses the Credential parameter to pass the credentials stored in $cred to Connect-WSMan.
Connect-WSMan then connects to the remote system server01 by using the Administrator credentials.

### Example 3: Connect to a remote computer over a specified port
```
PS C:\>Connect-WSMan -ComputerName "server01" -Port 80
PS C:\> cd wsman:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan
ComputerName                                  Type
------------                                  ----
localhost                                     Container
server01                                      Container
```

This command creates a connection to the remote server01 computer over port 80.

### Example 4: Connect to a remote computer by using connection options
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

This example creates a connection to the remote server01 computer by using the connection options that are defined in the New-WSManSessionOption command.

The first command uses New-WSManSessionOption to store a set of connection setting options in the $a variable.
In this case, the session options set a connection time out of 30 seconds (30,000 milliseconds).

The second command uses the SessionOption parameter to pass the credentials that are stored in the $a variable to Connect-WSMan.
Then, Connect-WSMan connects to the remote server01 computer by using the specified session options.

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
Default value: Default
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
Position: 1
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
Aliases: 

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
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
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

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* You can run management commands or query management data on a remote computer without creating a WS-Management session. You can do this by using the ComputerName parameters of Invoke-WSManAction and Get-WSManInstance. When you use the ComputerName parameter, Windows PowerShell creates a temporary connection that is used for the single command. After the command runs, the connection is closed.

*

## RELATED LINKS

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

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

