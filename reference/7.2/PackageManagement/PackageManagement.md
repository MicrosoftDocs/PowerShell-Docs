---
Download Help Link: https://aka.ms/powershell72-help
Help Version: 7.2.0.0
Locale: en-US
Module Guid: 4ae9fd46-338a-459c-8186-07f910774cb8
Module Name: PackageManagement
ms.date: 06/09/2017
schema: 2.0.0
title: PackageManagement
---
# PackageManagement Module

## Description

This topic displays help topics for the Package Management Cmdlets.

> [!IMPORTANT]
> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS)
> versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when
> trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS
> 1.2:
>
> `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
>
> For more information, see the
> [announcement](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/) in the
> PowerShell blog.

## PackageManagement Cmdlets

### [Find-Package](Find-Package.md)
Finds software packages in available package sources.

### [Find-PackageProvider](Find-PackageProvider.md)
Returns a list of Package Management package providers available for installation.

### [Get-Package](Get-Package.md)
Returns a list of all software packages that were installed with **PackageManagement**.

### [Get-PackageProvider](Get-PackageProvider.md)
Returns a list of package providers that are connected to Package Management.

### [Get-PackageSource](Get-PackageSource.md)
Gets a list of package sources that are registered for a package provider.

### [Import-PackageProvider](Import-PackageProvider.md)
Adds Package Management package providers to the current session.

### [Install-Package](Install-Package.md)
Installs one or more software packages.

### [Install-PackageProvider](Install-PackageProvider.md)
Installs one or more Package Management package providers.

### [Register-PackageSource](Register-PackageSource.md)
Adds a package source for a specified package provider.

### [Save-Package](Save-Package.md)
Saves packages to the local computer without installing them.

### [Set-PackageSource](Set-PackageSource.md)
Replaces a package source for a specified package provider.

### [Uninstall-Package](Uninstall-Package.md)
Uninstalls one or more software packages.

### [Unregister-PackageSource](Unregister-PackageSource.md)
Removes a registered package source.
