---
description: Describes the system requirements and configuration requirements for running remote commands in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_requirements?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Requirements
---
# About Remote Requirements

## SHORT DESCRIPTION
Describes the system requirements and configuration requirements for running
remote commands in PowerShell.

## LONG DESCRIPTION

This topic describes the system requirements, user requirements, and resource
requirements for establishing remote connections and running remote commands
in PowerShell. It also provides instructions for configuring remote
operations.

Note: Many cmdlets (including the Get-Service, Get-Process, Get-WMIObject,
Get-EventLog, and Get-WinEvent cmdlets) get objects from remote computers by
using Microsoft .NET Framework methods to retrieve the objects. They do not
use the PowerShell remoting infrastructure. The requirements in this
document do not apply to these cmdlets.

To find the cmdlets that have a ComputerName parameter but do not use
PowerShell remoting, read the description of the ComputerName parameter of the
cmdlets.

## SYSTEM REQUIREMENTS

To run remote sessions on Windows PowerShell 3.0, the local and remote computers
must have the following:

- Windows PowerShell 3.0 or later
- The Microsoft .NET Framework 4 or later
- Windows Remote Management 3.0

To run remote sessions on Windows PowerShell 2.0, the local and remote
computers must have the following:

- Windows PowerShell 2.0 or later
- The Microsoft .NET Framework 2.0 or later
- Windows Remote Management 2.0

You can create remote sessions between computers running Windows PowerShell
2.0 and Windows PowerShell 3.0. However, features that run only on Windows
PowerShell 3.0, such as the ability to disconnect and reconnect to sessions,
are available only when both computers are running Windows PowerShell 3.0.

To find the version number of an installed version of PowerShell,
use the $PSVersionTable automatic variable.

Windows Remote Management (WinRM) 3.0 and Microsoft .NET Framework 4 are
included in Windows 8, Windows Server 2012, and newer releases of the Windows
operating system. WinRM 3.0 is included in Windows Management Framework 3.0
for older operating systems. If the computer does not have the required
version of WinRM or the Microsoft .NET Framework, the installation fails.

## USER PERMISSIONS

To create remote sessions and run remote commands, by default, the current
user must be a member of the Administrators group on the remote computer or
provide the credentials of an administrator. Otherwise, the command fails.

The permissions required to create sessions and run commands on a remote
computer (or in a remote session on the local computer) are established by the
session configuration (also known as an "endpoint") on the remote computer to
which the session connects. Specifically, the security descriptor on the
session configuration determines who has access to the session configuration
and who can use it to connect.

The security descriptors on the default session configurations,
Microsoft.PowerShell, Microsoft.PowerShell32, and
Microsoft.PowerShell.Workflow, allow access only to members of the
Administrators group.

If the current user doesn't have permission to use the session configuration,
the command to run a command (which uses a temporary session) or create a
persistent session on the remote computer fails. The user can use the
ConfigurationName parameter of cmdlets that create sessions to select a
different session configuration, if one is available.

Members of the Administrators group on a computer can determine who has
permission to connect to the computer remotely by changing the security
descriptors on the default session configurations and by creating new session
configurations with different security descriptors.

For more information about session configurations, see
[about_Session_Configurations](about_Session_Configurations.md).

## WINDOWS NETWORK LOCATIONS

Beginning in Windows PowerShell 3.0, the Enable-PSRemoting cmdlet can enable
remoting on client and server versions of Windows on private, domain, and
public networks.

On server versions of Windows with private and domain networks, the
Enable-PSRemoting cmdlet creates firewall rules that allow unrestricted remote
access. It also creates a firewall rule for public networks that allows remote
access only from computers in the same local subnet. This local subnet
firewall rule is enabled by default on server versions of Windows on public
networks, but Enable-PSRemoting reapplies the rule in case it was changed or
deleted.

On client versions of Windows with private and domain networks, by default,
the Enable-PSRemoting cmdlet creates firewall rules that allow unrestricted
remote access.

To enable remoting on client versions of Windows with public networks, use the
SkipNetworkProfileCheck parameter of the Enable-PSRemoting cmdlet. It creates
a firewall rule that allows remote access only from computers in the same
local subnet.

To remove the local subnet restriction on public networks and allow remote
access from all locations on client and server versions of Windows, use the
Set-NetFirewallRule cmdlet in the NetSecurity module. Run the following
command:

```powershell
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
```

In Windows PowerShell 2.0, on server versions of Windows, Enable-PSRemoting
creates firewall rules that permit remote access on all networks.

In Windows PowerShell 2.0, on client versions of Windows, Enable-PSRemoting
creates firewall rules only on private and domain networks. If the network
location is public, Enable-PSRemoting fails.

## RUN AS ADMINISTRATOR

Administrator privileges are required for the following remoting operations:

- Establishing a remote connection to the local computer. This is commonly
  known as a "loopback" scenario.

- Managing session configurations on the local computer.

- Viewing and changing WS-Management settings on the local computer. These are
  the settings in the LocalHost node of the WSMAN: drive.

To perform these tasks, you must start PowerShell with the "Run as
administrator" option even if you are a member of the Administrators group on
the local computer.

In Windows 7 and in Windows Server 2008 R2, to start Windows PowerShell with
the "Run as administrator" option:

1. Click Start, click All Programs, click Accessories, and then click
   the Windows PowerShell folder.
2. Right-click Windows PowerShell, and then click "Run as administrator".

To start Windows PowerShell with the "Run as administrator" option:

1. Click Start, click All Programs, and then click the Windows PowerShell
   folder.
2. Right-click Windows PowerShell, and then click "Run as administrator".

The "Run as administrator" option is also available in other Windows Explorer
entries for Windows PowerShell, including shortcuts. Just right-click the
item, and then click "Run as administrator".

When you start Windows PowerShell from another program such as Cmd.exe, use
the "Run as administrator" option to start the program.

## HOW TO CONFIGURE YOUR COMPUTER FOR REMOTING

Computers running all supported versions of Windows can establish remote
connections to and run remote commands in PowerShell without any
configuration. However, to receive connections, and allow users to create
local and remote user-managed PowerShell sessions ("PSSessions") and
run commands on the local computer, you must enable PowerShell
remoting on the computer.

Windows Server 2012 and newer releases of Windows Server are enabled for
PowerShell remoting by default. If the settings are changed, you can
restore the default settings by running the Enable-PSRemoting cmdlet.

On all other supported versions of Windows, you need to run the
Enable-PSRemoting cmdlet to enable PowerShell remoting.

The remoting features of PowerShell are supported by the WinRM
service, which is the Microsoft implementation of the Web Services for
Management (WS-Management) protocol. When you enable PowerShell
remoting, you change the default configuration of WS-Management and add system
configuration that allow users to connect to WS-Management.

To configure PowerShell to receive remote commands:

1. Start PowerShell with the "Run as administrator" option.
2. At the command prompt, type: `Enable-PSRemoting`

To verify that remoting is configured correctly, run a test command such as
the following command, which creates a remote session on the local computer.

```powershell
New-PSSession
```

If remoting is configured correctly, the command will create a session on the
local computer and return an object that represents the session. The output
should resemble the following sample output:

```output
Id Name        ComputerName    State    ConfigurationName
-- ----        ------------    -----    -----
1  Session1    localhost       Opened   Microsoft.PowerShell
```

If the command fails, for assistance, see
[about_Remote_Troubleshooting](about_Remote_Troubleshooting.md).

## UNDERSTAND POLICIES

When you work remotely, you use two instances of PowerShell, one on
the local computer and one on the remote computer. As a result, your work is
affected by the Windows policies and the PowerShell policies on the
local and remote computers.

In general, before you connect and as you are establishing the connection, the
policies on the local computer are in effect. When you are using the
connection, the policies on the remote computer are in effect.

## Basic Authentication Limitations on Linux and macOS

When connecting from a Linux or macOS system to Windows, Basic Authentication
over HTTP is not supported. Basic Authentication can be used over HTTPS by
installing a certificate on the target server. The certificate must have a
CN name that matches the hostname, is not expired or revoked. A self-signed
certificate may be used for testing purposes.

See [How To: Configure WINRM for HTTPS](https://support.microsoft.com/help/2019527/how-to-configure-winrm-for-https)
for additional details.

The following command, run from an elevated command prompt, will configure the
HTTPS listener on Windows with the installed certificate.

```powershell
$hostinfo = '@{Hostname="<DNS_NAME>"; CertificateThumbprint="<THUMBPRINT>"}'
winrm create winrm/config/Listener?Address=*+Transport=HTTPS $hostinfo
```

On the Linux or macOS side, select Basic for authentication and -UseSSl.

> NOTE: Basic authentication cannot be used with domain accounts; a local account
is required and the account must be in the Administrators group.

```powershell
# The specified local user must have administrator rights on the target machine.
# Specify the unqualified username.
$cred = Get-Credential username
$session = New-PSSession -Computer <hostname> -Credential $cred `
  -Authentication Basic -UseSSL
```

An alternative to Basic Authentication over HTTPS is Negotiate. This results
in NTLM authentication between the client and server and payload is encrypted
over HTTP.

The following illustrates using Negotiate with New-PSSession:

```powershell
# The specified user must have administrator rights on the target machine.
$cred = Get-Credential username@hostname
$session = New-PSSession -Computer <hostname> -Credential $cred `
  -Authentication Negotiate
```

> [!NOTE]
> Windows Server requires an additional registry setting to enable
> administrators, other than the built in administrator, to connect using NTLM.
> Refer to the LocalAccountTokenFilterPolicy registry setting under Negotiate
> Authentication in
> [Authentication for Remote Connections](/windows/win32/winrm/authentication-for-remote-connections)

## SEE ALSO

[about_Remote](about_Remote.md)

[about_Remote_Variables](about_Remote_Variables.md)

[about_PSSessions](about_PSSessions.md)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

