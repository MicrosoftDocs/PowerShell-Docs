---
title:  Understanding Important Windows PowerShell Concepts
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  3e601e38-4520-4578-a48d-b6779f1d35ee
---

# Understanding Important Windows PowerShell Concepts
The Windows PowerShell design integrates concepts from many different environments. Several of them are familiar to people with experience in specific shells or programming environments, but very few people will know about all of them. Looking at some of these concepts provides a useful overview of the shell.

### Commands Are Not Text\-Based
Unlike traditional command\-line interface commands, Windows PowerShell cmdlets are designed to deal with objects \- structured information that is more than just a string of characters appearing on the screen. Command output always carries along extra information that you can use if you need it. We will discuss this topic in depth in this document.

If you have used text\-processing tools to process command\-line data in the past, you will find that they behave differently if you try to use them in Windows PowerShell. In most cases, you do not need text\-processing tools to extract specific information. You can access portions of the data directly by using standard Windows PowerShell object manipulation commands.

### The Command Family Is Extensible
Interfaces such as Cmd.exe do not provide a way for you to directly extend the built\-in command set. You can create external command\-line tools that run in Cmd.exe, but these external tools do not have services, such as Help integration, and Cmd.exe does not automatically know that they are valid commands.

The native binary commands in Windows PowerShell, known as *cmdlets* (pronounced command\-lets), can be augmented by cmdlets that you create and that you add to Windows PowerShell by using snap\-ins. Windows PowerShell *snap\-ins* are compiled, just like binary tools in any other interface. You can use them to add Windows PowerShell providers to the shell, as well as new cmdlets.

Because of the special nature of the Windows PowerShell internal commands, we will refer to them as *cmdlets*.

> [!NOTE]
> Windows PowerShell can run commands other than cmdlets. We will not be discussing them in detail in the Windows PowerShell User's Guide, but they are useful to know about as categories of command types. Windows PowerShell supports scripts that are analogous to UNIX shell scripts and Cmd.exe batch files, but have a .ps1 file name extension. Windows PowerShell also allows you to create internal functions that can be used directly in the interface or in scripts.

### Windows PowerShell Handles Console Input and Display
When you type a command, Windows PowerShell always processes the command\-line input directly. Windows PowerShell also formats the output that you see on the screen. This is significant because it reduces the work required of each cmdlet and ensures that you can always do things the same way regardless of which cmdlet you are using. One example of how this simplifies life for both tool developers and users is command\-line Help.

Traditional command\-line tools have their own schemes for requesting and displaying Help. Some command\-line tools use **\/?** to trigger the Help display; others use **\-?**, **\/H**, or even **\/\/**. Some will display Help in a GUI window, rather than in the console display. Some complex tools, such as application updaters, unpack internal files before displaying their Help. If you use the wrong parameter, the tool might ignore what you typed and begin performing a task automatically.

When you enter a command in Windows PowerShell, everything you enter is automatically parsed and pre\-processed by Windows PowerShell. If you use the **\-?** parameter with a Windows PowerShell cmdlet, it always means "show me Help for this command". Cmdlet developers do not have to parse the command; they only need to provide the Help text.

It is important to understand that the Help features of Windows PowerShell are available even when you run traditional command\-line tools in Windows PowerShell. Windows PowerShell processes the parameters and passes the results to the external tools.

> [!NOTE]
> If you run an graphic application in Windows PowerShell, the window for the application opens. Windows PowerShell intervenes only when processing the command\-line input you supply or the application output returned to the console window; it does not affect how the application works internally.

### Windows PowerShell Uses Some C\# Syntax
Windows PowerShell has syntax features and keywords that are very similar to those used in the C\# programming language, because Windows PowerShell is based on the .NET Framework. Learning Windows PowerShell will make it much easier to learn C\#, if you are interested in the language.

If you are not a C\# programmer, this similarity is not important. However, if you are already familiar with C\#, the similarities can make learning Windows PowerShell much easier.

