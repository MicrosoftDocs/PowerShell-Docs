---
ms.date: 03/22/2021
keywords:  powershell,cmdlet
title:  What is PowerShell?
description: This article is an introduction to the PowerShell scripting environment and its features.
---

# What is PowerShell?

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting
language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS.

## Shell

PowerShell is modern command shell that includes all of the best features of other popular shells.
Unlike most shells that only accept and return text, PowerShell accepts and returns .NET Objects.

Features

- Robust command-line [history][]
- Tab completion and command prediction (See [about_PSReadLine][])
- Supports command and parameter [aliases][]
- [Pipeline][] for chaining commands
- In console [help][] system similar to Unix `man` pages

## Scripting language

PowerShell is built on the .NET Common Language Runtime (CLR). All inputs and outputs are .NET
objects. No need to parse text output to extract information from output.

- Extensible through [functions][], [classes][], [scripts][], and [modules][]
- Extensible [formatting system][formatting] for easy output
- Extensible [type system][types] for creating dynamic types
- Built-in support for common data formats like [CSV][], [JSON][], and [XML][]

## Configuration management

PowerShell Desired State Configuration ([DSC][]) is a management framework in PowerShell that
enables you to manage your enterprise infrastructure with configuration as code.

- Create declarative [configurations][] and custom scripts for repeatable deployments
- Enforce setting and report on configuration drift
- Deploy configuration using a [push or pull][push-pull] models


<!-- link references -->

[history]: /powershell/module/microsoft.powershell.core/about/about_history
[about_PSReadLine]: /powershell/module/psreadline/about/about_psreadline
[aliases]: /powershell/module/microsoft.powershell.core/about/about_aliases
[Pipeline]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[help]: /powershell/module/microsoft.powershell.core/get-help
[modules]: /powershell/module/microsoft.powershell.core/about/about_modules
[functions]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced
[classes]: /powershell/module/microsoft.powershell.core/about/about_classes
[scripts]: /powershell/module/microsoft.powershell.core/about/about_scripts
[formatting]: /powershell/module/microsoft.powershell.core/about/about_format.ps1xml
[types]: /powershell/module/microsoft.powershell.core/about/about_types.ps1xml
[CSV]: /powershell/module/microsoft.powershell.utility/convertfrom-csv
[JSON]: /powershell/module/microsoft.powershell.utility/convertfrom-json
[XML]: /powershell/module/microsoft.powershell.utility/convertto-xml
[configurations]: /powershell/scripting/dsc/configurations/configurations
[DSC]: /powershell/scripting/dsc/overview/dscforengineers
[push-pull]: /powershell/scripting/dsc/pull-server/enactingconfigurations
