---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  README
ms.technology:  powershell
---

# Just Enough Administration
Just Enough Administration (JEA) is a security technology that enables delegated administration for anything that can be managed with PowerShell.
With JEA, you can:
- **Reduce the number of administrators on your machines** by leveraging virtual accounts that perform privileged actions on behalf of regular users.
- **Limit what users can do** by specifying which cmdlets, functions, and external commands they can run.
- **Better understand what your users are doing** with "over the shoulder" transcriptions that show you exactly what commands a user executed during a session.

**Why is this important?**  
Consider the common scenario where your DNS servers are co-located with your Active Directory Domain Controllers.
Your DNS administrators need to have local administrator privileges to fix issues with the DNS server, but in order to do so you have to make them members of the highly privileged "Domain Admins" security group.
This approach effectively gives DNS Administrators control over your whole domain and access to all resources on that machine.

With JEA in place, you can configure a role for your DNS administrators that gives them access to all the commands they need to get their job done, but nothing more.
This means you can provide the appropriate access to repair a poisoned DNS cache without unintentionally giving them rights to Active Directory, or to browse the file system, or run potentially dangerous scripts.
Better yet, when the JEA session is configured to use one-time privileged virtual accounts, your DNS adminstrators can connect to the server using *unprivileged* credentials and still be able to run privileged commands.

## Availability
JEA is being developed in parallel to Windows Server 2016, and is available on older versions of Windows through Windows Management Framework updates.
The current release of JEA is available on the following platforms:

**Windows Server**
- Windows Server 2016 Technical Preview 4 and higher
- Windows Server 2012 R2, 2012, and 2008 R2\* with [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed

**Windows Client**
- Windows 10 with the November Update (1511) installed
- Windows 8.1, 8, and 7\* with [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed

\* Support for virtual accounts in JEA sessions is currently not available on Windows Server 2008 R2 or Windows 7.


## Explore the experience guide
Ready to learn how to author, deploy, and use your own JEA endpoint?

This guide gets you started quickly with a pre-built JEA endpoint to get an idea of what the end-user experience is like, then walks you through recreating an endpoint from scratch to help demonstrate concepts like session configurations and Role Capabilities.

1.	[Introduction](introduction.md)   
Briefly review why you should care about JEA

2.	[Prerequisites](prerequisites.md)  
Explains how to Set up your environment

3.	[Using JEA](using-jea.md)  
Helps you start by understanding the operator experience of using JEA

4.	[Remake the Demo](remake-the-demo-endpoint.md)  
Create a JEA Session Configuration from scratch

5.	[Role Capabilities](role-capabilities.md)  
Learn about how to customize JEA capabilities with Role Capability Files

6.	[End to End - Active Directory](end-to-end---active-directory.md)  
Make a whole new endpoint for managing Active Directory

7.	[Multi-machine Deployment and Maintenance](multi-machine-deployment-and-maintenance.md)  
Discover how deployment and authoring changes with scale

8.	[Reporting on JEA](reporting-on-jea.md)  
Discover how to audit and report on all JEA actions and infrastructure

9.	Appendixes
  - [Key Concepts Used Throughout This Guide](key-concepts-used-throughout-this-guide.md)  
  -  [Creating a Domain Controller](creating-a-domain-controller.md)  
  -  [On Blacklisting](on-blacklisting.md)  
  -  [Considerations When Limiting Commands](considerations-when-limiting-commands.md)  
  -  [Common Role Capability Pitfalls](common-role-capability-pitfalls.md)

## Start authoring your own JEA endpoints
It's easy to author a JEA endpoint -- all you need is a JEA-enabled system and a text editor (like PowerShell ISE).
One helpful tip to get started is to create skeleton files using `New-PSRoleCapabilityFile -Path <path>` and `New-PSSessionCapabilityFile -Path <Path>` without any other arguments.
These skeleton files contain all of the applicable configuration fields along with helpful comments to explain what each field can be used for.

To make authoring JEA endpoints even easier, check out the [JEA Toolkit Helper](http://blogs.technet.com/b/privatecloud/archive/2015/12/20/introducing-the-updated-jea-helper-tool.aspx) which provides a GUI with which you can author Session Configuration and Role Capability files.
It even supports generating Role Capabilities based on PowerShell logs to start you off with the commands your users regularly run to get their jobs done.

