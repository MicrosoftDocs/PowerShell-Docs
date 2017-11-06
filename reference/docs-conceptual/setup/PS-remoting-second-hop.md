---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Making the second hop in PowerShell Remoting
---

# Making the second hop in PowerShell Remoting

The "second hop problem" refers to a situation like the following:

1. You are logged in to _ServerA_.
2. From _ServerA_, you start a remote PowerShell session to connect to _ServerB_.
3. A command you run on _ServerB_ via your PowerShell Remoting session attempts to access a resource on _ServerC_.
4. Access to the resource on _ServerC_ is denied, because the credentials you used to create the PowerShell Remoting session are not passed from _ServerB_ to _ServerC_.

There are several ways to address this problem. In this topic, we'll look at several of the most popular solutions to the second hop problem.

## CredSSP

You can use the [Credential Security Support Provider (CredSSP)](https://msdn.microsoft.com/en-us/library/windows/desktop/bb931352.aspx) for authentication. CredSSP caches credentials 
on the remote server (_ServerB_), so using it opens you up to credential theft attacks. If the remote computer is compromised, the attacker has access to the user's credentials. CredSSP is disabled by 
default on both client and server computers. You should enable CredSSP only in the most trusted environments. For example, a domain administrator connecting to a domain controller 
because the domain controller is highly trusted.

For more information about security concerns when using CredSSP for PowerShell Remoting, see 
[Accidental Sabotage: Beware of CredSSP](http://www.powershellmagazine.com/2014/03/06/accidental-sabotage-beware-of-credssp).

For more information about credential theft attacks, see [Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft](https://www.microsoft.com/en-us/download/details.aspx?id=36036).

For an example of how to enable and use CredSSP for PowerShell remoting, see 
[Using CredSSP to solve the second-hop problem](https://blogs.technet.microsoft.com/heyscriptingguy/2012/11/14/enable-powershell-second-hop-functionality-with-credssp/).

### Pros

- It works for all servers with Windows Server 2008 or later.

### Cons

- Has security vulnerabilities.
- Requires configuration of both client and server roles.

## Kerberos delegation (unconstrained)

You can also used Kerberos unconstrained delegation to make the second hop. However, this method provides no control of where delegated credentials are used.

>**Note:** Active Directory accounts that have the **Account is sensitive and cannot be delegated** property set cannot be delegated. For more information, see 
>[Security Focus: Analysing 'Account is sensitive and cannot be delegated' for Privileged Accounts](https://blogs.technet.microsoft.com/poshchap/2015/05/01/security-focus-analysing-account-is-sensitive-and-cannot-be-delegated-for-privileged-accounts/)
>and [Kerberos Authentication Tools and Settings](https://technet.microsoft.com/library/cc738673(v=ws.10).aspx)

### Pros

- Requires no special coding.

### Cons

- Does not support the second hop for WinRM.
- Provides no control over where credentials are used, creating a security vulnerability.

## Kerberos constrained delegation

You can use legacy constrained delegation (not resource-based) to make the second hop. 

>**Note:** Active Directory accounts that have the **Account is sensitive and cannot be delegated** property set cannot be delegated. For more information, see 
>[Security Focus: Analysing 'Account is sensitive and cannot be delegated' for Privileged Accounts](https://blogs.technet.microsoft.com/poshchap/2015/05/01/security-focus-analysing-account-is-sensitive-and-cannot-be-delegated-for-privileged-accounts/)
>and [Kerberos Authentication Tools and Settings](https://technet.microsoft.com/library/cc738673(v=ws.10).aspx)

### Pros

- Requires no special coding

### Cons

- Does not support the second hop for WinRM.
- Must be configured on the Active Directory object of the remote server (_ServerB_).
- Limited to one domain. Cannot cross domains or forests.
- Requires rights to update objects and Service Principal Names (SPNs).

## Resource-based Kerberos constrained delegation

Using resource-based Kerberos constrained delegation (introduced in Windows Server 2012), you configure credential delegation on the server object where resources reside.
In the second hop scenario described above, you configure _ServerC_ to specify from where it will accept delegated credentials.

>**Note:** Active Directory accounts that have the **Account is sensitive and cannot be delegated** property set cannot be delegated. For more information, see 
>[Security Focus: Analysing 'Account is sensitive and cannot be delegated' for Privileged Accounts](https://blogs.technet.microsoft.com/poshchap/2015/05/01/security-focus-analysing-account-is-sensitive-and-cannot-be-delegated-for-privileged-accounts/)
>and [Kerberos Authentication Tools and Settings](https://technet.microsoft.com/library/cc738673(v=ws.10).aspx)

### Pros

- Credentials are not stored.
- Relatively easy to configure by using PowerShell cmdlets--no special coding required.
- No special domain access is required.
- Works across domains and forests.
- PowerShell code.

### Cons

- Requires Windows Server 2012 or later.
- Does not support the second hop for WinRM.
- Requires rights to update objects and Service Principal Names (SPNs). 

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

The **PrincipalsAllowedToDelegateToAccount** parameter sets the Active Directory object attribute **msDS-AllowedToActOnBehalfOfOtherIdentity**, which contains an access control list (ACL) 
that specifies which accounts have permission to delegate credentials to the associated account (in our example, it will be the machine account for _Server_).

Now let's set up the variables we'll use to represent the servers:

```powershell
# Set up variables for reuse            
$ServerA = $env:COMPUTERNAME            
$ServerB = Get-ADComputer -Identity ServerB            
$ServerC = Get-ADComputer -Identity ServerC            
```

WinRM (and therefore PowerShell remoting) runs as the computer account by default. You can see this by looking at the **StartName** property of the `winrm` service:

```powershell
PS C:\> Get-WmiObject win32_service -filter 'name="winrm"' | Format-List StartName

StartName : NT AUTHORITY\NetworkService
```

For _ServerC_ to allow delegation from a PowerShell remoting session on _ServerB_, we will grant access by setting the **PrincipalsAllowedToDelegateToAccount** parameter
on _ServerC_ to the computer object of _ServerB_:

```powershell
# Grant resource-based Kerberos constrained delegation            
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $ServerB            
            
# Check the value of the attribute directly            
$x = Get-ADComputer -Identity $ServerC -Properties msDS-AllowedToActOnBehalfOfOtherIdentity            
$x.'msDS-AllowedToActOnBehalfOfOtherIdentity'.Access            
            
# Check the value of the attribute indirectly            
Get-ADComputer -Identity $ServerC -Properties PrincipalsAllowedToDelegateToAccount
```

The Kerberos [Key Distribution Center (KDC)](https://msdn.microsoft.com/library/windows/desktop/aa378170(v=vs.85).aspx) caches denied access attempts (negative cache) for 15
minutes. If _ServerB_ has previously attempted to access _ServerC_, you will need to clear the cache on _ServerB_ by invoking the following command:

```powershell
Invoke-Command -ComputerName $ServerB.Name -Credential $cred -ScriptBlock {            
    klist purge -li 0x3e7            
}
```

You could also restart the computer, or wait at least 15 minutes to clear the cache.

After clearing the cache, you can successfully run code from _ServerA_ through _ServerB_ to _ServerC_:

```powershell
# Capture a credential            
$cred = Get-Credential Contoso\Alice            
            
# Test kerberos double hop            
Invoke-Command -ComputerName $ServerB.Name -Credential $cred -ScriptBlock {            
    Test-Path \\$($using:ServerC.Name)\C$            
    Get-Process lsass -ComputerName $($using:ServerC.Name)            
    Get-EventLog -LogName System -Newest 3 -ComputerName $($using:ServerC.Name)            
}
```

In this example, the `$using` variable is used to make the `$ServerC` variable visible to _ServerB_. For more information about the `$using` variable, see
[about_Remote_Variables](https://technet.microsoft.com/en-us/library/jj149005.aspx).

To allow multiple servers to delegate credentials to _ServerC_, set the value of the **PrincipalsAllowedToDelegateToAccount** parameter on _ServerC_ to an array:

```powershell
# Set up variables for each server            
$ServerB1 = Get-ADComputer -Identity ServerB1            
$ServerB2 = Get-ADComputer -Identity ServerB2            
$ServerB3 = Get-ADComputer -Identity ServerB3            
$ServerC  = Get-ADComputer -Identity ServerC            
            
# Grant resource-based Kerberos constrained delegation            
Set-ADComputer -Identity $ServerC `
    -PrincipalsAllowedToDelegateToAccount @($ServerB1,$ServerB2,$ServerB3)
```

If you want to make the second hop across domains, add fully-qualified domain name (FQDN) of the domain controller of the domain to which _ServerB_ belongs:

```powershell
# For ServerC in Contoso domain and ServerB in other domain            
$ServerB = Get-ADComputer -Identity ServerB -Server dc1.alpineskihouse.com            
$ServerC = Get-ADComputer -Identity ServerC            
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $ServerB
```

To remove the ability to delegate credentials to ServerC, set the value of the **PrincipalsAllowedToDelegateToAccount** parameter on _ServerC_ to `$null`:

```powershell
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $null
```

### Information on resource-based Kerberos constrained delegation

- [What's New in Kerberos Authentication](https://technet.microsoft.com/library/hh831747.aspx)
- [How Windows Server 2012 Eases the Pain of Kerberos Constrained Delegation, Part 1](http://windowsitpro.com/security/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-1)
- [How Windows Server 2012 Eases the Pain of Kerberos Constrained Delegation, Part 2](http://windowsitpro.com/security/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-2)
- [Understanding Kerberos Constrained Delegation for Azure Active Directory Application Proxy Deployments with Integrated Windows Authentication](http://aka.ms/kcdpaper)
- [[MS-ADA2]: Active Directory Schema Attributes M2.210 Attribute msDS-AllowedToActOnBehalfOfOtherIdentity](https://msdn.microsoft.com/en-us/library/hh554126.aspx)
- [[MS-SFU]: Kerberos Protocol Extensions: Service for User and Constrained Delegation Protocol 1.3.2 S4U2proxy](https://msdn.microsoft.com/en-us/library/cc246079.aspx)
- [Resource Based Kerberos Constrained Delegation](https://blog.kloud.com.au/2013/07/11/kerberos-constrained-delegation/)
- [Remote Administration Without Constrained Delegation Using PrincipalsAllowedToDelegateToAccount](https://blogs.msdn.microsoft.com/taylorb/2012/11/06/remote-administration-without-constrained-delegation-using-principalsallowedtodelegatetoaccount/)

## PSSessionConfiguration using RunAs

You can create a session configuration on _ServerB_ and set its **RunAsCredential** parameter.

For information about using PSSessionConfiguration and RunAs to solve the second hop problem, see 
[Another solution to multi-hop PowerShell remoting](https://blogs.msdn.microsoft.com/sergey_babkins_blog/2015/03/18/another-solution-to-multi-hop-powershell-remoting/).

### Pros

- Works with any server with WMF 3.0 or later.

### Cons

- Requires configuration of **PSSessionConfiguration** and **RunAs** on every intermediate server (_ServerB_).
- Requires password maintenance when using a domain **RunAs** account

## Just Enough Administration (JEA)

JEA allows you to restrict what commands an administrator can run during a PowerShell session. It can be used to solve the second hop problem.

For information about JEA, see [Just Enough Administration](https://docs.microsoft.com/en-us/powershell/jea/overview).

### Pros

- No password maintenance when using a virtual account.

### Cons

- Requires WMF 5.0 or later.
- Requires configuration on every intermediate server (_ServerB_).

## Pass credentials inside an Invoke-Command script block

You can pass credentials inside the **ScriptBlock** parameter of a call to the 
[Invoke-Command](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/invoke-command) cmdlet.

### Pros

- Does not require special server configuration.
- Works on any server running WMF 2.0 or later.

## Cons

- Requires an awkward code technique.
- If running WMF 2.0, requires different syntax for passing arguments to a remote session.

## Example

The following example shows how to pass credentials in an **Invoke-Command** script block:

```powershell
# This works without delegation, passing fresh creds            
# Note $Using:Cred in nested request            
$cred = Get-Credential Contoso\Administrator            
Invoke-Command -ComputerName ServerB -Credential $cred -ScriptBlock {            
    hostname            
    Invoke-Command -ComputerName ServerC -Credential $Using:cred -ScriptBlock {hostname}            
}
```

## See also

[PowerShell Remoting Security Considerations](WinRMSecurity.md)








 
