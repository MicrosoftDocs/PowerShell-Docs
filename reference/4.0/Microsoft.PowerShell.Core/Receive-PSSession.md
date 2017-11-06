---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289604
external help file:  System.Management.Automation.dll-Help.xml
title:  Receive-PSSession
---

# Receive-PSSession

## SYNOPSIS
Gets results of commands in disconnected sessions

## SYNTAX

### Session (Default)
```
Receive-PSSession [-Session] <PSSession> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Id
```
Receive-PSSession [-Id] <Int32> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ComputerSessionName
```
Receive-PSSession [-ComputerName] <String> [-ApplicationName <String>] [-ConfigurationName <String>]
 [-Name] <String> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-Port <Int32>] [-UseSSL]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerInstanceId
```
Receive-PSSession [-ComputerName] <String> [-ApplicationName <String>] [-ConfigurationName <String>]
 -InstanceId <Guid> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-Port <Int32>] [-UseSSL]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUriSessionName
```
Receive-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri> [-AllowRedirection] [-Name] <String>
 [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUriInstanceId
```
Receive-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri> [-AllowRedirection] -InstanceId <Guid>
 [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceId
```
Receive-PSSession -InstanceId <Guid> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SessionName
```
Receive-PSSession [-Name] <String> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Receive-PSSession** cmdlet gets the results of commands running in Windows PowerShell sessions ("PSSession") that were disconnected.
If the session is currently connected, **Receive-PSSession** gets the results of commands that were running when the session was disconnected.
If the session is still disconnected, **Receive-PSSession** connects to the session, resumes any commands that were suspended, and gets the results of commands running in the session.

You can use a **Receive-PSSession** in addition to or in place of a Connect-PSSession command.
**Receive-PSSession** can connect to any disconnected or reconnected session, including those that were started in other sessions or on other computers.

**Receive-PSSession** works on PSSessions that were disconnected intentionally, such as by using the Disconnect-PSSession cmdlet or the **InDisconnectedSession** parameter of the Invoke-Command cmdlet, or unintentionally, such as by a network interruption.

If you use the **Receive-PSSession** cmdlet to connect to a session in which no commands are running or suspended, **Receive-PSSession** connects to the session, but returns no output or errors.

For more information about the Disconnected Sessions feature, see about_Remote_Disconnected_Sessions.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1
```
PS C:\> Receive-PSSession -ComputerName Server01 -Name ITTask
```

This command uses the **Receive-PSSession** cmdlet to connect to the ITTask session on the Server01 computer and get the results of commands that were running in the session.

Because the command does not use the **OutTarget** parameter, the results appear at the command line.

### Example 2
```
PS C:\> Get-PSSession -ComputerName  Server01, Server02 | Receive-PSSession
```

This command gets the results of all commands running in all disconnected sessions on the Server01 and Server02 computers.

If any session was not disconnected or is not running commands, **Receive-PSSession** does not connect to the session and does not return any output or errors.

### Example 3
```
PS C:\> Receive-PSSession -ComputerName Server01 -Name ITTask -OutTarget Job -JobName ITTaskJob01 -Credential Domain01\Admin01
Id     Name            State         HasMoreData     Location
--     ----            -----         -----------     --------
16     ITTaskJob01     Running       True            Server01
```

This command uses the **Receive-PSSession** cmdlet to get the results of a script that was running in the ITTask session on the Server01 computer.

The command uses the **ComputerName** and **Name** parameters to identify the disconnected session.
It uses the **OutTarget** parameter with a value of **Job** to direct **Receive-PSSession** to return the results as a job and the **JobName** parameter to specify a name for the job in the reconnected session.

The command uses the **Credential** parameter to run the **Receive-PSSession** command with the permissions of a domain administrator.

The output shows that **Receive-PSSession** returned the results as a job in the current session.
To get the job results, use a Receive-Job command

### Example 4
```
The first command uses the New-PSSession cmdlet to create a session on the Server01 computer. The command saves the session in the $s variable.The second command gets the session in the $s variable. Notice that the **State** is **Opened** and the **Availability** is **Available**. These values indicate that you are connected to the session and can run commands in the session.
PS C:\> $s = New-PSSession -ComputerName Server01 -Name AD -ConfigurationName ADEndpoint
PS C:\> $s 

Id Name    ComputerName    State         ConfigurationName     Availability
 -- ----    ------------    -----         -----------------     ------------
  8 AD      Server01        Opened        ADEndpoint            Available

The third command uses the Invoke-Command cmdlet to run a script in the session in the $s variable.The script begins to run and return data, but a network outage occurs that interrupts the session. The user has to exit the session and restart the local computer.
PS C:\> Invoke-Command -Session $s -FilePath \\Server12\Scripts\SharedScripts\New-ADResolve.ps1
 Running "New-ADResolve.ps1" â€¦.exit

# Network outage
# Restart local computer
# Network access is not re-established within 4 minutes

When the computer restarts, the user starts Windows PowerShell and runs a Get-PSSession command to get sessions on the Server01 computer. The output shows that the AD session still exists on the Server01 computer. The **State** indicates that it is disconnected and the **Availability** value, **None**, indicates that it is not connected to any client sessions.
PS C:\> Get-PSSession -ComputerName Server01

 Id Name    ComputerName    State         ConfigurationName     Availability
 -- ----    ------------    -----         -----------------     ------------
  1 Backup  Server01        Disconnected  Microsoft.PowerShell          None
  8 AD      Server01        Disconnected  ADEndpoint                   None


The fifth command uses the **Receive-PSSession** cmdlet to reconnect to the AD session and get the results of the script that ran in the session. The command uses the **OutTarget** parameter to request the results in a job named "ADJob".The command returns a job object. The output indicates that the script is still running.
PS C:\> Receive-PSSession -ComputerName Server01 -Name AD -OutTarget Job -JobName AD
Job Id     Name      State         HasMoreData     Location
--     ----      -----         -----------     --------
16     ADJob     Running       True            Server01

The sixth command uses the Get-PSSession cmdlet to check the job state. The output confirms that, in addition to resuming script execution and getting the script results, the **Receive-PSSession** cmdlet reconnected to the AD session, which is now open and available for commands.
PS C:\> Get-PSSession -ComputerName Server01
Id Name    ComputerName    State         ConfigurationName     Availability
-- ----    ------------    -----         -----------------     ------------ 
 1 Backup  Server01        Disconnected  Microsoft.PowerShell          Busy
 8 AD      Server01        Opened        ADEndpoint                Available
```

This example uses the **Receive-PSSession** cmdlet to get the results of a job after a network outage disrupts a session connection.
Windows PowerShell automatically attempts to reconnect the session once each second for the next four minutes and abandons the effort only if all attempts in the four-minute interval fail.

### Example 5
```
The first command uses the Invoke-Command cmdlet to run a script on the three remote computers. Because the scripts gathers and summarize data from multiple databases, it often takes the script an extended time to complete. The command uses the **InDisconnectedSession** parameter, which starts the scripts and then immediately disconnects the sessions.The command uses the **SessionOption** parameter to extend the **IdleTimeout** value of the disconnected session. Disconnected sessions are considered to be idle from the moment they are disconnected, so it's important to set the idle timeout for a long enough period that the commands can complete and you can reconnect to the session, if necessary. You can set the IdleTimeout only when you create the PSSession and change it only when you disconnect from it. You cannot change the **IdleTimeout** value when connecting to a PSSession or receiving its results.After running the command, the user exits Windows PowerShell and closes the computer .
PS C:\> Invoke-Command -InDisconnectedSession -ComputerName Server01, Server02, Server30 -FilePath \\Server12\Scripts\SharedScripts\Get-BugStatus.ps1 -Name BugStatus -SessionOption @{IdleTimeout = 86400000} -ConfigurationName ITTasks# Exit

# Start Windows PowerShell on a different computer.

On the next day, the user resumes Windows and starts Windows PowerShell. The second command uses the Get-PSSession cmdlet to get the sessions in which the scripts were running. The command identifies the sessions by the computer name, session name, and the name of the session configuration and saves the sessions in the $s variable.The third command displays the value of the $s variable. The output shows that the sessions are disconnected, but not busy, as expected.
PS C:\> $s = Get-PSSession -ComputerName Server01, Server02, Server30 -Name BugStatus
 PS C:\> $s
Id Name    ComputerName    State         ConfigurationName     Availability
 -- ----    ------------    -----         -----------------     ------------
  1 ITTask  Server01        Disconnected  ITTasks                       None
  8 ITTask  Server02        Disconnected  ITTasks                       None
  2 ITTask  Server30        Disconnected  ITTasks                       None


The fourth command uses the **Receive-PSSession** cmdlet to connect to the sessions in the $s variable and get their results. The command saves the results in the $Results variable..Another display of the $s variable shows that the sessions are connected and available for commands.
PS C:\> $Results = Receive-PSSession -Session $s
PS C:\> $s
 Id Name    ComputerName    State         ConfigurationName     Availability
-- ----    ------------    -----         -----------------     ------------ 
 1 ITTask  Server01        Opened        ITTasks                  Available
 8 ITTask  Server02        Opened        ITTasks                  Available
 2 ITTask  Server30        Opened        ITTasks                  Available


The fifth command displays the script results in the $Results variable. If any of the results are unexpected, the user can run commands in the sessions to investigate.
PS C:\> $Results
Bug Report - Domain 01
----------------------
ComputerName          BugCount          LastUpdated
--------------        ---------         ------------
Server01              121               Friday, December 30, 2011 5:03:34 PMâ€¦
```

This example uses the **Receive-PSSession** cmdlet to reconnect to sessions that were intentionally disconnected and get the results of jobs that were running in the sessions.

### Example 6
```
The first command uses the New-PSSession cmdlet to create the Test session on the Server01 computer. The command saves the session in the $s variable.
PS C:\> $s = New-PSSession -ComputerName Server01 -Name Test

The second command uses the Invoke-Command cmdlet to run a command in the session in the $s variable. The command uses the **AsJob** parameter to run the command as a job and to create the job object in the current session. The command returns a job object, which is saved in the $j variable.The third command displays the job object in the $j variable.
PS C:\> $j = Invoke-Command -Session $s { 1..1500 | Foreach-Object {"Return $_"; sleep 30}} -AsJob

PS C:\> $j
Id     Name           State         HasMoreData     Location
--     ----           -----         -----------     --------
16     Job1           Running       True            Server01

The fourth command disconnects the session in the $s variable.
PS C:\> $s | Disconnect-PSSession
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------ 
1  Test   Server01        Disconnected  Microsoft.PowerShell  None

The fifth command shows the effect of disconnecting on the job object in the $j variable. The job state is now Disconnected.
PS C:\> $j
Id     Name           State         HasMoreData     Location
--     ----           -----         -----------     --------
16     Job1           Disconnected  True            Server01

The sixth command runs a Receive-Job command on the job in the $j variable. The output shows that the job began to return output before the session (and the job) were disconnected.
PS C:\> Receive-Job $j -Keep
Return 1Return 2

The seventh command is run in the same client session. The command uses the Connect-PSSession cmdlet to reconnect to the Test session on the Server01 computer and saves the session in the $s2 variable.
PS C:\> $s2 = Connect-PSSession -ComputerName Server01 -Name Test

The eighth command uses the **Receive-PSSession** cmdlet to get the results of the job that was running in the session. Because the command is run in the same session, **Receive-PSSession** returns the results as a job by default and reuses the same job object. The command saves the job in the $j2 variable.The ninth command uses the **Receive-Job** cmdlet to get the results of the job in the $j variable.
PS C:\> $j2 = Receive-PSSession -ComputerName Server01 -Name Test

PS C:\> Receive-Job $j
Return 3
Return 4â€¦
```

This example shows what happens to a job that is running in a disconnected session.

## PARAMETERS

### -AllowRedirection
Allows redirection of this connection to an alternate Uniform Resource Identifier (URI).

When you use the **ConnectionURI** parameter, the remote destination can return an instruction to redirect to a different URI.
By default, Windows PowerShell does not redirect connections, but you can use this parameter to allow it to redirect the connection.

You can also limit the number of times the connection is redirected by changing the **MaximumConnectionRedirectionCount** session option value.
Use the  **MaximumRedirection** parameter of the New-PSSessionOption cmdlet or set the **MaximumConnectionRedirectionCount** property of the **$PSSessionOption** preference variable.
The default value is 5.

```yaml
Type: SwitchParameter
Parameter Sets: ConnectionUriSessionName, ConnectionUriInstanceId
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
For example, in the following connection URI, the application name is WSMan: `http://localhost:5985/WSMAN`.
The application name of a session is stored in the **Runspace.ConnectionInfo.AppName** property of the session.

The value of this parameter is used to select and filter sessions.
It does not change the application that the session uses.

```yaml
Type: String
Parameter Sets: ComputerSessionName, ComputerInstanceId
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Authentication
Specifies the mechanism that is used to authenticate the user's credentials in the command to reconnect to the disconnected session. 
Valid values are **Default**, **Basic**, **Credssp**, **Digest**, **Kerberos**, **Negotiate**, and **NegotiateWithImplicitCredential**. 
The default value is **Default**.

For more information about the values of this parameter, see [AuthenticationMechanism Enumeration](https://msdn.microsoft.com/library/system.management.automation.runspaces.authenticationmechanism) in the MSDN library.

CAUTION: Credential Security Support Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: AuthenticationMechanism
Parameter Sets: ComputerSessionName, ComputerInstanceId, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: 
Accepted values: Default, Basic, Negotiate, NegotiateWithImplicitCredential, Credssp, Digest, Kerberos

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint
Specifies the digital public key certificate (X509) of a user account that has permission to connect to the disconnected session.
Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication.
They can be mapped only to local user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use a **Get-Item** or **Get-ChildItem** command in the Windows PowerShell Cert: drive.

```yaml
Type: String
Parameter Sets: ComputerSessionName, ComputerInstanceId, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specifies the computer on which the disconnected session is stored.
Sessions are stored on the computer that is at the "server-side" or receiving end of a connection.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one computer.
Wildcards are not permitted.
To specify the local computer, type the computer name, "localhost", or a dot (.)

```yaml
Type: String
Parameter Sets: ComputerSessionName, ComputerInstanceId
Aliases: Cn

Required: True
Position: 0
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfigurationName
Connects only to sessions that use the specified session configuration.

Enter a configuration name or the fully qualified resource URI for a session configuration.
If you specify only the configuration name, the following schema URI is prepended:  http://schemas.microsoft.com/powershell.
The configuration name of a session is stored in the **ConfigurationName** property of the session.

The value of this parameter is used to select and filter sessions.
It does not change the session configuration that the session uses.

For more information about session configurations, see about_Session_Configurations .

```yaml
Type: String
Parameter Sets: ComputerSessionName, ComputerInstanceId, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: 

Required: False
Position: Named
Default value: None
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

### -ConnectionUri
Specifies a Uniform Resource Identifier (URI) that defines the connection endpoint that is used to reconnect to the disconnected session.

The URI must be fully qualified. 
The format of this string is as follows:

`\<Transport\>://\<ComputerName\>:\<Port\>/\<ApplicationName\>`

The default value is as follows:

`http://localhost:5985/WSMAN`

If you do not specify a connection URI, you can use the **UseSSL**, **ComputerName**, **Port**, and **ApplicationName** parameters to specify the connection URI values.

Valid values for the **Transport** segment of the URI are HTTP and HTTPS.
If you specify a connection URI with a Transport segment, but do not specify a port, the session is created with standards ports: 80 for HTTP and 443 for HTTPS.
To use the default ports for Windows PowerShell remoting, specify port 5985 for HTTP or 5986 for HTTPS.

If the destination computer redirects the connection to a different URI, Windows PowerShell prevents the redirection unless you use the **AllowRedirection** parameter in the command.

```yaml
Type: Uri
Parameter Sets: ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: URI, CU

Required: True
Position: 0
Default value: Http://localhost:5985/WSMAN
Accept pipeline input: True (ByPropertyName)
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
Parameter Sets: ComputerSessionName, ComputerInstanceId, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the ID of the disconnected session.
The ID parameter works only when the disconnected session was previously connected to the current session.

This parameter is valid, but not effective, when the session is stored on the local computer, but was not connected to the current session.

```yaml
Type: Int32
Parameter Sets: Id
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InstanceId
Specifies the instance ID of the disconnected session.

The instance ID is a GUID that uniquely identifies a PSSession on a local or remote computer.

The instance ID is stored in the **InstanceID** property of the PSSession.

```yaml
Type: Guid
Parameter Sets: ComputerInstanceId, ConnectionUriInstanceId
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Guid
Parameter Sets: InstanceId
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobName
Specifies a friendly name for the job that **Receive-PSSession** returns.

**Receive-PSSession** returns a job when the value of the **OutTarget** parameter is **Job** or the job that is running in the disconnected session was started in the current session.

If the job that is running in the disconnected session was started in the current session, Windows PowerShell reuses the original job object in the session and ignores the value of the **JobName** parameter.

If the job that is running in the disconnected session was started in a different session, Windows PowerShell creates a new job object.
It uses a default name, but you can use this parameter to change the name.

If the default value or explicit value of  the **OutTarget** parameter is not **Job**, the command succeeds, but the **JobName** parameter has no effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Job<n>
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the friendly name of the disconnected session.

```yaml
Type: String
Parameter Sets: ComputerSessionName, ConnectionUriSessionName
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SessionName
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutTarget
Determines how the session results are returned.

Valid values are:

- **Job**: Returns the results asynchronously in a job object. You can use the **JobName** parameter to specify a name or new name for the job.
- **Host**: Returns the results to the command line (synchronously). If the command is being resumed or the results consist of a large number of objects, the response might be delayed.

The default value of the **OutTarget** parameter is **Host**.
However, if the command that is being received in disconnected session was started in the current session, the default value of the **OutTarget** parameter is the form in which the command was started.
If the command was started as a job, it is returned as a job by default.
Otherwise, it is returned to the host program by default.

Typically, the host program displays returned objects at the command line without delay, but this behavior can vary.

```yaml
Type: OutTarget
Parameter Sets: (All)
Aliases: 
Accepted values: Default, Host, Job

Required: False
Position: Named
Default value: Host
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specifies the network port on the remote computer that is used to reconnect to the session. 
To connect to a remote computer, the remote computer must be listening on the port that the connection uses. 
The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Before using an alternate port, you must configure the WinRM listener on the remote computer to listen at that port.
To configure the listener, type the following two commands at the Windows PowerShell prompt:

`Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse`

`New-Item -Path WSMan:\Localhost\listener -Transport http -Address * -Port \<port-number\>`

Do not use the **Port** parameter unless you must.
The port that is set in the command applies to all computers or sessions on which the command runs.
An alternate port setting might prevent the command from running on all computers.

```yaml
Type: Int32
Parameter Sets: ComputerSessionName, ComputerInstanceId
Aliases: 

Required: False
Position: Named
Default value: 5985, 5986
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session
Specifies the disconnected session.
Enter a variable that contains the PSSession or a command that creates or gets the PSSession, such as a Get-PSSession command.

```yaml
Type: PSSession
Parameter Sets: Session
Aliases: 

Required: True
Position: 0
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
For information about the **$PSSessionOption** preference variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).
For more information about session configurations, see about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152).

```yaml
Type: PSSessionOption
Parameter Sets: ComputerSessionName, ComputerInstanceId, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Uses the Secure Sockets Layer (SSL) protocol to connect to the disconnected session.
By default, SSL is not used.

WS-Management encrypts all Windows PowerShell content transmitted over the network.
**UseSSL** is an additional protection that sends the data across an HTTPS connection instead of an HTTP connection.

If you use this parameter, but SSL is not available on the port used for the command, the command fails.

```yaml
Type: SwitchParameter
Parameter Sets: ComputerSessionName, ComputerInstanceId
Aliases: 

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Runspaces.PSSession
You can pipe session objects, such as those returned by the Get-PSSession cmdlet to Receive-PSSession.

### System.Int32
You can pipe session IDs to Receive-PSSession.

### System.Guid
You can pipe the instance IDs of sessions to Receive-PSSession.

### System.String
You can pipe session names to Receive-PSSession.

## OUTPUTS

### System.Management.Automation.Job or PSObject
**Receive-PSSession** gets the results of commands that ran in the disconnected session, if any.
If the value or default value of the **OutTarget** parameter is **Job**, **Receive-PSSession** returns a job object.
Otherwise, it returns objects that represent that command results.

## NOTES
* **Receive-PSSession** gets results only from sessions that were disconnected. Only sessions that are connected to (terminate at) computers running Windows PowerShell 3.0 or later can be disconnected and reconnected.
* If the commands that were running in the disconnected session did not generate results or if the results were already returned to another session, **Receive-PSSession** does not generate any output.
* The output buffering mode of a session determines how commands in the session manage output when the session is disconnected. When the value of the **OutputBufferingMode** option of the session is **Drop** and the output buffer is full, the command begins to delete output. Receive-PSSession cannot recover this output. For more information about the output buffering mode option, see the help topics for the New-PSSessionOption and New-PSTransportOption cmdlets.
* You cannot change the idle timeout value of a PSSession when you connect to the PSSession or receive results. The **SessionOption** parameter of **Receive-PSSession** takes a **SessionOption** object that has an **IdleTimeout** value. However, the **IdleTimeout** value of the **SessionOption** object and the **IdleTimeout** value of the **$PSSessionOption** variable are ignored when connecting to a PSSession or receiving results.

  You can set and change the idle timeout of a PSSession when you create the PSSession (by using the New-PSSession or Invoke-Command cmdlets) and when you disconnect from the PSSession.

  The **IdleTimeout** property of  a PSSession is critical to disconnected sessions, because it determines how long a disconnected session is maintained on the remote computer.
Disconnected sessions are considered to be idle from the moment that they are disconnected, even if commands are running in the disconnected session.

* If you start a start a job in a remote session by using the **AsJob** parameter of the Invoke-Command cmdlet, the job object is created in the current session, even though the job runs in the remote session. If you disconnect the remote session, the job object in the current session is now disconnected from the job. The job object still contains any results that were returned to it, but it does not receive new results from the job in the disconnected session.

  If a different client connects to the session that contains the running job, the results that were delivered to the original job object in the original session are not available in the newly connected session.
Only results that were not delivered to the original job object are available in the reconnected session.

  Similarly, if you start a script in a session and then disconnect from the session, any results that the script delivers to the session before disconnecting are not available to another client that connects to the session.

  To prevent data loss in sessions that you intend to disconnect, use the **InDisconnectedSession** parameter of the ** Invoke-Command** cmdlet.
Because this parameter prevents results from being returned to the current session, all results are available when the session is reconnected.

  You can also prevent data loss by using the **Invoke-Command** cmdlet to run a Start-Job command in the remote session.
In this case, the job object is created in the remote session.
You cannot use the **Receive-PSSession** cmdlet to get the job results.
Instead, use the **Connect-PSSession** cmdlet to connect to the session and then use the **Invoke-Command** cmdlet to run a Receive-Job command in the session.

* When a session that contains a running job is disconnected and then reconnected, the original job object is reused only if the job is disconnected and reconnected to the same session, and the command to reconnect does not specify a new job name. If the session is reconnected to a different client session or a new job name is specified, Windows PowerShell creates a new job object for the new session.
* When you disconnect a PSSession, the session state is **Disconnected** and the availability is **None**.

  The value of the **State** property is relative to the current session.
Therefore, a value of **Disconnected** means that the PSSession is not connected to the current session.
However, it does not mean that the PSSession is disconnected from all sessions.
It might be connected to a different session.
To determine whether you can connect or reconnect to the session, use the **Availability** property.

  An **Availability** value of **None** indicates that you can connect to the session.
A value of **Busy** indicates that you cannot connect to the PSSession because it is connected to another session.

  For more information about the values of the **State** property of sessions, see [RunspaceState Enumeration](https://msdn.microsoft.com/library/system.management.automation.runspaces.runspacestate) in the MSDN library.

  For more information about the values of the **Availability** property of sessions, see [RunspaceAvailability Enumeration](https://msdn.microsoft.com/library/system.management.automation.runspaces.runspaceavailability) in the MSDN library.

## RELATED LINKS

[Connect-PSSession](Connect-PSSession.md)

[Enter-PSSession](Enter-PSSession.md)

[Exit-PSSession](Exit-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Invoke-Command](Invoke-Command.md)

[New-PSSession](New-PSSession.md)

[New-PSSessionOption](New-PSSessionOption.md)

[Receive-PSSession](Receive-PSSession.md)

[Remove-PSSession](Remove-PSSession.md)

[about_PSSessions](About/about_PSSessions.md)

[about_Remote](About/about_Remote.md)

[about_Remote_Disconnected_Sessions](About/about_Remote_Disconnected_Sessions.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

