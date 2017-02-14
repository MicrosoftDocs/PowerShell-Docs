---
manager:  carmonm
ms.topic:  article
author:  rpsqrd
ms.author:  ryanpu
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-12-05
title:  JEA Session Configurations
ms.technology:  powershell
---

# JEA Session Configurations

> Applies to: Windows PowerShell 5.0

A JEA endpoint is registered on a system by creating and registering a PowerShell session configuration file in a specific way.
Session configurations determine *who* can use the JEA endpoint, and which role(s) they will have access to.
They also define global settings that apply to users of any role in the JEA session.

This topic describes how to create a PowerShell session configuration file and register a JEA endpoint.

## Create a session configuration file

In order to register a JEA endpoint, you need to specify how that endpoint should be configured.
There are many options to consider here, the most important of which being who should have access to the JEA endpoint, which roles will they be assigned, which identity will JEA use under the covers, and what will be the name of the JEA endpoint.
These are all defined in a PowerShell session configuration file, which is a PowerShell data file ending with a .pssc extension.

To create a skeleton session configuration file for JEA endpoints, run the following command.

```powershell
New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path .\MyJEAEndpoint.pssc
```

> [!TIP]
> Only the most common configuration options are included in the skeleton file by default.
> Use the `-Full` switch to include all applicable settings in the generated PSSC.

You can open the session configuration file in any text editor.
The `-SessionType RestrictedRemoteServer` field indicates that the session configuration will be used by JEA for secure management.
Sessions configured this way will operate in [NoLanguage mode](https://technet.microsoft.com/en-us/library/dn433292.aspx) and only have the following 8 default cmdlets (and aliases) available:

- Clear-Host (cls, clear)
- Exit-PSSession (exsn, exit)
- Get-Command (gcm)
- Get-FormatData
- Get-Help
- Measure-Object (measure)
- Out-Default
- Select-Object (select)

No PowerShell providers are available, nor are any external programs (executables, scripts, etc.).

There are several other fields you will want to configure for the JEA session.
They are covered in the following sections.

### Choose the JEA identity

Behind the scenes, JEA needs an identity (account) to use when running a connected user's commands.
You decide which identity JEA will use in the session configuration file.

#### Local Virtual Account

If the roles supported by this JEA endpoint are all used to manage the local machine, and a local administrator account is sufficient to run the commands succesfully, you should configure JEA to use a local virtual account.
Virtual accounts are temporary accounts that are unique to a specific user and only last for the duration of their PowerShell session.
On a member server or workstation, virtual accounts belong to the local computer's **Administrators** group, and have access to most system resources.
On an Active Directory Domain Controller, virtual accounts belong to the domain's **Domain Admins** group.

```powershell
# Setting the session to use a virtual account
RunAsVirtualAccount = $true
```

If the roles supported by the session configuration do not require such broad privileges, you can optionally specify the security groups to which the virtual account will belong.
On a member server or workstation, the specified security groups must be local groups, not groups from a domain.

When one or more security groups is specified, the virtual account will no longer belong to the local or domain administrators group.

```powershell
# Setting the session to use a virtual account that only belongs to the NetworkOperator and NetworkAuditor local groups
RunAsVirtualAccount = $true
RunAsVirtualAccountGroups = 'NetworkOperator', 'NetworkAuditor'
```

#### Group Managed Service Account


For scenarios requiring the JEA user to access network resources such as other machines or web services, a group managed service account (gMSA) is a more appropriate identity to use.
gMSA accounts give you a domain identity which can be used to authenticate against resources on any machine within the domain.
The rights the gMSA account gives you is determined by the resources you are accessing.
You will not automatically have admin rights on any machines or services unless the machine/service administrator has explicitly granted the gMSA account admin privileges.

```powershell
# Configure JEA sessions to use the gMSA account in the local computer's domain with the sAMAccountName of 'MyJEAgMSA'
GroupManagedServiceAccount = 'MyJEAgMSA'
```

gMSA accounts should only be used when access to network resources are required for a few reasons:

- It is harder to trace back actions to a user when using a gMSA account since every user shares the same run-as identity. You will need to consult PowerShell session transcripts and logs to correlate users with their actions.

- The gMSA account may have access to many network resources which the connecting user does not need access to. Always try to limit effective permissions in a JEA session to follow the principle of least privilege.

> [!NOTE]
> Group managed service accounts are only available in Windows PowerShell 5.1 or newer and on domain-joined machines.


#### More information about run as users

Additional information about run as identities and how they factor into the security of a JEA session can be found in the [security considerations](security-considerations.md) article.

### Session transcripts

It is recommended that you configure a JEA session configuration file to automatically record transcripts of users' sessions.
PowerShell session transcripts contain information about the connecting user, the run as identity assigned to them, and the commands run by the user.
They can be useful to an auditing team who needs to understand who performed a specific change to a system.

To configure automatic transcription in the session configuration file, provide a path to a folder where the transcripts should be stored.

```powershell
TranscriptDirectory = 'C:\ProgramData\JEAConfiguration\Transcripts'
```

The specified folder should be configured to prevent users from modifying or deleting any data in it.
Transcripts are written to the folder by the Local System account, which requires read and write access to the directory.
Standard users should have no access to the folder, and a limited set of security administrators should have access to audit the transcripts.

### User drive

If your connecting users will need to copy files to/from the JEA endpoint in order to run a command, you can enable the user drive in the session configuration file.
The user drive is a [PSDrive](https://msdn.microsoft.com/en-us/powershell/scripting/getting-started/cookbooks/managing-windows-powershell-drives) that is mapped to a unique folder for each connecting user.
This folder serves as a space for them to copy files to/from the system, without giving them access to the full file system or exposing the FileSystem provider.
The user drive contents are persistent across sessions to accommodate situations where network connectivity may be interrupted.

```powershell
MountUserDrive = $true
```

By default, the user drive allows you to store a maximum of 50MB of data per user.
You can limit the amount of data a user can consume with the *UserDriveMaxmimumSize* field.

```powershell
# Enables the user drive with a per-user limit of 500MB (524288000 bytes)
MountUserDrive = $true
UserDriveMaximumSize = 524288000
```

If you do not want data in the user drive to be persistent, you can configure a scheduled task on the system to automatically clean up the folder every night.

> [!NOTE]
> The user drive is only available in Windows PowerShell 5.1 or newer.

### Role definitions

Role definitions in a session configuration file define the mapping of *users* to *roles*.
Every user or group included in this field will automatically be granted permission to the JEA endpoint when it is registered.
Each user or group can be included as a key in the hashtable only once, but can be assigned multiple roles.
The name of the role capability should be the name of the role capability file, without the .psrc extension.

```powershell
RoleDefinitions = @{
    'CONTOSO\JEA_DNS_ADMINS'    = @{ RoleCapabilities = 'DnsAdmin', 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_OPERATORS' = @{ RoleCapabilities = 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_AUDITORS'  = @{ RoleCapabilities = 'DnsAuditor' }
}
```

If a user belongs to more than one group in the role definition, they will get access to the roles of each.
If two roles grant access to the same cmdlets, the most permissive parameter set will be granted to the user.

### Role capability search order
As shown in the example above, role capabilities are referenced by the flat name (filename without the extension) of the role capability file.
If multiple role capabilities are available on the system with the same flat name, PowerShell will use its implicit search order to select the effective role capability file.
It will **not** give access to all role capability files with the same name.

The search order for JEA role capabilities is determined by the ordering of paths in `$env:PSModulePath` and the name of the parent module.
The default module path in PowerShell is the following:

```powershell
PS C:\> $env:PSModulePath


C:\Users\Alice\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\
```

Paths that appear earlier (to the left) in the PSModulePath list have higher precedence than paths on the right.

Within each path, there may be 0 or more PowerShell modules.
Role capabilities are selected from the first module, alphabetically, that contain a role capability file that matches the desired name.

To help illustrate this precedence, consider the following example where the plus sign (+) indicates a folder, and the minus sign (-) indicates a file.

```
+ C:\Program Files\WindowsPowerShell\Modules
    + ContosoMaintenance
        - ContosoMaintenance.psd1
        + RoleCapabilities
            - DnsAdmin.psrc
            - DnsOperator.psrc
            - DnsAuditor.psrc
    + FabrikamModule
        - FabrikamModule.psd1
        + RoleCapabilities
            - DnsAdmin.psrc
            - FileServerAdmin.psrc

+ C:\Windows\System32\WindowsPowerShell\v1.0\Modules
    + BuiltInModule
        - BuiltInModule.psd1
        + RoleCapabilities
            - DnsAdmin.psrc
            - OtherBuiltinRole.psrc
```

There are several role capability files installed on this system.
What happens if a session configuration file gives a user access to the "DnsAdmin" role?


The effective role capability file will be the one located at "C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoMaintenance\\RoleCapabilities\\DnsAdmin.psrc".

If you're wondering why, remember the 2 orders of precedence:

1. The `$env:PSModulePath` variable has the Program Files folder listed before the System32 folder, so it will prefer files from the Program Files folder.
2. Alphabetically, the ContosoMaintenance module comes before the FabrikamModule, so it will select the DnsAdmin role from ContosoMaintenance.

### Conditional access rules

All users and groups included in the RoleDefinitions field are automatically granted access to JEA endpoints.
Conditional access rules allow you to refine this access and require users to belong to additional security groups which do not impact the roles which they are assigned.
This can be useful if you want to integrate a "just in time" privileged access management solution, smartcard authentication, or other multifactor authentication solution with JEA.

Conditional access rules are defined in the RequiredGroups field in a session configuration file.
There, you can provide a hashtable (optionally nested) that uses 'And' and 'Or' keys to construct your rules.
Here are some examples of how to leverage this field:

```powershell
# Example 1: Connecting users must belong to a security group called "elevated-jea"
RequiredGroups = @{ And = 'elevated-jea' }

# Example 2: Connecting users must have signed on with 2 factor authentication or a smart card
# The 2 factor authentication group name is "2FA-logon" and the smart card group name is "smartcard-logon"
RequiredGroups = @{ Or = '2FA-logon', 'smartcard-logon' }

# Example 3: Connecting users must elevate into "elevated-jea" with their JIT system and have logged on with 2FA or a smart card
RequiredGroups = @{ And = 'elevated-jea', @{ Or = '2FA-logon', 'smartcard-logon' }}
```

> [!NOTE]
> Conditional access rules are only available in Windows PowerShell 5.1 or newer.

### Other properties
Session configuration files can also do everything a role capability file can do, just without the ability to give connecting users access to different commands.
If you want to allow all users access to specific cmdlets, functions, or providers, you can do so right in the session configuration file.
For a full list of supported properties in the session configuration file, run `Get-Help New-PSSessionConfigurationFile -Full`.

## Testing a session configuration file

You can test a session configuration using the [Test-PSSessionConfigurationFile](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/test-pssessionconfigurationfile) cmdlet.
It is strongly recommended that you test your session configuration file if you have edited the pssc file manually using a text editor to ensure the syntax is correct.
If a session configuration file does not pass this test, it will not be able to be successfully registered on the system.

## Sample session configuration file

Below is a complete example showing how to create and validate a session configuration for JEA.
Note that the role definitions are created and stored in the `$roles` variable for convenience and readability.
It is not a requirement to do so.

```powershell
$roles = @{
    'CONTOSO\JEA_DNS_ADMINS'    = @{ RoleCapabilities = 'DnsAdmin', 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_OPERATORS' = @{ RoleCapabilities = 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_AUDITORS'  = @{ RoleCapabilities = 'DnsAuditor' }
}

New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path .\JEAConfig.pssc -RunAsVirtualAccount -TranscriptDirectory 'C:\ProgramData\JEAConfiguration\Transcripts' -RoleDefinitions $roles -RequiredGroups @{ Or = '2FA-logon', 'smartcard-logon' }
Test-PSSessionConfigurationFile -Path .\JEAConfig.pssc # should yield True
```

## Updating session configuration files

If you need to change properties of a JEA session configuration, including the mapping of users to roles, you must [unregister](register-jea.md#unregistering-jea-configurations) and [re-register](register-jea.md) the JEA session configuration.
When you re-register the JEA session configuration, use an updated PowerShell session configuration file that includes your desired changes.

## Next steps

- [Register a JEA configuration](register-jea.md)
- [Author JEA roles](role-capabilities.md)
