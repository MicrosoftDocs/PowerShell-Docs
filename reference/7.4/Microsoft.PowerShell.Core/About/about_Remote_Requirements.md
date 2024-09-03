---
description: Describes the system requirements and configuration requirements for running remote commands in PowerShell.
Locale: en-US
ms.date: 07/03/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_requirements?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Requirements
---

# about_Remote_Requirements

## Short description
Describes the system requirements and configuration requirements for running
remote commands in PowerShell.

## Long description

This topic describes the system requirements, user requirements, and resource
requirements for establishing remote connections and running remote commands
in PowerShell. It also provides instructions for configuring remote
operations.

> [!NOTE]
> Some cmdlets get objects from remote computers RPC connections or WMI
> sessions for remote connections. They don't use the PowerShell remoting
> infrastructure. The requirements in this document don't apply to these
> cmdlets.

To find the cmdlets that have a **ComputerName** parameter but don't use
PowerShell remoting, read the description of the **ComputerName** parameter of
the cmdlets.

## System requirements

In Windows, PowerShell remoting uses Windows Remote Management (WinRM), which
is provided by the Windows Management Framework (WMF). To run remote sessions
on PowerShell, the local and remote computers must have the following:

- Windows PowerShell 3.0 or higher
- The Microsoft .NET Framework 4 or higher
- Windows Remote Management 3.0 or higher

To run remote sessions on Windows PowerShell 2.0, the local and remote
computers must have the following:

- Windows PowerShell 2.0 or later
- The Microsoft .NET Framework 2.0 or later
- Windows Remote Management 2.0

To be fully supported, you should be using WMF 5.1. For more information about
WMF support, see [Windows Management Framework (WMF)][02].

You can create a remote session between a computer running Windows PowerShell
2.0 and one running a newer version of PowerShell. However, features that run
only on new versions of PowerShell, such as the ability to disconnect and
reconnect to sessions, are only available when both computers are running
Windows PowerShell 3.0 and higher.

To find the version number of an installed version of PowerShell, use the
`$PSVersionTable` automatic variable.

PowerShell 7 and higher also supports PowerShell remoting over SSH. PowerShell
remoting over SSH allows you to connect to any Windows, macOS, or Linux host
that is running SSH. For more information, see
[PowerShell Remoting Over SSH][01].

## User permissions

To create remote sessions and run remote commands, by default, the current user
must be a member of the **Administrators** group on the remote computer or
provide the credentials of an administrator. Otherwise, the command fails.

The permissions required to create sessions and run commands on a remote
computer are established by the session configuration. The session
configuration defines the configuration options for the connection _endpoint_
on the remote computer. Specifically, the security descriptor on the session
configuration determines who has access to the session configuration and who
can use it to connect.

The security descriptors on the default session configurations,
**Microsoft.PowerShell** and **Microsoft.PowerShell32**, only allow access to
members of the **Administrators** group.

Members of the **Administrators** group on a computer can determine who has
permission to connect to the computer remotely by changing the security
descriptors on the default session configurations or create new session
configurations with different security descriptors. Users can use the
**ConfigurationName** parameter of `*-PSSession` cmdlets to connect to
different endpoints.

For more information about session configurations, see
[about_Session_Configurations][07].

## Windows network locations

Beginning in Windows PowerShell 3.0, the `Enable-PSRemoting` cmdlet can enable
remoting on client and server versions of Windows.

On server versions of Windows with private and domain networks, the
`Enable-PSRemoting` cmdlet creates firewall rules that allow unrestricted
remote access. It also creates a firewall rule for public networks that allows
remote access only from computers in the same local subnet. This local subnet
firewall rule is enabled by default on server versions of Windows on public
networks, but `Enable-PSRemoting` reapplies the rule in case it was changed or
deleted.

On client versions of Windows with private and domain networks,
`Enable-PSRemoting` creates firewall rules that allow unrestricted remote
access.

To enable remoting on client versions of Windows with public networks, use the
**SkipNetworkProfileCheck** parameter of the `Enable-PSRemoting` cmdlet. This
option creates a firewall rule that allows remote access only from computers in
the same local subnet.

To remove the local subnet restriction on public networks and allow remote
access from all locations on client and server versions of Windows, use the
`Set-NetFirewallRule` cmdlet in the **NetSecurity** module. Run the following
command:

```powershell
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
```

> [!NOTE]
> The name of the firewall rule can be different for different versions of
> Windows. Use `Get-NetFirewallRule` to see a list of rules. Before enabling
> the firewall rule, view the security settings in the rule to verify that the
> configuration is appropriate for your environment.

In Windows PowerShell 2.0, on server versions of Windows, `Enable-PSRemoting`
creates firewall rules that permit remote access on all networks.

In Windows PowerShell 2.0, on client versions of Windows, `Enable-PSRemoting`
creates firewall rules only on private and domain networks. If the network
location is public, `Enable-PSRemoting` fails.

## Run as administrator

Administrator privileges are required for the following remoting operations:

- Establishing a remote connection to the local computer. This is commonly
  known as a "loopback" scenario.
- Managing session configurations on the local computer.
- Viewing and changing WS-Management settings on the local computer. These are
  the settings in the LocalHost node of the WSMAN: drive.

You must start PowerShell with the **Run as administrator** option even if you
are a member of the **Administrators** group on the local computer.

When you start Windows PowerShell from another program such as `cmd.exe`, use
the **Run as administrator** option to start the program.

## How to configure your computer for remoting

Computers running any supported version of Windows can establish remote
connections and run remote commands in PowerShell without any configuration.
However, to receive remote connections you must enable PowerShell remoting on
the computer.

Windows Server 2012 and newer releases of Windows Server are enabled for
PowerShell remoting by default. If the settings are changed, you can
restore the default settings by running the `Enable-PSRemoting` cmdlet.

By default, the remoting features of PowerShell are supported by the WinRM
service, which is the Microsoft implementation of the Web Services for
Management (WS-Management) protocol. When you enable PowerShell remoting, you
change the default configuration of WS-Management and add system configuration
that allow users to connect to WS-Management.

To configure PowerShell to receive remote commands:

1. Start PowerShell with the **Run as administrator** option.
1. At the command prompt, type: `Enable-PSRemoting`

To verify that remoting is configured correctly, run a test command such as
the following command, which creates a remote session on the local computer.

```powershell
New-PSSession
```

If remoting is configured correctly, the command creates a session on the local
computer and returns an object that represents the session.

```Output
Id Name        ComputerName    State    ConfigurationName
-- ----        ------------    -----    -----
1  Session1    localhost       Opened   Microsoft.PowerShell
```

If the command fails, see [about_Remote_Troubleshooting][04].

## Understand policies

When you work remotely, you use two instances of PowerShell, one on the local
computer and one on the remote computer. As a result, your work is affected by
the Windows and PowerShell policies on both the local and remote computers.

Before you connect and while establishing the connection, the policies on
the local computer are in effect. When you are using the connection, the
policies on the remote computer are in effect.

## See also

- [about_Remote][06]
- [about_Remote_Variables][05]
- [about_PSSessions][03]
- [Invoke-Command][09]
- [Enter-PSSession][08]
- [New-PSSession][10]

<!-- link references -->
[01]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[02]: /powershell/scripting/windows-powershell/wmf/overview
[03]: about_PSSessions.md
[04]: about_Remote_Troubleshooting.md
[05]: about_Remote_Variables.md
[06]: about_Remote.md
[07]: about_Session_Configurations.md
[08]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[09]: xref:Microsoft.PowerShell.Core.Invoke-Command
[10]: xref:Microsoft.PowerShell.Core.New-PSSession
