---
ms.date:  2017-06-12
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# PackageManagement Cmdlets
This is the core of PackageManagement to support software discovery, installation, and inventory (SDII). Try out the cmdlets for these operations:
-   Find-Package
-   Find-PackageProvider
-   Get-Package
-   Get-PackageProvider
-   Get-PackageSource
-   Import-PackageProvider
-   Install-Package
-   Install-PackageProvider
-   Register-PackageSource
-   Save-Package
-   Set-PackageSource
-   Uninstall-Package
-   Unregister-PackageSource

As PackageManagement is a PowerShell module, you can do the following to update PackageManagement itself:
```powershell
PS C:\> Install-Module PackageManagement –Force
```
In this case, you will have to re-enter PowerShell session to switch to the new version of PackageManagement.

## [Find-Package Cmdlet](https://technet.microsoft.com/library/dn890709.aspx)
This cmdlet allows discovery of software packages in available package sources using loaded package providers.
```powershell
# Find all available Windows PowerShell module packages from galleries registered
# with PowerShellGet provider
Find-Package -Provider PowerShellGet -Source PSGallery

# Find a package from a provider that is not yet installed
# This will bootstrap NuGet provider and then search for jquery package using NuGet
# with <http://www.nuget.org/api/v2/> as source
Find-Package -Name jquery –Provider NuGet -Source http://www.nuget.org/api/v2/

# Find package with name and version
# Here we are assuming that the user already registered nuget.org using
# Register-PackageSource. You can specify either the provider or the source, or
# neither. For the latter, performance may be less optimal as it searches through all
# the providers and registered sources.
Find-Package -Name jquery –Provider NuGet –RequiredVersion 2.1.4 -Source nuget.org
```

## [Find-PackageProvider Cmdlet](https://technet.microsoft.com/library/mt676544.aspx)
The Find-PackageProvider cmdlet finds matching PackageManagement providers that are available in package sources registered with PowerShellGet. These are package providers available for installation with the Install-PackageProvider cmdlet. By default, this includes modules available in the PowerShell Gallery with the 'PackageManagement' and 'Provider' Tags. 

Find-PackageProvider also finds matching PackageManagement providers that are available in the PackageManagement azure blob store where we use the PackageManagement boostrapper provider for finding and installing them.
```powershell
#Find all available package providers in PackageManagement azure blob store as well as in PowerShellGallery.com
Find-PackageProvider

#Find all versions of a provider
Find-PackageProvider -Name "Nuget" -AllVersions

#Find a provider from a specified source
Find-PackageProvider -Name "Gistprovider" -Source "PSGallery"
```

## [Get-Package Cmdlet](https://technet.microsoft.com/library/dn890704.aspx)
This cmdlet returns a list of all software packages that have been installed using PackageManagement.
```powershell
# Get all the packages installed by Programs provider
Get-Package –Provider Programs

# Get all the packages installed by NuGet provider at c:\test using the dynamic
# parameter destination
Get-Package –Provider NuGet -Destination c:\test
```

## [Get-PackageProvider Cmdlet](https://technet.microsoft.com/en-us/library/dn890703.aspx)
Package providers that are loaded and ready to be used on the local machine can be inventoried by using the cmdlet.
```powershell
# Get all currently loaded package providers
Get-PackageProvider

# The following cmdlet will show all the package providers available on the machine (including those that are not loaded):
Get-PackageProvider -ListAvailable
```

## [Get-PackageSource Cmdlet](https://technet.microsoft.com/en-us/library/dn890705.aspx)
This cmdlet gets a list of package sources that are registered for a package provider.
```powershelll
# Get all package sources
Get-PackageSource

# Get all package sources for a specific provider
Get-PackageSource –ProviderName PowerShellGet
```

## [Import-PackageProvider Cmdlet](https://technet.microsoft.com/en-us/library/mt676545.aspx)
This cmdlet adds Package Management package providers to the current session.
```powershell
# Import a package provider from the local machine
Import-PackageProvider –Name MyProvider

#The -Name parameter can be either the name of the provider or the full path to the provider. Currently, we support .dll, .exe and.psm1 for the full path case. If the name of the provider is used for the -Name parameter, then additional version parameters such as -RequiredVersion, -MinimumVersion and -MaximumVersion may be specified. Otherwise, the latest version of the provider will be imported.

#If a package provider is not yet loaded to your system, we can discover and install on-demand. You can use explicit discovery and install cmdlets to do so:
 Find-PackageProvider
 Install-PackageProvider –Name MyProvider

#After installed, follow the Import-PackageProvider to load it to your system.

# Import a specific version of a package provider. PackageManagement supports installations of multiple versions of a package provider using PackageProvider cmdlets (not by bootstrapper provider). You can install another version of a package provider given that you already have one up running by:
Find-PackageProvider –Name "Nuget" -AllVersions
Install-PackageProvider -Name "Nuget" -RequiredVersion "2.8.5.201" -Force
Get-PackageProvider –ListAvailable
Import-PackageProvider –Name "Nuget" -RequiredVersion "2.8.5.201" -Verbose
Import-PackageProvider –Name MyProvider –RequiredVersion xxxx -force
```

##[ Install-Package Cmdlet](https://technet.microsoft.com/en-us/library/dn890711.aspx)

This cmdlet allows installation of software packages in available package sources using loaded package providers.
```powershell
# Install a package by name.
# NuGet provider requires us to provide the dynamic parameter destination path
# when we use this provider to install. Not all providers will require you to supply
# dynamic parameters for PackageManagement cmdlets.
Install-Package -Name jquery -Source nuget.org -Destination c:\test

# Install a package by piping.
Find-Package -Name jquery –Provider NuGet | Install-Package -Destination c:\test
```

## [Install-PackageProvider Cmdlet](https://technet.microsoft.com/en-us/library/mt676543.aspx)
This cmdlet installs one or more Package Management package providers.
```powershell
# Install a package provider from the PowerShell Gallery
Install-PackageProvider –Name "Gistprovider" -Verbose

# Install a specified version of a package provider
Find-PackageProvider –Name "Nuget" -AllVersions
Install-PackageProvider -Name "Nuget" -RequiredVersion "2.8.5.201" -Force

# Find a provider and install it
Find-PackageProvider –Name "Gistprovider" | Install-PackageProvider -Verbose

# Install a provider to the current user’s module folder
Install-PackageProvider –Name Gistprovider –Verbose –Scope CurrentUser
```

## [Register-PackageSource Cmdlet](https://technet.microsoft.com/en-us/library/dn890701.aspx)
This cmdlet adds a package source for a specified package provider.
Each PackageManagement provider may have one or multiple software sources, or repositories. PackageManagement provides PowerShell cmdlets to add/remove/query the source. For example, you can register a package source for the NuGet provider:
```powershell
Register-PackageSource -Name "NugetSource" -Location "http://www.nuget.org/api/v2" –ProviderName nuget
```

## [Save-Package Cmdlet](https://technet.microsoft.com/en-us/library/dn890708.aspx)
This cmdlet saves packages to the local computer without installing them.
```powershell
# Saves jquery package to c:\test using NuGetProvider
# Notes that the -Path parameter must point to an existing location
Save-Package -Name jquery –Provider NuGet -Path c:\test

# Save a package by piping.
Find-Package -Name jquery -Source http://www.nuget.org/api/v2/ | Save-Package -Path c:\test
Find-Package -source c:\test
```

## [Set-PackageSource Cmdlet](https://technet.microsoft.com/en-us/library/dn890710.aspx)
This cmdlet changes information about an existing package source. 
```powershell
#Set-PackageSource changes the values for a source that has already been registered by running the Register-PackageSource cmdlet. By #running Set-PackageSource, you can change the source name and location.
Set-PackageSource  -Name nuget.org -Location  http://www.nuget.org/api/v2 -NewName nuget2 -NewLocation https://www.nuget.org/api/v2 
```

## [Uninstall-Package Cmdlet](https://technet.microsoft.com/en-us/library/dn890702.aspx)
This cmdlet uninstalls packages installed on the local computer.
```powershell
# Uninstall jquery using nuget
Uninstall-Package -Name jquery –Provider NuGet -Destination c:\test

# Uninstall a package with by piping with Get-Package
Get-Package -Name jquery –Provider NuGet -Destination c:\test | Uninstall-Package
```

## [Unregister-PackageSource Cmdlet](https://technet.microsoft.com/en-us/library/dn890707.aspx)
```powershell
# Unregister a package source for the NuGet provider. You can use command Unregister-PackageSource, to disconnect with a repository, and Get-PackageSource, to discover what the repositories are associated with that provider.
Unregister-PackageSource  -Name "NugetSource"
```

