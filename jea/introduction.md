---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  introduction
ms.technology:  powershell
---

# Introduction

##  **Motivation**  
When you grant someone privileged access to your systems, you extend your trust boundary to that person.
This is a risk -- administrators are an attack surface.
Insider attacks and stolen credentials are both real and common.

##  **Not a new problem**  
You are probably very familiar with the principle of least privilege, and you might use some form of role based access control (RBAC) with applications that provide it.
However, the effectiveness and manageability of these solutions are often limited by their broad scope and imprecision.
Furthermore, there are gaps in RBAC coverage.
For example, in Windows, privileged access is largely a binary switch, forcing you to give unnecessary permissions when adding users to the Administrators group.

##  **Just Enough Administration -JEA-** 
Provides a role-based access control -RBAC- platform through PowerShell Remoting.
*It allows specific users to perform specific administrative tasks on servers without giving them administrator rights.*
This allows you to fill in the gaps between your existing RBAC solutions, and simplifies management of those settings.

