
---
title: PowerShell Remoting Over SSH
description: Remoting in PowerShell Core using SSH
ms.date: 08/06/2018
---

# PowerShell Remoting Over SSH

## Overview

PowerShell remoting normally uses WinRM for connection negotiation and data transport. SSH was
chosen for this remoting implementation since it is now available for both Linux and Windows
platforms and allows true multiplatform PowerShell remoting. However, WinRM also provides a robust
hosting model for PowerShell remote sessions which this implementation does not yet do. And this
means that PowerShell remote endpoint configuration and JEA (Just Enough Administration) is not yet
supported in this implementation.

PowerShell SSH remoting lets you do basic PowerShell session remoting between Windows and Linux
machines. This is done by creating a PowerShell hosting process on the target machine as an SSH
subsystem. Eventually this will be changed to a more general hosting model similar to how WinRM
works in order to support endpoint configuration and JEA.

The `New-PSSession`, `Enter-PSSession` and `Invoke-Command` cmdlets now have a new parameter set to
facilitate this new remoting connection

```
[-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
```

This new parameter set will likely change but for now allows you to create SSH PSSessions that you
can interact with from the command line or invoke commands and scripts on. You specify the target
machine with the HostName parameter and provide the user name with UserName. When running the
cmdlets interactively at the PowerShell command line you will be prompted for a password. But you
also have the option to use SSH key authentication and provide a private key file path with the
KeyFilePath parameter.

## General setup information

SSH is required to be installed on all machines. You should install both client (`ssh.exe`) and
server (`sshd.exe`) so that you can experiment with remoting to and from the machines. For Windows
you will need to install [Win32 OpenSSH from GitHub](https://github.com/PowerShell/Win32-OpenSSH/releases).
For Linux you will need to install SSH (including sshd server) appropriate to your platform. You
will also need a recent PowerShell build or package from GitHub having the SSH remoting feature.
SSH subsystems is used to establish a PowerShell process on the remote machine and the SSH server
will need to be configured for that. In addition you will need to enable password authentication
and optionally key based authentication.

## Setup on Windows Machine

1. Install the latest version of [PowerShell Core for Windows]

   - You can tell if it has the SSH remoting support by looking at the parameter sets for
     `New-PSSession`

   ```powershell
   Get-Command New-PSSession -syntax
   ```

   ```output
   New-PSSession [-HostName] <string[]> [-Name <string[]>] [-UserName <string>] [-KeyFilePath <string>] [-SSHTransport] [<CommonParameters>]
   ```

2. Install the latest [Win32 OpenSSH] build from GitHub using the [installation] instructions
3. Edit the sshd_config file at the location where you installed Win32 OpenSSH

   - Make sure password authentication is enabled

     ```
     PasswordAuthentication yes
     ```

     ```
     Subsystem    powershell c:/program files/powershell/6.0.0/pwsh.exe -sshs -NoLogo -NoProfile
     ```

     > [!NOTE]
     > There is a bug in OpenSSH for Windows that prevents spaces from working in subsystem executable paths.
     > See [this issue on GitHub for more information](https://github.com/PowerShell/Win32-OpenSSH/issues/784).

     One solution is to create a symlink to the Powershell installation directory that does not contain spaces:

     ```powershell
     mklink /D c:\pwsh "C:\Program Files\PowerShell\6.0.0"
     ```

     and then enter it in the subsystem:

     ```
     Subsystem    powershell c:\pwsh\pwsh.exe -sshs -NoLogo -NoProfile
     ```

     ```
     Subsystem    powershell c:/program files/powershell/6.0.0/pwsh.exe -sshs -NoLogo -NoProfile
     ```

   - Optionally enable key authentication

     ```
     PubkeyAuthentication yes
     ```

4. Restart the sshd service

   ```powershell
   Restart-Service sshd
   ```

5. Add the path where OpenSSH is installed to your Path Env Variable

   - This should be along the lines of `C:\Program Files\OpenSSH\`
   - This allows for the ssh.exe to be found

## Setup on Linux (Ubuntu 14.04) Machine

1. Install the latest [PowerShell Core for Linux] build from GitHub
2. Install [Ubuntu SSH] as needed

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

## Setup on MacOS Machine

1. Install the latest [PowerShell Core for MacOS] build

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

## PowerShell Remoting Example

The easiest way to test remoting is to just try it on a single machine. Here I will create a remote
session back to the same machine on a Linux box. Notice that I am using PowerShell cmdlets from a
command prompt so we see prompts from SSH asking to verify the host computer as well as password
prompts. You can do the same thing on a Windows machine to ensure remoting is working there and
then remote between machines by simply changing the host name.

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
 Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
 -- ----            ------------    ------------    -----         -----------------     ------------
  1 SSH1            UbuntuVM1       RemoteMachine   Opened        DefaultShell             Available
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

The sudo command does not work in remote session to Linux machine.

## See Also

[PowerShell Core for Windows](../setup/installing-powershell-core-on-windows.md#msi)

[PowerShell Core for Linux](../setup/installing-powershell-core-on-linux.md#ubuntu-1404)

[PowerShell Core for MacOS](../setup/installing-powershell-core-on-macos.md)

[Win32 OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/releases)

[installation](https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH)

[Ubuntu SSH](https://help.ubuntu.com/lts/serverguide/openssh-server.html)