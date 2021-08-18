---
ms.date: 03/22/2021
keywords:  powershell,cmdlet
title:  What is PowerShell?
description: This article is an introduction to the PowerShell scripting environment and its features.
---

# What is PowerShell?

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting
language, and a configuration management framework. PowerShell runs on Windows, Linux and macOS.

## Shell

PowerShell is a modern command shell that includes the best features of other popular shells. Unlike
most shells that only accept and return text, PowerShell accepts and returns .NET objects. The shell
includes the following features:

- Robust command-line [history][history]
- Tab completion and command prediction (See [about_PSReadLine][about_PSReadLine])
- Supports command and parameter [aliases][aliases]
- [Pipeline][Pipeline] for chaining commands
- In-console [help][help] system, similar to Unix `man` pages

## Scripting language

As a scripting language, PowerShell is commonly used for automating the management of systems. It is
also used to build, test, and deploy solutions, often in CI/CD environments. PowerShell is built on
the .NET Common Language Runtime (CLR). All inputs and outputs are .NET objects. No need to parse
text output to extract information from output. The PowerShell scripting language includes the
following features:

- Extensible through [functions][functions], [classes][classes], [scripts][scripts], and [modules][modules]
- Extensible [formatting system][formatting] for easy output
- Extensible [type system][types] for creating dynamic types
- Built-in support for common data formats like [CSV][CSV], [JSON][JSON], and [XML][XML]

## Configuration management

PowerShell Desired State Configuration ([DSC][DSC]) is a management framework in PowerShell that
enables you to manage your enterprise infrastructure with configuration as code. With DSC, you can:

- Create declarative [configurations][configurations] and custom scripts for repeatable deployments
- Enforce configuration settings and report on configuration drift
- Deploy configuration using [push or pull][push-pull] models

## Next steps

### Getting started

Are you new to PowerShell and don't know where to start? Take a look at these resources.

- [Installing PowerShell][install]
- [PowerShell 101][PS101]
- [PowerShell Bits tutorials][tutorials]
- [PowerShell Learn modules][learn]

### PowerShell in action

Take a look at how PowerShell is being used in different scenarios and on different platforms.

- [PowerShell remoting over SSH][remoting]
- [Getting started with Azure PowerShell][azure]
- [Building a CI/CD pipeline with DSC][devops]
- [Managing Microsoft Exchange][exchange]

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
[install]: /powershell/scripting/install/installing-powershell
[PS101]: /powershell/scripting/learn/ps101/00-introduction
[tutorials]: /powershell/scripting/learn/tutorials/00-introduction
[learn]: /learn/browse/?terms=PowerShell
[azure]: /powershell/azure/get-started-azureps
[devops]: /azure/devops/pipelines/release/dsc-cicd
[exchange]: /powershell/exchange/exchange-management-shell
[remoting]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
