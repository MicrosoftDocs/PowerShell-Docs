---
description:  
manager:  dongill
ms.topic:  article
author:  rpsqrd
ms.author:  ryanpu
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-12-05
title:  Overview of Just Enough Administration
ms.technology:  powershell
---

# Just Enough Administration

Just Enough Administration (JEA) is a security technology that enables delegated administration for anything that can be managed with PowerShell.
With JEA, you can:

- **Reduce the number of administrators on your machines** by leveraging virtual accounts that perform privileged actions on behalf of regular users.
- **Limit what users can do** by specifying which cmdlets, functions, and external commands they can run.
- **Better understand what your users are doing** with transcripts and logs that show you exactly which commands a user executed during their session.

**Why is this important?**

Highly privileged accounts used to administer your servers pose a serious security risk.
Should an attacker compromise one of these accounts, they could launch [lateral attacks](http://aka.ms/pth) across your organization.
Each account they compromise can give them access to even more accounts and resources, putting them one step closer to stealing company secrets, launching a denial-of-service attack, and more.

It is not always easy to remove administrative privileges, either.
Consider the common scenario where the DNS role is installed on the same machine as your Active Directory Domain Controller.
Your DNS administrators require local administrator privileges to fix issues with the DNS server, but in order to do so you have to make them members of the highly privileged "Domain Admins" security group.
This approach effectively gives DNS Administrators control over your whole domain and access to all resources on that machine.

JEA helps address this problem by helping you adopt the principle of *Least Privilege*.
With JEA, you can configure a management endpoint for DNS administrators that gives them access to all the PowerShell commands they need to get their job done, but nothing more.
This means you can provide the appropriate access to repair a poisoned DNS cache or restart the DNS server without unintentionally giving them rights to Active Directory, or to browse the file system, or run potentially dangerous scripts.
Better yet, when the JEA session is configured to use temporary privileged virtual accounts, your DNS administrators can connect to the server using *non-admin* credentials and still be able to run commands which typically require admin privileges.
This capability enables you to remove users from widely-privileged local/domain administrator roles and instead carefully control what they are able to do on each machine.

## Get Started with JEA

You can start using JEA today on any machine running Windows Server 2016 or Windows 10.
You can also run JEA on older operating systems with a Windows Management Framework update.
To learn more about the requirements to use JEA and to learn how to create, use, and audit a JEA endpoint, check out the following topics:

- [Prerequisites](prerequisites.md) - explains how to set up your environment to use JEA.
- [Role Capabilities](role-capabilities.md) - explains how to create roles which determine what a user is allowed to do in a JEA session.
- [Session Configurations](session-configurations.md) - explains how to configure JEA endpoints that map users to roles and set the JEA identity
- [Registering JEA](register-jea.md) - create a JEA endpoint and make it available for users to connect to.
- [Using JEA](using-jea.md) - learn the various ways you can use JEA.
- [Security Considerations](security-considerations.md) - review security best practices and implications of JEA configuration options.
- [Audit and Report on JEA](audit-and-report.md) - learn how to audit and report on JEA endpoints.