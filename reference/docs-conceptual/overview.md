---
description: This article is an introduction to the PowerShell scripting environment and its features.
ms.date: 10/30/2024
ms.topic: overview
title: What is PowerShell?
---

# What is PowerShell?

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting
language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS.

## Command-line Shell

PowerShell is a modern command shell that includes the best features of other popular shells. Unlike
most shells that only accept and return text, PowerShell accepts and returns .NET objects. The shell
includes the following features:

- Robust command-line [history][01]
- Tab completion and command prediction (See [about_PSReadLine][02])
- Supports command and parameter [aliases][03]
- [Pipeline][04] for chaining commands
- In-console [help][05] system, similar to Unix `man` pages

## Scripting language

As a scripting language, PowerShell is commonly used for automating the management of systems. It's
also used to build, test, and deploy solutions, often in CI/CD environments. PowerShell is built on
the .NET Common Language Runtime (CLR). All inputs and outputs are .NET objects. No need to parse
text output to extract information from output. The PowerShell scripting language includes the
following features:

- Extensible through [functions][06], [classes][07], [scripts][08], and [modules][09]
- Extensible [formatting system][10] for easy output
- Extensible [type system][11] for creating dynamic types
- Built-in support for common data formats like [CSV][12], [JSON][13], and [XML][14]

## Automation platform

The extensible nature of PowerShell has enabled an ecosystem of PowerShell modules to deploy and
manage almost any technology you work with. For example:

Microsoft

- [Azure][15]
- [Windows][16]
- [Exchange][17]
- [SQL][18]

Third-party

- [AWS][19]
- [VMWare][20]
- [Google Cloud][21]

### Configuration management

PowerShell Desired State Configuration ([DSC][22]) is a management framework in PowerShell that
enables you to manage your enterprise infrastructure with configuration as code. With DSC, you can:

- Create declarative [configurations][23] and custom scripts for repeatable deployments
- Enforce configuration settings and report on configuration drift
- Deploy configuration using [push or pull][24] models

## Next steps

### Getting started

Are you new to PowerShell and don't know where to start? Take a look at these resources.

- [Installing PowerShell][25]
- [Discover PowerShell][26]
- [PowerShell 101][27]
- [Microsoft Virtual Academy videos][28]
- [PowerShell Learn modules][29]

### PowerShell in action

Take a look at how PowerShell is being used in different scenarios and on different platforms.

- [PowerShell remoting over SSH][30]
- [Getting started with Azure PowerShell][31]
- [Building a CI/CD pipeline with DSC][32]
- [Managing Microsoft Exchange][33]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_history
[02]: /powershell/module/psreadline/about/about_psreadline
[03]: /powershell/module/microsoft.powershell.core/about/about_aliases
[04]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[05]: /powershell/module/microsoft.powershell.core/get-help
[06]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced
[07]: /powershell/module/microsoft.powershell.core/about/about_classes
[08]: /powershell/module/microsoft.powershell.core/about/about_scripts
[09]: /powershell/module/microsoft.powershell.core/about/about_modules
[10]: /powershell/module/microsoft.powershell.core/about/about_format.ps1xml
[11]: /powershell/module/microsoft.powershell.core/about/about_types.ps1xml
[12]: /powershell/module/microsoft.powershell.utility/convertfrom-csv
[13]: /powershell/module/microsoft.powershell.utility/convertfrom-json
[14]: /powershell/module/microsoft.powershell.utility/convertto-xml
[15]: /powershell/azure
[16]: /powershell/windows/get-started
[17]: /powershell/exchange/exchange-management-shell
[18]: /sql/powershell/sql-server-powershell
[19]: https://aws.amazon.com/powershell/
[20]: https://developer.broadcom.com/powercli
[21]: https://cloud.google.com/powershell/
[22]: /powershell/scripting/dsc/overview/dscforengineers
[23]: /powershell/scripting/dsc/configurations/configurations
[24]: /powershell/scripting/dsc/pull-server/enactingconfigurations
[25]: /powershell/scripting/install/installing-powershell
[26]: discover-powershell.md
[27]: /powershell/scripting/learn/ps101/00-introduction
[28]: /shows/browse?terms=powershell
[29]: /training/browse/?terms=PowerShell
[30]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[31]: /powershell/azure/get-started-azureps
[32]: /azure/devops/pipelines/release/dsc-cicd
[33]: /powershell/exchange/exchange-management-shell
