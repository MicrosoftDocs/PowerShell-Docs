---
description: Contains questions and answers about running remote commands in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 07/23/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_faq?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_FAQ
---
# About Remote FAQ

## Short description
Contains questions and answers about running remote commands in PowerShell.

## Long description

When you work remotely, you type commands in PowerShell on one computer (known
as the "local computer"), but the commands run on another computer (known as
the "remote computer"). The experience of working remotely should be as much
like working directly at the remote computer as possible.

Note: To use PowerShell remoting, the remote computer must be configured for
remoting. For more information, see
[about_Remote_Requirements](about_Remote_Requirements.md).

### Must both computers have PowerShell installed?

Yes. To work remotely, the local and remote computers must have PowerShell, the
Microsoft .NET Framework, and the Web Services for Management (WS-Management)
protocol. Any files and other resources that are needed to execute a particular
command must be on the remote computer.

Computers running Windows PowerShell 3.0 and computers running Windows
PowerShell 2.0 can connect to each other remotely and run remote commands.
However, some features, such as the ability to disconnect from a session and
reconnect to it, work only when both computers are running Windows PowerShell
3.0.

You must have permission to connect to the remote computer, permission to run
PowerShell, and permission to access data stores (such as files and folders),
and the registry on the remote computer.

For more information, see [about_Remote_Requirements](about_Remote_Requirements.md).

### How does remoting work?

When you submit a remote command, the command is transmitted across the network
to the PowerShell engine on the remote computer, and it runs in the PowerShell
client on the remote computer. The command results are sent back to the local
computer and appear in the PowerShell session on the local computer.

To transmit the commands and receive the output, PowerShell uses the
WS-Management protocol. For information about the WS-Management protocol, see
[WS-Management Protocol](/windows/win32/winrm/ws-management-protocol) in the
Windows documentation.

Beginning in Windows PowerShell 3.0, remote sessions are stored on the remote
computer. This enables you to disconnect from the session and reconnect from a
different session or a different computer without interrupting the commands or
losing state.

### Is PowerShell remoting secure?

When you connect to a remote computer, the system uses the username and
password credentials on the local computer or the credentials that you supply
in the command to log you in to the remote computer. The credentials and the
rest of the transmission are encrypted.

To add additional protection, you can configure the remote computer to use
Secure Sockets Layer (SSL) instead of HTTP to listen for Windows Remote
Management (WinRM) requests. Then, users can use the **UseSSL** parameter of
the `Invoke-Command`, `New-PSSession`, and `Enter-PSSession` cmdlets when
establishing a connection. This option uses the more secure HTTPS channel
instead of HTTP.

### Do all remote commands require PowerShell remoting?

No. Several cmdlets have a **ComputerName** parameter that lets you get objects
from the remote computer.

These cmdlets do not use PowerShell remoting. So, you can use them on any
computer that is running PowerShell, even if the computer is not configured for
PowerShell remoting or if the computer does not meet the requirements for
PowerShell remoting.

These cmdlets include the following:

- `Get-Process`
- `Get-Service`
- `Get-WinEvent`
- `Get-EventLog`
- `Test-Connection`

To find all the cmdlets with a **ComputerName** parameter, type:

```powershell
Get-Help * -Parameter ComputerName
# or
Get-Command -ParameterName ComputerName
```

To determine whether the **ComputerName** parameter of a particular cmdlet
requires PowerShell remoting, see the parameter description. To display the
parameter description, type:

```powershell
Get-Help <cmdlet-name> -Parameter ComputerName
```

For example:

```powershell
Get-Help Get-Process -Parameter ComputerName
```

For all other commands, use the `Invoke-Command` cmdlet.

### How do I run a command on a remote computer?

To run a command on a remote computer, use the `Invoke-Command` cmdlet.

Enclose your command in braces (`{}`) to make it a script block. Use the
**ScriptBlock** parameter of `Invoke-Command` to specify the command.

You can use the **ComputerName** parameter of `Invoke-Command` to specify a
remote computer. Or, you can create a persistent connection to a remote
computer (a session) and then use the **Session** parameter of `Invoke-Command`
to run the command in the session.

For example, the following commands run a `Get-Process` command remotely.

```powershell
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock {Get-Process}

#  - OR -

Invoke-Command -Session $s -ScriptBlock {Get-Process}
```

To interrupt a remote command, type <kbd>CTRL</kbd>+<kbd>C</kbd>. The
interruption request is passed to the remote computer, where it terminates the
remote command.

For more information about remote commands, see about_Remote and the Help
topics for the cmdlets that support remoting.

### Can I just telnet into a remote computer?

You can use the `Enter-PSSession` cmdlet to start an interactive session with a
remote computer.

At the PowerShell prompt, type:

```powershell
Enter-PSSession <ComputerName>
```

The command prompt changes to show that you are connected to the remote
computer.

```
<ComputerName>\C:>
```

Now, the commands that you type run on the remote computer just as though you
typed them directly on the remote computer.

To end the interactive session, type:

```powershell
Exit-PSSession
```

An interactive session is a persistent session that uses the WS-Management
protocol. It is not the same as using Telnet, but it provides a similar
experience.

For more information, see `Enter-PSSession`.

### Can I create a persistent connection?

Yes. You can run remote commands by specifying the name of the remote computer,
its NetBIOS name, or its IP address. Or, you can run remote commands by
specifying a PowerShell session (PSSession) that is connected to the remote
computer.

When you use the **ComputerName** parameter of `Invoke-Command` or
`Enter-PSSession`, PowerShell establishes a temporary connection. PowerShell
uses the connection to run only the current command, and then it closes the
connection. This is a very efficient method for running a single command or
several unrelated commands, even on many remote computers.

When you use the `New-PSSession` cmdlet to create a PSSession, PowerShell
establishes a persistent connection for the PSSession. Then, you can run
multiple commands in the PSSession, including commands that share data.

Typically, you create a PSSession to run a series of related commands that
share data. Otherwise, the temporary connection created by the **ComputerName**
parameter is sufficient for most commands.

For more information about sessions, see about_PSSessions.

### Can I run commands on more than one computer at a time?

Yes. The **ComputerName** parameter of the `Invoke-Command` cmdlet accepts
multiple computer names, and the **Session** parameter accepts multiple
PSSessions.

When you run an `Invoke-Command` command, PowerShell runs the commands on all
of the specified computers or in all of the specified PSSessions.

PowerShell can manage hundreds of concurrent remote connections. However, the
number of remote commands that you can send might be limited by the resources
of your computer and its capacity to establish and maintain multiple network
connections.

For more information, see the example in the `Invoke-Command` Help topic.

### Where are my profiles?

PowerShell profiles are not run automatically in remote sessions, so the
commands that the profile adds are not present in the session. In addition, the
`$profile` automatic variable is not populated in remote sessions.

To run a profile in a session, use the `Invoke-Command` cmdlet.

For example, the following command runs the CurrentUserCurrentHost profile
from the local computer in the session in `$s`.

```
Invoke-Command -Session $s -FilePath $profile
```

The following command runs the CurrentUserCurrentHost profile from the remote
computer in the session in `$s`. Because the `$profile` variable is not populated,
the command uses the explicit path to the profile.

```powershell
Invoke-Command -Session $s {
  . "$home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}
```

After running this command, the commands that the profile adds to the session
are available in `$s`.

You can also use a startup script in a session configuration to run a profile
in every remote session that uses the session configuration.

For more information about PowerShell profiles, see about_Profiles.
For more information about session configurations, see
`Register-PSSessionConfiguration`.

### How does throttling work on remote commands?

To help you manage the resources on your local computer, PowerShell
includes a per-command throttling feature that lets you limit the number of
concurrent remote connections that are established for each command.

The default is 32 concurrent connections, but you can use the **ThrottleLimit**
parameter of the cmdlets to set a custom throttle limit for particular
commands.

When you use the throttling feature, remember that it is applied to each
command, not to the entire session or to the computer. If you are running
commands concurrently in several sessions or PSSessions, the number of
concurrent connections is the sum of the concurrent connections in all the
sessions.

To find cmdlets with a **ThrottleLimit** parameter, type:

```
Get-Help * -Parameter ThrottleLimit
-or-
Get-Command -ParameterName ThrottleLimit
```

### Is the output of remote commands different from local output?

When you use PowerShell locally, you send and receive "live" .NET
Framework objects; "live" objects are objects that are associated with actual
programs or system components. When you invoke the methods or change the
properties of live objects, the changes affect the actual program or
component. And, when the properties of a program or component change, the
properties of the object that represent them also change.

However, because most live objects cannot be transmitted over the network,
PowerShell "serializes" most of the objects sent in remote commands,
that is, it converts each object into a series of XML (Constraint Language in
XML [CLiXML]) data elements for transmission.

When PowerShell receives a serialized object, it converts the XML into
a deserialized object type. The deserialized object is an accurate record of
the properties of the program or component at a previous time, but it is no
longer "live", that is, it is no longer directly associated with the
component. And, the methods are removed because they are no longer effective.

Typically, you can use deserialized objects just as you would use live
objects, but you must be aware of their limitations. Also, the objects that
are returned by the `Invoke-Command` cmdlet have additional properties that help
you to determine the origin of the command.

Some object types, such as DirectoryInfo objects and GUIDs, are converted back
into live objects when they are received. These objects do not need any
special handling or formatting.

For information about interpreting and formatting remote output, see
[about_Remote_Output](about_Remote_Output.md).

### Can I run background jobs remotely?

Yes. A PowerShell background job is a PowerShell command that
runs asynchronously without interacting with the session. When you start a
background job, the command prompt returns immediately, and you can continue
to work in the session while the job runs even if it runs for an extended
period of time.

You can start a background job even while other commands are running because
background jobs always run asynchronously in a temporary session.

You can run background jobs on a local or remote computer. By default, a
background job runs on the local computer. However, you can use the **AsJob**
parameter of the `Invoke-Command` cmdlet to run any remote command as a
background job. And, you can use `Invoke-Command` to run a `Start-Job` command
remotely.

For more information about background jobs in PowerShell , see
[about_Jobs(about_Jobs.md)] and [about_Remote_Jobs(about_Remote_Jobs.md)].

### Can I run windows programs on a remote computer?

You can use PowerShell remote commands to run Windows-based programs on remote
computers. For example, you can run `Shutdown.exe` or `Ipconfig.exe` on a
remote computer.

However, you cannot use PowerShell commands to open the user interface
for any program on a remote computer.

When you start a Windows program on a remote computer, the command is not
completed, and the PowerShell command prompt does not return, until the program
is finished or until you press <kbd>CTRL</kbd>+<kbd>C</kbd> to interrupt the
command. For example, if you run the `Ipconfig.exe` program on a remote
computer, the command prompt does not return until `Ipconfig.exe` is completed.

If you use remote commands to start a program that has a user interface, the
program process starts, but the user interface does not appear. The PowerShell
command is not completed, and the command prompt does not return until you stop
the program process or until you press <kbd>CTRL</kbd>+<kbd>C</kbd>, which
interrupts the command and stops the process.

For example, if you use a PowerShell command to run `Notepad` on a
remote computer, the Notepad process starts on the remote computer, but the
Notepad user interface does not appear. To interrupt the command and restore
the command prompt, press <kbd>CTRL</kbd>+<kbd>C</kbd>.

### Can I limit the commands that users can run remotely on my computer?

Yes. Every remote session must use one of the session configurations on the
remote computer. You can manage the session configurations on your computer
(and the permissions to those session configurations) to determine who can run
commands remotely on your computer and which commands they can run.

A session configuration configures the environment for the session. You can
define the configuration by using an assembly that implements a new
configuration class or by using a script that runs in the session. The
configuration can determine the commands that are available in the session.
And, the configuration can include settings that protect the computer, such as
settings that limit the amount of data that the session can receive remotely
in a single object or command. You can also specify a security descriptor that
determines the permissions that are required to use the configuration.

The `Enable-PSRemoting` cmdlet creates the default session configurations on
your computer: Microsoft.PowerShell, Microsoft.PowerShell.Workflow, and
Microsoft.PowerShell32 (64-bit operating systems only). `Enable-PSRemoting` sets
the security descriptor for the configuration to allow only members of the
Administrators group on your computer to use them.

You can use the session configuration cmdlets to edit the default session
configurations, to create new session configurations, and to change the
security descriptors of all the session configurations.

Beginning in Windows PowerShell 3.0, the `New-PSSessionConfigurationFile` cmdlet
lets you create custom session configurations by using a text file. The file
includes options for setting the language mode and for specifying the cmdlets
and modules that are available in sessions that use the session configuration.

When users use the `Invoke-Command`, `New-PSSession`, or `Enter-PSSession`
cmdlets, they can use the **ConfigurationName** parameter to indicate the
session configuration that is used for the session. And, they can change the
default configuration that their sessions use by changing the value of the
`$PSSessionConfigurationName` preference variable in the session.

For more information about session configurations, see the Help for the
session configuration cmdlets. To find the session configuration cmdlets,
type:

```powershell
Get-Command *PSSessionConfiguration
```

### What are fan in and fan out configurations?

The most common PowerShell remoting scenario involving multiple
computers is the one-to-many configuration, in which one local computer (the
administrator's computer) runs PowerShell commands on numerous remote
computers. This is known as the "fan-out" scenario.

However, in some enterprises, the configuration is many-to-one, where many
client computers connect to a single remote computer that is running
PowerShell, such as a file server or a kiosk. This is known as the "fan-in"
configuration.

PowerShell remoting supports both fan-out and fan-in configurations.

For the fan-out configuration, PowerShell uses the Web Services for
Management (WS-Management) protocol and the WinRM service that supports the
Microsoft implementation of WS-Management. When a local computer connects to a
remote computer, WS-Management establishes a connection and uses a plug-in for
PowerShell to start the PowerShell host process
(Wsmprovhost.exe) on the remote computer. The user can specify an alternate
port, an alternate session configuration, and other features to customize the
remote connection.

To support the "fan-in" configuration, PowerShell uses internet Information
Services (IIS) to host WS-Management, to load the PowerShell plug-in, and to
start PowerShell. In this scenario, instead of starting each PowerShell session
in a separate process, all PowerShell sessions run in the same host process.

IIS hosting and fan-in remote management is not supported in Windows XP or in
Windows Server 2003.

In a fan-in configuration, the user can specify a connection URI and an HTTP
endpoint, including the transport, computer name, port, and application name.
IIS forwards all the requests with a specified application name to the
application. The default is WS-Management, which can host PowerShell.

You can also specify an authentication mechanism and prohibit or allow
redirection from HTTP and HTTPS endpoints.

### Can I test remoting on a single computer not in a domain?

Yes. PowerShell remoting is available even when the local computer is
not in a domain. You can use the remoting features to connect to sessions and
to create sessions on the same computer. The features work the same as they do
when you connect to a remote computer.

To run remote commands on a computer in a workgroup, change the following
Windows settings on the computer.

Caution: These settings affect all users on the system and they can make the
system more vulnerable to a malicious attack. Use caution when making these
changes.

- Windows Vista, Windows 7, Windows 8:

  Create the following registry entry, and then set its value to 1:
  LocalAccountTokenFilterPolicy in
 ` HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`

  You can use the following PowerShell command to add this entry:

    ```powershell
    $parameters = @{
      Path='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
      Name='LocalAccountTokenFilterPolicy'
      propertyType='DWord'
      Value=1
    }
    New-ItemProperty @parameters
    ```

- Windows Server 2003, Windows Server 2008, Windows Server 2012, Windows
  Server 2012 R2:

  No changes are needed because the default setting of the "Network Access:
  Sharing and security model for local accounts" policy is "Classic". Verify
  the setting in case it has changed.

### Can I run remote commands on a computer in another domain?

Yes. Typically, the commands run without error, although you might need to use
the **Credential** parameter of the `Invoke-Command`, `New-PSSession`, or
`Enter-PSSession` cmdlets to provide the credentials of a member of the
Administrators group on the remote computer. This is sometimes required even
when the current user is a member of the Administrators group on the local and
remote computers.

However, if the remote computer is not in a domain that the local computer
trusts, the remote computer might not be able to authenticate the user's
credentials.

To enable authentication, use the following command to add the remote computer
to the list of trusted hosts for the local computer in WinRM. Type the command
at the PowerShell prompt.

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value <Remote-computer-name>
```

For example, to add the Server01 computer to the list of trusted hosts on the
local computer, type the following command at the PowerShell prompt:

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value Server01
```

### Does PowerShell support remoting over SSH?

Yes. For more information, see
[PowerShell remoting over SSH](/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core).

## See also

[about_Remote](about_Remote.md)

[about_Profiles](about_Profiles.md)

[about_PSSessions](about_PSSessions.md)

[about_Remote_Jobs](about_Remote_Jobs.md)

[about_Remote_Variables](about_Remote_Variables.md)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)
