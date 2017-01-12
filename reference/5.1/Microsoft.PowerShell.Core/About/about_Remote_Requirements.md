---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Remote_Requirements
ms.technology:  powershell
---

# About Remote Requirements
## about_Remote_Requirements



# SHORT DESCRIPTION

Describes the system requirements and configuration requirements for
running remote commands in Windows PowerShell.

# LONG DESCRIPTION

This topic describes the system requirements, user requirements, and
resource requirements for establishing remote connections and running
remote commands in Windows PowerShell. It also provides instructions for
configuring remote operations.

Note: Many cmdlets (including the Get-Service, Get-Process, Get-WMIObject,
Get-EventLog, and Get-WinEvent cmdlets) get objects from remote
computers by using Microsoft .NET Framework methods to retrieve the
objects. They do not use the Windows PowerShell remoting
infrastructure. The requirements in this document do not apply to
these cmdlets.

To find the cmdlets that have a ComputerName parameter but do not use
Windows PowerShell remoting, read the description of the ComputerName
parameter of the cmdlets.

# SYSTEM REQUIREMENTS


To run remote sessions on Windows PowerShell 3.0, the local and remote computers
must have the following:

--  Windows PowerShell 3.0 or later
--  The Microsoft .NET Framework 4 or later
--  Windows Remote Management 3.0

To run remote sessions on Windows PowerShell 2.0, the local and remote computers
must have the following:

--  Windows PowerShell 2.0 or later
--  The Microsoft .NET Framework 2.0 or later
--  Windows Remote Management 2.0

You can create remote sessions between computers running Windows PowerShell 2.0
and Windows PowerShell 3.0. However, features that run only on Windows
PowerShell 3.0, such as the ability to disconnect and reconnect to sessions, are
available only when both computers are running Windows PowerShell 3.0.

To find the version number of an installed version of Windows PowerShell,
use the $PSVersionTable automatic variable.

Windows Remote Management (WinRM) 3.0 and Microsoft .NET Framework 4 are included
in Windows 8, Windows Server 2012, and newer releases of the Windows operating
system. WinRM 3.0 is included in Windows Management Framework 3.0 for older
operating systems. If the computer does not have the required version of
WinRM or the Microsoft .NET Framework, the installation fails.

# USER PERMISSIONS


To create remote sessions and run remote commands, by default, the current
user must be a member of the Administrators group on the remote computer or
provide the credentials of an administrator. Otherwise, the command fails.

The permissions required to create sessions and run commands on a remote
computer (or in a remote session on the local computer) are established by
the session configuration (also known as an "endpoint") on the remote
computer to which the  session connects. Specifically, the security
descriptor on the session configuration determines who has access to the
session configuration and who can use it to connect.

The security descriptors on the default session configurations,
Microsoft.PowerShell, Microsoft.PowerShell32, and
Microsoft.PowerShell.Workflow, allow access only to members of the
Administrators group.

If the current user doesn't have permission to use the session configuration,
the command to run a command (which uses a temporary session) or create
a persistent session on the remote computer fails. The user can use the
ConfigurationName parameter of cmdlets that create sessions to select a
different session configuration, if one is available.

Members of the Administrators group on a computer can determine who has
permission to connect to the computer remotely by changing the security
descriptors on the default session configurations and by creating new
session configurations with different security descriptors.

For more informations about session configurations, see
about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152).

# WINDOWS NETWORK LOCATIONS

Beginning in Windows PowerShell 3.0, the Enable-PSRemoting cmdlet can enable
remoting on client and server versions of Windows on private, domain, and
public networks.

On server versions of Windows with private and domain networks, the
Enable-PSRemoting cmdlet creates  firewall rules that allow unrestricted
remote access. It also creates a firewall rule for public networks that
allows remote  access only from computers in the same local subnet. This
local subnet firewall rule is enabled by default on server versions of
Windows on public networks, but Enable-PSRemoting reapplies the rule in
case it was changed or deleted.

On client versions of Windows with private and domain networks, by
default, the Enable-PSRemoting cmdlet creates firewall rules that
allow unrestricted remote access.

To enable remoting on client versions of Windows with public networks,
use the SkipNetworkProfileCheck parameter of the Enable-PSRemoting cmdlet.
It creates a firewall rule that that allows remote access only from
computers in the same local subnet.

To remove the local subnet restriction on public networks and allow remote
access from all locations on client and server versions of Windows, use
the Set-NetFirewallRule cmdlet in the NetSecurity module. Run the following
command:

Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any

In Windows PowerShell 2.0, on server versions of Windows, Enable-PSRemoting
creates firewall rules that permit remote access on all networks.

In Windows PowerShell 2.0, on client versions of Windows, Enable-PSRemoting
creates firewall rules only on private and domain networks. If the network
location is public, Enable-PSRemoting fails.
# .


# RUN AS ADMINISTRATOR


Administrator privileges are required for the following remoting
operations:

-- Establishing a remote connection to the local computer. This is
commonly known as a "loopback" scenario.

-- Managing session configurations on the local computer.

-- Viewing and changing WS-Management settings on the local computer.
These are the settings in the LocalHost node of the WSMAN: drive.

To perform these tasks, you must start Windows PowerShell with the "Run
as administrator" option even if you are a member of the Administrators
group on the local computer.

In Windows 7 and in Windows Server 2008 R2, to start Windows PowerShell
with the "Run as administrator" option:

1. Click Start, click All Programs, click Accessories, and then click
the Windows PowerShell folder.

2. Right-click Windows PowerShell, and then click
"Run as administrator".

To start Windows PowerShell with the "Run as administrator" option:

1. Click Start, click All Programs, and then click the Windows
PowerShell folder.

2. Right-click Windows PowerShell, and then click
"Run as administrator".

The "Run as administrator" option is also available in other Windows
Explorer entries for Windows PowerShell, including shortcuts. Just
right-click the item, and then click "Run as administrator".

When you start Windows PowerShell from another program such as Cmd.exe, use
the "Run as administrator" option to start the program.

# HOW TO CONFIGURE YOUR COMPUTER FOR REMOTING


Computers running all supported versions of Windows can establish remote
connections to and run remote commands in Windows PowerShell without any
configuration. However, to receive connections, and allow users to create
local and remote user-managed Windows PowerShell sessions ("PSSessions")
and run commands on the local computer, you must enable Windows PowerShell
remoting on the computer.

Windows Server 2012 and newer releases of Windows Server are enabled for
Windows PowerShell remoting by default. If the settings are changed,
you can restore the default settings by running the Enable-PSRemoting cmdlet.

On all other supported versions of Windows, you need to run the
Enable-PSRemoting cmdlet to enable Windows PowerShell remoting.

The remoting features of Windows PowerShell are supported by the WinRM
service, which is the Microsoft implementation of the Web Services for
Management (WS-Management) protocol. When you enable Windows PowerShell
remoting, you change the default configuration of WS-Management and add
system configuration that allow users to connect to WS-Management.

To configure Windows PowerShell to receive remote commands:

1. Start Windows PowerShell with the "Run as administrator"
option.

2. At the command prompt, type:
Enable-PSRemoting

To verify that remoting is configured correctly, run a test command such as
the following command, which creates a remote session on the local
computer.

New-PSSession

If remoting is configured correctly, the command will create a session on
the local computer and return an object that represents the session. The
output should resemble the following sample output:

C:\PS> new-pssession

Id Name        ComputerName    State    ConfigurationName
-- ----        ------------    -----    -----
1  Session1    localhost       Opened   Microsoft.PowerShell

If the command fails, for assistance, see about_Remote_Troubleshooting.

# UNDERSTAND POLICIES


When you work remotely, you use two instances of Windows PowerShell, one
on the local computer and one on the remote computer. As a result, your
work is affected by the Windows policies and the Windows PowerShell
policies on the local and remote computers.

In general, before you connect and as you are establishing the connection,
the policies on the local computer are in effect. When you are using the
connection, the policies on the remote computer are in effect.

# SEE ALSO

about_Remote
about_Remote_Variables
about_PSSessions
Invoke-Command
Enter-PSSession
New-PSSession

