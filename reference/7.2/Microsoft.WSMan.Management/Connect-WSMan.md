---
external help file: Microsoft.WSMan.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/connect-wsman?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Connect-WSMan
---

# Connect-WSMan

## SYNOPSIS
Connects to the WinRM service on a remote computer.

## SYNTAX

### ComputerName (Default)

```
Connect-WSMan [-ApplicationName <String>] [[-ComputerName] <String>] [-OptionSet <Hashtable>] [-Port <Int32>]
 [-SessionOption <SessionOption>] [-UseSSL] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [<CommonParameters>]
```

### URI

```
Connect-WSMan [-ConnectionURI <Uri>] [-OptionSet <Hashtable>] [-Port <Int32>] [-SessionOption <SessionOption>]
 [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Connect-WSMan** cmdlet connects to the WinRM service on a remote computer, and it establishes a persistent connection to the remote computer.
You can use this cmdlet in the context of the WSMan provider to connect to the WinRM service on a remote computer.
However, you can also use this cmdlet to connect to the WinRM service on a remote computer before you change to the WSMan provider.
The remote computer appears in the root directory of the WSMan provider.

Explicit credentials are required when the client and server computers are in different domains or workgroups.

For information about how to disconnect from the WinRM service on a remote computer, see the Disconnect-WSMan cmdlet.

## EXAMPLES

### Example 1: Connect to a remote computer

```
PS C:\> Connect-WSMan -ComputerName "server01"
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

The **Connect-WSMan** cmdlet is generally used in the context of the WSMan provider to connect to a remote computer, in this case the server01 computer.
However, you can use the cmdlet to establish connections to remote computers before you change to the WSMan provider.
Those connections appear in the **ComputerName** list.

### Example 2: Connect to a remote computer by using Administrator credentials

```
PS C:\> $cred = Get-Credential Administrator
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
**Get-Credential** prompts you for a password of username and password through a dialog box or at the command line, depending on system registry settings.

The second command uses the *Credential* parameter to pass the credentials stored in $cred to **Connect-WSMan**.
**Connect-WSMan** then connects to the remote system server01 by using the Administrator credentials.

### Example 3: Connect to a remote computer over a specified port

```
PS C:\> Connect-WSMan -ComputerName "server01" -Port 80
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
PS C:\> $a = New-WSManSessionOption -OperationTimeout 30000
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

This example creates a connection to the remote server01 computer by using the connection options that are defined in the **New-WSManSessionOption** command.

The first command uses **New-WSManSessionOption** to store a set of connection setting options in the $a variable.
In this case, the session options set a connection time out of 30 seconds (30,000 milliseconds).

The second command uses the *SessionOption* parameter to pass the credentials that are stored in the $a variable to **Connect-WSMan**.
Then, **Connect-WSMan** connects to the remote server01 computer by using the specified session options.

## PARAMETERS

### -ApplicationName
Specifies the application name in the connection.
The default value of the *ApplicationName* parameter is WSMAN.
The complete identifier for the remote endpoint is in the following format:

\<transport\>://\<server\>:\<port\>/\<ApplicationName\>

For example: `http://server01:8080/WSMAN`

Internet Information Services (IIS), which hosts the session, forwards requests with this endpoint to the specified application.
This default setting of WSMAN is appropriate for most uses.
This parameter is designed to be used if many computers establish remote connections to one computer that is running PowerShell.
In this case, IIS hosts Web Services for Management (WS-Management) for efficiency.

```yaml
Type: System.String
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
Type: Microsoft.WSMan.Management.AuthenticationMechanism
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

To get a certificate thumbprint, use the Get-Item or Get-ChildItem command in the PowerShell Cert: drive.

```yaml
Type: System.String
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
Type: System.String
Parameter Sets: ComputerName
Aliases: cn

Required: False
Position: 0
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
Type: System.Uri
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
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases: cred, c

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OptionSet
Specifies a set of switches to a service to modify or refine the nature of the request.
These resemble switches used in command-line shells because they are service specific.
Any number of options can be specified.

The following example demonstrates the syntax that passes the values 1, 2, and 3 for the a, b, and c parameters:

`-OptionSet @{a=1;b=2;c=3}`

```yaml
Type: System.Collections.Hashtable
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
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionOption
Specifies extended options for the WS-Management session.
Enter a **SessionOption** object that you create by using the New-WSManSessionOption cmdlet.
For more information about the options that are available, type `Get-Help New-WSManSessionOption`.

```yaml
Type: Microsoft.WSMan.Management.SessionOption
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

WS-Management encrypts all the PowerShell content that is transmitted over the network.
The *UseSSL* parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port that is used for the connection, and you specify this parameter, the command fails.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

* You can run management commands or query management data on a remote computer without creating a WS-Management session. You can do this by using the *ComputerName* parameters of Invoke-WSManAction and Get-WSManInstance. When you use the *ComputerName* parameter, PowerShell creates a temporary connection that is used for the single command. After the command runs, the connection is closed.

*

## RELATED LINKS

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Disconnect-WSMan](Disconnect-WSMan.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)

