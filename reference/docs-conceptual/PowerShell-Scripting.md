---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  PowerShell Scripting
---

# PowerShell

Built on the .NET Framework, PowerShell is a task-based command-line shell and scripting language.
System administrators and power-users can rapidly automate tasks that manage operating systems
(Linux, macOS, and Windows) and processes.

## PowerShell is open-source

PowerShell base source code is now available in GitHub and open to community contributions.
See [PowerShell source on GitHub](https://github.com/powershell/powershell).

You can start with the bits you need at [Get PowerShell](https://github.com/PowerShell/PowerShell#get-powershell).
Or, perhaps, with a quick tour at [Getting Started](https://github.com/PowerShell/PowerShell/blob/master/docs/learning-powershell)

## PowerShell design goals

PowerShell is designed to improve the command-line and scripting environment by eliminating long-standing problems and adding new features.

### Discoverability

PowerShell makes it easy to discover its features. For example, to find a list of cmdlets that view and change Windows services, type:

```powershell
Get-Command *-Service
```

After discovering which cmdlet accomplishes a task, you can learn more about the cmdlet by using the `Get-Help` cmdlet.
For example, to display help about the `Get-Service` cmdlet, type:

```powershell
Get-Help Get-Service
```

Most cmdlets return objects that can be manipulated and then rendered as text for display.
To fully understand the output of a cmdlet, pipe the output to the `Get-Member` cmdlet.
For example, the following command displays information about the members of the object output by the `Get-Service` cmdlet.

```powershell
Get-Service | Get-Member
```

### Consistency

Managing systems can be a complex task.
Tools that have a consistent interface help to control the inherent complexity.
Unfortunately, command-line tools and scriptable COM objects aren't known for their consistency.

The consistency of PowerShell is one of its primary assets.
For example, if you learn how to use the `Sort-Object` cmdlet, you can use that knowledge to sort the output of any cmdlet.
You don't have to learn the different sorting routines of each cmdlet.

Additionally, cmdlet developers don't have to design sorting features for their cmdlets.
PowerShell provides a framework with the basic features that forces consistency.
The framework eliminates some choices that are left to the developer.
But, in return, it makes the development of cmdlets much simpler.

### Interactive and Scripting Environments

The Windows Command Prompt provides an interactive shell with access command-line tools and basic scripting.
Windows Script Host (WSH) provides access to scriptable command-line tools and COM automation objects, but doesn't provide an interactive shell.

PowerShell is a combined interactive shell and scripting environment.
PowerShell provides access to command-line tools, COM objects, and .NET class libraries.
By combining these features, PowerShell extends the ability of the interactive user, the script writer, and the system administrator.

### Object Orientation

PowerShell is based on object not text.
The output of a command is an object.
You can send the output object, through the pipeline, to another command as its input.

This pipeline provides a familiar interface for people experienced with other shells.
PowerShell extends this concept by sending objects rather than text.

### Easy Transition to Scripting

PowerShell's command discoverability makes it easy to transition from typing commands interactively to creating and running scripts.
PowerShell transcripts and history make it easy to copy commands to a file for use as a script.
