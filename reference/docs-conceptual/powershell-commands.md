---
description: Commands for PowerShell are known as cmdlets (pronounced command-lets)
ms.date: 11/16/2022
ms.topic: overview
title: What is a PowerShell command?
---
# What is a PowerShell command (cmdlet)?

Commands for PowerShell are known as cmdlets (pronounced command-lets). In addition to cmdlets,
PowerShell allows you to run any command available on your system.

## What is a cmdlet?

Cmdlets are native PowerShell commands, not stand-alone executables. Cmdlets are collected into
PowerShell modules that can be loaded on demand. Cmdlets can be written in any compiled .NET
language or in the PowerShell scripting language itself.

## Cmdlet names

PowerShell uses a _Verb-Noun_ name pair to name cmdlets. For example, the `Get-Command` cmdlet
included in PowerShell is used to get all the cmdlets that are registered in the command shell. The
verb identifies the action that the cmdlet performs, and the noun identifies the resource on which
the cmdlet performs its action.

## Next steps

To learn more about PowerShell and how to find other cmdlets, see the PowerShell Bits tutorial
[Discover PowerShell][01].

For more information about creating your own cmdlets, see the following resources:

Script-based cmdlets

- [about_Functions_Advanced][02]
- [about_Functions_CmdletBindingAttribute][03]
- [about_Functions_Advanced_Methods][04]

Compiled cmdlets (PowerShell SDK docs)

- [Cmdlet overview][05]

<!-- link references -->
[01]: learn/tutorials/01-discover-powershell.md
[02]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced
[03]: /powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute
[04]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods
[05]: developer/cmdlet/cmdlet-overview.md
