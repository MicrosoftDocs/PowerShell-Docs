---
ms.date: 5/15/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=210604
external help file:  System.Management.Automation.dll-Help.xml
title:  Connect-PSSession
---
# Connect-PSSession

## SYNOPSIS
Reconnects to disconnected sessions

## SYNTAX

### Name (Default)

```
Connect-PSSession -Name <String[]> [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Session

```
Connect-PSSession [-Session] <PSSession[]> [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerNameGuid

```
Connect-PSSession [-ComputerName] <String[]> [-ApplicationName <String>] [-ConfigurationName <String>]
 -InstanceId <Guid[]> [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [-Port <Int32>] [-UseSSL] [-SessionOption <PSSessionOption>]
 [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerName

```
Connect-PSSession [-ComputerName] <String[]> [-ApplicationName <String>] [-ConfigurationName <String>]
 [-Name <String[]>] [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [-Port <Int32>] [-UseSSL] [-SessionOption <PSSessionOption>]
 [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUri

```
Connect-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri[]> [-AllowRedirection] [-Name <String[]>]
 [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-SessionOption <PSSessionOption>] [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUriGuid

```
Connect-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri[]> [-AllowRedirection]
 -InstanceId <Guid[]> [-Credential <PSCredential>] [-Authentication <AuthenticationMechanism>]
 [-CertificateThumbprint <String>] [-SessionOption <PSSessionOption>] [-ThrottleLimit <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### InstanceId

```
Connect-PSSession -InstanceId <Guid[]> [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Id

```
Connect-PSSession [-ThrottleLimit <Int32>] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Connect-PSSession** cmdlet reconnects to user-managed Windows PowerShell sessions
("PSSessions") that were disconnected.
It works on sessions that are disconnected intentionally, such as by using the Disconnect-PSSession
cmdlet or the **InDisconnectedSession** parameter of the Invoke-Command cmdlet, and those that were
disconnected unintentionally, such as by a temporary network outage.

**Connect-PSSession** can connect to any disconnected session that was started by the same user,
including those that were started by or disconnected from other sessions on other computers.

However, **Connect-PSSession** cannot connect to broken or closed sessions, or interactive sessions
started by using the Enter-PSSession cmdlet.
Also you cannot connect sessions to sessions started by other users, unless you can provide the
credentials of the user who created the session.

For more information about the Disconnected Sessions feature, see 
[about_Remote_Disconnected_Sessions](./About/about_Remote_Disconnected_Sessions.md).

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1

```
PS> Connect-PSSession -ComputerName Server01 -Name ITTask
Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 4 ITTask          Server01        Opened        ITTasks                  Available
```

This command reconnects to the ITTask session on the Server01 computer.

The output shows that the command was successful.
The **State** of the session is **Opened** and the **Availability** is **Available**, indicating
that you can run commands in the session.

### Example 2

```
PS> Get-PSSession

Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 Backups         Localhost       Opened        Microsoft.PowerShell     Available


PS> Get-PSSession | Disconnect-PSSession

Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 Backups         Localhost       Disconnected  Microsoft.PowerShell          None


PS> Get-PSSession | Connect-PSSession

Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 Backups         Localhost       Opened        Microsoft.PowerShell     Available
```

This example shows the effect of disconnecting and then reconnecting to a session.

The first command uses the Get-PSSession cmdlet.
Without the **ComputerName** parameter, the command gets only sessions that were created in the
current session.

The output shows that the command gets the Backups session on the local computer.
The **State** of the session is **Opened** and the **Availability** is **Available**.

The second command uses the **Get-PSSession** cmdlet to get the PSSessions that were created in the
current session and the Disconnect-PSSession cmdlet to disconnect the sessions.
The output shows that the Backups session was disconnected.
The **State** of the session is **Disconnected** and the **Availability** is **None**.

The third command uses the **Get-PSSession** cmdlet to get the PSSessions that were created in the
current session and the **Connect-PSSession** cmdlet to reconnect the sessions.
The output shows that the Backups session was reconnected.
The **State** of the session is **Opened** and the **Availability** is **Available**.

If you use the **Connect-PSSession** cmdlet on a session that is not disconnected, the command has
no effect on the session and it does not generate any errors.

### Example 3

```
The administrator begins by creating a sessions on a remote computer and running a script in the session.The first command uses the New-PSSession cmdlet to create the ITTask session on the Server01 remote computer. The command uses the **ConfigurationName** parameter to specify the ITTasks session configuration. The command saves the sessions in the $s variable.
PS> $s = New-PSSession -ComputerName Server01 -Name ITTask -ConfigurationName ITTasks

 The second command **Invoke-Command** cmdlet to start a background job in the session in the $s variable. It uses the **FilePath** parameter to run the script in the background job.
PS> Invoke-Command -Session $s {Start-Job -FilePath \\Server30\Scripts\Backup-SQLDatabase.ps1}
Id     Name            State         HasMoreData     Location             Command
--     ----            -----         -----------     --------             -------
2      Job2            Running       True            Server01             \\Server30\Scripts\Backup...

The third command uses the Disconnect-PSSession cmdlet to disconnect from the session in the $s variable. The command uses the **OutputBufferingMode** parameter with a value of **Drop** to prevent the script from being blocked by having to deliver output to the session. It uses the **IdleTimeoutSec** parameter to extend the session timeout to 15 hours.When the command completes, the administrator locks her computer and goes home for the evening.
PS> Disconnect-PSSession -Session $s -OutputBufferingMode Drop -IdleTimeoutSec 60*60*15
Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 ITTask          Server01        Disconnected  ITTasks               None

Later that evening, the administrator starts her home computer, logs on to the corporate network, and starts Windows PowerShell. The fourth command uses the  Get-PSSession cmdlet to get the sessions on the Server01 computer. The command finds the ITTask session.The fifth command uses the **Connect-PSSession** cmdlet to connect to the ITTask session. The command saves the session in the $s variable.
PS> Get-PSSession -ComputerName Server01 -Name ITTask

Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 ITTask          Server01        Disconnected  ITTasks               None


PS> $s = Connect-PSSession -ComputerName Server01 -Name ITTask


Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 ITTask          Server01        Opened        ITTasks               Available

The sixth command uses the Invoke-Command cmdlet to run a Get-Job command in the session in the $s variable. The output shows that the job completed successfully.The seventh command uses the **Invoke-Command** cmdlet to run a Receive-Job command in the session in the $s variable in the session. The command saves the results in the $BackupSpecs variable.The eighth command uses the **Invoke-Command** cmdlet to runs another script in the session. The command uses the value of the $BackupSpecs variable in the session as input to the script.


PS> Invoke-Command -Session $s {Get-Job}

Id     Name            State         HasMoreData     Location             Command
--     ----            -----         -----------     --------             -------
2      Job2            Completed     True            Server01             \\Server30\Scripts\Backup...

PS> Invoke-Command -Session $s {$BackupSpecs = Receive-Job -JobName Job2}

PS> Invoke-Command -Session $s {\\Server30\Scripts\New-SQLDatabase.ps1 -InitData $BackupSpecs.Initialization}

The ninth command disconnects from the session in the $s variable.The administrator closes Windows PowerShell and closes the computer. She can reconnect to the session on the next day and check the script status from her work computer.
PS> Disconnect-PSSession -Session $s -OutputBufferingMode Drop -IdleTimeoutSec 60*60*15
Id Name            ComputerName    State         ConfigurationName     Availability
-- ----            ------------    -----         -----------------     ------------
 1 ITTask          Server01        Disconnected  ITTasks               None
```

This series of commands shows how the **Connect-PSSession** cmdlet might be used in an enterprise
scenario.
In this case, a system administrator starts a long-running job in a session on a remote computer.
After starting the job, the administrator disconnects from the session and goes home.
Later that evening, the administrator logs on to her home computer and verifies that the job ran to
completion.

## PARAMETERS

### -Authentication

Specifies the mechanism that is used to authenticate the user's credentials in the command to
reconnect to the disconnected session.
Valid values are **Default**, **Basic**, **Credssp**, **Digest**, **Kerberos**, **Negotiate**, and
**NegotiateWithImplicitCredential**. The default value is **Default**.

For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](/dotnet/api/system.management.automation.runspaces.authenticationmechanism) in
the MSDN library.

CAUTION: Credential Security Support Provider (CredSSP) authentication, in which the user's
credentials are passed to a remote computer to be authenticated, is designed for commands that
require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control
the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: ComputerNameGuid, ComputerName, ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint

Specifies the digital public key certificate (X509) of a user account that has permission to connect
to the disconnected session. Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication.
They can be mapped only to local user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use a **Get-Item** or **Get-ChildItem** command in the Windows
PowerShell Cert: drive.

```yaml
Type: String
Parameter Sets: ComputerNameGuid, ComputerName, ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the computers on which the disconnected sessions are stored.
Sessions are stored on the computer that is at the "server-side" or receiving end of a connection.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one computer.
Wildcards are not permitted.
To specify the local computer, type the computer name, "localhost", or a dot (.)

```yaml
Type: String[]
Parameter Sets: ComputerNameGuid, ComputerName
Aliases: Cn

Required: True
Position: 1
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to connect to the disconnected session.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01".
Or, enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: ComputerNameGuid, ComputerName, ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the IDs of the disconnected sessions.
The ID parameter works only when the disconnected session was previously connected to the current
session.

This parameter is valid, but not effective, when the session is stored on the local computer, but
was not connected to the current session.

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies the instance IDs of the disconnected sessions.

The instance ID is a GUID that uniquely identifies a PSSession on a local or remote computer.

The instance ID is stored in the **InstanceID** property of the PSSession.

```yaml
Type: Guid[]
Parameter Sets: ComputerNameGuid, ConnectionUriGuid, InstanceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the friendly names of the disconnected sessions.

```yaml
Accept pipeline input: False
Position: Named
Accept wildcard characters: False
Parameter Sets: Name, ComputerName, ConnectionUri
Required: True (Name), False (ComputerName, ConnectionUri)
Default value: None
Aliases: 
Type: String[]
```

### -Port

Specifies the network port on the remote computer that is used to reconnect to the session.
To connect to a remote computer, the remote computer must be listening on the port that the
connection uses.
The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Before using an alternate port, you must configure the WinRM listener on the remote computer to
listen at that port.
To configure the listener, type the following two commands at the Windows PowerShell prompt:

`Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse`

`New-Item -Path WSMan:\Localhost\listener -Transport http -Address * -Port \<port-number\>`

Do not use the **Port** parameter unless you must.
The port that is set in the command applies to all computers or sessions on which the command runs.
An alternate port setting might prevent the command from running on all computers.

```yaml
Type: Int32
Parameter Sets: ComputerNameGuid, ComputerName
Aliases:

Required: False
Position: Named
Default value: 5985, 5986
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session

Specifies the disconnected sessions.
Enter a variable that contains the PSSessions or a command that creates or gets the PSSessions, such
as a Get-PSSession command.

```yaml
Type: PSSession[]
Parameter Sets: Session
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SessionOption

Sets advanced options for the session.
Enter a **SessionOption** object, such as one that you create by using the New-PSSessionOption
cmdlet, or a hash table in which the keys are session option names and the values are session option
values.

The default values for the options are determined by the value of the **$PSSessionOption**
preference variable, if it is set.
Otherwise, the default values are established by options set in the session configuration.

The session option values take precedence over default values for sessions set in the
**$PSSessionOption** preference variable and in the session configuration.
However, they do not take precedence over maximum values, quotas or limits set in the session
configuration.

For a description of the session options, including the default values, see New-PSSessionOption.
For information about the **$PSSessionOption** preference variable, see [about_Preference_Variables](About/about_Preference_Variables.md).
For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

```yaml
Type: PSSessionOption
Parameter Sets: ComputerNameGuid, ComputerName, ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the maximum number of concurrent connections that can be established to run this command.
If you omit this parameter or enter a value of 0, the default value, 32, is used.

The throttle limit applies only to the current command, not to the session or to the computer.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL

Uses the Secure Sockets Layer (SSL) protocol to connect to the disconnected session.
By default, SSL is not used.

WS-Management encrypts all Windows PowerShell content transmitted over the network.
**UseSSL** is an additional protection that sends the data across an HTTPS connection instead of an
HTTP connection.

If you use this parameter, but SSL is not available on the port used for the command, the command
fails.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerNameGuid, ComputerName
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowRedirection

Allows redirection of this connection to an alternate Uniform Resource Identifier (URI).

When you use the **ConnectionURI** parameter, the remote destination can return an instruction to
redirect to a different URI.
By default, Windows PowerShell does not redirect connections, but you can use this parameter to
allow it to redirect the connection.

You can also limit the number of times the connection is redirected by changing the
**MaximumConnectionRedirectionCount** session option value.
Use the  **MaximumRedirection** parameter of the New-PSSessionOption cmdlet or set the
**MaximumConnectionRedirectionCount** property of the **$PSSessionOption** preference variable.
The default value is 5.

```yaml
Type: SwitchParameter
Parameter Sets: ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName

Connects only to sessions that use the specified application.

Enter the application name segment of the connection URI.
For example, in the following connection URI, the application name is WSMan:
`http://localhost:5985/WSMAN`.
The application name of a session is stored in the **Runspace.ConnectionInfo.AppName** property of
the session.

The value of this parameter is used to select and filter sessions.
It does not change the application that the session uses.

```yaml
Type: String
Parameter Sets: ComputerNameGuid, ComputerName
Aliases:

Required: False
Position: Named
Default value: WSMan
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfigurationName

Connects only to sessions that use the specified session configuration.

Enter a configuration name or the fully qualified resource URI for a session configuration.
If you specify only the configuration name, the following schema URI is prepended: 
http://schemas.microsoft.com/powershell.
The configuration name of a session is stored in the **ConfigurationName** property of the session.

The value of this parameter is used to select and filter sessions.
It does not change the session configuration that the session uses.

For more information about session configurations, see [about_Session_Configurations](About/about_Session_Configurations.md).

```yaml
Type: String
Parameter Sets: ComputerNameGuid, ComputerName, ConnectionUri, ConnectionUriGuid
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionUri

Specifies the Uniform Resource Identifiers (URIs) of the connection endpoints for the disconnected
sessions.

The URI must be fully qualified.
The format of this string is as follows:

`\<Transport\>://\<ComputerName\>:\<Port\>/\<ApplicationName\>`

The default value is as follows:

`http://localhost:5985/WSMAN`

If you do not specify a connection URI, you can use the **UseSSL** and **Port**  parameters to
specify the connection URI values.

Valid values for the **Transport** segment of the URI are HTTP and HTTPS.
If you specify a connection URI with a Transport segment, but do not specify a port, the session is
created with standards ports: 80 for HTTP and 443 for HTTPS.
To use the default ports for Windows PowerShell remoting, specify port 5985 for HTTP or 5986 for
HTTPS.

If the destination computer redirects the connection to a different URI, Windows PowerShell prevents
the redirection unless you use the **AllowRedirection** parameter in the command.

```yaml
Type: Uri[]
Parameter Sets: ConnectionUri, ConnectionUriGuid
Aliases: URI, CU

Required: True
Position: 1
Default value: Http://localhost:5985/WSMAN
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.Runspaces.PSSession

You can pipe a session (PSSession) to the **Connect-PSSession** cmdlet.

## OUTPUTS

### System.Management.Automation.Runspaces.PSSession

**Connect-PSSession** returns an object that represents the session to which it reconnected.

## NOTES

- **Connect-PSSession** reconnects only to sessions that are disconnected, that is, sessions that
have a value of **Disconnected** for  the **State** property. Only sessions that are connected to
(terminate at) computers running Windows PowerShell 3.0 or later can be disconnected and
reconnected.
- If you use the **Connect-PSSession** cmdlet on a session that is not disconnected, the command has
no effect on the session and it does not generate errors.
- Disconnected loopback sessions with interactive tokens (those created with the
**EnableNetworkAccess** parameter) can be reconnected only from the computer on which the session
was created. This restriction protects the computer from malicious access.
- The value of the **State** property of a PSSession is relative to the current session. Therefore,
a value of **Disconnected** means that the PSSession is not connected to the current session.
However, it does not mean that the PSSession is disconnected from all sessions. It might be
connected to a different session. To determine whether you can connect or reconnect to the session,
use the **Availability** property.

  An **Availability** value of **None** indicates that you can connect to the session.
A value of **Busy** indicates that you cannot connect to the PSSession because it is connected to
another session.

  For more information about the values of the **State** property of sessions, see 
[RunspaceState Enumeration](/dotnet/api/system.management.automation.runspaces.runspacestate) in the
MSDN library.

  For more information about the values of the **Availability** property of sessions, see 
[RunspaceAvailability Enumeration](/dotnet/api/system.management.automation.runspaces.runspaceavailability) in the MSDN library.

- You cannot change the idle timeout value of a PSSession when you connect to the PSSession. The
**SessionOption** parameter of **Connect-PSSession** takes a **SessionOption** object that has an
**IdleTimeout** value. However, the **IdleTimeout** value of the **SessionOption** object and the
**IdleTimeout** value of the **$PSSessionOption** variable are ignored when connecting to a
PSSession.

  You can set and change the idle timeout of a PSSession when you create the PSSession (by using the
New-PSSession or Invoke-Command cmdlets) and when you disconnect from the PSSession.

  The **IdleTimeout** property of  a PSSession is critical to disconnected sessions, because it
determines how long a disconnected session is maintained on the remote computer.
Disconnected sessions are considered to be idle from the moment that they are disconnected, even if
commands are running in the disconnected session.

## RELATED LINKS

[Connect-PSSession](Connect-PSSession.md)

[Disconnect-PSSession](Disconnect-PSSession.md)

[Enter-PSSession](Enter-PSSession.md)

[Exit-PSSession](Exit-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[New-PSSession](New-PSSession.md)

[New-PSSessionOption](New-PSSessionOption.md)

[New-PSTransportOption](New-PSTransportOption.md)

[Receive-PSSession](Receive-PSSession.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Remove-PSSession](Remove-PSSession.md)

[about_PSSessions](About/about_PSSessions.md)

[about_Remote](About/about_Remote.md)

[about_Remote_Disconnected_Sessions](About/about_Remote_Disconnected_Sessions.md)

[about_Session_Configurations](About/about_Session_Configurations.md)