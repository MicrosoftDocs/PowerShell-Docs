---
description: PackageManagement is an aggregator for software package managers. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 03/30/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_packagemanagement?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PackageManagement
---
# About PackageManagement

## SHORT DESCRIPTION
PackageManagement is an aggregator for software package managers.

## LONG DESCRIPTION

PackageManagement functionality was introduced in Windows PowerShell 5.0.

PackageManagement is a unified interface for software package management
systems; you can run PackageManagement cmdlets to perform software discovery,
installation, and inventory (SDII) tasks. Regardless of the underlying
installation technology, you can run the common cmdlets in the
PackageManagement module to search for, install, or uninstall packages; add,
remove, and query package repositories; and run queries on a computer to
determine which software packages are installed.

PackageManagement supports a flexible plug-in model that enables support for
other software package management systems.

The PackageManagement module is included with Windows PowerShell 5.0 and later
releases of PowerShell, and works on three levels of package management
structure: package providers, package sources, and the packages themselves. Let
us define some terms:

- Package manager: Software package management system. In PackageManagement
  terms, this is a package provider.
- Package provider: PackageManagement term for a package manager. Examples can
  include Windows Installer, Chocolatey, and others.
- Package source: A URL, local folder, or network shared folder that you
  configure package providers to use as a repository.
- Package: A piece of software that a package provider manages, and that is
  stored in a specific package source.

The PackageManagement module includes the following cmdlets. For more
information, see the [PackageManagement](/powershell/module/packagemanagement)
help.

- `Get-PackageProvider`: Returns a list of package providers that are
   connected to PackageManagement.
- `Get-PackageSource`: Gets a list of package sources that are registered for
  a package provider.
- `Register-PackageSource`: Adds a package source for a specified package
  provider.
- `Set-PackageSource`: Sets properties on an existing package source.
- `Unregister-PackageSource`: Removes a registered package source.
- `Get-Package`: Returns a list of installed software packages.
- `Find-Package`: Finds software packages in available package sources.
- `Install-Package`: Installs one or more software packages.
- `Save-Package`: Saves packages to the local computer without installing
  them.
- `Uninstall-Package`: Uninstalls one or more software packages.

### Package Provider Bootstrapping and Dynamic Cmdlet Parameters

By default, PackageManagement ships with a core bootstrap provider. You can
install additional package providers as you need them by bootstrapping the
providers; that is, responding to a prompt to install the provider
automatically, from a web service. You can specify a package provider with any
PackageManagement cmdlet; if the specified provider is not available,
PackageManagement prompts you to bootstrap (or automatically install) the
provider. In the following examples, if the Chocolatey provider is not already
installed, PackageManagement bootstrapping installs the provider.

```powershell
Find-Package -Provider Chocolatey <PackageName>
```

If the Chocolatey provider is not already installed, when you run the
preceding command, you are prompted to install it.

```powershell
Install-Package <Chocolatey package Name> -ForceBootstrap
```

If the Chocolatey provider is not already installed, when you run the
preceding command, the provider is installed; but because the ForceBootstrap
parameter has been added to the command, you are not prompted to install it;
both the provider and the package are installed automatically.

When you try to install a package, if you do not already have the supporting
provider installed, and you do not add the ForceBootstrap parameter to your
command, PackageManagement prompts you to install the provider.

Specifying a package provider in your PackageManagement command can make
dynamic parameters available that are specific to that package provider. When
you run Get-Help for a specific PackageManagement cmdlet, a list of parameter
sets are returned, grouping dynamic parameters for available package providers
in separate parameter sets.

More Information About the PackageManagement Project

For more information about the PackageManagement open development project,
including how to create a PackageManagement package provider, see the
PackageManagement project on GitHub at https://oneget.org.

## SEE ALSO

[Get-PackageProvider](xref:PackageManagement.Get-PackageProvider)

[Get-PackageSource](xref:PackageManagement.Get-PackageSource)

[Register-PackageSource](xref:PackageManagement.Register-PackageSource)

[Set-PackageSource](xref:PackageManagement.Set-PackageSource)

[Unregister-PackageSource](xref:PackageManagement.Unregister-PackageSource)

[Get-Package](xref:PackageManagement.Get-Package)

[Find-Package](xref:PackageManagement.Find-Package)

[Install-Package](xref:PackageManagement.Install-Package)

[Save-Package](xref:PackageManagement.Save-Package)

[Uninstall-Package](xref:PackageManagement.Uninstall-Package)

