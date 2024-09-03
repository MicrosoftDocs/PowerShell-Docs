---
description: Describes how to troubleshoot remote operations in PowerShell.
Locale: en-US
ms.date: 07/03/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Troubleshooting
---
# about_Remote_Troubleshooting

## Short description
Describes how to troubleshoot remote operations in PowerShell.

## Long description

Before using PowerShell remoting, see [about_Remote][08] and
[about_Remote_Requirements][06] for guidance on configuration and basic use.

You must have administrative rights to view or change settings for the local
computer in the `WSMan:` drive. This includes changes to session configuration,
trusted hosts, ports, or listeners.

You must run PowerShell with the **Run as administrator** option.

## How to run as administrator

For error:

> ERROR: Access is denied. You need to run this cmdlet from an elevated
> process.

To start Windows PowerShell with the **Run as administrator** option,
right-click on the PowerShell icon in the Start Menu and select **Run as
administrator**.

## How to enable remoting

For errors:

> - ERROR:  ACCESS IS DENIED
> - ERROR: The connection to the remote host was refused. Verify that the
>   WS-Management service is running on the remote host and configured to
>   listen for requests on the correct port and HTTP URL.

To receive remote commands, PowerShell remoting must be enabled on the
computer. Windows PowerShell remoting is enabled by default on Windows Server
2012 and newer releases of Windows Server. You can run `Enable-PSRemoting` to
re-enable remoting if it was disabled. For more information, see
[Enable-PSRemoting][10].

## How to enable remoting in an enterprise

For errors:

> - ERROR:  ACCESS IS DENIED
> - ERROR: The connection to the remote host was refused. Verify that the
>   WS-Management service is running on the remote host and configured to
>   listen for requests on the correct port and HTTP URL.

To enable a single computer to receive remote PowerShell commands and accept
connections, use the `Enable-PSRemoting` cmdlet.

To enable remoting for multiple computers in an enterprise, you can use the
following scaled options.

- Enable the **Allow automatic configuration of listeners** group policy to
  configure listeners for remoting.
- Configure and enable the **Windows Firewall: Allow Local Port Exceptions**
  group policy.
- Set the startup type of the WinRM service to `Automatic` and start the
  service.

### How to enable listeners by using a group policy

For errors:

> - ERROR:  ACCESS IS DENIED
> - ERROR: The connection to the remote host was refused. Verify that the
>   WS-Management service is running on the remote host and configured to listen
>   for requests on the correct port and HTTP URL.

Enable the **Allow automatic configuration of listeners** policy to configure
the listeners for all computers in a domain.

The policy is found in the following Group Policy path:

```
Computer Configuration\Administrative Templates\Windows Components
    \Windows Remote Management (WinRM)\WinRM service
```

Enable the policy and specify the IPv4 and IPv6 filters. Wildcards (`*`) are
permitted.

### How to enable remoting on public networks

`Enable-PSRemoting` returns this error when the local network is public and the
**SkipNetworkProfileCheck** parameter is not used in the command.

> ERROR:  Unable to check the status of the firewall

On server versions of Windows, `Enable-PSRemoting` succeeds on all network
profiles. It creates firewall rules that allow remote access to private
and domain ("Home" and "Work") networks. For public networks, it creates
firewall rules that allows remote access from the same local subnet.

On client versions of Windows, `Enable-PSRemoting` succeeds on private and
domain networks. By default, it fails on public networks, but if you use the
**SkipNetworkProfileCheck** parameter, `Enable-PSRemoting` succeeds and creates
a firewall rule that allows traffic from the same local subnet.

> [!NOTE]
> In Windows PowerShell 2.0, on computers running server versions of Windows,
> `Enable-PSRemoting` creates firewall rules that allow remote access on
> private, domain and public networks. On computers running client versions of
> Windows, `Enable-PSRemoting` creates firewall rules that allow remote access
> only on private and domain networks.

To remove the local subnet restriction on public networks and allow remote
access from any location, run the following command:

```powershell
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
```

The `Set-NetFirewallRule` cmdlet is exported by the **NetSecurity** module.

> [!NOTE]
> The name of the firewall rule can be different for different versions of
> Windows. Use `Get-NetFirewallRule` to see a list of rules. Before enabling
> the firewall rule, view the security settings in the rule to verify that the
> configuration is appropriate for your environment.

### How to enable a firewall exception by using a group policy

For errors:

> - ERROR:  ACCESS IS DENIED

> - ERROR: The connection to the remote host was refused. Verify that the
>   WS-Management service is running on the remote host and configured to
>   listen for requests on the correct port and HTTP URL.

Use the **Windows Firewall: Allow local port exceptions** policy to enable a
firewall exception for in all computers in a domain.

The policy is located in the following Group Policy path:

```
Computer Configuration\Administrative Templates\Network
    \Network Connections\Windows Firewall\Domain Profile
```

This policy allows members of the Administrators group to create a firewall
exception for the Windows Remote Management (WinRM) service.

If the policy configuration is incorrect you may receive the following error:

> The client cannot connect to the destination specified in the request. Verify
> that the service on the destination is running and is accepting requests.

A configuration error in the policy results in an empty value for the
**ListeningOn** property. Use the following command to check the value.

```powershell
Get-WSManInstance winrm/config/listener -Enumerate
```

```Output
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

For error:

> ERROR:  ACCESS IS DENIED

PowerShell remoting depends upon the Windows Remote Management (WinRM) service.
The service must be running to support remote commands.

On server versions of Windows, the WinRM service startup type is `Automatic`.
However, on client versions of Windows, the WinRM service is disabled by
default.

Use the following example to set the startup type of the WinRM service to
`Automatic` and start the service. The **ComputerName** parameter accepts
multiple values.

```powershell
$invokeCimMethodSplat = @{
    ComputerName = 'Server01', 'Server02'
    Query = 'Select * From Win32_Service Where Name = "WinRM"'
    MethodName = 'ChangeStartMode'
    Arguments = @{StartMode  = 'Automatic'}
}
Invoke-CimMethod @invokeCimMethodSplat
```

## How to recreate the default session configurations

For error:

> ERROR:  ACCESS IS DENIED

When you use `Enable-PSRemoting`, it creates default session configurations on
the local computer. Remote users use these session configurations whenever a
remote command does not include the **ConfigurationName** parameter.

If the default configurations on a computer are unregistered or deleted, use
the `Enable-PSRemoting` cmdlet to recreate them. You can use this cmdlet
repeatedly. It doesn't generate errors if a feature is already configured.

If you change the default session configurations and want to restore the
original session configurations you can delete and recreate the configurations.

Use the `Unregister-PSSessionConfiguration` cmdlet to delete the changed
session configurations. Use `Enable-PSRemoting` to restore the original session
configurations. `Enable-PSRemoting` doesn't change existing session
configurations.

> [!NOTE]
> When `Enable-PSRemoting` restores the default session configuration, it does
> not create explicit security descriptors for the configurations. Instead, the
> configurations inherit the security descriptor of the **RootSDDL**, which is
> secure by default.

To see the **RootSDDL** security descriptor, type:

```powershell
Get-Item wsman:\localhost\Service\RootSDDL
```

To change the **RootSDDL**, use the `Set-Item` cmdlet in the `WSMan:` drive. To
change the security descriptor of a session configuration, use the
`Set-PSSessionConfiguration` cmdlet with the **SecurityDescriptorSDDL** or
**ShowSecurityDescriptorUI** parameters.

For more information about the `WSMan:` drive, see [about_WSMan_Provider][01].

## How to provide administrator credentials

For error:

> ERROR: ACCESS IS DENIED

You must be a member of the Administrators group connect to the default remote
session endpoints. You can use the **Credential** parameter of the
`New-PSSession`, `Enter-PSSession` or `Invoke-Command` cmdlets to connect to
remote endpoints using alternate credentials.

The following example shows how to provide the credentials for an admin user.

```powershell
Invoke-Command -ComputerName Server01 -Credential Domain01\Admin01
```

For more information about the **Credential** parameter, see the help for
[New-PSSession][14], [Enter-PSSession][11] or [Invoke-Command][13].

## How to enable remoting for non-administrative users

For error:

> ERROR: ACCESS IS DENIED

By default, only members of the Administrators group on a computer have
permission to use the default session configurations. Therefore, only members
of the Administrators group can connect to the computer remotely.

To allow other users to connect to the local computer, give the user
**Execute** permissions to the default session configurations on the local
computer.

The following example opens a property sheet that lets you change the security
descriptor of the default `Microsoft.PowerShell` session configuration on the
local computer.

```powershell
Set-PSSessionConfiguration Microsoft.PowerShell -ShowSecurityDescriptorUI
```

For more information, see [about_Session_Configurations][09].

## How to enable remoting for administrators in other domains

For error:

> ERROR:  ACCESS IS DENIED

When a user in another domain is a member of the Administrators group on the
local computer, the user cannot connect to the local computer remotely with
Administrator privileges. By default, remote connections from other domains run
with only standard user privilege tokens.

You can use the **LocalAccountTokenFilterPolicy** registry entry to change the
default behavior and allow remote users who are members of the Administrators
group to run with Administrator privileges.

> [!CAUTION]
> The **LocalAccountTokenFilterPolicy** entry disables user account control
> (UAC) remote restrictions for all users of all affected computers. Consider
> the implications of this setting carefully before changing the policy.

Use the following command to set the **LocalAccountTokenFilterPolicy** registry
value to 1.

```powershell
$newItemPropertySplat = @{
  Name = 'LocalAccountTokenFilterPolicy'
  Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
  PropertyType = 'DWord'
  Value = 1
}
New-ItemProperty @newItemPropertySplat
```

## How to use an ip address in a remote command

For error:

> ERROR: The WinRM client cannot process the request. If the authentication
> scheme is different from Kerberos, or if the client computer is not joined to
> a domain, then HTTPS transport must be used or the destination machine must
> be added to the TrustedHosts configuration setting.

The **ComputerName** parameter of the `New-PSSession`, `Enter-PSSession` and
`Invoke-Command` cmdlets accepts an IP address as a valid value. However,
because Kerberos authentication doesn't support IP addresses. When you specify
an IP address, NTLM authentication is used.

To support NTLM authentication, you must meet the following requirements:

- Configure the computer for HTTPS transport or add the IP addresses of the
  remote computers to the **TrustedHosts** list on the local computer.
- Use the **Credential** parameter in all remote commands. This is required
  even when you connect as the current user.

## How to connect remotely from a workgroup-based computer

For error

> ERROR: The WinRM client cannot process the request. If the authentication
> scheme is different from Kerberos, or if the client computer is not joined to
> a domain, then HTTPS transport must be used or the destination machine must
> be added to the TrustedHosts configuration setting.

When the local computer isn't in a domain, you must meet the following
requirements:

- Configure the computer for HTTPS transport or add the IP addresses of the
  remote computers to the **TrustedHosts** list on the local computer.
- Verify that a password is set on the workgroup-based computer. If a password
  is not set or the password value is empty, you cannot run remote commands.
- Use the **Credential** parameter in all remote commands. This is required
  even when you connect as the current user.

## How to add a computer to the trusted hosts list

The **TrustedHosts** item can contain a comma-separated list of computer names,
IP addresses, and fully-qualified domain names. Wildcards are permitted.

To view or change the trusted host list, use the `WSMan:` drive. The
**TrustedHost** item is in the `WSMan:\localhost\Client` node. Only members of
the Administrators group on the computer have permission to change the list of
trusted hosts on the computer.

> [!CAUTION]
> The value that you set for the **TrustedHosts** item affects all users of the
> computer.

To view the list of trusted hosts, use the following command:

```powershell
Get-Item wsman:\localhost\Client\TrustedHosts
```

The following example uses the wildcard character (`*`) to add all computers to
the list of trusted hosts.

```powershell
Set-Item wsman:localhost\client\trustedhosts -Value *
```

You can also use a wildcard character (`*`) to add all computers in a
particular domain to the list of trusted hosts. For example, the following
command adds all of the computers in the Fabrikam domain.

```powershell
Set-Item wsman:localhost\client\trustedhosts *.fabrikam.com
```

The following example set the list of trusted hosts to a single computer.

```powershell
$server = 'Server01.Domain01.Fabrikam.com'
Set-Item wsman:\localhost\Client\TrustedHosts -Value $server
```

To add a computer name to an existing list of trusted hosts, first save the
current value in a variable. Then set the value to a string containing a
comma-separated list that includes the current and new values.

The following example add Server01 to an existing list of trusted hosts.

```powershell
$newServer = 'Server01.Domain01.Fabrikam.com'
$curValue = (Get-Item wsman:\localhost\Client\TrustedHosts).Value
Set-Item wsman:\localhost\Client\TrustedHosts -Value "$curValue, $newServer"
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

To add a computer to the **TrustedHosts** list of a remote computer, use the
`Connect-WSMan` to connect to `WSMan:` drive the remote computer the use
`Set-Item` to add the computer.

For more information about, see the help for [Connect-WSMan][18].

## How to configure remoting on alternate ports

For error:

> ERROR: The connection to the specified remote host was refused. Verify that
> the WS-Management service is running on the remote host and configured to
> listen for requests on the correct port and HTTP URL.

PowerShell remoting uses port 80 for HTTP transport by default. The default
port is used whenever the user does not specify the **ConnectionURI** or
**Port** parameters in a remote command.

Use `Set-Item` cmdlet to change the **Port** value in the listener leaf node.

For example, the following command changes the default port to 8080.

```powershell
Set-Item wsman:\localhost\listener\listener*\port -Value 8080
```

## How to configure remoting with a proxy server

For error:

> ERROR: The client cannot connect to the destination specified in the request.
> Verify that the service on the destination is running and is accepting
> requests.

Because PowerShell remoting uses the HTTP protocol, it is affected by HTTP
proxy settings. In enterprises that have proxy servers, users cannot access a
PowerShell remote computer directly.

To resolve this problem, use proxy setting options in your remote command.

- Use the **ProxyAccessType**, **ProxyAuthentication**, and **ProxyCredential**
  parameters of the `New-PSSessionOption` cmdlet to create a variable
  containing a **PSSessionOption** object with the proxy settings for your
  enterprise.
- Use the variable containing the **PSSessionOption** object wit the
  **SessionOption** parameter of a `New-PSSession`, `Enter-PSSession`, or
  `Invoke-Command` command.

```powershell
$newPSSessionOptionSplat = @{
    ProxyAccessType = 'IEConfig'
    ProxyAuthentication = 'Negotiate'
    ProxyCredential = 'Domain01\User01'
}
$SessionOption = New-PSSessionOption @newPSSessionOptionSplat

$newPSSessionSplat = @{
    ConnectionUri = 'https://www.fabrikam.com'
    SessionOption = $SessionOption
}
New-PSSession @newPSSessionSplat
```

For more information about the `New-PSSessionOption` cmdlet, see
[New-PSSessionOption][15].

To set these options for all remote commands in the current session, set the
`$PSSessionOption` preference variable to the **PSSessionOption** object you
created. For more information, see [about_Preference_Variables][04].

To set these options for all remote commands in all PowerShell sessions on the
local computer, add the `$PSSessionOption` preference variable to your
PowerShell profile. For more information about PowerShell profiles, see
[about_Profiles][05].

## How to detect a 32-bit session on a 64-bit computer

For error:

> ERROR: The term \<tool-name\> is not recognized as the name of a cmdlet,
> function, script file, or operable program. Check the spelling of the name,
> or if a path was included, verify that the path is correct and try again.

If the remote computer is running a 64-bit version of Windows, and the remote
command uses a 32-bit session configuration, like **Microsoft.PowerShell32**,
WinRM loads a WOW64 process. Windows automatically redirects all references to
`$env:Windir\System32` to the `$env:Windir\SysWOW64` directory.

As a result, running tools in the `System32` directory that do not have
counterparts in the `SysWow64` directory can't be found.

To find the processor architecture that is being used in the session, use the
value of the **PROCESSOR_ARCHITECTURE** environment variable.

```powershell
$s = New-PSSession -ComputerName Server01 -ConfigurationName CustomShell
Invoke-Command -Session $s {$env:PROCESSOR_ARCHITECTURE}
```

```Output
x86
```

For more information, see [about_Session_Configurations][09].

## Troubleshooting policy and preference issues

This section discusses remoting problems that are related to policies and
preferences set on the local and remote computers.

## How to change the execution policy for Import-PSSession and Import-Module

For error:

> ERROR: Import-Module: File \<filename\> cannot be loaded because the
> execution of scripts is disabled on this system.

The `Import-PSSession` and `Export-PSSession` cmdlets create modules that
contains unsigned script files and formatting files.

To import the modules that are created by these cmdlets, the execution policy
in the current session can't be `Restricted` or `AllSigned`. For more
information, see [about_Execution_Policies][03].

To import the modules without changing the execution policy for the local
computer, use the **Scope** parameter of `Set-ExecutionPolicy` to set a less
restrictive execution policy for a single process.

For example, the following example sets the execution policy to `RemoteSigned`
for the current process. The change only affects the current process.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

You can also use the **ExecutionPolicy** parameter of `PowerShell.exe` to start
a single session with a less restrictive execution policy.

```powershell
pwsh.exe -ExecutionPolicy RemoteSigned
```

## How to set and change quotas

You can use quotas to protect the local computer and the remote computer from
excessive resource use, both accidental and malicious. When quotas conflict
with a command, PowerShell generates the following error.

> ERROR: The total data received from the remote client exceeded allowed
> maximum.

The WSMan provider has the following quota settings:

- The **MaxEnvelopeSizeKB** and **MaxProviderRequests** settings in the
  `WSMan:<ComputerName>` node and the **MaxConcurrentOperations**,
  **MaxConcurrentOperationsPerUser**, and **MaxConnections** settings in the
  `WSMan:<ComputerName>\Service` node.
- You can use the **MaximumReceivedDataSizePerCommand** and
  **MaximumReceivedObjectSize** parameters of the `New-PSSessionOption` cmdlet
  and the `$PSSessionOption` preference variable to protect the local computer.
- To protect the remote computer, add restrictions to the session
  configurations using the **MaximumReceivedDataSizePerCommandMB** and
  **MaximumReceivedObjectSizeMB** parameters of the
  `Register-PSSessionConfiguration` cmdlet.

To resolve the error, change the remote command to comply with the quota or
increase the quota to allow the command to complete.

For example, the following command increases the object size quota in the
**Microsoft.PowerShell** session configuration on the remote computer from 10
MB (the default value) to 11 MB.

```powershell
$setPSSessionConfigurationSplat = @{
    Name = 'Microsoft.PowerShell'
    MaximumReceivedObjectSizeMB = 11
    Force = $true
}
Set-PSSessionConfiguration @setPSSessionConfigurationSplat
```

For more information about the WS-Management quotas, see
[about_WSMan_Provider][01].

## How to resolve timeout errors

You can use timeouts to protect the local computer and the remote computer from
excessive resource use, both accidental and malicious. When timeouts are set on
both the local and remote computer, PowerShell uses the shortest timeout
settings.

When a timeout value does not permit an operation to complete, PowerShell
terminates the operation and generates the following error.

> ERROR: The WS-Management service cannot complete the operation within the
> time specified in OperationTimeout.

The WSMan provider has the following timeouts settings.

- **MaxTimeoutMs** setting in the `WSMan:<ComputerName>` node and the
  **EnumerationTimeoutMs** and **MaxPacketRetrievalTimeSeconds** settings in
  the `WSMan:<ComputerName>\Service` node.
- You can protect the local computer using the **CancelTimeout**,
  **IdleTimeout**, **OpenTimeout**, and **OperationTimeout** parameters of the
  `New-PSSessionOption` cmdlet and the `$PSSessionOption` preference variable.
- You can also protect the remote computer by setting timeout values
  programmatically in the session configuration for the session.

To resolve the error, change the command to complete within the timeout
interval or increase the timeout interval to allow the command to complete.

The following example creates a session option with an **OperationTimeout**
value of 4 minutes (in MS), then uses the session option to create a remote
session.

```powershell
$pso = New-PSSessionOption -OperationTimeout 240000
New-PSSession -ComputerName Server01 -SessionOption $pso
```

For more information about the WS-Management timeouts, see
[about_WSMan_Provider][01].

## How to interrupt a command that is unresponsive

Some native programs, such as programs with a user interface, console
applications that prompt for input, and console applications that use the Win32
console API, do not work correctly in the PowerShell remote host.

When you use these programs, you might see unexpected behavior, such as no
output, partial output, or a remote command that does not complete.

To end an unresponsive program, type <kbd>Ctrl</kbd>+<kbd>c</kbd>. Use
`Get-Error` in the local host and the remote session to view any errors that
might have been reported.

## How to recover from an operation failure

The following error is returned when an operation is terminated before it
completes.

> ERROR: The I/O operation has been aborted because of either a thread exit or
> an application request.

Typically, this occurs when the WinRM service stops or restarts while other
WinRM operations are in progress.

To resolve this issue, verify that the WinRM service is running and try the
command again.

1. Start PowerShell with the **Run as administrator** option.
1. Run the following command:

   `Start-Service WinRM`

1. Re-run the command that generated the error.

## Linux and macOS limitations

PowerShell remoting is Linux and macOS using remoting over SSH. For more
information, see [PowerShell Remoting Over SSH][02].

## See also

- [about_Remote][08]
- [about_Remote_Requirements][06]
- [about_Remote_Variables][07]
- [Import-Module][12]
- [Export-PSSession][16]
- [Import-PSSession][17]

<!-- link references -->
[01]: ../../microsoft.wsman.management/about/about_wsman_provider.md
[02]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[03]: about_Execution_Policies.md
[04]: about_Preference_Variables.md
[05]: about_Profiles.md
[06]: about_Remote_Requirements.md
[07]: about_Remote_Variables.md
[08]: about_Remote.md
[09]: about_Session_Configurations.md
[10]: xref:Microsoft.PowerShell.Core.Enable-PSRemoting
[11]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[12]: xref:Microsoft.PowerShell.Core.Import-Module
[13]: xref:Microsoft.PowerShell.Core.Invoke-Command
[14]: xref:Microsoft.PowerShell.Core.New-PSSession
[15]: xref:Microsoft.PowerShell.Core.New-PSSessionOption
[16]: xref:Microsoft.PowerShell.Utility.Export-PSSession
[17]: xref:Microsoft.PowerShell.Utility.Import-PSSession
[18]: xref:Microsoft.WSMan.Management.Connect-WSMan
