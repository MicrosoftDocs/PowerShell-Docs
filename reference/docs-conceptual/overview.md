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

- Robust command-line [history][09]
- Tab completion and command prediction (See [about_PSReadLine][18])
- Supports command and parameter [aliases][05]
- [Pipeline][11] for chaining commands
- In-console [help][14] system, similar to Unix `man` pages

## Scripting language

As a scripting language, PowerShell is commonly used for automating the management of systems. It's
also used to build, test, and deploy solutions, often in CI/CD environments. PowerShell is built on
the .NET Common Language Runtime (CLR). All inputs and outputs are .NET objects. No need to parse
text output to extract information from output. The PowerShell scripting language includes the
following features:

- Extensible through [functions][08], [classes][06], [scripts][12], and [modules][10]
- Extensible [formatting system][07] for easy output
- Extensible [type system][13] for creating dynamic types
- Built-in support for common data formats like [CSV][15], [JSON][16], and [XML][17]

## Automation platform

The extensible nature of PowerShell provides an ecosystem of PowerShell modules to deploy and manage
almost any technology you work with. For example:

Microsoft modules

- [Azure][02]
- [Windows][25]
- [Exchange][04]
- [SQL][27]

Third-party modules

- [AWS][30]
- [VMware][32]
- [Google Cloud][31]

### Configuration management

PowerShell Desired State Configuration ([DSC][20]) is a management framework in PowerShell that
enables you to manage your enterprise infrastructure with configuration as code. With DSC, you can:

- Create declarative [configurations][19] and custom scripts for repeatable deployments
- Enforce configuration settings and report on configuration drift
- Deploy configuration using [push or pull][21] models

## Monad Manifesto

Jeffrey Snover, the inventor of PowerShell, wrote the Monad Manifesto to explain his vision for
PowerShell and how it would change the way we manage systems. Use the following link to download a
copy of the [Monad Manifesto][33].

This PDF file is a version of the original Monad Manifesto, which articulated the long-term vision and
started the development effort that became PowerShell. PowerShell has delivered on many of the
elements described in this document.

## Next steps

### Getting started

Are you new to PowerShell and don't know where to start? Take a look at these resources.

- [Install PowerShell][22]
- [Discover PowerShell][29]
- [PowerShell 101][23]
- [Microsoft Virtual Academy videos][26]
- [PowerShell Learn modules][28]

### PowerShell in action

Take a look at how PowerShell is being used in different scenarios and on different platforms.

- [PowerShell remoting over SSH][24]
- [Getting started with Azure PowerShell][03]
- [Building a CI/CD pipeline with DSC][01]
- [Managing Microsoft Exchange][04]

<!-- link references -->
[01]: /azure/devops/pipelines/release/dsc-cicd
[02]: /powershell/azure
[03]: /powershell/azure/get-started-azureps
[04]: /powershell/exchange/exchange-management-shell
[05]: /powershell/module/microsoft.powershell.core/about/about_aliases
[06]: /powershell/module/microsoft.powershell.core/about/about_classes
[07]: /powershell/module/microsoft.powershell.core/about/about_format.ps1xml
[08]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced
[09]: /powershell/module/microsoft.powershell.core/about/about_history
[10]: /powershell/module/microsoft.powershell.core/about/about_modules
[11]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[12]: /powershell/module/microsoft.powershell.core/about/about_scripts
[13]: /powershell/module/microsoft.powershell.core/about/about_types.ps1xml
[14]: /powershell/module/microsoft.powershell.core/get-help
[15]: /powershell/module/microsoft.powershell.utility/convertfrom-csv
[16]: /powershell/module/microsoft.powershell.utility/convertfrom-json
[17]: /powershell/module/microsoft.powershell.utility/convertto-xml
[18]: /powershell/module/psreadline/about/about_psreadline
[19]: /powershell/scripting/dsc/configurations/configurations
[20]: /powershell/scripting/dsc/overview/dscforengineers
[21]: /powershell/scripting/dsc/pull-server/enactingconfigurations
[22]: /powershell/scripting/install/installing-powershell
[23]: /powershell/scripting/learn/ps101/00-introduction
[24]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[25]: /powershell/windows/get-started
[26]: /shows/browse?terms=powershell
[27]: /sql/powershell/sql-server-powershell
[28]: /training/browse/?terms=PowerShell
[29]: discover-powershell.md
[30]: https://aws.amazon.com/powershell/
[31]: https://cloud.google.com/powershell/
[32]: https://developer.broadcom.com/powercli
[33]: https://github.com/MicrosoftDocs/PowerShell-Docs/blob/main/assets/MonadManifesto.pdf
