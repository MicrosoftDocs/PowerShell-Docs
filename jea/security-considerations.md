---
ms.date:  2017-06-12
author:  rpsqrd
ms.topic:  conceptual
keywords:  jea,powershell,security
title:  JEA Security Considerations
---

# JEA Security Considerations

> Applies to: Windows PowerShell 5.0

JEA helps you improve your security posture by reducing the number of permanent administrators on your machines.
It does so by creating a new entry point for users to manage the system (a PowerShell session configuration) which is tightly locked down by default to prevent misuse.
Users who need some, but not unlimited, access to the machine to perform administrative tasks can be granted access to the JEA endpoint.
Because JEA allows them to run admin commands without directly having admin access, you can then remove those users from highly privileged security groups (make them standard users).

This topic describes the JEA security model and best practices in more detail.

## Run As account

Each JEA endpoint has a designated "run as" account, which is the account under which the connecting user's actions are performed.
This account is configurable in the [session configuration file](session-configurations.md), and the account you choose has a significant bearing on the security of your endpoint.

**Virtual accounts** are the recommended way of configuring the run as account.
Virtual accounts are one-time, temporary local accounts that are created for the connecting user to use during the duration of their JEA session.
As soon as their session is terminated, the virtual account will be destroyed and cannot be used anymore.
The connecting user does not know the credentials for the virtual account and cannot use the virtual account to access the system via other means, such as Remote Desktop or an unconstrained PowerShell endpoint.

By default, virtual accounts belong to the local administrators group on the machine.
This gives them full rights to manage anything on the system, but no rights to manage resources on the network.
When authenticating with other machines, the user context will be that of the local computer account, not the virtual account.

Domain controllers are a special case since there is no concept of a local administrators group.
Instead, virtual accounts belong to Domain Admins instead and can manage the directory services on the domain controller.
The domain identity is still restricted to use on the domain controller where the JEA session was instantiated, and any network access will appear to come from the domain controller computer object instead.

In both cases, you can also explicitly define which security groups the virtual account should belong to.
This is a good practice when the task you are performing can be done without local/domain admin privileges.
If you already have a security group defined for your admins, you can simply grant the virtual account membership to that group to give it the permissions it needs.
Virtual account group membership is limited to local security groups on workstation and member servers, but on a domain controller they can only be members of domain security groups.
Once you specify one or more security groups for the virtual account to belong to, it will no longer belong to the default groups (local admin or domain admin).

The table below summarizes the possible configuration options and resulting permissions for virtual accounts

Computer type                | Virtual account group configuration | Local user context                                      | Network user context
-----------------------------|-------------------------------------|---------------------------------------------------------|--------------------------------------------------
Domain controller            | Default                             | Domain user, member of '*DOMAIN*\Domain Admins'         | Computer account
Domain controller            | Domain groups A and B               | Domain user, member of '*DOMAIN*\A', '*DOMAIN*\B'       | Computer account
Member server or workstation | Default                             | Local user, member of '*BUILTIN*\Administrators'        | Computer account
Member server or workstation | Local groups C and D                | Local user, member of '*COMPUTER*\C' and '*COMPUTER*\D' | Computer account

When you look at security audit events and application event logs, you will see that each JEA user session has a unique virtual account.
This helps you track user actions in a JEA endpoint back to the original user who ran the command.
Virtual account names follow the format "WinRM Virtual Users\\WinRM\_VA\_*ACCOUNTNUMBER*\_*DOMAIN*\_*sAMAccountName*"
For example, if user "Alice" in domain "Contoso" restarts a service in a JEA endpoint, the username associated with any service control manager events would be "WinRM Virtual Users\\WinRM\_VA\_1\_contoso\_alice".


**Group managed service accounts (gMSAs)** are useful when a member server needs to have access to network resources in the JEA session.
An example use case for this is a JEA endpoint that is used to control access to a REST API hosted on a different machine.
It is easy to write functions to make the desired invocations on the REST API, but in order to authenticate with the API you need a network identity.
Using a group managed service account makes the "second hop" possible while still having control over which computers can use the account.
The effective permissions of the gMSA are defined by the security groups (local or domain) to which the gMSA account belongs.

When a JEA endpoint is configured to use a gMSA account, the actions of all JEA users will appear to come from the same group managed service account.
The only way you can trace actions back to a specific user is to identify the set of commands run in a PowerShell session transcript.

**Pass-thru credentials** are used when you do not specify a run as account and want PowerShell to use the connecting user's credential to run commands on the remote server.
This configuration is *not* recommended for JEA as it would require you to grant the connecting user direct access to privileged management groups.
If the connecting user already has admin privileges, they can avoid JEA altogether and manage the system via other, unconstrained means.
See the section below on how [JEA does not protect against admins](#jea-does-not-protect-against-admins) for more information.

**Standard run as accounts** allow you to specify any user account under which the entire PowerShell session will run.
This is an important distinction, because a session configuration set to use a fixed run as account (with the `-RunAsCredential` parameter) is not JEA-aware.
That means that role definitions no longer function as expected, and every user authorized to access the endpoint will be assigned the same role.

You should not use a RunAsCredential on a JEA endpoint because of the difficulty in tracing actions back to specific users and the lack of support for mapping users to roles.

## WinRM Endpoint ACL

As with regular PowerShell remoting endpoints, each JEA endpoint has a separate access control list (ACL) set in the WinRM configuration that controls who can authenticate with the JEA endpoint.
If improperly configured, trusted users may not be able to access the JEA endpoint and/or untrusted users may gain access.
The WinRM ACL does not, however, affect the mapping of users to JEA roles.
That is controlled by the *RoleDefinitions* field in the session configuration file that was registered on the system.

By default, when you register a JEA endpoint using a session configuration file and one or more role capabilities, the WinRM ACL will be configured to allow all users mapping to one or more roles access to the endpoint.
For example, a JEA session configured using the following commands will grant full access to *CONTOSO\JEA\_Lev1* and *CONTOSO\JEA\_Lev2*.

```powershell
$roles = @{ 'CONTOSO\JEA_Lev1' = 'Lev1Role'; 'CONTOSO\JEA_Lev2' = 'Lev2Role' }
New-PSSessionConfigurationFile -Path '.\jea.pssc' -SessionType RestrictedRemoteServer -RoleDefinitions $roles -RunAsVirtualAccount
Register-PSSessionConfiguration -Path '.\jea.pssc' -Name 'MyJEAEndpoint'
```

You can audit user permissions with the [Get-PSSessionConfiguration](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-pssessionconfiguration) cmdlet.

```powershell
PS C:\> Get-PSSessionConfiguration -Name 'MyJEAEndpoint' | Select-Object Permission

Permission
----------
CONTOSO\JEA_Lev1 AccessAllowed
CONTOSO\JEA_Lev2 AccessAllowed
```

To change which users have access, run either `Set-PSSessionConfiguration -Name 'MyJEAEndpoint' -ShowSecurityDescriptorUI` for an interactive prompt or `Set-PSSessionConfiguration -Name 'MyJEAEndpoint' -SecurityDescriptorSddl <SDDL string>` to update the permissions.
Users need at least *Invoke* rights to access the JEA endpoint.

If additional users are granted access to the JEA endpoint but do not fall into any of the roles defined in the session configuration file, they will be able to start a JEA session but only have access to the default cmdlets.
You can audit user permissions in a JEA endpoint by running `Get-PSSessionCapability`.
Check out the [Auditing and Reporting on JEA](audit-and-report.md) article for more information about auditing which commands a user has access to in a JEA endpoint.

## Least privilege roles

When designing JEA roles, it is important to remember that the virtual or group managed service account running behind the scenes often has unrestricted access to manage the local machine.
JEA role capabilities help restrict what that account can be used for by limiting the commands and applications that can be run using that privileged context.
Improperly designed roles can allow dangerous commands to run that may allow a user to break out of the JEA boundaries or obtain access to sensitive information.

For example, consider the following role capability entry:

```powershell
@{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\*-Process'
}
```

This role capability allows users to run any PowerShell cmdlet with the noun "Process" from the Microsoft.PowerShell.Management module.
Users may need to access cmdlets like `Get-Process` to understand what applications are running on the system and `Stop-Process` to kill any hung applications.
However, this entry also allows `Start-Process`, which can be used to start up an arbitrary program with full administrator permissions.
The program doesn't need to be installed locally on the system, so an adversary could simply start a program on a file share that gives the connecting user local admin privileges, runs malware, and more.'

A more secure version of this same role capability would look like:

```powershell
@{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\Get-Process', 'Microsoft.PowerShell.Management\Stop-Process'
}
```

Avoid using wildcards in role capabilities, and be sure to [audit effective user permissions](audit-and-report.md#check-effective-rights-for-a-specific-user) regularly to understand which commands a user has access to.

## JEA does not protect against admins

One of the core principles of JEA is that it allows non-admins to perform *some* admin tasks.
JEA does not protect against those who already have administrator privileges.
Users who belong "domain admins," "local admins," or other highly privileged groups in your environment will still be able to get around JEA's protections by signing into the machine via another means.
They could, for example, sign in with RDP, use remote MMC consoles, or connect to unconstrained PowerShell endpoints.
Local admins on the system can also modify JEA configurations to allow additional users to manage the system or change a role capability to extend the scope of what a user can do in their JEA session.
It is therefore important to evaluate your JEA users' extended permissions to see if there are other ways they could gain privileged access to the system.

A common practice is to use JEA for regular day-to-day maintenance and have a "just in time" privileged access management solution allow users to temporarily become local admins in emergency situations.
This helps ensure users are not permanent admins on the system, but can get those rights if, and only when, they complete a workflow that documents their use of those permissions.

