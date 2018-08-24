---
ms.date:  08/23/2018
keywords:  powershell,cmdlet
title:  Understanding important PowerShell concepts
ms.assetid:  3e601e38-4520-4578-a48d-b6779f1d35ee
---

# Understanding important PowerShell concepts

The PowerShell design integrates concepts from many different environments. Several of the concepts will be familiar to people with experience in shells or programming environments. However, few people will know about all of them. Looking at some of these concepts provides a useful overview of the shell.

## Commands are not text-based

Unlike traditional command-line interfaces, PowerShell cmdlets are designed to deal with objects.
An object is structured information that is more than just a string of characters appearing on the
screen. Command output always carries extra information that you can use if you need it. We
discuss this topic in depth in this article.

If you have used text-processing tools to process command-line data in the past, you will find that
they behave differently if you try to use them in PowerShell. In most cases, you do not need
text-processing tools to extract specific information. You can access portions of the data directly
by using standard PowerShell object manipulation commands.

## The command family is extensible

Interfaces such as Cmd.exe do not provide a way for you to directly extend the built-in command
set. You can create external command-line tools that run in Cmd.exe, but these external tools do
not have services, such as Help integration, and Cmd.exe does not automatically know that they are
valid commands.

The native binary commands in PowerShell, known as *cmdlets* (pronounced command-lets), can be
augmented by cmdlets that you create and that you add to PowerShell by using snap-ins. PowerShell
*snap-ins* are compiled, just like binary tools in any other interface. You can use them to add
PowerShell providers to the shell, as well as new cmdlets.

Because of the special nature of the PowerShell internal commands, we will refer to them as *cmdlets*.

> [!NOTE]
> PowerShell can run commands other than cmdlets. We will not be discussing them in detail in the
> PowerShell User's Guide, but they are useful to know about as categories of command types.
> PowerShell supports scripts that are analogous to UNIX shell scripts and Cmd.exe batch files, but
> have a .ps1 file name extension. PowerShell also allows you to create internal functions that can
> be used directly in the interface or in scripts.

## PowerShell handles console input and display

When you type a command, PowerShell always processes the command-line input directly. PowerShell also formats the output that you see on the screen. This is significant because it reduces the work required of each cmdlet and ensures that you can always do things the same way regardless of which cmdlet you are using. One example of how this simplifies life for both tool developers and users is command-line Help.

Traditional command-line tools have their own schemes for requesting and displaying Help. Some command-line tools use **/?** to trigger the Help display; others use **-?**, **/H**, or even **//**. Some will display Help in a GUI window, rather than in the console display. Some complex tools, such as application updaters, unpack internal files before displaying their Help. If you use the wrong parameter, the tool might ignore what you typed and begin performing a task automatically.

When you enter a command in PowerShell, everything you enter is automatically parsed and pre-processed by PowerShell. If you use the **-?** parameter with a PowerShell cmdlet, it always means "show me Help for this command". Cmdlet developers do not have to parse the command; they only need to provide the Help text.

It is important to understand that the Help features of PowerShell are available even when you run traditional command-line tools in PowerShell. PowerShell processes the parameters and passes the results to the external tools.

> [!NOTE]
> If you run an graphic application in PowerShell, the window for the application opens. PowerShell intervenes only when processing the command-line input you supply or the application output returned to the console window; it does not affect how the application works internally.

## PowerShell uses some C# syntax

PowerShell has syntax features and keywords that are very similar to those used in the C# programming language, because PowerShell is based on the .NET Framework. Learning PowerShell will make it much easier to learn C#, if you are interested in the language.

If you are not a C# programmer, this similarity is not important. However, if you are already familiar with C#, the similarities can make learning PowerShell much easier.