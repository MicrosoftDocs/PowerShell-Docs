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
3. A command you run on _ServerB_ via your PowerShell Remoting session requires a resource on _ServerC_.
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
- PowerShell code .

