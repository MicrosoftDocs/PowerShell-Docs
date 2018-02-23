---
ms.date:  2017-06-12
author:  rpsqrd
ms.topic:  conceptual
keywords:  jea,powershell,security
title:  JEA Prerequisites
---

# Prerequisites

> Applies to: Windows PowerShell 5.0

Just Enough Administration is a feature included with Windows PowerShell 5.0 and higher.
This topic describes the prerequisites that must be satisfied in order to start using JEA.

## Install JEA

JEA is available with Windows PowerShell 5.0 and higher, but for full functionality it is recommended that you install the latest version of PowerShell available for your system.
The following table describes JEA's availability on Windows Server:

Server Operating System   | JEA Availability
--------------------------|--------------------------------
Windows Server 2016       | Preinstalled
Windows Server 2012 R2    | Full functionality with WMF 5.1
Windows Server 2012       | Full functionality with WMF 5.1
Windows Server 2008 R2    | Reduced functionality<sup>1</sup> with WMF 5.1

You can also use JEA on your home or work computer:

Client Operating System   | JEA Availability
--------------------------|-----------------------------------------------------
Windows 10 1607+          | Preinstalled
Windows 10 1603, 1511     | Preinstalled, with reduced functionality<sup>2</sup>
Windows 10 1507           | Not available
Windows 8, 8.1            | Full functionality with WMF 5.1
Windows 7                 | Reduced functionality<sup>1</sup> with WMF 5.1

<sup>1</sup> JEA cannot be configured to use group managed service accounts on Windows Server 2008 R2 or Windows 7.
Virtual accounts and other JEA features *are* supported.

<sup>2</sup> Windows 10 versions 1511 and 1603 do not support the following JEA features: running as a group managed service account, conditional access rules in session configurations, the user drive, and granting access to local user accounts.
To get support for these features, update Windows to version 1607 (Anniversary Update) or higher.

### Check which version of PowerShell is installed

To check which version of PowerShell is installed on your system, check the `$PSVersionTable` variable in a Windows PowerShell prompt.

```powershell
PS C:\> $PSVersionTable.PSVersion

Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  1000
```

You are ready to use JEA if the *Major* version is equal to or greater than **5**.
For the best experience, and to have access to all the latest features, it is recommended that you upgrade to PowerShell version **5.1** when possible.

### Install Windows Management Framework

If you are running an older version of PowerShell, you will need to update your system with the latest Windows Management Framework (WMF) update.
Update packages and a link to the latest WMF release notes are available in the [Download Center](https://aka.ms/WMF5).

It is strongly recommended that you test your workload's compatibility with WMF before upgrading all of your servers.

Windows 10 users should install the latest feature updates to obtain the current version of Windows PowerShell.

## Enable PowerShell Remoting

PowerShell Remoting provides the foundation on which JEA is built.
It is therefore necessary to ensure PowerShell Remoting is enabled and [properly secured](https://msdn.microsoft.com/powershell/scripting/setup/winrmsecurity) on your system before you can use JEA.

PowerShell Remoting is enabled by default on Windows Server 2012, 2012 R2, and 2016.
You can enable PowerShell Remoting by running the following command in an elevated PowerShell window.

```powershell
Enable-PSRemoting
```

## Enable PowerShell module and script block logging (optional)

The following steps enable logging for all PowerShell actions on your system.
PowerShell Module Logging is not required for JEA, however it is strongly recommended that you turn it on to ensure the commands users run are logged in a central location.

You can configure the PowerShell Module Logging policy using Group Policy.

1. Open the Local Group Policy Editor on a workstation or a Group Policy Object in the Group Policy Management Console on an Active Directory Domain Controller
2. Navigate to **Computer Configuration\\Administrative Templates\\Windows Components\\Windows PowerShell**
3. Double click on **Turn on Module Logging**
4. Click **Enabled**
5. In the Options section, click on **Show** next to Module Names
6. Type "**\***" in the pop up window. This instructs PowerShell to log commands from all modules.
7. Click **OK** to set the policy
8. Double click on **Turn on PowerShell Script Block Logging**
9. Click **Enabled**
10. Click **OK** to set the policy
11. (On domain-joined machines only) Run **gpupdate** or wait for Group Policy to process the updated policy and apply the settings

You can also enable system-wide PowerShell transcription through Group Policy.

## Next steps

- [Create a role capability file](role-capabilities.md)
- [Create a session configuration file](session-configurations.md)

## See also

- [Additional information about PowerShell Remoting and WinRM security](https://msdn.microsoft.com/powershell/scripting/setup/winrmsecurity)
- [*PowerShell ♥ the Blue Team* blog post on security](https://blogs.msdn.microsoft.com/powershell/2015/06/09/powershell-the-blue-team/)

