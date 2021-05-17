---
title: What is a PowerShell command?
description: Commands for PowerShell are known as cmdlets (pronounced command-lets)
ms.date: 03/31/2021
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
[Discover PowerShell](learn/tutorials/01-discover-powershell.md).

For more information about creating your own cmdlets, see the following resources:

Script-based cmdlets

- [about_Functions_Advanced](/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
- [about_Functions_CmdletBindingAttribute](/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute)
- [about_Functions_Advanced_Methods](/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods)

Compiled cmdlets (PowerShell SDK docs)

- [Cmdlet overview](developer/cmdlet/cmdlet-overview.md)
