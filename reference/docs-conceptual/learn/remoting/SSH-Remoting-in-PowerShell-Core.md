---
title: PowerShell Remoting Over SSH
description: Remoting in PowerShell Core using SSH
ms.date: 08/14/2018
---

# PowerShell Remoting Over SSH

## Overview

PowerShell remoting normally uses WinRM for connection negotiation and data transport. SSH is now available for Linux and Windows platforms and allows true multiplatform PowerShell remoting.

WinRM provides a robust hosting model for PowerShell remote sessions. SSH-based remoting doesn't currently support remote endpoint configuration and JEA (Just Enough Administration).

SSH remoting lets you do basic PowerShell session remoting between Windows and Linux machines. SSH Remoting creates a PowerShell host process on the target machine as an SSH subsystem.
Eventually we'll implement a general hosting model, similar to WinRM, to support endpoint
configuration and JEA.

The `New-PSSession`, `Enter-PSSession`, and `Invoke-Command` cmdlets now have a new parameter set to
support this new remoting connection.

```
[-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
```

To create a remote session, you specify the target machine with the `HostName` parameter and
provide the user name with `UserName`. When running the cmdlets interactively, you're prompted for
a password. You can also, use SSH key authentication using a private key file with the
`KeyFilePath` parameter.

## General setup information

SSH must be installed on all machines. Install both the SSH client (`ssh.exe`) and server
(`sshd.exe`) so that you can remote to and from the machines. OpenSSH for Windows is now availabe
in Windows 10 build 1809 and Windows Server 2019. For more information, see
[OpenSSH for Windows](/windows-server/administration/openssh/openssh_overview). For Linux, install
SSH (including sshd server) appropriate to your platform. You also need to install PowerShell Core
from GitHub to get the SSH remoting feature. The SSH server must be configured to create an SSH
subsystem to host a PowerShell process on the remote machine. You also must configure enable
password or key-based authentication.

## Set up on Windows Machine

1. Install the latest version of [PowerShell Core for Windows](../../install/installing-powershell-core-on-windows.md#msi)

   - You can tell if it has the SSH remoting support by looking at the parameter sets for
     `New-PSSession`

   ```powershell
   Get-Command New-PSSession -syntax
   ```

   ```output
   New-PSSession [-HostName] <string[]> [-Name <string[]>] [-UserName <string>] [-KeyFilePath <string>] [-SSHTransport] [<CommonParameters>]
   ```

2. Install the latest Win32 OpenSSH. For installation instructions, see
   [Installation of OpenSSH](/windows-server/administration/openssh/openssh_install_firstuse).
3. Edit the `sshd_config` file located at `$env:ProgramData\ssh`.

   - Make sure password authentication is enabled

     ```
     PasswordAuthentication yes
     ```

     ```
     Subsystem    powershell c:/program files/powershell/6/pwsh.exe -sshs -NoLogo -NoProfile
     ```

     > [!NOTE]
     > There is a bug in OpenSSH for Windows that prevents spaces from working in subsystem
     > executable paths. For more information, see [this GitHub issue](https://github.com/PowerShell/Win32-OpenSSH/issues/784).

     One solution is to create a symlink to the PowerShell installation directory that doesn't have spaces:

     ```powershell
     mklink /D c:\pwsh "C:\Program Files\PowerShell\6"
     ```

     and then enter it in the subsystem:

     ```
     Subsystem    powershell c:\pwsh\pwsh.exe -sshs -NoLogo -NoProfile
     ```

   - Optionally enable key authentication

     ```
     PubkeyAuthentication yes
     ```

4. Restart the sshd service

   ```powershell
   Restart-Service sshd
   ```

5. Add the path where OpenSSH is installed to your Path environment variable. For example,
   `C:\Program Files\OpenSSH\`. This entry allows for the ssh.exe to be found.

## Set up on Linux (Ubuntu 14.04) Machine

1. Install the latest [PowerShell Core for Linux](../../install/installing-powershell-core-on-linux.md#ubuntu-1404) build from GitHub
2. Install [Ubuntu SSH](https://help.ubuntu.com/lts/serverguide/openssh-server.html) as needed

   ```bash
   sudo apt install openssh-client
   sudo apt install openssh-server
   ```

3. Edit the sshd_config file at location /etc/ssh

   - Make sure password authentication is enabled

   ```
   PasswordAuthentication yes
   ```

   - Add a PowerShell subsystem entry

   ```
   Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile
   ```

   - Optionally enable key authentication

   ```
   PubkeyAuthentication yes
   ```

4. Restart the sshd service

   ```bash
   sudo service sshd restart
   ```

## Set up on MacOS Machine

1. Install the latest [PowerShell Core for MacOS](../../install/installing-powershell-core-on-macos.md) build

   - Make sure SSH Remoting is enabled by following these steps:
     - Open `System Preferences`
     - Click on `Sharing`
     - Check `Remote Login` - Should say `Remote Login: On`
     - Allow access to appropriate users

2. Edit the `sshd_config` file at location `/private/etc/ssh/sshd_config`

   - Use your favorite editor or

     ```bash
     sudo nano /private/etc/ssh/sshd_config
     ```

   - Make sure password authentication is enabled

     ```
     PasswordAuthentication yes
     ```

   - Add a PowerShell subsystem entry

     ```
     Subsystem powershell /usr/local/bin/pwsh -sshs -NoLogo -NoProfile
     ```

   - Optionally enable key authentication

     ```
     PubkeyAuthentication yes
     ```

3. Restart the sshd service

   ```bash
   sudo launchctl stop com.openssh.sshd
   sudo launchctl start com.openssh.sshd
   ```

## Authentication

PowerShell remoting over SSH relies on the authentication exchange between the SSH client and SSH service and does not implement any authentication schemes itself.
This means that any configured authentication schemes including multi-factor authentication is handled by SSH and independent of PowerShell.
For example, you can configure the SSH service to require public key authentication as well as a one-time password for added security.
Configuration of multi-factor authentication is outside the scope of this documentation.
Refer to documentation for SSH on how to correctly configure multi-factor authentication and validate it works outside of PowerShell
before attempting to use it with PowerShell remoting.

## PowerShell Remoting Example

The easiest way to test remoting is to try it on a single machine. In this example, we create a
remote session back to the same Linux machine. We are using PowerShell cmdlets interactively so we
see prompts from SSH asking to verify the host computer and prompting for a password. You can do
the same thing on a Windows machine to ensure remoting is working. Then remote between machines by
changing the host name.

```powershell
#
# Linux to Linux
#
$session = New-PSSession -HostName UbuntuVM1 -UserName TestUser
```

```output
The authenticity of host 'UbuntuVM1 (9.129.17.107)' cannot be established.
ECDSA key fingerprint is SHA256:2kCbnhT2dUE6WCGgVJ8Hyfu1z2wE4lifaJXLO7QJy0Y.
Are you sure you want to continue connecting (yes/no)?
TestUser@UbuntuVM1s password:
```

```powershell
$session
```

```output
 Id Name   ComputerName    ComputerType    State    ConfigurationName     Availability
 -- ----   ------------    ------------    -----    -----------------     ------------
  1 SSH1   UbuntuVM1       RemoteMachine   Opened   DefaultShell             Available
```

```powershell
Enter-PSSession $session
```

```output
[UbuntuVM1]: PS /home/TestUser> uname -a
Linux TestUser-UbuntuVM1 4.2.0-42-generic 49~14.04.1-Ubuntu SMP Wed Jun 29 20:22:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

[UbuntuVM1]: PS /home/TestUser> Exit-PSSession
```

```powershell
Invoke-Command $session -ScriptBlock { Get-Process powershell }
```

```output
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

```output
PTestName@WinVM1s password:
```

```powershell
[WinVM1]: PS C:\Users\PTestName\Documents> cmd /c ver
```

```output
Microsoft Windows [Version 10.0.10586]
```

```powershell
#
# Windows to Windows
#
C:\Users\PSUser\Documents>pwsh.exe
```

```output
PowerShell
Copyright (c) Microsoft Corporation. All rights reserved.
```

```powershell
$session = New-PSSession -HostName WinVM2 -UserName PSRemoteUser
```

```output
The authenticity of host 'WinVM2 (10.13.37.3)' can't be established.
ECDSA key fingerprint is SHA256:kSU6slAROyQVMEynVIXAdxSiZpwDBigpAF/TXjjWjmw.
Are you sure you want to continue connecting (yes/no)?
Warning: Permanently added 'WinVM2,10.13.37.3' (ECDSA) to the list of known hosts.
PSRemoteUser@WinVM2's password:
```

```powershell
$session
```

```output
 Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
 -- ----            ------------    ------------    -----         -----------------     ------------
  1 SSH1            WinVM2          RemoteMachine   Opened        DefaultShell             Available
```

```powershell
Enter-PSSession -Session $session
```

```output
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

### Known Issues

The sudo command doesn't work in remote session to Linux machine.

## See Also

[PowerShell Core for Windows](../../install/installing-powershell-core-on-windows.md#msi)

[PowerShell Core for Linux](../../install/installing-powershell-core-on-linux.md#ubuntu-1404)

[PowerShell Core for MacOS](../../install/installing-powershell-core-on-macos.md)

[OpenSSH for Windows](/windows-server/administration/openssh/openssh_overview)

[Ubuntu SSH](https://help.ubuntu.com/lts/serverguide/openssh-server.html)
