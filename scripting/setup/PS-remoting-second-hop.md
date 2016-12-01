---
title:  Making the second hop in PowerShell Remoting
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  eslesar
manager:  carmonmills
ms.prod:  powershell
---

# Making the second hop in PowerShell Remoting

The "second hop problem" refers to a situation like the following:

1. You are logged in to _ServerA_.
2. From _ServerA_, you start a remote PowerShell session to connect to _ServerB_.
3. A command you run on _ServerB_ via your PowerShell Remoting session attempts to access a resource on _ServerC_.
4. Access to the resource on _ServerC_ is denied, because the credentials you used to create the PowerShell Remoting session are not passed from _ServerB_ to _ServerC_.

There are several ways to address this problem. In this topic, we'll look at several of the most popular solutions to the second hop problem.

## Resource-based Kerberos constrained delegation

Using resource-based Kerberos constrained delegation (introduced in Windows Server 2012), you configure credential delegation on the server object where resources reside.
In the second hop scenario described above, you configure _ServerC_ to specify from where it will accept delegated credentials. 

### Pros

- Credentials are not stored.
- Relatively easy to configure by using PowerShell cmdlets--no special coding required.
- No special domain access is required.
- Works across domains and forests.
- PowerShell code.

### Cons

- Requires Windows Server 2012 or later.

### Example

Let's look at a PowerShell example that configures resource based constrained delegation on _ServerC_ to allow delegated credentials from a _ServerB_.
This example assumes that all servers are running Windows Server 2012 or later, and that there is at least one Windows Server 2012 domain controller each domain to which 
any of the servers belong.

Before you can configure constrained delegation, you must add the `RSAT-AD-PowerShell` feature to install the Active Directory PowerShell module, and then import that 
module into your session:

```powershell
PS C:\> Add-WindowsFeature RSAT-AD-PowerShell

PS C:\> Import-Module ActiveDirector
```
Several available cmdlets now have a **PrincipalsAllowedToDelegateToAccount** parameter:

```powershell
PS C:\> Get-Command -ParameterName PrincipalsAllowedToDelegateToAccount

CommandType Name                 ModuleName     
----------- ----                 ----------     
Cmdlet      New-ADComputer       ActiveDirectory
Cmdlet      New-ADServiceAccount ActiveDirectory
Cmdlet      New-ADUser           ActiveDirectory
Cmdlet      Set-ADComputer       ActiveDirectory
Cmdlet      Set-ADServiceAccount ActiveDirectory
Cmdlet      Set-ADUser           ActiveDirectory
```

This parameter sets the Active Directory object attribute **msDS-AllowedToActOnBehalfOfOtherIdentity**, which contains an access control list (ACL) that specifies which
accounts have permission to delegate credentials to the associated account (in our example, it will be the machine account for _Server_).



 
