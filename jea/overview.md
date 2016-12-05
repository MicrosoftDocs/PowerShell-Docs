---
description:  
manager:  dongill
ms.topic:  article
author:  rpsqrd
ms.author:  ryanpu
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-12-05
title:  README
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

## Availability
JEA is a component of Windows PowerShell and comes preinstalled on Windows Server 2016 and Windows 10.
It is also available on older versions of Windows with the free [Windows Management Framework (WMF) 5](http://aka.ms/wmf) update.
The table below describes how you can obtain JEA for your system.

Operating System       | JEA Availability
-----------------------|-----------------
Windows Server 2016    | Preinstalled
Windows Server 2012 R2 | Full functionality with WMF 5.1
Windows Server 2012    | Full functionality with WMF 5.1
Windows Server 2008 R2 | Full functionality with WMF 5.1
Windows 10 Anniversary Update | Preinstalled
Windows 10 1603, 1511  | Preinstalled, with reduced functionality<sup>1</sup>
Windows 10 1507        | Not available
Windows 8, 8.1         | Full functionality with WMF 5.1
Windows 7              | Limited functionality<sup>2</sup> with WMF 5.1

<sup>1</sup> Windows 10 versions 1511 and 1603 do not support the following JEA features: running as a group managed service account, conditional access rules in session configurations, the user drive, and granting access to local user accounts.
To get support for these features, update Windows to version 1607 (Anniversary Update) or higher.

<sup>2</sup> JEA endpoints on Windows 7 do not support the use of temporary virtual accounts.
The connecting user must therefore be privileged to run the commands and access the resources used in the JEA session.
This often means giving the connecting user local admin privileges, which will grant the user the ability to manage the system outside of JEA's constraints.
Consult the [JEA security model](./jea-secure-practices.md) before using JEA on Windows 7.

## Getting started with JEA

1. Core Concepts
  1. [JEA endpoints](concepts-jea-endpoints.md)
  2. [Role Capabilities](concepts-role-capabilties.md)
  3. [Session Configurations](concepts-session-configurations.md)
  4. [Security model and best practices](concepts-security-model.md)

2. Deploying JEA
  1. Planning for a JEA deployment
  2. Authoring JEA roles
  3. Testing a JEA configuration
  4. Registering JEA endpoints on a single machine
  5. Registering JEA endpoints with DSC
  6. Publishing JEA roles to the PowerShell Gallery

3. Updating JEA endpoints
  1. Changing an existing role
  2. Adding, removing, or changing access to a role
  3. Removing a JEA endpoint

4. Reporting on JEA
  1. [Audit what users can do in a JEA endpoint](report-audit-access.md)
  2. Review transcripts from a JEA session
  3. Correlating application events with JEA sessions

5. End-to-end sample


## Start authoring your own JEA endpoints
It's easy to author a JEA endpoint -- all you need is a JEA-enabled system and a text editor (like PowerShell ISE).
One helpful tip to get started is to create skeleton files using [`New-PSRoleCapabilityFile -Path <path>`](https://technet.microsoft.com/library/mt631422.aspx) and [`New-PSSessionConfigurationFile -Path <Path>`](https://technet.microsoft.com/library/mt631422.aspx) without any other arguments.
These skeleton files contain all of the applicable configuration fields along with helpful comments to explain what each field can be used for.

To make authoring JEA endpoints even easier, check out the [JEA Toolkit Helper](http://blogs.technet.com/b/privatecloud/archive/2015/12/20/introducing-the-updated-jea-helper-tool.aspx) which provides a GUI with which you can author Session Configuration and Role Capability files.
It even supports generating Role Capabilities based on PowerShell logs to start you off with the commands your users regularly run to get their jobs done.

