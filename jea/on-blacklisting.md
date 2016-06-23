---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  on blacklisting
ms.technology:  powershell
---

### On Blacklisting
After playing around with JEA, you may be wondering if it is possible to blacklist commands.
This is an understandable request, but it is not currently planned for JEA for the following reasons:

1.	We designed JEA to limit operators to only the actions they need to do.
A blacklist is the opposite.

2.	PowerShell command authors did not design PowerShell commands with the JEA in mind.
On a fresh install of Windows Server 2016, there are about 1520 commands immediately available.
The threat models for these commands did not include the possibility that a user would be running commands as a more privileged account.
For example, certain commands allow for code injection by design (e.g. Add-Type and Invoke-Command in the core PowerShell module).
JEA can warn you when you expose the specific commands we know about, but we have not re-assessed every other command in Windows based on the new threat model.
You must understand the capabilities of the commands you exposing through JEA.  

3.	Furthermore, even if JEA blocked all commands with code-injection vulnerabilities, there is no guarantee that a malicious user would not be able to carry out a blacklisted action with another related command.
Unless you understand all of the commands that you are exposing, it is impossible for you to guarantee that a certain action is not possible.
The burden is on you to understand what commands you are exposing, whether they are using a whitelist or a blacklist.
The number of commands a blacklist would expose is unmanageable, so JEA is implemented using whitelists instead.

