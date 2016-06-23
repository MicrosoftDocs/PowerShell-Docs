---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  common role capability pitfalls
ms.technology:  powershell
---

### Common Role Capability Pitfalls
You may run into a few common pitfalls into you go through this process yourself.
Here is a quick guide explaining how to identify and remediate these issues when modifying or creating a new endpoint:

#### Functions vs. Cmdlets
PowerShell commands written in PowerShell are PowerShell Functions.
PowerShell commands written as specialized .NET classes are PowerShell Cmdlets.
You can check the command type by running `Get-Command`.

#### VisibleProviders
You will need to expose any providers your commands need.
The most common is the FileSystem provider, but you may also need to expose others, like the Registry provider.
For an introduction to providers, check out this [Hey, Scripting Guy blog post](http://blogs.technet.com/b/heyscriptingguy/archive/2015/04/20/find-and-use-windows-powershell-providers.aspx).
Be careful when exposing providers -- often, it is better to define your own function that works with the underlying providers than to directly expose the provider in a JEA session.
This way, you can still allow users to work with files, registry keys, etc. but retain control over **which** files and registry keys they can work with using custom validation logic.

