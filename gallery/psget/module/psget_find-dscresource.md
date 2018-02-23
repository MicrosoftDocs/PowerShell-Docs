---
ms.date:  2017-06-12
contributor:  manikb
ms.topic:  reference
keywords:  gallery,powershell,cmdlet,psget
title:  Find-DscResource
---

# Find-DscResource

Finds DSC Resources in modules.

## Description

The Find-DscResource cmdlet finds [Desired State Configuration (DSC)](https://msdn.microsoft.com/PowerShell/dsc/overview) resources contained in modules that match the specified criteria from registered repositories.
For each module that this cmdlet finds, Find-DscResource returns a PSGetDscResourceInfo object that you can pipe to Install-Module to install the modules containing the resources that this cmdlet returns.

DSC is a new management platform in Windows PowerShell that enables deploying and managing configuration data for software services and managing the environment in which these services run.

Desired State Configuration (DSC) Resources provide the building blocks for a DSC configuration. A resource exposes properties that can be configured (schema) and contains the PowerShell script functions that the Local Configuration Manager (LCM) calls to "make it so".

A resource can model something as generic as a file or as specific as an IIS server setting. Groups of like resources are combined in to a DSC Module, which organizes all the required files in to a structure that is portable and includes metadata to identify how the resources are intended to be used.

- Find-DscResource can filter with version parameters: MinimumVersion, RequiredVersion, AllVersions.
  - These parameters are mutually exclusive.
  - These version parameters are allowed only with the single module name without any wildcards.
  - If the RequiredVersion parameter is not specified, Find-DscResource returns the latest version of the module that is equal to or greater than the minimum version specified or the latest version of the module if no minimum version is specified.
  - If the RequiredVersion parameter is specified, Find-DscResource only returns the version of the module that exactly matches the specified version.
- Find-DscResource can filter on module metadata with the -Tag parameter
- Find-DscResource can filter on repository-specific search language with the -Filter parameter.
- Find-DscResource can filter on modules from all or few of the registered repositories.

## Cmdlet syntax
```powershell
Get-Command -Name Find-DscResource -Module PowerShellGet -Syntax
```

## Cmdlet online help reference

[Find-DscResource](http://go.microsoft.com/fwlink/?LinkId=517196)

## Example commands
```powershell

# Find a specific DSC Resource
Find-DscResource -Name xIisFeatureDelegation

Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xIisFeatureDelegation               1.10.0.0   xWebAdministration                  PSGallery

# Find all available DSC Resources from all registered repositories
Find-DscResource

# Find a DSC resource by name
Find-DscResource -Name xWebsite

# Find multiple DSC Resources
Find-DscResource -Name xIisHandler, xFirewall

# Find all DSC resources contained within a specific module
Find-DscResource -ModuleName xNetworking
Find-DscResource -ModuleName xWebAdministration

# Find all DSC resources in modules with DSCResourceKit or DesiredStateConfiguration
Find-DscResource -Tag DesiredStateConfiguration, DSCResourceKit

# Find available DSC Resources from few registered repositories
Find-DscResource -Repository PSGallery,PrivatePSGallery

# Find all DSC Resources in a specified repository
Find-DscResource -Repository PSGallery

# Find DSC Resources from all versions of a module
Find-DscResource -ModuleName xNetworking -AllVersions

# Find DSC Resources with module name and MinimumVersion.
Find-DscResource -ModuleName xNetworking -MinimumVersion 1.1

# Find DSC Resources with module name and exact version
Find-DscResource -ModuleName xNetworking -RequiredVersion 2.1.1

# Find DSC Resources defined modules with -Filter based search. -Filter searches in description and module names
Find-DscResource -Filter Domain

# Find all DSC Resources with tags Azure or DSC in module metadata
Find-DscResource -Tag Azure, DSC

```

