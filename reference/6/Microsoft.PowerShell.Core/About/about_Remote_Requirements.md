---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Remote_Requirements
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

To find the cmdlets that have a ComputerName parameter but do not use Windows
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

For more informations about session configurations, see
[about_Session_Configurations](about_Session_Configurations.md).

## WINDOWS NETWORK LOCATIONS

Beginning in Windows PowerShell 3.0, the Enable-PSRemoting cmdlet can enable
remoting on client and server versions of Windows on private, domain, and
public networks.

On server versions of Windows with private and domain networks, the
Enable-PSRemoting cmdlet creates firewall rules that allow unrestricted remote
access. It also creates a fir