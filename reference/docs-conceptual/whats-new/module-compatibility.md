---
description: This article lists the compatibility status of modules published for other Microsoft products with PowerShell 7.
ms.date: 06/28/2023
title: PowerShell 7 module compatibility
---
# PowerShell 7 module compatibility

This article contains a partial list of PowerShell modules published by Microsoft.

The PowerShell team is working with the various feature teams that create PowerShell modules to help
them produce modules that work in PowerShell 7. These modules are not owned by the PowerShell team.

The following modules are known to support PowerShell 7.

## Azure PowerShell

The Az PowerShell module is a set of cmdlets for managing Azure resources directly from PowerShell.
PowerShell 7.0.6 LTS or higher is the recommended version of PowerShell for use with the Azure Az
PowerShell module on all platforms.

For more information, see [Introducing the Azure Az PowerShell module][02].

## MSGraph PowerShell SDK

The Microsoft Graph SDKs are designed to simplify building high-quality, efficient, and resilient
applications that access Microsoft Graph. PowerShell 7 and later is the recommended PowerShell
version for use with the Microsoft Graph PowerShell SDK.

For more information, see [Install the Microsoft Graph PowerShell SDK][01].

## Windows management modules

The Windows management modules provide management and support for various Windows features and
services. Most of these modules have been updated to work natively with PowerShell 7, or tested for
compatibility with PowerShell 7.

These modules are installed in different ways depending on the Edition of Windows, and how the
module is packaged for that Edition.

For more information about installation and compatibility, see
[PowerShell 7 module compatibility][05] in the Windows documentation.

## Exchange Online Management 2.0

The Exchange Online PowerShell V2 module (EXO V2) connects to all Exchange-related PowerShell
environments in Microsoft 365: Exchange Online PowerShell, Security & Compliance PowerShell, and
standalone Exchange Online Protection (EOP) PowerShell.

EXO v2.0.4 or later is supported in PowerShell 7.0.3 or later.

For more information, see [About the Exchange Online PowerShell V2 module][03].

## PowerShell modules for SQL Server

There are two SQL Server PowerShell modules:

- **SqlServer**: This module includes new cmdlets to support the latest SQL features, including
  updated versions of the cmdlets in SQLPS.
- **SQLPS**: The SQLPS is the module used by SQL Agent to run agent jobs in agent job steps using
  the PowerShell subsystem.

The SqlServer modules require PowerShell version 5.0 or greater.

For more information, see [Install the SQL Server PowerShell module][06].

## Finding the status of other modules

You can find a complete list of modules using the [PowerShell Module Browser][04]. Using the Module
Browser, you can find documentation for other PowerShell modules to determine their PowerShell
version requirements.

<!-- link references -->
[01]: /graph/powershell/installation#supported-powershell-versions
[02]: /powershell/azure/new-azureps-module-az
[03]: /powershell/exchange/exchange-online-powershell-v2
[04]: /powershell/module
[05]: /powershell/windows/module-compatibility
[06]: /sql/powershell/download-sql-server-ps-module
