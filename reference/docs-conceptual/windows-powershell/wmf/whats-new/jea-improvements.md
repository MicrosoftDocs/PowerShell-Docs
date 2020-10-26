---
ms.date: 06/12/2017
title: Improvements to Just Enough Administration (JEA)
description: JEA is a new feature in WMF 5.0 that enables role-based administration through PowerShell remoting. It extends the existing constrained endpoint infrastructure by allowing non-administrators to run specific commands, scripts, and executables as an administrator.
---
# Improvements to Just Enough Administration (JEA)

Just Enough Administration is a new feature in WMF 5.0 that enables role-based administration
through PowerShell remoting. It extends the existing constrained endpoint infrastructure by allowing
non-administrators to run specific commands, scripts, and executables as an administrator. This
enables you to reduce the number of full administrators in your environment and improve security.

## Constrained file copy to/from JEA endpoints

You can now remotely copy files to/from a JEA endpoint and be assured that the connecting user can't
copy just *any* file on your system. This is possible by configuring your PSSC file to mount a user
drive for connecting users. The user drive is a new PSDrive that is unique to each connecting user
and persists across sessions. When `Copy-Item` is used to copy files to or from a JEA session, it is
constrained to only allow access to the user drive. Attempts to copy files to any other PSDrive will
fail.

To set up the user drive in your JEA session configuration file, use the following new fields:

```powershell
MountUserDrive = $true
UserDriveMaximumSize = 10485760    # 10 MB
```

The folder backing the user drive is created at
`$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\DriveRoots\`. For each user connecting to the
endpoint, a folder is created with the name `$env:USERDOMAIN_$env:USERNAME`.

To utilize the user drive and copy files to/from a JEA endpoint configured to expose the User
drive, use the `-ToSession` and `-FromSession` parameters on `Copy-Item`.

```powershell
# Connect to the JEA endpoint
$jeasession = New-PSSession -ComputerName 'srv01' -ConfigurationName 'UserDemo'

# Copy a file in the local folder to the remote machine.
# Note: you cannot specify the file name or subfolder on the remote machine.
# You must exactly type "User:"
Copy-Item -Path .\SampleFile.txt -Destination User: -ToSession $jeasession

# Copy the file back from the remote machine to your local machine
Copy-Item -Path User:\SampleFile.txt -Destination . -FromSession $jeasession
```

You can then write custom functions to process the data stored in the user drive and make those
available to users in your Role Capability file.

## Support for Group Managed Service Accounts

In some cases, a task a user needs to perform in a JEA session may need to access resources beyond
the local machine. When a JEA session is configured to use a virtual account, any attempt to reach
such resources will appear to come from the local machine's identity, not the virtual account or
connected user. In TP5, we have enabled support for running JEA under the context of a
[Group Managed Service Account](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj128431\(v=ws.11\)),
making it much easier to access network resources by using a domain identity.

To configure a JEA session to run under a gMSA account, use the following new key in your PSSC file:

```powershell
# Provide the name of your gMSA account here (don't include a trailing $)
# The local machine must be privileged to use this gMSA in Active Directory
GroupManagedServiceAccount = 'myGMSAforJEA'

# You cannot configure a JEA endpoint to use both a gMSA and virtual account
# You can leave the RunAsVirtualAccount field commented out or explicitly set it to false
RunAsVirtualAccount = $false
```

> [!NOTE]
> Group Managed Service Accounts do not afford the isolation or limited scope of virtual accounts.
> Every connecting user will share the same gMSA identity, which may have permissions across your
> entire enterprise. Be very careful when selecting to use a gMSA, and always prefer virtual
> accounts which are limited to the local machine when possible.

## Conditional access policies

JEA is great at limiting what someone can do when they've connected to a system to manage it, but
what if you also want to limit *when* someone can use JEA? We have added configuration options into
the session configuration files (.pssc) to let you specify security groups to which a user must
belong in order to establish a JEA session. This is especially helpful if you have a Just In Time
(JIT) system in your environment, and want to make your users elevate their privileges before
accessing a highly-privileged JEA endpoint.

The new *RequiredGroups* field in the PSSC file allows you to specify the logic to determine if a
user can connect to JEA. It consists of specifying a hashtable (optionally nested) that uses the
'And' and 'Or' keys to construct your rules. Here are some examples of how to use this field:

```powershell
# Example 1: Connecting users must belong to a security group called "elevated-jea"
RequiredGroups = @{ And = 'elevated-jea' }

# Example 2: Connecting users must have signed on with 2 factor authentication or a smart card
# The 2 factor authentication group name is "2FA-logon" and the smart card group name is "smartcard-logon"
RequiredGroups = @{ Or = '2FA-logon', 'smartcard-logon' }

# Example 3: Connecting users must elevate into "elevated-jea" with their JIT system and have logged on with 2FA or a smart card
RequiredGroups = @{ And = 'elevated-jea', @{ Or = '2FA-logon', 'smartcard-logon' }}
```

## Fixed: Virtual accounts are now supported on Windows Server 2008 R2

In WMF 5.1, you are now able to use virtual accounts on Windows Server 2008 R2, enabling consistent
configurations and feature parity across Windows Server 2008 R2 - 2016. Virtual accounts remain
unsupported when using JEA on Windows 7.
