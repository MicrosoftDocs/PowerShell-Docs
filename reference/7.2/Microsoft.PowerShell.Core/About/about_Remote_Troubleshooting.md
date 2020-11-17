---
description: Describes how to troubleshoot remote operations in PowerShell.
Locale: en-US
ms.date: 10/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Troubleshooting
---
# About Remote Troubleshooting

## Short description
Describes how to troubleshoot remote operations in PowerShell.

## Long description

This section describes some of the problems that you might encounter when using
the remoting features of PowerShell that are based on WS-Management technology
and it suggests solutions to these problems.

Before using PowerShell remoting, see [about_Remote](about_remote.md) and
[about_Remote_Requirements](about_Remote_Requirements.md) for guidance on
configuration and basic use. Also, the Help topics for each of the remoting
cmdlets, particularly the parameter descriptions, have useful information that
is designed to help you avoid problems.

> [!NOTE]
> To view or change settings for the local computer in the WSMan: drive,
> including changes to the session configurations, trusted hosts, ports, or
> listeners, start PowerShell with the **Run as administrator** option.

## Troubleshooting permission and authentication issues

This section discusses remoting problems that are related to user and computer
permissions and remoting requirements.

### How to run as administrator

```
ERROR: Access is denied. You need to run this cmdlet from an elevated
process.
```

To start a remote session on the local computer, or to view or change settings
for the local computer in the WSMan: drive, including changes to the session
configurations, trusted hosts, ports, or listeners, start Windows PowerShell
with the **Run as administrator** option.

To start Windows PowerShell with the **Run as administrator** option:

- Right-click a Windows PowerShell (or Windows PowerShell ISE) icon and then
  click **Run as administrator**.

  To start Windows PowerShell with the **Run as administrator** option in Windows
  7 and Windows Server 2008 R2.

- In the Windows taskbar, right-click the Windows PowerShell icon, and then
  click **Run as administrator**.

  In Windows Server 2008 R2, the Windows PowerShell icon is pinned to the
  taskbar by default.

### How to enable remoting

```
ERROR:  ACCESS IS DENIED

or

ERROR: The connection to the remote host was refused. Verify that the
WS-Management service is running on the remote host and configured to
listen for requests on the correct port and HTTP URL.
```

No configuration is required to enable a computer to send remote commands.
However, to receive remote commands, PowerShell remoting must be enabled on the
computer. Enabling includes starting the WinRM service, setting the startup
type for the WinRM service to Automatic, creating listeners for HTTP and HTTPS
connections, and creating default session configurations.

Windows PowerShell remoting is enabled on Windows Server 2012 and newer
releases of Windows Server by default. On all other systems, run the
`Enable-PSRemoting` cmdlet to enable remoting. You can also run the
`Enable-PSRemoting` cmdlet to re-enable remoting on Windows Server 2012 and
newer releases of Windows Server if remoting is disabled.

To configure a computer to receive remote commands, use the `Enable-PSRemoting`
cmdlet. The following command enables all required remote settings, enables the
session configurations, and restarts the WinRM service to make the changes
effective.

`Enable-PSRemoting`

To suppress all user prompts, type:

`Enable-PSRemoting -Force`

For more information, see
[Enable-PSRemoting](xref:Microsoft.PowerShell.Core.Enable-PSRemoting).

### How to enable remoting in an enterprise

```
ERROR:  ACCESS IS DENIED

or

ERROR: The connection to the remote host was refused. Verify that the
WS-Management service is running on the remote host and configured to listen
for requests on the correct port and HTTP URL.
```

To enable a single computer to receive remote PowerShell commands and accept
connections, use the `Enable-PSRemoting` cmdlet.

To enable remoting for multiple computers in an enterprise, you can use the
following scaled options.

- To configure listeners for remoting, enable the **Allow automatic
  configuration of listeners** group policy.

- To set the startup type of the Windows Remote Management (WinRM) to Automatic
  on multiple computers, use the `Set-Service` cmdlet.

- To enable a firewall exception, use the **Windows Firewall: Allow Local Port
  Exceptions** group policy.

### How to enable listeners by using a group policy

```
ERROR:  ACCESS IS DENIED

or

ERROR: The connection to the remote host was refused. Verify that the
WS-Management service is running on the remote host and configured to listen
for requests on the correct port and HTTP URL.
```

To configure the listeners for all computers in a domain, enable the **Allow
automatic configuration of listeners** policy in the following Group Policy
path:

```
Computer Configuration\Administrative Templates\Windows Components
    \Windows Remote Management (WinRM)\WinRM service
```

Enable the policy and specify the IPv4 and IPv6 filters. Wildcards (`*`) are
permitted.

### How to enable remoting on public networks

```
ERROR:  Unable to check the status of the firewall
```

The `Enable-PSRemoting` cmdlet returns this error when the local network is
public and the **SkipNetworkProfileCheck** parameter is not used in the command.

On server versions of Windows, `Enable-PSRemoting` succeeds on all network
location types. It creates firewall rules that allow remote access to private
and domain ("Home" and "Work") networks. For public networks, it creates
firewall rules that allows remote access from the same local subnet.

On client versions of Windows, `Enable-PSRemoting` succeeds on private and
domain networks. By default, it fails on public networks, but if you use the
**SkipNetworkProfileCheck** parameter, `Enable-PSRemoting` succeeds and creates
a firewall rule that allows traffic from the same local subnet.

To remove the local subnet restriction on public networks and allow remote
access from any location, run the following command:

```powershell
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
```

The `Set-NetFirewallRule` cmdlet is exported by the NetSecurity module.

> [!NOTE]
> In Windows PowerShell 2.0, on computers running server versions of Windows,
> `Enable-PSRemoting` creates firewall rules that allow remote access on
> private, domain and public networks. On computers running client versions of
> Windows, `Enable-PSRemoting` creates firewall rules that allow remote access
> only on private and domain networks.

### How to enable a firewall exception by using a group policy

```
ERROR:  ACCESS IS DENIED

or

ERROR: The connection to the remote host was refused. Verify that the
WS-Management service is running on the remote host and configured to listen
for requests on the correct port and HTTP URL.
```

To enable a firewall exception for in all computers in a domain, enable the
**Windows Firewall: Allow local port exceptions** policy in the following Group
Policy path:

```
Computer Configuration\Administrative Templates\Network
    \Network Connections\Windows Firewall\Domain Profile
```

This policy allows members of the Administrators group on the computer to use
**Windows Firewall** in **Control Panel** to create a firewall exception for
the Windows Remote Management service.

If the policy configuration is incorrect you may receive the following error:

```
The client cannot connect to the destination specified in the request. Verify
that the service on the destination is running and is accepting requests.
```

A configuration error in the policy results in an empty value for the
**ListeningOn** property. Use the following command to check the value.

```powershell
PS> Get-WSManInstance winrm/config/listener -Enumerate

cfg                   : http://schemas.microsoft.com/wbem/wsman/1/config/listener
xsi                   : http://www.w3.org/2001/XMLSchema-instance
Source                : GPO
lang                  : en-US
Address               : *
Transport             : HTTP
Port                  : 5985
Hostname              :
Enabled               : true
URLPrefix             : wsman
CertificateThumbprint :
ListeningOn           : {}
```

### How to set the startup type of the WinRM service

```
ERROR:  ACCESS IS DENIED
```

PowerShell remoting depends upon the Windows Remote Management (WinRM) service.
The service must be running to support remote commands.

On server versions of Windows, the startup type of the Windows Remote
Management (WinRM) service is Automatic.

However, on client versions of Windows, the WinRM service is disabled
by default.

To set the startup type of a service on a remote computer, use the
`Set-Service` cmdlet.

To run the command on multiple computers, you can create a text file or CSV
file of the computer names.

For example, the following commands get a list of computer names from the
`Servers.txt` file and then sets the startup type of the WinRM service on all
of the computers to **Automatic**.

```powershell
$servers = Get-Content servers.txt
Set-Service WinRM -ComputerName $servers -startuptype Automatic
```

To see the results use the `Get-WMIObject` cmdlet with the **Win32_Service**
object. For more information, see
[Set-Service](xref:Microsoft.PowerShell.Management.Set-Service).

### How to recreate the default session configurations

```
ERROR:  ACCESS IS DENIED
```

To connect to the local computer and run commands remotely, the local computer
must include session configurations for remote commands.

When you use `Enable-PSRemoting`, it creates default session configurations on
the local computer. Remote users use these session configurations whenever a
remote command does not include the **ConfigurationName** parameter.

If the default configurations on a computer are unregistered or deleted, use
the `Enable-PSRemoting` cmdlet to recreate them. You can use this cmdlet
repeatedly. It does not generate errors if a feature is already configured.

If you change the default session configurations and want to restore the
original default session configurations, use the
`Unregister-PSSessionConfiguration` cmdlet to delete the changed session
configurations and then use the `Enable-PSRemoting` cmdlet to restore them.
`Enable-PSRemoting` does not change existing session configurations.

> [!NOTE]
> When `Enable-PSRemoting` restores the default session configuration, it does
> not create explicit security descriptors for the configurations. Instead, the
> configurations inherit the security descriptor of the RootSDDL, which is
> secure by default.

To see the RootSDDL security descriptor, type:

```powershell
Get-Item wsman:\localhost\Service\RootSDDL
```

To change the RootSDDL, use the `Set-Item` cmdlet in the WSMan: drive. To
change the security descriptor of a session configuration, use the
`Set-PSSessionConfiguration` cmdlet with the **SecurityDescriptorSDDL** or
**ShowSecurityDescriptorUI** parameters.

For more information about the WSMan: drive, see the Help topic for the WSMan
provider ("Get-Help wsman").

### How to provide administrator credentials

```
ERROR:  ACCESS IS DENIED
```

To create a PSSession or run commands on a remote computer, by default, the
current user must be a member of the Administrators group on the remote
computer. Credentials are sometimes required even when the current user is
logged on to an account that is a member of the Administrators group.

If the current user is a member of the Administrators group on the remote
computer, or can provide the credentials of a member of the Administrators
group, use the **Credential** parameter of the `New-PSSession`,
`Enter-PSSession` or `Invoke-Command` cmdlets to connect remotely.

For example, the following command provides the credentials of an
Administrator.

```powershell
Invoke-Command -ComputerName Server01 -Credential Domain01\Admin01
```

For more information about the **Credential** parameter, see
[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession),
[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession) or
[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command).

### How to enable remoting for non-administrative users

```
ERROR:  ACCESS IS DENIED
```

To establish a PSSession or run a command on a remote computer, the user must
have permission to use the session configurations on the remote computer.

By default, only members of the Administrators group on a computer have
permission to use the default session configurations. Therefore, only members
of the Administrators group can connect to the computer remotely.

To allow other users to connect to the local computer, give the user Execute
permissions to the default session configurations on the local computer.

The following command opens a property sheet that lets you change the security
descriptor of the default Microsoft.PowerShell session configuration on the
local computer.

```powershell
Set-PSSessionConfiguration Microsoft.PowerShell -ShowSecurityDescriptorUI
```

For more information, see
[about_Session_Configurations](about_Session_Configurations.md).

### How to enable remoting for administrators in other domains

```
ERROR:  ACCESS IS DENIED
```

When a user in another domain is a member of the Administrators group on the
local computer, the user cannot connect to the local computer remotely with
Administrator privileges. By default, remote connections from other domains run
with only standard user privilege tokens.

However, you can use the **LocalAccountTokenFilterPolicy** registry entry to
change the default behavior and allow remote users who are members of the
Administrators group to run with Administrator privileges.

> [!CAUTION]
> The **LocalAccountTokenFilterPolicy** entry disables user account control
> (UAC) remote restrictions for all users of all affected computers. Consider
> the implications of this setting carefully before changing the policy.

To change the policy, use the following command to set the value of the
**LocalAccountTokenFilterPolicy** registry entry to 1.

```powershell
New-ItemProperty -Name LocalAccountTokenFilterPolicy `
  -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
  -PropertyType DWord -Value 1
```

### How to use an ip address in a remote command

```
ERROR: The WinRM client cannot process the request. If the authentication
scheme is different from Kerberos, or if the client computer is not joined to a
domain, then HTTPS transport must be used or the destination machine must be
added to the TrustedHosts configuration setting.
```

The **ComputerName** parameter of the `New-PSSession`, `Enter-PSSession` and
`Invoke-Command` cmdlets accepts an IP address as a valid value. However,
because Kerberos authentication does not support IP addresses, NTLM
authentication is used by default whenever you specify an IP address.

When using NTLM authentication, the following procedure is required
for remoting.

1. Configure the computer for HTTPS transport or add the IP addresses of the
   remote computers to the TrustedHosts list on the local computer.

1. Use the **Credential** parameter in all remote commands.

   This is required even when you are submitting the credentials of the current
   user.

### How to connect remotely from a workgroup-based computer

```
ERROR: The WinRM client cannot process the request. If the authentication
scheme is different from Kerberos, or if the client computer is not joined to a
domain, then HTTPS transport must be used or the destination machine must be
added to the TrustedHosts configuration setting.
```

When the local computer is not in a domain, the following procedure is required
for remoting.

1. Configure the computer for HTTPS transport or add the names of the remote
   computers to the TrustedHosts list on the local computer.

1. Verify that a password is set on the workgroup-based computer. If a password
   is not set or the password value is empty, you cannot run remote commands.

   To set password for your user account, use User Accounts in Control Panel.

1. Use the **Credential** parameter in all remote commands.

   This is required even when you are submitting the credentials of the current
   user.

### How to add a computer to the trusted hosts list

The TrustedHosts item can contain a comma-separated list of computer names, IP
addresses, and fully-qualified domain names. Wildcards are permitted.

To view or change the trusted host list, use the WSMan: drive. The TrustedHost
item is in the `WSMan:\localhost\Client` node.

Only members of the Administrators group on the computer have permission to
change the list of trusted hosts on the computer.

Caution: The value that you set for the TrustedHosts item affects all users of
the computer.

To view the list of trusted hosts, use the following command:

```powershell
Get-Item wsman:\localhost\Client\TrustedHosts
```

You can also use the `Set-Location` cmdlet (alias = cd) to navigate though the
WSMan: drive to the location. For example:

```powershell
cd WSMan:\localhost\Client; dir
```

To add all computers to the list of trusted hosts, use the following command,
which places a value of * (all) in the ComputerName

```powershell
Set-Item wsman:localhost\client\trustedhosts -Value *
```

You can also use a wildcard character (`*`) to add all computers in a
particular domain to the list of trusted hosts. For example, the following
command adds all of the computers in the Fabrikam domain to the list of trusted
hosts.

```powershell
Set-Item wsman:localhost\client\trustedhosts *.fabrikam.com
```

To add the names of particular computers to the list of trusted hosts, use
the following command format:

```powershell
Set-Item wsman:\localhost\Client\TrustedHosts -Value <ComputerName>
```

where each value `<ComputerName>` must have the following format:

```
<Computer>.<Domain>.<Company>.<top-level-domain>
```

For example:

```powershell
$server = 'Server01.Domain01.Fabrikam.com'
Set-Item wsman:\localhost\Client\TrustedHosts -Value $server
```

To add a computer name to an existing list of trusted hosts, first save the
current value in a variable, and then set the value to a comma-separated list
that includes the current and new values.

For example, to add the Server01 computer to an existing list of trusted hosts,
use the following command

```powershell
$curValue = (Get-Item wsman:\localhost\Client\TrustedHosts).value

Set-Item wsman:\localhost\Client\TrustedHosts -Value `
  "$curValue, Server01.Domain01.Fabrikam.com"
```

To add the IP addresses of particular computers to the list of trusted hosts,
use the following command format:

```powershell
Set-Item wsman:\localhost\Client\TrustedHosts -Value <IP Address>
```

For example:

```powershell
Set-Item wsman:\localhost\Client\TrustedHosts -Value 172.16.0.0
```

To add a computer to the TrustedHosts list of a remote computer, use the
`Connect-WSMan` cmdlet to add a node for the remote computer to the WSMan:
drive on the local computer. Then use a `Set-Item` command to add the computer.

For more information about the `Connect-WSMan` cmdlet, see
[Connect-WSMan](xref:Microsoft.WSMan.Management.Connect-WSMan).

## Troubleshooting computer configuration issues

This section discusses remoting problems that are related to particular
configurations of a computer, domain, or enterprise.

### How to configure remoting on alternate ports

```
ERROR: The connection to the specified remote host was refused. Verify that the
WS-Management service is running on the remote host and configured to listen
for requests on the correct port and HTTP URL.
```

PowerShell remoting uses port 80 for HTTP transport by default. The default
port is used whenever the user does not specify the **ConnectionURI** or
**Port** parameters in a remote command.

To change the default port that PowerShell uses, use `Set-Item` cmdlet in the
WSMan: drive to change the Port value in the listener leaf node.

For example, the following command changes the default port to 8080.

```powershell
Set-Item wsman:\localhost\listener\listener*\port -Value 8080
```

### How to configure remoting with a proxy server

```
ERROR: The client cannot connect to the destination specified in the request.
Verify that the service on the destination is running and is accepting
requests.
```

Because PowerShell remoting uses the HTTP protocol, it is affected by HTTP
proxy settings. In enterprises that have proxy servers, users cannot access a
PowerShell remote computer directly.

To resolve this problem, use proxy setting options in your remote command. The
following settings are available:

- ProxyAccessType
- ProxyAuthentication
- ProxyCredential

To set these options for a particular command, use the following procedure:

1. Use the **ProxyAccessType**, **ProxyAuthentication**, and
   **ProxyCredential** parameters of the `New-PSSessionOption` cmdlet to create
   a session option object with the proxy settings for your enterprise. Save
   the option object is a variable.

1. Use the variable that contains the option object as the value of the
   **SessionOption** parameter of a `New-PSSession`, `Enter-PSSession`, or
   `Invoke-Command` command.

For example, the following command creates a session option object with proxy
session options and then uses the object to create a remote session.

```powershell
$SessionOption = New-PSSessionOption -ProxyAccessType IEConfig `
-ProxyAuthentication Negotiate -ProxyCredential Domain01\User01

New-PSSession -ConnectionURI https://www.fabrikam.com
```

For more information about the `New-PSSessionOption` cmdlet, see
[New-PSSessionOption](xref:Microsoft.PowerShell.Core.New-PSSessionOption).

To set these options for all remote commands in the current session, use the
option object that `New-PSSessionOption` creates in the value of the
`$PSSessionOption` preference variable. For more information, see
[about_Preference_Variables](about_Preference_Variables.md).

To set these options for all remote commands all PowerShell sessions on the
local computer, add the `$PSSessionOption` preference variable to your PowerShell
profile. For more information about PowerShell profiles, see
[about_Profiles](about_Profiles.md).

### How to detect a 32-bit session on a 64-bit computer

```
ERROR: The term "<tool-Name>" is not recognized as the name of a cmdlet,
function, script file, or operable program. Check the spelling of the name, or
if a path was included, verify that the path is correct and try again.
```

If the remote computer is running a 64-bit version of Windows, and the remote
command is using a 32-bit session configuration, such as
Microsoft.PowerShell32, Windows Remote Management (WinRM) loads a WOW64 process
and Windows automatically redirects all references to the
`$env:Windir\System32` directory to the `$env:Windir\SysWOW64` directory.

As a result, if you try to use tools in the System32 directory that do not have
counterparts in the SysWow64 directory, such as `Defrag.exe`, the tools cannot
be found in the directory.

To find the processor architecture that is being used in the session, use the
value of the **PROCESSOR_ARCHITECTURE** environment variable. The following
command finds the processor architecture of the session in the `$s` variable.

```powershell
$s = New-PSSession -ComputerName Server01 -ConfigurationName CustomShell
Invoke-Command -Session $s {$env:PROCESSOR_ARCHITECTURE}
```

```Output
x86
```

For more information about session configurations, see
[about_Session_Configurations](about_Session_Configurations.md).

## Troubleshooting policy and preference issues

This section discusses remoting problems that are related to policies and
preferences set on the local and remote computers.

### How to change the execution policy for Import-PSSession and Import-Module

```
ERROR: Import-Module: File <filename> cannot be loaded because the
execution of scripts is disabled on this system.
```

The `Import-PSSession` and `Export-PSSession` cmdlets create modules that
contains unsigned script files and formatting files.

To import the modules that are created by these cmdlets, either by using
`Import-PSSession` or `Import-Module`, the execution policy in the current
session cannot be Restricted or AllSigned. For information about PowerShell
execution policies, see
[about_Execution_Policies](about_Execution_Policies.md).

To import the modules without changing the execution policy for the local
computer that is set in the registry, use the **Scope** parameter of
`Set-ExecutionPolicy` to set a less restrictive execution policy for a single
process.

For example, the following command starts a process with the `RemoteSigned`
execution policy. The execution policy change affects only the current process
and does not change the PowerShell **ExecutionPolicy** registry setting.

```powershell
Set-ExecutionPolicy -Scope process -ExecutionPolicy RemoteSigned
```

You can also use the **ExecutionPolicy** parameter of `PowerShell.exe` to start a
single session with a less restrictive execution policy.

```powershell
PowerShell.exe -ExecutionPolicy RemoteSigned
```

For more information about execution policies, see
[about_Execution_Policies](about_Execution_Policies.md). For more information,
type `PowerShell.exe -?`.

### How to set and change quotas

```
ERROR: The total data received from the remote client exceeded allowed
maximum.
```

You can use quotas to protect the local computer and the remote computer from
excessive resource use, both accidental and malicious.

The following quotas are available in the basic configuration.

- The WSMan provider (WSMan:) provides several quota settings, such as the
  **MaxEnvelopeSizeKB** and **MaxProviderRequests** settings in the
  `WSMan:<ComputerName>` node and the **MaxConcurrentOperations**,
  **MaxConcurrentOperationsPerUser**, and **MaxConnections** settings in the
  `WSMan:<ComputerName>\Service` node.

- You can protect the local computer by using the
  **MaximumReceivedDataSizePerCommand** and **MaximumReceivedObjectSize**
  parameters of the `New-PSSessionOption` cmdlet and the `$PSSessionOption`
  preference variable.

- You can protect the remote computer by adding restrictions to the session
  configurations, such as by using the **MaximumReceivedDataSizePerCommandMB**
  and **MaximumReceivedObjectSizeMB** parameters of the
  `Register-PSSessionConfiguration` cmdlet.

When quotas conflict with a command, PowerShell generates an error.

To resolve the error, change the remote command to comply with the quota. Or,
determine the source of the quota, and then increase the quota to allow the
command to complete.

For example, the following command increases the object size quota in the
Microsoft.PowerShell session configuration on the remote computer from 10 MB
(the default value) to 11 MB.

```powershell
Set-PSSessionConfiguration -Name microsoft.PowerShell `
  -MaximumReceivedObjectSizeMB 11 -Force
```

For more information about the `New-PSSessionOption` cmdlet, see
`New-PSSessionOption`.

For more information about the WS-Management quotas, see
[about_WSMan_Provider](../../Microsoft.WsMan.Management/About/about_WSMan_Provider.md).

### How to resolve timeout errors

```
ERROR: The WS-Management service cannot complete the operation within
the time specified in OperationTimeout.
```

You can use timeouts to protect the local computer and the remote computer from
excessive resource use, both accidental and malicious. When timeouts are set on
both the local and remote computer, PowerShell uses the shortest timeout
settings.

The following timeouts are available in the basic configuration.

- The WSMan provider (WSMan:) provides several client-side and service-side
  timeout settings, such as the **MaxTimeoutms** setting in the
  `WSMan:<ComputerName>` node and the **EnumerationTimeoutms** and
  **MaxPacketRetrievalTimeSeconds** settings in the
  `WSMan:<ComputerName>\Service` node.

- You can protect the local computer by using the **CancelTimeout**,
  **IdleTimeout**, **OpenTimeout**, and **OperationTimeout** parameters of the
  `New-PSSessionOption` cmdlet and the `$PSSessionOption` preference variable.

- You can also protect the remote computer by setting timeout values
  programmatically in the session configuration for the session.

When a timeout value does not permit a operation to complete, PowerShell
terminates the operation and generates an error.

To resolve the error, change the command to complete within the timeout
interval or determine the source of the timeout limit and increase the timeout
interval to allow the command to complete.

For example, the following commands use the `New-PSSessionOption` cmdlet to
create a session option object with an **OperationTimeout** value of 4 minutes
(in MS) and then use the session option object to create a remote session.

```powershell
$pso = New-PSSessionoption -OperationTimeout 240000

New-PSSession -ComputerName Server01 -sessionOption $pso
```

For more information about the WS-Management timeouts, see the Help topic for
the WSMan provider (type `Get-Help WSMan`).

For more information about the `New-PSSessionOption` cmdlet, see
[New-PSSessionOption](xref:Microsoft.PowerShell.Core.New-PSSessionOption).

## Troubleshooting unresponsive behavior

This section discusses remoting problems that prevent a command from completing
and prevent or delay the return of the PowerShell prompt.

### How to interrupt a command

Some native Windows programs, such as programs with a user interface, console
applications that prompt for input, and console applications that use the Win32
console API, do not work correctly in the PowerShell remote host.

When you use these programs, you might see unexpected behavior, such as no
output, partial output, or a remote command that does not complete.

To end an unresponsive program, type <kbd>CTRL</kbd>+<kbd>C</kbd>. To view any
errors that might have been reported, type `$error` in the local host and the
remote session.

## How to recover from an operation failure

```
ERROR: The I/O operation has been aborted because of either a thread exit
or an  application request.
```

This error is returned when an operation is terminated before it completes.
Typically, it occurs when the WinRM service stops or restarts while other WinRM
operations are in progress.

To resolve this issue, verify that the WinRM service is running and try the
command again.

1. Start PowerShell with the **Run as administrator** option.
1. Run the following command:

   `Start-Service WinRM`

1. Re-run the command that generated the error.

## Linux and macOS limitations

### Authentication

Only basic authentication works on macOS and attempting to use other
authentication schemes may result in the process crashing.

Please see the
[OMI authentication](https://github.com/PowerShell/psl-omi-provider#connecting-from-linux-to-windows)
instructions.

## SEE ALSO

[Import-PSSession](xref:Microsoft.PowerShell.Utility.Import-PSSession)

[Export-PSSession](xref:Microsoft.PowerShell.Utility.Export-PSSession)

[Import-Module](xref:Microsoft.PowerShell.Core.Import-Module)

[about_Remote](about_Remote.md)

[about_Remote_Requirements](about_Remote_Requirements.md)

[about_Remote_Variables](about_Remote_Variables.md)
