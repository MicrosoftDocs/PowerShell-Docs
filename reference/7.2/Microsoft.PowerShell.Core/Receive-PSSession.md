---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 12/11/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/receive-pssession?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Receive-PSSession
---

# Receive-PSSession

## SYNOPSIS

Gets results of commands in disconnected sessions

## SYNTAX

### Session (Default)

```
Receive-PSSession [-Session] <PSSession> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Id

```
Receive-PSSession [-Id] <Int32> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ComputerSessionName

```
Receive-PSSession [-ComputerName] <String> [-ApplicationName <String>] [-ConfigurationName <String>]
 -Name <String> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-Port <Int32>]
 [-UseSSL] [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerInstanceId

```
Receive-PSSession [-ComputerName] <String> [-ApplicationName <String>] [-ConfigurationName <String>]
 -InstanceId <Guid> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>] [-Port <Int32>]
 [-UseSSL] [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUriSessionName

```
Receive-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri> [-AllowRedirection]
 -Name <String> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ConnectionUriInstanceId

```
Receive-PSSession [-ConfigurationName <String>] [-ConnectionUri] <Uri> [-AllowRedirection]
 -InstanceId <Guid> [-OutTarget <OutTarget>] [-JobName <String>] [-Credential <PSCredential>]
 [-Authentication <AuthenticationMechanism>] [-CertificateThumbprint <String>]
 [-SessionOption <PSSessionOption>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceId

```
Receive-PSSession -InstanceId <Guid> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SessionName

```
Receive-PSSession -Name <String> [-OutTarget <OutTarget>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Receive-PSSession` cmdlet gets the results of commands running in PowerShell sessions
(**PSSession**) that were disconnected. If the session is currently connected, `Receive-PSSession`
gets the results of commands that were running when the session was disconnected. If the session is
still disconnected, `Receive-PSSession` connects to the session, resumes any commands that were
suspended, and gets the results of commands running in the session.

This cmdlet was introduced in PowerShell 3.0.

You can use a `Receive-PSSession` in addition to or instead of a `Connect-PSSession` command.
`Receive-PSSession` can connect to any disconnected or reconnected session that was started in other
sessions or on other computers.

`Receive-PSSession` works on **PSSessions** that were disconnected intentionally using the
`Disconnect-PSSession` cmdlet or the `Invoke-Command` **InDisconnectedSession** parameter. Or
disconnected unintentionally by a network interruption.

If you use the `Receive-PSSession` cmdlet to connect to a session in which no commands are running
or suspended, `Receive-PSSession` connects to the session, but returns no output or errors.

For more information about the Disconnected Sessions feature, see
[about_Remote_Disconnected_Sessions](./About/about_Remote_Disconnected_Sessions.md).

Some examples use splatting to reduce the line length and improve readability. For more information,
see [about_Splatting](./About/about_Splatting.md).

## EXAMPLES

### Example 1: Connect to a PSSession

This example connects to a session on a remote computer and gets the results of commands that are
running in a session.

```powershell
Receive-PSSession -ComputerName Server01 -Name ITTask
```

The `Receive-PSSession` specifies the remote computer with the **ComputerName** parameter. The
**Name** parameter identifies the ITTask session on the Server01 computer. The example gets the
results of commands that were running in the ITTask session.

Because the command doesn't use the **OutTarget** parameter, the results appear on the command line.

### Example 2: Get results of all commands on disconnected sessions

This example gets the results of all commands running in all disconnected sessions on two remote
computers.

If any session wasn't disconnected or isn't running commands, `Receive-PSSession` doesn't connect to
the session and doesn't return any output or errors.

```powershell
Get-PSSession -ComputerName Server01, Server02 | Receive-PSSession
```

`Get-PSSession` uses the **ComputerName** parameter to specify the remote computers. The objects are
sent down the pipeline to `Receive-PSSession`.

### Example 3: Get the results of a script running in a session

This example uses the `Receive-PSSession` cmdlet to get the results of a script that was running in
a remote computer's session.

```powershell
$parms = @{
  ComputerName = "Server01"
  Name = "ITTask"
  OutTarget = "Job"
  JobName = "ITTaskJob01"
  Credential = "Domain01\Admin01"
}
Receive-PSSession @parms
```

```Output
Id     Name            State         HasMoreData     Location
--     ----            -----         -----------     --------
16     ITTaskJob01     Running       True            Server01
```

The command uses the **ComputerName** and **Name** parameters to identify the disconnected session.
It uses the **OutTarget** parameter with a value of Job to direct `Receive-PSSession` to return the
results as a job. The **JobName** parameter specifies a name for the job in the reconnected session.
The **Credential** parameter runs the `Receive-PSSession` command using the permissions of a domain
administrator.

The output shows that `Receive-PSSession` returned the results as a job in the current session. To
get the job results, use a `Receive-Job` command

### Example 4: Get results after a network outage

This example uses the `Receive-PSSession` cmdlet to get the results of a job after a network outage
disrupts a session connection. PowerShell automatically attempts to reconnect the session once per
second for the next four minutes and abandons the effort only if all attempts in the four-minute
interval fail.

```
PS> $s = New-PSSession -ComputerName Server01 -Name AD -ConfigurationName ADEndpoint
PS> $s

Id  Name   ComputerName    State        ConfigurationName     Availability
--  ----   ------------    -----        -----------------     ------------
8   AD      Server01       Opened       ADEndpoint               Available


PS> Invoke-Command -Session $s -FilePath \\Server12\Scripts\SharedScripts\New-ADResolve.ps1

Running "New-ADResolve.ps1"

# Network outage
# Restart local computer
# Network access is not re-established within 4 minutes


PS> Get-PSSession -ComputerName Server01

Id  Name   ComputerName    State          ConfigurationName      Availability
--  ----   ------------    -----          -----------------      ------------
1  Backup  Server01        Disconnected   Microsoft.PowerShell           None
8  AD      Server01        Disconnected   ADEndpoint                     None


PS> Receive-PSSession -ComputerName Server01 -Name AD -OutTarget Job -JobName AD

Job Id   Name      State         HasMoreData     Location
--       ----      -----         -----------     --------
16       ADJob     Running       True            Server01


PS> Get-PSSession -ComputerName Server01

Id  Name    ComputerName    State         ConfigurationName     Availability
--  ----    ------------    -----         -----------------     ------------
1  Backup   Server01        Disconnected  Microsoft.PowerShell          Busy
8  AD       Server01        Opened        ADEndpoint               Available
```

The `New-PSSession` cmdlet creates a session on the Server01 computer and saves the session in the
`$s` variable. The `$s` variable displays that the **State** is Opened and the **Availability** is
Available. These values indicate that you're connected to the session and can run commands in the
session.

The `Invoke-Command` cmdlet runs a script in the session in the `$s` variable. The script begins to
run and return data, but a network outage occurs that interrupts the session. The user has to exit
the session and restart the local computer.

When the computer restarts, the user starts PowerShell and runs a `Get-PSSession` command to get
sessions on the Server01 computer. The output shows that the **AD** session still exists on the
Server01 computer. The **State** indicates that the **AD** session is disconnected. The
**Availability** value of None, indicates that the session isn't connected to any client sessions.

The `Receive-PSSession` cmdlet reconnects to the **AD** session and gets the results of the script
that ran in the session. The command uses the **OutTarget** parameter to request the results in a
job named **ADJob**. The command returns a job object and the output indicates that the script is
still running.

The `Get-PSSession` cmdlet is used to check the job state. The output confirms that the
`Receive-PSSession` cmdlet reconnected to the **AD** session, which is now open and available for
commands. And, the script resumed execution and is getting the script results.

### Example 5: Reconnect to disconnected sessions

This example uses the `Receive-PSSession` cmdlet to reconnect to sessions that were intentionally
disconnected and get the results of jobs that were running in the sessions.

```
PS> $parms = @{
      InDisconnectedSession = $True
      ComputerName = "Server01", "Server02", "Server30"
      FilePath = "\\Server12\Scripts\SharedScripts\Get-BugStatus.ps1"
      Name = "BugStatus"
      SessionOption = @{IdleTimeout = 86400000}
      ConfigurationName = "ITTasks"
    }
PS> Invoke-Command @parms
PS> Exit


PS> $s = Get-PSSession -ComputerName Server01, Server02, Server30 -Name BugStatus
PS> $s

Id  Name   ComputerName    State         ConfigurationName     Availability
--  ----   ------------    -----         -----------------     ------------
1  ITTask  Server01        Disconnected  ITTasks                       None
8  ITTask  Server02        Disconnected  ITTasks                       None
2  ITTask  Server30        Disconnected  ITTasks                       None


PS> $Results = Receive-PSSession -Session $s
PS> $s

Id  Name   ComputerName    State         ConfigurationName     Availability
--  ----   ------------    -----         -----------------     ------------
1  ITTask  Server01        Opened        ITTasks                  Available
8  ITTask  Server02        Opened        ITTasks                  Available
2  ITTask  Server30        Opened        ITTasks                  Available


PS> $Results

Bug Report - Domain 01
----------------------
ComputerName          BugCount          LastUpdated
--------------        ---------         ------------
Server01              121               Friday, December 30, 2011 5:03:34 PM
```

The `Invoke-Command` cmdlet runs a script on three remote computers. Because the script gathers and
summarizes data from multiple databases, it often takes the script an extended time to finish. The
command uses the **InDisconnectedSession** parameter that starts the scripts and then immediately
disconnects the sessions. The **SessionOption** parameter extends the **IdleTimeout** value of the
disconnected session. Disconnected sessions are considered idle from the moment they're
disconnected. It's important to set the idle time-out for long enough so that the commands can
complete and you can reconnect to the session. You can set the **IdleTimeout** only when you create
the **PSSession** and change it only when you disconnect from it. You can't change the
**IdleTimeout** value when you connect to a **PSSession** or receiving its results. After running
the command, the user exits PowerShell and closes the computer.

The next day, the user resumes Windows, starts PowerShell, and uses `Get-PSSession` to get the
sessions in which the scripts were running. The command identifies the sessions by the computer
name, session name, and the name of the session configuration and saves the sessions in the `$s`
variable. The value of the `$s` variable is displayed and shows that the sessions are disconnected,
but aren't busy.

The `Receive-PSSession` cmdlet connects to the sessions in the `$s` variable and gets their results.
The command saves the results in the `$Results` variable. The `$s` variable is displayed and shows
that the sessions are connected and available for commands.

The script results in the `$Results` variable are displayed in the PowerShell console. If any of the
results are unexpected, the user can run commands in the sessions to investigate the root cause.

### Example 6: Running a job in a disconnected session

This example shows what happens to a job that's running in a disconnected session.

```
PS> $s = New-PSSession -ComputerName Server01 -Name Test
PS> $j = Invoke-Command -Session $s { 1..1500 | Foreach-Object {"Return $_"; sleep 30}} -AsJob
PS> $j

Id     Name           State         HasMoreData     Location
--     ----           -----         -----------     --------
16     Job1           Running       True            Server01


PS> $s | Disconnect-PSSession

Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1  Test   Server01        Disconnected  Microsoft.PowerShell          None


PS> $j

Id     Name           State         HasMoreData     Location
--     ----           -----         -----------     --------
16     Job1           Disconnected  True            Server01


PS> Receive-Job $j -Keep

Return 1
Return 2


PS> $s2 = Connect-PSSession -ComputerName Server01 -Name Test
PS> $j2 = Receive-PSSession -ComputerName Server01 -Name Test
PS> Receive-Job $j

Return 3
Return 4
```

The `New-PSSession` cmdlet creates the Test session on the Server01 computer. The command saves the
session in the `$s` variable.

The `Invoke-Command` cmdlet runs a command in the session in the `$s` variable. The command uses the
**AsJob** parameter to run the command as a job and creates the job object in the current session.
The command returns a job object that's saved in the `$j` variable. The `$j` variable displays the
job object.

The session object in the `$s` variable is sent down the pipeline to `Disconnect-PSSession` and the
session is disconnected.

The `$j` variable is displayed and shows the effect of disconnecting the job object in the `$j`
variable. The job state is now Disconnected.

The `Receive-Job` is run on the job in the `$j` variable. The output shows that the job began to
return output before the session and the job were disconnected.

The `Connect-PSSession` cmdlet is run in the same client session. The command reconnects to the Test
session on the Server01 computer and saves the session in the `$s2` variable.

The `Receive-PSSession` cmdlet gets the results of the job that was running in the session. Because
the command is run in the same session, `Receive-PSSession` returns the results as a job by default
and reuses the same job object. The command saves the job in the `$j2` variable. The `Receive-Job`
cmdlet gets the results of the job in the `$j` variable.

## PARAMETERS

### -AllowRedirection

Indicates that this cmdlet allows redirection of this connection to an alternate Uniform Resource
Identifier (URI).

When you use the **ConnectionURI** parameter, the remote destination can return an instruction to
redirect to a different URI. By default, PowerShell doesn't redirect connections, but you can use
this parameter to enable it to redirect the connection.

You can also limit the number of times the connection is redirected by changing the
**MaximumConnectionRedirectionCount** session option value. Use the **MaximumRedirection** parameter
of the `New-PSSessionOption` cmdlet or set the **MaximumConnectionRedirectionCount** property of the
`$PSSessionOption` preference variable. The default value is 5.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName

Specifies an application. This cmdlet connects only to sessions that use the specified application.

Enter the application name segment of the connection URI. For example, in the following connection
URI, WSMan is the application name: `http://localhost:5985/WSMAN`.

The application name of a session is stored in the **Runspace.ConnectionInfo.AppName** property of
the session.

The parameter's value is used to select and filter sessions. It doesn't change the application that
the session uses.

```yaml
Type: System.String
Parameter Sets: ComputerInstanceId, ComputerSessionName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Authentication

Specifies the mechanism that's used to authenticate the user credentials in the command to reconnect
to a disconnected session. The acceptable values for this parameter are:

- Default
- Basic
- Credssp
- Digest
- Kerberos
- Negotiate
- NegotiateWithImplicitCredential

The default value is Default.

For more information about the values of this parameter, see
[AuthenticationMechanism Enumeration](/dotnet/api/system.management.automation.runspaces.authenticationmechanism).

> [!CAUTION]
> Credential Security Support Provider (CredSSP) authentication, in which the user credentials are
> passed to a remote computer to be authenticated, is designed for commands that require
> authentication on more than one resource, such as accessing a remote network share. This mechanism
> increases the security risk of the remote operation. If the remote computer is compromised, the
> credentials that are passed to it can be used to control the network session.

```yaml
Type: System.Management.Automation.Runspaces.AuthenticationMechanism
Parameter Sets: ComputerInstanceId, ComputerSessionName, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:
Accepted values: Default, Basic, Negotiate, NegotiateWithImplicitCredential, Credssp, Digest, Kerberos

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint

Specifies the digital public key certificate (X509) of a user account that has permission to connect
to the disconnected session. Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication. Certificates can be mapped only to
local user accounts, and don't work with domain accounts.

To get a certificate thumbprint, use a `Get-Item` or `Get-ChildItem` command in the PowerShell
`Cert:` drive.

```yaml
Type: System.String
Parameter Sets: ComputerInstanceId, ComputerSessionName, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the computer on which the disconnected session is stored. Sessions are stored on the
computer that's at the server-side, or receiving end of a connection. The default is the local
computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name (FQDN) of one computer.
Wildcard characters aren't permitted. To specify the local computer, type the computer name, a dot
(`.`), `$env:COMPUTERNAME`, or localhost.

```yaml
Type: System.String
Parameter Sets: ComputerInstanceId, ComputerSessionName
Aliases: Cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfigurationName

Specifies the name of a session configuration. This cmdlet connects only to sessions that use the
specified session configuration.

Enter a configuration name or the fully qualified resource URI for a session configuration. If you
specify only the configuration name, the following schema URI is prepended:

`http://schemas.microsoft.com/powershell`.

The configuration name of a session is stored in the **ConfigurationName** property of the session.

The parameter's value is used to select and filter sessions. It doesn't change the session
configuration that the session uses.

For more information about session configurations, see
[about_Session_Configurations](./About/about_Session_Configurations.md).

```yaml
Type: System.String
Parameter Sets: ComputerInstanceId, ComputerSessionName, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionUri

Specifies a URI that defines the connection endpoint that is used to reconnect to the disconnected
session.

The URI must be fully qualified. The string's format is as follows:

`<Transport>://<ComputerName>:<Port>/<ApplicationName>`

The default value is as follows:

`http://localhost:5985/WSMAN`

If you don't specify a connection URI, you can use the **UseSSL**, **ComputerName**, **Port**, and
**ApplicationName** parameters to specify the connection URI values.

Valid values for the **Transport** segment of the URI are HTTP and HTTPS. If you specify a
connection URI with a Transport segment, but don't specify a port, the session is created with
standard ports: 80 for HTTP and 443 for HTTPS. To use the default ports for PowerShell remoting,
specify port 5985 for HTTP or 5986 for HTTPS.

If the destination computer redirects the connection to a different URI, PowerShell prevents the
redirection unless you use the **AllowRedirection** parameter in the command.

```yaml
Type: System.Uri
Parameter Sets: ConnectionUriSessionName, ConnectionUriInstanceId
Aliases: URI, CU

Required: True
Position: 0
Default value: http://localhost:5985/WSMAN
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to connect to the disconnected session. The default is
the current user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet. If you type a user name, you're prompted to enter the
password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: ComputerInstanceId, ComputerSessionName, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the ID of a disconnected session. The **Id** parameter works only when the disconnected
session was previously connected to the current session.

This parameter is valid, but not effective, when the session is stored on the local computer, but
wasn't connected to the current session.

```yaml
Type: System.Int32
Parameter Sets: Id
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InstanceId

Specifies the instance ID of the disconnected session. The instance ID is a GUID that uniquely
identifies a **PSSession** on a local or remote computer. The instance ID is stored in the
**InstanceID** property of the **PSSession**.

```yaml
Type: System.Guid
Parameter Sets: ComputerInstanceId, ConnectionUriInstanceId, InstanceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobName

Specifies a friendly name for the job that `Receive-PSSession` returns.

`Receive-PSSession` returns a job when the value of the **OutTarget** parameter is Job or the job
that's running in the disconnected session was started in the current session.

If the job that's running in the disconnected session was started in the current session, PowerShell
reuses the original job object in the session and ignores the value of the **JobName** parameter.

If the job that's running in the disconnected session was started in a different session, PowerShell
creates a new job object. It uses a default name, but you can use this parameter to change the name.

If the default value or explicit value of the **OutTarget** parameter isn't Job, the command
succeeds, but the **JobName** parameter has no effect.

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

### -Name

Specifies the friendly name of the disconnected session.

```yaml
Type: System.String
Parameter Sets: ComputerSessionName, ConnectionUriSessionName, SessionName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutTarget

Determines how the session results are returned. The acceptable values for this parameter are:

- **Job**. Returns the results asynchronously in a job object. You can use the **JobName** parameter
  to specify a name or new name for the job.
- **Host**. Returns the results to the command line (synchronously). If the command is being resumed
  or the results consist of a large number of objects, the response might be delayed.

The default value of the **OutTarget** parameter is Host. If the command that's being received in a
disconnected session was started in the current session, the default value of the **OutTarget**
parameter is the form in which the command was started. If the command was started as a job, by
default, it's returned as a job. Otherwise, it's returned to the host program by default.

Typically, the host program displays returned objects at the command line without delay, but this
behavior can vary.

```yaml
Type: Microsoft.PowerShell.Commands.OutTarget
Parameter Sets: (All)
Aliases:
Accepted values: Default, Host, Job

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port

Specifies the remote computer's network port that's used to reconnect to the session. To connect to
a remote computer, it must be listening on the port that the connection uses. The default ports are
5985, which is the WinRM port for HTTP, and 5986, which is the WinRM port for HTTPS.

Before using an alternate port, you must configure the WinRM listener on the remote computer to
listen on that port. To configure the listener, type the following two commands at the PowerShell
prompt:

`Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse`

`New-Item -Path WSMan:\Localhost\listener -Transport http -Address * -Port \<port-number\>`

Don't use the **Port** parameter unless it's necessary. The port that's set in the command applies
to all computers or sessions on which the command runs. An alternate port setting might prevent the
command from running on all computers.

```yaml
Type: System.Int32
Parameter Sets: ComputerInstanceId, ComputerSessionName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session

Specifies the disconnected session. Enter a variable that contains the **PSSession** or a command
that creates or gets the **PSSession**, such as a `Get-PSSession` command.

```yaml
Type: System.Management.Automation.Runspaces.PSSession
Parameter Sets: Session
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SessionOption

Specifies advanced options for the session. Enter a **SessionOption** object, such as one that you
create by using the `New-PSSessionOption` cmdlet, or a hash table in which the keys are session
option names and the values are session option values.

The default values for the options are determined by the value of the `$PSSessionOption` preference
variable, if it's set. Otherwise, the default values are established by options set in the session
configuration.

The session option values take precedence over default values for sessions set in the
`$PSSessionOption` preference variable and in the session configuration. However, they don't take
precedence over maximum values, quotas, or limits set in the session configuration.

For a description of the session options that includes the default values, see
`New-PSSessionOption`. For information about the **$PSSessionOption** preference variable, see
[about_Preference_Variables](./About/about_Preference_Variables.md). For more information about
session configurations, see
[about_Session_Configurations](./About/about_Session_Configurations.md).

```yaml
Type: System.Management.Automation.Remoting.PSSessionOption
Parameter Sets: ComputerInstanceId, ComputerSessionName, ConnectionUriSessionName, ConnectionUriInstanceId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL

Indicates that this cmdlet uses the Secure Sockets Layer (SSL) protocol to connect to the
disconnected session. By default, SSL isn't used.

WS-Management encrypts all PowerShell content transmitted over the network. **UseSSL** is an
additional protection that sends the data across an HTTPS connection instead of an HTTP connection.

If you use this parameter and SSL isn't available on the port that's used for the command, the
command fails.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ComputerInstanceId, ComputerSessionName
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Runspaces.PSSession

You can pipe session objects to this cmdlet, such as objects returned by the `Get-PSSession` cmdlet.

### System.Int32

You can pipe session Ids to this cmdlet.

### System.Guid

You can pipe the instance Ids of sessions this cmdlet.

### System.String

You can pipe session names to this cmdlet.

## OUTPUTS

### System.Management.Automation.Job or PSObject

This cmdlet returns the results of commands that ran in the disconnected session, if any. If the
value or default value of the **OutTarget** parameter is Job, `Receive-PSSession` returns a job
object. Otherwise, it returns objects that represent that command results.

## NOTES

This cmdlet is only available on Windows platforms.

`Receive-PSSession` gets results only from sessions that were disconnected. Only sessions that are
connected to, or terminate at, computers that run PowerShell 3.0 or later versions can be
disconnected and reconnected.

If the commands that were running in the disconnected session didn't generate results or if the
results were already returned to another session, `Receive-PSSession` doesn't generate any output.

A session's output buffering mode determines how commands in the session manage output when the
session is disconnected. When the value of the **OutputBufferingMode** option of the session is Drop
and the output buffer is full, the command starts to delete output. `Receive-PSSession` can't
recover this output. For more information about the output buffering mode option, see the help
articles for the [New-PSSessionOption](New-PSSessionOption.md) and
[New-PSTransportOption](New-PSTransportOption.md) cmdlets.

You can't change the idle time-out value of a **PSSession** when you connect to the **PSSession** or
receive results. The **SessionOption** parameter of `Receive-PSSession` takes a **SessionOption**
object that has an **IdleTimeout** value. However, the **IdleTimeout** value of the
**SessionOption** object and the **IdleTimeout** value of the `$PSSessionOption` variable are
ignored when it connects to a **PSSession** or receiving results.

- You can set and change the idle time-out of a **PSSession** when you create the **PSSession**, by
  using the `New-PSSession` or `Invoke-Command` cmdlets, and when you disconnect from the
  **PSSession**.
- The **IdleTimeout** property of a **PSSession** is critical to disconnected sessions because it
  determines how long a disconnected session is maintained on the remote computer. Disconnected
  sessions are considered to be idle from the moment that they are disconnected, even if commands
  are running in the disconnected session.

If you start a start a job in a remote session by using the **AsJob** parameter of the
`Invoke-Command` cmdlet, the job object is created in the current session, even though the job runs
in the remote session. If you disconnect the remote session, the job object in the current session
is disconnected from the job. The job object contains any results that were returned to it, but
doesn't receive new results from the job in the disconnected session.

If a different client connects to the session that contains the running job, the results that were
delivered to the original job object in the original session aren't available in the newly connected
session. Only results that were not delivered to the original job object are available in the
reconnected session.

Similarly, if you start a script in a session and then disconnect from the session, any results that
the script delivers to the session before disconnecting aren't available to another client that
connects to the session.

To prevent data loss in sessions that you intend to disconnect, use the **InDisconnectedSession**
parameter of the `Invoke-Command` cmdlet. Because this parameter prevents results from being
returned to the current session, all results are available when the session is reconnected.

You can also prevent data loss by using the `Invoke-Command` cmdlet to run a `Start-Job` command in
the remote session. In this case, the job object is created in the remote session. You can't use the
`Receive-PSSession` cmdlet to get the job results. Instead, use the `Connect-PSSession` cmdlet to
connect to the session and then use the `Invoke-Command` cmdlet to run a `Receive-Job` command in
the session.

When a session that contains a running job is disconnected and then reconnected, the original job
object is reused only if the job is disconnected and reconnected to the same session, and the
command to reconnect doesn't specify a new job name. If the session is reconnected to a different
client session or a new job name is specified, PowerShell creates a new job object for the new
session.

When you disconnect a **PSSession**, the session state is Disconnected and the availability is None.

- The value of the **State** property is relative to the current session. A value of Disconnected
  means that the **PSSession** isn't connected to the current session. However, it doesn't mean that
  the **PSSession** is disconnected from all sessions. It might be connected to a different session.
  To determine whether you can connect or reconnect to the session, use the **Availability**
  property.
- An **Availability** value of None indicates that you can connect to the session. A value of Busy
  indicates that you can't connect to the **PSSession** because it's connected to another session.
- For more information about the values of the **State** property of sessions, see
  [RunspaceState](/dotnet/api/system.management.automation.runspaces.runspacestate).
- For more information about the values of the **Availability** property of sessions, see
  [RunspaceAvailability](/dotnet/api/system.management.automation.runspaces.runspaceavailability).

## RELATED LINKS

[about_PSSessions](./About/about_PSSessions.md)

[about_Remote](./About/about_Remote.md)

[about_Remote_Disconnected_Sessions](./About/about_Remote_Disconnected_Sessions.md)

[about_Session_Configurations](./About/about_Session_Configurations.md)

[Connect-PSSession](Connect-PSSession.md)

[Enter-PSSession](Enter-PSSession.md)

[Exit-PSSession](Exit-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Invoke-Command](Invoke-Command.md)

[New-PSSession](New-PSSession.md)

[New-PSSessionOption](New-PSSessionOption.md)

[New-PSTransportOption](New-PSTransportOption.md)

[Remove-PSSession](Remove-PSSession.md)
