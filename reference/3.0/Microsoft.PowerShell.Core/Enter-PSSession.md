---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=135210
external help file:  System.Management.Automation.dll-Help.xml
title:  Enter-PSSession
---
# Enter-PSSession

## SYNOPSIS

Starts an interactive session with a remote computer.

## SYNTAX

### ComputerName (Default)

```
Enter-PSSession [-ComputerName] <String> [-EnableNetworkAccess] [-Credential <PSCredential>] [-Port <Int32>]
 [-UseSSL] [-ConfigurationName <String>] [-ApplicationName <String>] [-SessionOption <PSSessionOption>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [<CommonParameters>]
```

### Session

```
Enter-PSSession [[-Session] <PSSession>] [<CommonParameters>]
```

### Uri

```
Enter-PSSession [[-ConnectionUri] <Uri>] [-EnableNetworkAccess] [-Credential <PSCredential>]
 [-ConfigurationName <String>] [-AllowRedirection] [-SessionOption <PSSessionOption>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [<CommonParameters>]
```

### InstanceId

```
Enter-PSSession [-InstanceId <Guid>] [<CommonParameters>]
```

### Id

```
Enter-PSSession [[-Id] <Int32>] [<CommonParameters>]
```

### Name

```
Enter-PSSession [-Name <String>] [<CommonParameters>]
```

## DESCRIPTION

The **Enter-PSSession** cmdlet starts an interactive session with a single remote computer.
During the session, the commands that you type run on the remote computer, just as though you were typing directly on the remote computer.
You can have only one interactive session at a time.

Typically, you use the **ComputerName** parameter to specify the name of the remote computer.
However, you can also use a session that you create by using the New-PSSession cmdlet for the interactive session.
However, you cannot use the Disconnect-PSSession, Connect-PSSession, or Receive-PSSession cmdlets to disconnect from or re-connect to an interactive session.

To end the interactive session and disconnect from the remote computer, use the Exit-PSSession cmdlet, or type "exit".

## EXAMPLES

### Example 1

```
PS> Enter-PSSession
[localhost]: PS>
```

This command starts an interactive session on the local computer.
The command prompt changes to indicate that you are now running commands in a different session.

The commands that you enter run in the new session, and the results are returned to the default session as text.

### Example 2

```
PS> Enter-PSSession -ComputerName Server01
[Server01]: PS>
[Server01]: PS> Get-Process PowerShell > C:\ps-test\Process.txt
[Server01]: PS> exit
PS>
PS> dir C:\ps-test\process.txt
```

```output
Get-ChildItem : Cannot find path 'C:\ps-test\process.txt' because it does not exist.
At line:1 char:4
+ dir <<<<  c:\ps-test\process.txt
```

The first command uses the Enter-PSSession cmdlet to start an interactive session with Server01, a remote computer. When the session starts, the command prompt changes to include the computer name.

The second command gets the PowerShell process and redirects the output to the Process.txt file. The command is submitted to the remote computer, and the file is saved on the remote computer.

The third command uses the Exit keyword to end the interactive session and close the connection.

The fourth command confirms that the Process.txt file is on the remote computer. A Get-ChildItem ("dir") command on the local computer cannot find the file.

### Example 3

```
PS> $s = New-PSSession -ComputerName Server01
PS> Enter-PSSession -Session $s
[Server01]: PS>
```

These commands use the Session parameter of Enter-PSSession to run the interactive session in an existing Windows PowerShell session (PSSession).

### Example 4

```
PS> Enter-PSSession -ComputerName Server01 -Port 90 -Credential Domain01\User01
[Server01]: PS>
```

This command starts an interactive session with the Server01 computer.
It uses the Port parameter to specify the port and the Credential parameter to specify the account of a user with permission to connect to the remote computer.

### Example 5

```
PS> Enter-PSSession -ComputerName Server01
[Server01]: PS> Exit-PSSession
PS>
```

This example shows how to start and stop an interactive session.
The first command uses the Enter-PSSession cmdlet to start an interactive session with the Server01 computer.

The second command uses the Exit-PSSession cmdlet to end the session.
You can also use the Exit keyword to end the interactive session.
Exit-PSSession and Exit have the same effect.

## PARAMETERS

### -AllowRedirection

Allows redirection of this connection to an alternate Uniform Resource Identifier (URI).
By default, redirection is not allowed.

When you use the **ConnectionURI** parameter, the remote destination can return an instruction to redirect to a different URI.
By default, Windows PowerShell does not redirect connections, but you can use this parameter to allow it to redirect the connection.

You can also limit the number of times the connection is redirected by changing the **MaximumConnectionRedirectionCount** session option value.
Use the  **MaximumRedirection** parameter of the New-PSSessionOption cmdlet or set the **MaximumConnectionRedirectionCount** property of the **$PSSessionOption** preference variable.
The default value is 5.

```yaml
Type: SwitchParameter
Parameter Sets: Uri
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName

Specifies the application name segment of the connection URI.
Use this parameter to specify the application name when you are not using the ConnectionURI parameter in the command.

The default value is the value of the $PSSessionApplicationName preference variable on the local computer.
If this preference variable is not defined, the default value is WSMAN.
This value is appropriate for most uses.
For more information, see [about_Preference_Variables](./About/about_Preference_Variables.md).

The WinRM service uses the application name to select a listener to service the connection request.
The value of this parameter should match the value of the URLPrefix property of a listener on the remote computer.

```yaml
Type: String
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: WSMAN
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Authentication

Specifies the mechanism that is used to authenticate the user's credentials.
Valid values are "Default", "Basic", "Credssp", "Digest", "Kerberos", "Negotiate", and "NegotiateWithImplicitCredential".
The default value is "Default".

CredSSP authentication is available only in Windows Vista, Windows Server 2008, and later versions of Windows.

For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](/dotnet/api/system.management.automation.runspaces.authenticationmechanism) in the MSDN library.

Caution: Credential Security Support Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: ComputerName, Uri
Aliases:

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

To get a certificate, use the Get-Item or Get-ChildItem command in the Windows PowerShell Cert: drive.

```yaml
Type: String
Parameter Sets: ComputerName, Uri
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Starts an interactive session with the specified remote computer.
Enter only one computer name.
The default is the local computer.

Type the NetBIOS name, the IP address, or the fully qualified domain name of the computer.
You can also pipe a computer name to Enter-PSSession.

To use an IP address in the value of the ComputerName parameter, the command must include the Credential parameter.
Also, the computer must be configured for HTTPS transport or the IP address of the remote computer must be included in the WinRM TrustedHosts list on the local computer.
For instructions for adding a computer name to the TrustedHosts list, see "How to Add  a Computer to the Trusted Host List" in [about_Remote_Troubleshooting](./About/about_Remote_Troubleshooting.md).

Note:  In Windows Vista and later versions of Windows, to include the local computer in the value of the ComputerName parameter, you must start Windows PowerShell with the "Run as administrator" option.

```yaml
Type: String
Parameter Sets: ComputerName
Aliases: Cn

Required: True
Position: 1
Default value: Local computer
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ConfigurationName

Specifies the session configuration that is used for the interactive session.

Enter a configuration name or the fully qualified resource URI for a session configuration.
If you specify only the configuration name, the following schema URI is prepended:  http://schemas.microsoft.com/powershell.

The session configuration for a session is located on the remote computer.
If the specified session configuration does not exist on the remote computer, the command fails.

The default value is the value of the $PSSessionConfigurationName preference variable on the local computer.
If this preference variable is not set, the default is Microsoft.PowerShell.
For more information, see [about_Preference_Variables](./About/about_Preference_Variables.md).

```yaml
Type: String
Parameter Sets: ComputerName, Uri
Aliases:

Required: False
Position: Named
Default value: Microsoft.PowerShell
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionUri

Specifies a Uniform Resource Identifier (URI) that defines the connection endpoint for the session.
The URI must be fully qualified.
The format of this string is as follows:

\<Transport\>://\<ComputerName\>:\<Port\>/\<ApplicationName\>

The default value is as follows:

http://localhost:5985/WSMAN

If you do not specify a **ConnectionURI**, you can use the **UseSSL**, **ComputerName**, **Port**, and **ApplicationName** parameters to specify the **ConnectionURI** values.

Valid values for the Transport segment of the URI are HTTP and HTTPS.
If you specify a connection URI with a Transport segment, but do not specify a port, the session is created with standards ports: 80 for HTTP and 443 for HTTPS.
To use the default ports for Windows PowerShell remoting, specify port 5985 for HTTP or 5986 for HTTPS.

If the destination computer redirects the connection to a different URI, Windows PowerShell prevents the redirection unless you use the **AllowRedirection** parameter in the command.

```yaml
Type: Uri
Parameter Sets: Uri
Aliases: URI, CU

Required: False
Position: 2
Default value: Http://localhost:80/WSMAN
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01", "Domain01\User01", or "User@Domain.com", or enter a PSCredential object, such as one returned by the Get-Credential cmdlet.

When you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: ComputerName, Uri
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnableNetworkAccess

Adds an interactive security token to loopback sessions.
The interactive token lets you run commands in the loopback session that get data from other computers.
For example, you can run a command in the session that copies XML files from a remote computer to the local computer.

A "loopback session" is a PSSession that originates and terminates on the same computer.
To create a loopback session, omit the **ComputerName** parameter or set its value to ".", "localhost", or the name of the local computer.

By default, loopback sessions are created with a network token, which might not provide sufficient permission to authenticate to remote computers.

The **EnableNetworkAccess** parameter is effective only in loopback sessions.
If you use the **EnableNetworkAccess** parameter when creating a session on a remote computer, the command succeeds, but the parameter is ignored.

You can also allow remote access in a loopback session by using the **CredSSP** value of the **Authentication** parameter, which delegates the session credentials to other computers.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerName, Uri
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the ID of an existing session.
Enter-PSSession uses the specified session for the interactive session.

To find the ID of a session, use the Get-PSSession cmdlet.

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies the instance ID of an existing session.
Enter-PSSession uses the specified session for the interactive session.

The instance ID is a GUID.
To find the instance ID of a session, use the Get-PSSession cmdlet.
You can also use the Session, Name, or ID parameters to specify an existing session.
Or, you can use the ComputerName parameter to start a temporary session.

```yaml
Type: Guid
Parameter Sets: InstanceId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the friendly name of an existing session.
Enter-PSSession uses the specified session for the interactive session.

If the name that you specify matches more than one session, the command fails.
You can also use the Session, InstanceID, or ID parameters to specify an existing session.
Or, you can use the ComputerName parameter to start a temporary session.

To establish a friendly name for a session, use the Name parameter of the New-PSSession cmdlet.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port

Specifies the network port  on the remote computer used for this command.
To connect to a remote computer, the remote computer must be listening on the port that the connection uses.
The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Before using an alternate port, you must configure the WinRM listener on the remote computer to listen at that port.
Use the following commands to configure the listener:

`1.
winrm delete winrm/config/listener?Address=*+Transport=HTTP`

`2.
winrm create winrm/config/listener?Address=*+Transport=HTTP @{Port="\<port-number\>"}`

Do not use the **Port** parameter unless you must.
The port setting in the command applies to all computers or sessions on which the command runs.
An alternate port setting might prevent the command from running on all computers.

```yaml
Type: Int32
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: 5985, 5986
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session

Specifies a Windows PowerShell session (PSSession) to use for the interactive session.
This parameter takes a session object.
You can also use the Name, InstanceID, or ID parameters to specify a PSSession.

Enter a variable that contains a session object or a command that creates or gets a session object, such as a New-PSSession or Get-PSSession command.
You can also pipe a session object to Enter-PSSession.
You can submit only one PSSession with this parameter.
If you enter a variable that contains more than one PSSession, the command fails.

When you use Exit-PSSession or the EXIT keyword, the interactive session ends, but the PSSession that you created remains open and available for use.

```yaml
Type: PSSession
Parameter Sets: Session
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SessionOption

Sets advanced options for the session.
Enter a **SessionOption** object, such as one that you create by using the New-PSSessionOption cmdlet, or a hash table in which the keys are session option names and the values are session option values.

The default values for the options are determined by the value of the **$PSSessionOption** preference variable, if it is set.
Otherwise, the default values are established by options set in the session configuration.

The session option values take precedence over default values for sessions set in the **$PSSessionOption** preference variable and in the session configuration.
However, they do not take precedence over maximum values, quotas or limits set in the session configuration.

For a description of the session options, including the default values, see New-PSSessionOption.
For information about the **$PSSessionOption** preference variable, see [about_Preference_Variables](About/about_Preference_Variables.md).
For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

```yaml
Type: PSSessionOption
Parameter Sets: ComputerName, Uri
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL

Uses the Secure Sockets Layer (SSL) protocol to establish a connection to the remote computer.
By default, SSL is not used.

WS-Management encrypts all Windows PowerShell content transmitted over the network.
UseSSL is an additional protection that sends the data across an HTTPS connection instead of an HTTP connection.

If you use this parameter, but SSL is not available on the port used for the command, the command fails.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerName
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.String or System.Management.Automation.Runspaces.PSSession

You can pipe a computer name (a string) or a session object to Enter-PSSession.

## OUTPUTS

### None

The cmdlet does not return any output.

## NOTES

- To connect to a remote computer, you must be a member of the Administrators group on the remote computer.
- In Windows Vista and later versions of Windows, to start an interactive session on the local computer, you must start Windows PowerShell with the "Run as administrator" option.
- When you use Enter-PSSession, your user profile on the remote computer is used for the interactive session. The commands in the remote user profile, including commands to add Windows PowerShell snap-ins and to change the command prompt, run before the remote prompt is displayed.
- Enter-PSSession uses the UI culture setting on the local computer for the interactive session. To find the local UI culture, use the $UICulture automatic variable.
- Enter-PSSession requires the Get-Command, Out-Default, and Exit-PSSession cmdlets. If these cmdlets are not included in the session configuration on the remote computer, the Enter-PSSession commands fails.
- Unlike Invoke-Command, which parses and interprets the commands before sending them to the remote computer, Enter-PSSession sends the commands directly to the remote computer without interpretation.
- If the session that you want to enter is busy processing a command, there might be a delay before Windows PowerShell responds to the Enter-PSSession command. You will be connected as soon as the session is available. To cancel the Enter-PSSession command, press CTRL+C.

## RELATED LINKS

[Exit-PSSession](Exit-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Invoke-Command](Invoke-Command.md)

[New-PSSession](New-PSSession.md)

[Remove-PSSession](Remove-PSSession.md)

[Connect-PSSession](Connect-PSSession.md)

[Disconnect-PSSession](Disconnect-PSSession.md)

[Receive-PSSession](Receive-PSSession.md)

[about_PSSessions](About/about_PSSessions.md)

[about_Remote](About/about_Remote.md)