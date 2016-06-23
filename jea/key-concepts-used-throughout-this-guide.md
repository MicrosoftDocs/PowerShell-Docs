---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  key concepts used throughout this guide
ms.technology:  powershell
---

# Key Concepts Used Throughout This Guide
**What exactly is JEA?**

JEA is an extension of PowerShell [constrained endpoints](http://blogs.technet.com/b/heyscriptingguy/archive/2014/03/31/introduction-to-powershell-endpoints.aspx) that adds in role definitions, virtual accounts, and several other improvements to make it even easier to lock down your management endpoints.
A JEA endpoint consists of a PowerShell Session Configuration file and one or more Role Capability files.

**What are Session Configuration and Role Capability files?**

PowerShell Session Configuration files (.pssc) define *who* can connect to a PowerShell endpoint and *how* it is configured.
This is where you would map users and security groups to specific management roles and configure global settings like virtual accounts and transcription policies.
Session configuration files are specific to each machine, which allows you to control access on a per-machine basis if desired.

PowerShell Role Capability files (.psrc) define *what* users belonging to a role are able to do on the system.
Here, you can restrict which cmdlets, functions, providers, and external programs a user may use in their JEA session.
Role Capability files are often generic for the role being served (DNS admin, level 1 helpdesk, read-only inventory auditing, etc.) and belong to PowerShell modules, making it easy to share them across your environment and with others.

**How does JEA leverage virtual accounts?**

In the PowerShell Session Configuration file, you can configure JEA sessions to use virtual "run as" accounts.
Virtual accounts are one-time privileged accounts spun up for the specific connecting user in that specific session under which context the user's commands are executed.
Virtual accounts belong to the local "Administrators" security group by default, but can optionally be configured to only belong to security groups you specify.

**PowerShell Remoting**:
PowerShell remoting allows you to run PowerShell commands against remote machines.
You can operate against one or many computers, and use either temporary or persistent connections.
In this demo, you remoted into your local machine with an interactive session.
JEA restricts the functionality available through PowerShell remoting.
For more information about PowerShell remoting, run `Get-Help about_Remote`.

**"RunAs" User**:
When using JEA, a non-administrator "runs as" a privileged "Virtual Account."
The Virtual Account only lasts the duration of the remote session.
That is to say, it is created when a user connects to the endpoint, and destroyed when the user ends the session.
By default, the Virtual Account is a member of the local Administrators group.
On a domain controller, it is a member of Domain Admins.
Virtual Accounts are local to the machine on which they are created, and do not have permissions outside of that machine.
This means that they are not registered in Active Directory (no RID is assigned).
Additionally, if an allowed command/script tries to access resources outside of the local machine, it will be accessing those resources under the machine's identity, not the Virtual Account identity.

**"Connected" User**:
The non-administrator user who connects to the JEA endpoint and to whom roles are assigned.
Any commands this user runs are run under the context of the RunAs User or virtual account.

