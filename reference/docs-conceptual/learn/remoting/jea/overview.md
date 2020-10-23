---
ms.date:  07/10/2019
keywords:  jea,powershell,security
title:  Overview of Just Enough Administration (JEA)
description: JEA is a security technology that enables delegated administration for anything managed by PowerShell.
---

# Just Enough Administration

Just Enough Administration (JEA) is a security technology that enables delegated administration for
anything managed by PowerShell. With JEA, you can:

- **Reduce the number of administrators on your machines** using virtual accounts or group-managed
  service accounts to perform privileged actions on behalf of regular users.
- **Limit what users can do** by specifying which cmdlets, functions, and external commands they can
  run.
- **Better understand what your users are doing** with transcripts and logs that show you exactly
  which commands a user executed during their session.

**Why is JEA important?**

Highly privileged accounts used to administer your servers pose a serious security risk. Should an
attacker compromise one of these accounts, they could launch [lateral attacks](https://aka.ms/pth)
across your organization. Each compromised account gives an attacker access to even more accounts
and resources, and puts them one step closer to stealing company secrets, launching a
denial-of-service attack, and more.

It's not always easy to remove administrative privileges, either. Consider the common scenario where
the DNS role is installed on the same machine as your Active Directory Domain Controller. Your DNS
administrators require local administrator privileges to fix issues with the DNS server. But to do
so, you must make them members of the highly privileged **Domain Admins** security group. This
approach effectively gives DNS Administrators control over your whole domain and access to all
resources on that machine.

JEA addresses this problem through the principle of **Least Privilege**. With JEA, you can configure
a management endpoint for DNS administrators that gives them access only to the PowerShell commands
they need to get their job done. This means you can provide the appropriate access to repair a
poisoned DNS cache or restart the DNS server without unintentionally giving them rights to Active
Directory, or to browse the file system, or run potentially dangerous scripts. Better yet, when the
JEA session is configured to use temporary privileged virtual accounts, your DNS administrators can
connect to the server using **non-admin** credentials and still run commands that typically require
admin privileges. JEA enables you to remove users from widely privileged local/domain administrator
roles and carefully control what they can do on each machine.

## Next steps

To learn more about the requirements to use JEA, see the [Prerequisites](prerequisites.md) article.

## Samples and DSC resource

Sample JEA configurations and the JEA DSC resource can be found in the
[JEA GitHub repository](https://github.com/PowerShell/JEA).
