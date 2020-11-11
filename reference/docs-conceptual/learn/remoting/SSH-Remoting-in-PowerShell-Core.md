---
title: PowerShell Remoting Over SSH
ms.date: 10/19/2020
description: Explains how to set up the SSH protocol for PowerShell remoting.
---

# PowerShell remoting over SSH

## Overview

PowerShell remoting normally uses WinRM for connection negotiation and data transport. SSH is now
available for Linux and Windows platforms and allows true multiplatform PowerShell remoting.

WinRM provides a robust hosting model for PowerShell remote sessions. SSH-based remoting doesn't
currently support remote endpoint configuration and Just Enough Administration (JEA).

SSH remoting lets you do basic PowerShell session remoting between Windows and Linux computers. SSH
remoting creates a PowerShell host process on the target computer as an SSH subsystem. Eventually
we'll implement a general hosting model, similar to WinRM, to support endpoint configuration and
JEA.

The `New-PSSession`, `Enter-PSSession`, and `Invoke-Command` cmdlets now have a new parameter set to
support this new remoting connection.

```
[-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
```

To create a remote session, you specify the target computer with the **HostName** parameter and
provide the user name with **UserName**. When running the cmdlets interactively, you're prompted for
a password. You can also use SSH key authentication using a private key file with the
**KeyFilePath** parameter. Creating keys for SSH authentication varies by platform.

## General setup information

PowerShell 6 or higher, and SSH must be installed on all computers. Install both the SSH client
(`ssh.exe`) and server (`sshd.exe`) so that you can remote to and from the computers. OpenSSH for
Windows is now available in Windows 10 build 1809 and Windows Server 2019. For more information, see
[Manage Windows with OpenSSH](/windows-server/administration/openssh/openssh_overview). For Linux,
install SSH, including sshd server, that's appropriate for your platform. You also need to install
PowerShell from GitHub to get the SSH remoting feature. The SSH server must be configured to create
an SSH subsystem to host a PowerShell process on the remote computer. And, you must enable
**password** or **key-based** authentication.

## Set up on a Windows computer

1. Install the latest version of PowerShell. For more information, see
   [Installing PowerShell Core on Windows](../../install/installing-powershell-core-on-windows.md#msi).

   You can confirm that PowerShell has SSH remoting support by listing the `New-PSSession` parameter
   sets. You'll notice there are parameter set names that begin with **SSH**. Those parameter sets
   include **SSH** parameters.

   ```powershell
   (Get-Command New-PSSession).ParameterSets.Name
   ```

   ```Output
   Name
   ----
   SSHHost
   SSHHostHashParam
   ```

1. Install the latest Win32 OpenSSH. For installation instructions, see
   [Getting started with OpenSSH](/windows-server/administration/openssh/openssh_install_firstuse).

   > [!NOTE]
   > If you want to set PowerShell as the default shell for OpenSSH, see
   > [Configuring Windows for OpenSSH](/windows-server/administration/openssh/openssh_server_configuration).

1. Edit the `sshd_config` file located at `$env:ProgramData\ssh`.

   Make sure password authentication is enabled:

   ```
   PasswordAuthentication yes
   ```

   Create the SSH subsystem that hosts a PowerShell process on the remote computer:

   ```
   Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo
   ```

   > [!NOTE]
   > The default location of the PowerShell executable is `c:/progra~1/powershell/7/pwsh.exe`. The
   > location can vary depending on how you installed PowerShell.
   >
   > You must use the 8.3 short name for any file paths that contain spaces. There's a bug in
   > OpenSSH for Windows that prevents spaces from working in subsystem executable paths. For more
   > information, see this [GitHub issue](https://github.com/PowerShell/Win32-OpenSSH/issues/784).
   >
   > The 8.3 short name for the `Program Files` folder in Windows is usually `Progra~1`. However,
   > you can use the following command to make sure:
   >
   > ```powershell
   > Get-CimInstance Win32_Directory -Filter 'Name="C:\\Program Files"' |
   >   Select-Object EightDotThreeFileName
   > ```
   >
   > ```Output
   > EightDotThreeFileName
   > ---------------------
   > c:\progra~1
   > ```

   Optionally, enable key authentication:

   ```
   PubkeyAuthentication yes
   ```

   For more information, see [Managing OpenSSH Keys](/windows-server/administration/openssh/openssh_keymanagement).

1. Restart the **sshd** service.

   ```powershell
   Restart-Service sshd
   ```

1. Add the path where OpenSSH is installed to your Path environment variable. For example,
   `C:\Program Files\OpenSSH\`. This entry allows for the `ssh.exe` to be found.

## Set up on an Ubuntu 16.04 Linux computer

1. Install the latest version of PowerShell, see
   [Installing PowerShell Core on Linux](../../install/installing-powershell-core-on-linux.md#ubuntu-1604).
1. Install [Ubuntu OpenSSH Server](https://help.ubuntu.com/lts/serverguide/openssh-server.html).

   ```bash
   sudo apt install openssh-client
   sudo apt install openssh-server
   ```

1. Edit the `sshd_config` file at location `/etc/ssh`.

   Make sure password authentication is enabled:

   ```
   PasswordAuthentication yes
   ```

   Optionally, enable key authentication:

   ```
   PubkeyAuthentication yes
   ```

   For more information about creating SSH keys on Ubuntu, see the manpage for
   [ssh-keygen](http://manpages.ubuntu.com/manpages/xenial/man1/ssh-keygen.1.html).

   Add a PowerShell subsystem entry:

   ```
   Subsystem powershell /usr/bin/pwsh -sshs -NoLogo
   ```

   > [!NOTE]
   > The default location of the PowerShell executable is `/usr/bin/pwsh`. The location can vary
   > depending on how you installed PowerShell.

   Optionally, enable key authentication:

   ```
   PubkeyAuthentication yes
   ```

1. Restart the **ssh** service.

   ```bash
   sudo service ssh restart
   ```

## Set up on a macOS computer

1. Install the latest version of PowerShell. For more information,
   [Installing PowerShell Core on macOS](../../install/installing-powershell-core-on-macos.md).

   Make sure SSH Remoting is enabled by following these steps:

   1. Open `System Preferences`.
   1. Click on `Sharing`.
   1. Check `Remote Login` to set `Remote Login: On`.
   1. Allow access to the appropriate users.

1. Edit the `sshd_config` file at location `/private/etc/ssh/sshd_config`.

   Use a text editor such as **nano**:

   ```bash
   sudo nano /private/etc/ssh/sshd_config
   ```

   Make sure password authentication is enabled:

   ```
   PasswordAuthentication yes
   ```

   Add a PowerShell subsystem entry:

   ```
   Subsystem powershell /usr/local/bin/pwsh -sshs -NoLogo
   ```

   > [!NOTE]
   > The default location of the PowerShell executable is `/usr/local/bin/pwsh`. The location can
   > vary depending on how you installed PowerShell.

   Optionally, enable key authentication:

   ```
   PubkeyAuthentication yes
   ```

1. Restart the **sshd** service.

   ```bash
   sudo launchctl stop com.openssh.sshd
   sudo launchctl start com.openssh.sshd
   ```

## Authentication

PowerShell remoting over SSH relies on the authentication exchange between the SSH client and SSH
service and doesn't implement any authentication schemes itself. The result is that any configured
authentication schemes including multi-factor authentication are handled by SSH and independent of
PowerShell. For example, you can configure the SSH service to require public key authentication and
a one-time password for added security. Configuration of multi-factor authentication is outside the
scope of this documentation. Refer to documentation for SSH on how to correctly configure
multi-factor authentication and validate it works outside of PowerShell before attempting to use it
with PowerShell remoting.

> [!NOTE]
> Users retain the same privileges in remote sessions. Meaning, Administrators have access to an
> elevated shell, and normal users will not.

## PowerShell remoting example

The easiest way to test remoting is to try it on a single computer. In this example, we create a
remote session back to the same Linux computer. We're using PowerShell cmdlets interactively so we
see prompts from SSH asking to verify the host computer and prompting for a password. You can do the
same thing on a Windows computer to ensure remoting is working. Then, remote between computers by
changing the host name.

```powershell
# Linux to Linux
#
$session = New-PSSession -HostName UbuntuVM1 -UserName TestUser
```

```Output
The authenticity of host 'UbuntuVM1 (9.129.17.107)' cannot be established.
ECDSA key fingerprint is SHA256:2kCbnhT2dUE6WCGgVJ8Hyfu1z2wE4lifaJXLO7QJy0Y.
Are you sure you want to continue connecting (yes/no)?
TestUser@UbuntuVM1s password:
```

```powershell
$session
```

```Output
 Id Name   ComputerName    ComputerType    State    ConfigurationName     Availability
 -- ----   ------------    ------------    -----    -----------------     ------------
  1 SSH1   UbuntuVM1       RemoteMachine   Opened   DefaultShell             Available
```

```powershell
Enter-PSSession $session
```

```Output
[UbuntuVM1]: PS /home/TestUser> uname -a
Linux TestUser-UbuntuVM1 4.2.0-42-generic 49~16.04.1-Ubuntu SMP Wed Jun 29 20:22:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

[UbuntuVM1]: PS /home/TestUser> Exit-PSSession
```

```powershell
Invoke-Command $session -ScriptBlock { Get-Process powershell }
```

```Output
Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                    PSComputerName
-------  ------    -----      -----     ------     --  -- -----------                    --------------
      0       0        0         19       3.23  10635 635 powershell                     UbuntuVM1
      0       0        0         21       4.92  11033 017 powershell                     UbuntuVM1
      0       0        0         20       3.07  11076 076 powershell                     UbuntuVM1
```

```powershell
#
# Linux to Windows
#
Enter-PSSession -HostName WinVM1 -UserName PTestName
```

```
PTestName@WinVM1s password:
```

```powershell
[WinVM1]: PS C:\Users\PTestName\Documents> cmd /c ver
```

```Output
Microsoft Windows [Version 10.0.10586]
```

```powershell
#
# Windows to Windows
#
C:\Users\PSUser\Documents>pwsh.exe
```

```Output
PowerShell
Copyright (c) Microsoft Corporation. All rights reserved.
```

```powershell
$session = New-PSSession -HostName WinVM2 -UserName PSRemoteUser
```

```Output
The authenticity of host 'WinVM2 (10.13.37.3)' can't be established.
ECDSA key fingerprint is SHA256:kSU6slAROyQVMEynVIXAdxSiZpwDBigpAF/TXjjWjmw.
Are you sure you want to continue connecting (yes/no)?
Warning: Permanently added 'WinVM2,10.13.37.3' (ECDSA) to the list of known hosts.
PSRemoteUser@WinVM2's password:
```

```powershell
$session
```

```Output
 Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
 -- ----            ------------    ------------    -----         -----------------     ------------
  1 SSH1            WinVM2          RemoteMachine   Opened        DefaultShell             Available
```

```powershell
Enter-PSSession -Session $session
```

```Output
[WinVM2]: PS C:\Users\PSRemoteUser\Documents> $PSVersionTable

Name                           Value
----                           -----
PSEdition                      Core
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
SerializationVersion           1.1.0.1
BuildVersion                   3.0.0.0
CLRVersion
PSVersion                      6.0.0-alpha
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
GitCommitId                    v6.0.0-alpha.17


[WinVM2]: PS C:\Users\PSRemoteUser\Documents>
```

### Limitations

- The **sudo** command doesn't work in a remote session to a Linux computer.

- PSRemoting over SSH does not support Profiles and does not have access to `$PROFILE`. Once in a
  session, you can load a profile by dot sourcing the profile with the full filepath. This is not
  related to SSH profiles. You can configure the SSH server to use PowerShell as the default shell
  and to load a profile through SSH. See the SSH documentation for more information.

- Prior to PowerShell 7.1, remoting over SSH did not support second-hop remote sessions. This
  capability was limited to sessions using WinRM. PowerShell 7.1 allows `Enter-PSSession` and
  `Enter-PSHostProcess` to work from within any interactive remote session.

## See also

[Installing PowerShell Core on Linux](../../install/installing-powershell-core-on-linux.md#ubuntu-1604)

[Installing PowerShell Core on macOS](../../install/installing-powershell-core-on-macos.md)

[Installing PowerShell Core on Windows](../../install/installing-powershell-core-on-windows.md#msi)

[Manage Windows with OpenSSH](/windows-server/administration/openssh/openssh_overview)

[Managing OpenSSH Keys](/windows-server/administration/openssh/openssh_keymanagement)

[Ubuntu SSH](https://help.ubuntu.com/lts/serverguide/openssh-server.html)
