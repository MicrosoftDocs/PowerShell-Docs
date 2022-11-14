---
description: This article contains guidelines for the proper use of product names and terms.
ms.date: 11/14/2022
ms.topic: conceptual
title: Product terminology and branding guidelines
---
# Product terminology and branding guidelines

When writing about any product it's important to correctly and consistently use product names and
terminology. This guide defines product names and terminology related to PowerShell. Note the
capitalization of specific words or use cases.

## PowerShell (collective name)

Use **PowerShell** to describe the scripting language and an interactive shell.

### PowerShell (product name)

The cross-platform version of PowerShell that's built on .NET (core), rather than the .NET
Framework. PowerShell can be installed on Windows, Linux, and macOS.

### PowerShell Core (product deprecated)

The name used for PowerShell v6, built on .NET Core. This name shouldn't be used.

### Windows PowerShell (product name)

The version of PowerShell that ships in Windows, which requires the full .NET Framework.

Guidelines

- First mention - use "Windows PowerShell"
- Subsequent mentions - Use "PowerShell" unless the use case requires "Windows PowerShell" to be
  more specific:

  > In PowerShell, the `Invoke-WebRequest` cmdlet returns **BasicHtmlWebResponseObject**

  > In Windows PowerShell, the `Invoke-WebRequest` cmdlet returns **HtmlWebResponseObject**

## PowerShell modules

PowerShell modules are add-ons that containing PowerShell cmdlets that manage specific products or
services.

For example:

- Azure PowerShell
- Az.Accounts module
- Windows management module
- Hyper-V module
- Microsoft Graph PowerShell SDK
- Exchange PowerShell

Guidelines

- Always use the collective name or the more specific module name when referring to a PowerShell
  module
- Never refer to a module as "PowerShell"

## Azure PowerShell (collective name)

The branded group of products containing PowerShell modules used to manage Azure.

There are several versions of Azure PowerShell products available. Each product contains multiple
named modules.

Guidelines

- Use "Azure PowerShell" as the collective name for the product
- Always use the collective name, never just "PowerShell"
- Use the more specific product name when referring to a specific version

### Az PowerShell (product name)

The currently supported collection of modules for use with Azure.

### AzureRM PowerShell (product name)

The earlier collection of modules that use the Azure Resource Manager model for managing Azure
resources. This product is deprecated and will not be supported after February 29, 2024.

### Azure Service Management PowerShell (product name)

The earliest collection of modules is for managing legacy Azure resources that use Service
Management APIs.

### Azure PowerShell-related products

These products are used to manage Azure resources but aren't included in one of the Azure PowerShell
product collections.

- Azure Active Directory PowerShell
- Azure Information Protection PowerShell
- Azure Deployment Manager PowerShell
- Azure Elastic Database Jobs PowerShell
- Azure Service Fabric PowerShell
- Azure Stack PowerShell

Guidelines

- Always use the full proper name of the product or the specific PowerShell module name

## Other PowerShell-related products

### Visual Studio Code (VS Code)

This is Microsoft's free, open source editor.

Guidelines

- First mention - use the full name
- Subsequent mentions - you can use "VS Code"
- Never use "VSCode"

### PowerShell Extension for Visual Studio Code

The extension turns VS Code into the preferred IDE for PowerShell.

Guidelines

- First mention - use the full name
- Subsequent mentions - you can use "PowerShell extension"
