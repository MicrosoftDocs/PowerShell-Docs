---
ms.date: 05/14/2020
keywords:  powershell,cmdlet
title:  Making the second hop in PowerShell Remoting
description: This article explains the various methods for configuring second-hop authentication for PowerShell remoting, including the security implications and recommendations.
---

# Making the second hop in PowerShell Remoting

The "second hop problem" refers to a situation like the following:

1. You are logged in to _ServerA_.
2. From _ServerA_, you start a remote PowerShell session to connect to _ServerB_.
3. A command you run on _ServerB_ via your PowerShell Remoting session attempts to access a resource
   on _ServerC_.
4. Access to the resource on _ServerC_ is denied, because the credentials you used to create the
   PowerShell Remoting session are not passed from _ServerB_ to _ServerC_.

There are several ways to address this problem. The following table lists the methods in order of
preference.

|                      Configuration                       |                                  Note                                  |
| -------------------------------------------------------- | ---------------------------------------------------------------------- |
| CredSSP                                                  | Balances ease of use and security                                      |
| Resource-based Kerberos constrained delegation           | Higher security with simpler configuration                             |
| Kerberos constrained delegation                          | High security but requires Domain Administrator                         |
| Kerberos delegation (unconstrained)                      | Not recommended                                                        |
| Just Enough Administration (JEA)                         | Can provide the best security but requires more detailed configuration |
| PSSessionConfiguration using RunAs                       | Simpler to configure but requires credential management                |
| Pass credentials inside an `Invoke-Command` script block | Simplest to use but you must provide credentials                       |

## CredSSP

You can use the [Credential Security Support Provider (CredSSP)][credssp] for authentication.
CredSSP caches credentials on the remote server (_ServerB_), so using it opens you up to credential
theft attacks. If the remote computer is compromised, the attacker has access to the user's
credentials. CredSSP is disabled by default on both client and server computers. You should enable
CredSSP only in the most trusted environments. For example, a domain administrator connecting to a
domain controller because the domain controller is highly trusted.

For more information about security concerns when using CredSSP for PowerShell Remoting, see
[Accidental Sabotage: Beware of CredSSP][beware].

For more information about credential theft attacks, see
[Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft][pth].

For an example of how to enable and use CredSSP for PowerShell remoting, see
[Enable PowerShell "Second-Hop" Functionality with CredSSP][credssp-psblog].

**Pros**

- It works for all servers with Windows Server 2008 or later.

**Cons**

- Has security vulnerabilities.
- Requires configuration of both client and server roles.
- Does not work with the Protected Users group. For more information, see
  [Protected Users Security Group][protected-users].

## Kerberos constrained delegation

You can use legacy constrained delegation (not resource-based) to make the second hop. Configure
Kerberos constrained delegation with the option "Use any authentication protocol" to allow protocol
transition.

**Pros**

- Requires no special coding
- Credentials are not stored.

**Cons**

- Does not support the second hop for WinRM.
- Requires Domain Administrator access to configure.
- Must be configured on the Active Directory object of the remote server (_ServerB_).
- Limited to one domain. Cannot cross domains or forests.
- Requires rights to update objects and Service Principal Names (SPNs).
- _ServerB_ can acquire a Kerberos ticket to _ServerC_ on behalf of the user without user
  intervention.

> [!NOTE]
> Active Directory accounts that have the **Account is sensitive and cannot be delegated** property
> set cannot be delegated. For more information, see
> [Security Focus: Analysing 'Account is sensitive and cannot be delegated' for Privileged Accounts][blog]
> and [Kerberos Authentication Tools and Settings][ktools].

## Resource-based Kerberos constrained delegation

Using resource-based Kerberos constrained delegation (introduced in Windows Server 2012), you
configure credential delegation on the server object where resources reside. In the second hop
scenario described above, you configure _ServerC_ to specify from where it accepts delegated
credentials.

**Pros**

- Credentials are not stored.
- Configured using PowerShell cmdlets. No special coding required.
- Does not require Domain Administrator access to configure.
- Works across domains and forests.

**Cons**

- Requires Windows Server 2012 or later.
- Does not support the second hop for WinRM.
- Requires rights to update objects and Service Principal Names (SPNs).

> [!NOTE]
> Active Directory accounts that have the **Account is sensitive and cannot be delegated** property
> set cannot be delegated. For more information, see
> [Security Focus: Analysing 'Account is sensitive and cannot be delegated' for Privileged Accounts][blog]
> and [Kerberos Authentication Tools and Settings][ktools].

### Example

Let's look at a PowerShell example that configures resource-based constrained delegation on
_ServerC_ to allow delegated credentials from a _ServerB_. This example assumes that all servers are
running Windows Server 2012 or later, and that there is at least one Windows Server 2012 domain
controller each domain to which any of the servers belong.

Before you can configure constrained delegation, you must add the `RSAT-AD-PowerShell` feature to
install the Active Directory PowerShell module, and then import that module into your session:

```powershell
Add-WindowsFeature RSAT-AD-PowerShell
Import-Module ActiveDirectory
Get-Command -ParameterName PrincipalsAllowedToDelegateToAccount
```

Several available cmdlets now have a **PrincipalsAllowedToDelegateToAccount** parameter:

```Output
CommandType Name                 ModuleName
----------- ----                 ----------
Cmdlet      New-ADComputer       ActiveDirectory
Cmdlet      New-ADServiceAccount ActiveDirectory
Cmdlet      New-ADUser           ActiveDirectory
Cmdlet      Set-ADComputer       ActiveDirectory
Cmdlet      Set-ADServiceAccount ActiveDirectory
Cmdlet      Set-ADUser           ActiveDirectory
```

The **PrincipalsAllowedToDelegateToAccount** parameter sets the Active Directory object attribute
**msDS-AllowedToActOnBehalfOfOtherIdentity**, which contains an access control list (ACL) that
specifies which accounts have permission to delegate credentials to the associated account (in our
example, it will be the machine account for _ServerA_).

Now let's set up the variables we'll use to represent the servers:

```powershell
# Set up variables for reuse
$ServerA = $env:COMPUTERNAME
$ServerB = Get-ADComputer -Identity ServerB
$ServerC = Get-ADComputer -Identity ServerC
```

WinRM (and therefore PowerShell remoting) runs as the computer account by default. You can see this
by looking at the **StartName** property of the `winrm` service:

```powershell
Get-CimInstance Win32_Service -Filter 'Name="winrm"' | Select-Object StartName
```

```Output
StartName
---------
NT AUTHORITY\NetworkService
```

For _ServerC_ to allow delegation from a PowerShell remoting session on _ServerB_, we must set the
**PrincipalsAllowedToDelegateToAccount** parameter on _ServerC_ to the computer object of _ServerB_:

```powershell
# Grant resource-based Kerberos constrained delegation
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $ServerB

# Check the value of the attribute directly
$x = Get-ADComputer -Identity $ServerC -Properties msDS-AllowedToActOnBehalfOfOtherIdentity
$x.'msDS-AllowedToActOnBehalfOfOtherIdentity'.Access

# Check the value of the attribute indirectly
Get-ADComputer -Identity $ServerC -Properties PrincipalsAllowedToDelegateToAccount
```

The Kerberos [Key Distribution Center (KDC)](/windows/win32/secauthn/key-distribution-center) caches
denied-access attempts (negative cache) for 15 minutes. If _ServerB_ has previously attempted to
access _ServerC_, you will need to clear the cache on _ServerB_ by invoking the following command:

```powershell
Invoke-Command -ComputerName $ServerB.Name -Credential $cred -ScriptBlock {
    klist purge -li 0x3e7
}
```

You could also restart the computer, or wait at least 15 minutes to clear the cache.

After clearing the cache, you can successfully run code from _ServerA_ through _ServerB_ to
_ServerC_:

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

In this example, the `$using` variable is used to make the `$ServerC` variable visible to _ServerB_.
For more information about the `$using` variable, see
[about_Remote_Variables](/powershell/module/Microsoft.PowerShell.Core/About/about_Remote_Variables).

To allow multiple servers to delegate credentials to _ServerC_, set the value of the
**PrincipalsAllowedToDelegateToAccount** parameter on _ServerC_ to an array:

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

If you want to make the second hop across domains, add fully-qualified domain name (FQDN) of the
domain controller of the domain to which _ServerB_ belongs:

```powershell
# For ServerC in Contoso domain and ServerB in other domain
$ServerB = Get-ADComputer -Identity ServerB -Server dc1.alpineskihouse.com
$ServerC = Get-ADComputer -Identity ServerC
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $ServerB
```

To remove the ability to delegate credentials to ServerC, set the value of the
**PrincipalsAllowedToDelegateToAccount** parameter on _ServerC_ to `$null`:

```powershell
Set-ADComputer -Identity $ServerC -PrincipalsAllowedToDelegateToAccount $null
```

### Information on resource-based Kerberos constrained delegation

- [What's New in Kerberos Authentication][whats-new]
- [How Windows Server 2012 Eases the Pain of Kerberos Constrained Delegation, Part 1][kcd2012-1]
- [How Windows Server 2012 Eases the Pain of Kerberos Constrained Delegation, Part 2][kcd2012-2]
- [Understanding Kerberos Constrained Delegation for Azure Active Directory Application Proxy Deployments with Integrated Windows Authentication][kcdpaper]
- [[MS-ADA2] Active Directory Schema Attributes M2.210 Attribute msDS-AllowedToActOnBehalfOfOtherIdentity][MS-ADA2]
- [[MS-SFU] Kerberos Protocol Extensions: Service for User and Constrained Delegation Protocol 1.3.2 S4U2proxy][MS-SFU]
- [Remote Administration Without Constrained Delegation Using PrincipalsAllowedToDelegateToAccount][remote-admin]

## Kerberos delegation (unconstrained)

You can also used Kerberos unconstrained delegation to make the second hop. Like all Kerberos
scenarios, credentials are not stored. This method does not support the second hop for WinRM.

> [!WARNING]
> This method provides no control of where delegated credentials are used. It is less secure than
> CredSSP. This method should only be used for testing scenarios.

## Just Enough Administration (JEA)

JEA allows you to restrict what commands an administrator can run during a PowerShell session. It
can be used to solve the second hop problem.

For information about JEA, see [Just Enough Administration](/powershell/scripting/learn/remoting/jea/overview).

**Pros**

- No password maintenance when using a virtual account.

**Cons**

- Requires WMF 5.0 or later.
- Requires configuration on every intermediate server (_ServerB_).

## PSSessionConfiguration using RunAs

You can create a session configuration on _ServerB_ and set its **RunAsCredential** parameter.

For information about using **PSSessionConfiguration** and **RunAs** to solve the second hop
problem, see [Another solution to multi-hop PowerShell remoting][pssessionconfig].

**Pros**

- Works with any server with WMF 3.0 or later.

**Cons**

- Requires configuration of **PSSessionConfiguration** and **RunAs** on every intermediate server
  (_ServerB_).
- Requires password maintenance when using a domain **RunAs** account

## Pass credentials inside an Invoke-Command script block

You can pass credentials inside the **ScriptBlock** parameter of a call to the
[Invoke-Command](/powershell/module/microsoft.powershell.core/invoke-command) cmdlet.

**Pros**

- Does not require special server configuration.
- Works on any server running WMF 2.0 or later.

**Cons**

- Requires an awkward code technique.
- If running WMF 2.0, requires different syntax for passing arguments to a remote session.

### Example

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

<!-- link references -->
[blog]: /archive/blogs/poshchap/security-focus-analysing-account-is-sensitive-and-cannot-be-delegated-for-privileged-accounts
[ktools]: /previous-versions/windows/it-pro/windows-server-2003/cc738673(v=ws.10)
[credssp]: /windows/win32/secauthn/credential-security-support-provider
[beware]: https://www.powershellmagazine.com/2014/03/06/accidental-sabotage-beware-of-credssp
[pth]: https://www.microsoft.com/download/details.aspx?id=36036
[credssp-psblog]: https://devblogs.microsoft.com/scripting/enable-powershell-second-hop-functionality-with-credssp/
[whats-new]: /previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831747(v=ws.11)
[kcd2012-1]: https://www.itprotoday.com/windows-server/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-1
[kcd2012-2]: https://www.itprotoday.com/windows-server/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-2
[kcdpaper]: https://aka.ms/kcdpaper
[MS-ADA2]: /openspecs/windows_protocols/ms-ada2/cea4ac11-a4b2-4f2d-84cc-aebb4a4ad405
[MS-SFU]: /openspecs/windows_protocols/ms-sfu/bde93b0e-f3c9-4ddf-9f44-e1453be7af5a
[remote-admin]: /archive/blogs/taylorb/remote-administration-without-constrained-delegation-using-principalsallowedtodelegatetoaccount
[pssessionconfig]: /archive/blogs/sergey_babkins_blog/another-solution-to-multi-hop-powershell-remoting
[protected-users]: /windows-server/security/credentials-protection-and-management/protected-users-security-group
