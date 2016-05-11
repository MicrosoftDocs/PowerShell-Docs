---
title:  About Windows PowerShell
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  979654ae-7994-47f8-be43-d79e7a140143
---

# About Windows PowerShell
Windows PowerShell is designed to improve the command\-line and scripting environment by eliminating long\-standing problems and adding new features.

## Discoverability
Windows PowerShell makes it easy to discover its features. For example, to find a list of cmdlets that view and change Windows services, type:

```
Get-Command *-Service
```

After discovering which cmdlet accomplishes a task, you can learn more about the cmdlet by using the Get\-Help cmdlet. For example, to display help about the Get\-Service cmdlet, type:

```
Get-Help Get-Service
```
Most cmdlets emit objects which can be manipulated and then rendered into text for display. To fully understand the output of that cmdlet, pipe its output to the Get\-Member cmdlet. For example, the following command displays information about the members of the object output by the Get\-Service cmdlet.

```
Get-Service | Get-Member
```

## Consistency
Managing systems can be a complex endeavor and tools that have a consistent interface help to control the inherent complexity. Unfortunately, neither command\-line tools nor scriptable COM objects have been known for their consistency.

The consistency of Windows PowerShell is one of its primary assets. For example, if you learn how to use the Sort\-Object cmdlet, you can use that knowledge to sort the output of any cmdlet. You do not have to learn the different sorting routines of each cmdlet.

In addition, cmdlet developers do not have to design sorting features for their cmdlets. Windows PowerShell gives them a framework that provides the basic features and forces them to be consistent about many aspects of the interface. The framework eliminates some of the choices that are typically left to the developer, but, in return, it makes the development of robust and easy\-to\-use cmdlets much simpler.

## Interactive and Scripting Environments
Windows PowerShell is a combined interactive and scripting environment that gives you access to command\-line tools and COM objects, and also enables you to use the power of the .NET Framework Class Library (FCL).

This environment improves upon the Windows Command Prompt, which provides an interactive environment with multiple command\-line tools. It also improves upon Windows Script Host (WSH) scripts, which let you use multiple command\-line tools and COM automation objects, but do not provide an interactive environment.

By combining access to all of these features, Windows PowerShell extends the ability of the interactive user and the script writer, and makes system administration more manageable.

## Object Orientation
Although you interact with Windows PowerShell by typing commands in text, Windows PowerShell is based on objects, not text. The output of a command is an object. You can send the output object to another command as its input. As a result, Windows PowerShell provides a familiar interface to people experienced with other shells, while introducing a new and powerful command\-line paradigm. It extends the concept of sending data between commands by enabling you to send objects, rather than text.

## Easy Transition to Scripting
Windows PowerShell makes it easy to transition from typing commands interactively to creating and running scripts. You can type commands at the Windows PowerShell command prompt to discover the commands that perform a task. Then, you can save those commands in a transcript or a history before copying them to a file for use as a script.

