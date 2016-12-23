---
title:   DSC PackageManagement Resource
ms.date:  
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  brywang-msft
manager:  kriscv
ms.prod:  powershell
---

# DSC PackageManagement Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **PackageManagement** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to install or uninstall Package Management packages on a target node. This resource requires the **PackageManagement** module, available from http://PowerShellGallery.com.

## Syntax

```
PackageManagement [string] #ResourceName
{
    Name = [string]
    [ Source = [string] ]
	[ Ensure = [string] { Absent | Present }  ]
    [ RequiredVersion = [string] ]
    [ MinimumVersion = [string] ]
	[ MaximumVersion = [string] ]
    [ SourceCredential = [PSCredential] ]
    [ ProviderName = [string] ]
    [ AdditionalParameters = [Microsoft.Management.Infrastructure.CimInstance[]] ]
}
```

## Properties
|  Property  |  Description   | 
|---|---| 
| Name| Specifies the name of the Package to be installed or uninstalled.| 
| Source| Specifies the name of the package source where the package can be found. This can either be a URI or a source registered with Register-PackageSource or PackageManagementSource DSC resource. The DSC resource MSFT_PackageManagementSource can also register a package source.| 
| Ensure| Determines whether the package is to be installed or uninstalled.| 
| RequiredVersion| Specifies the exact version of the package that you want to install. If you do not specify this parameter, this DSC resource installs the newest available version of the package that also satisfies any maximum version specified by the MaximumVersion parameter.| 
| MinimumVersion| Specifies the minimum allowed version of the package that you want to install. If you do not add this parameter, this DSC resource intalls the highest available version of the package that also satisfies any maximum specified version specified by the MaximumVersion parameter.| 
| MaximumVersion| Specifies the maximum allowed version of the package that you want to install. If you do not specify this parameter, this DSC resource installs the highest-numbered available version of the package.| 
| SourceCredential | Specifies a user account that has rights to install a package for a specified package provider or source.| 
| ProviderName| Specifies a package provider name to which to scope your package search. You can get package provider names by running the Get-PackageProvider cmdlet.| 
| AdditionalParameters| Provider specific parameters that are passed as an Hashtable. For example, for NuGet provider you can pass additional parameters like DestinationPath.| 

## Additional Parameters
The following table lists options for the AdditionalParameters property.
|  Parameter  | Description   | 
|---|---|
| DestinationPath| Used by providers such as the built-in Nuget Provider. Specifies a file location where you want the package to be installed.|
| InstallationPolicy| Used by providers such as the built-in Nuget Provider. Determines whether you trust the package's source. One of: "Untrusted", "Trusted".|

## Example

This example installs the **JQuery** NuGet package and **GistProvider** PowerShell module using the **PackageManagement** DSC resource. This example first ensures the required package sources are available then defines the expected state of the **JQuery** and **GistProvider** packages (NuGet and PowerShell, respectively).

```powershell
Configuration PackageTest
{    
    PackageManagementSource SourceRepository 
    { 
		Ensure      = "Present" 
		Name        = "MyNuget" 
		ProviderName= "Nuget" 
		SourceUri   = "http://nuget.org/api/v2/"   
		InstallationPolicy ="Trusted" 
    }    
	
	PackageManagementSource PSGallery 
    { 
		Ensure      = "Present" 
		Name        = "psgallery" 
		ProviderName= "PowerShellGet" 
		SourceUri   = "https://www.powershellgallery.com/api/v2/"   
		InstallationPolicy ="Trusted" 
    } 
          
    PackageManagement NugetPackage 
    { 
		Ensure               = "Present"  
		Name                 = "JQuery"
		AdditionalParameters = "$env:HomeDrive\nuget"
		RequiredVersion      = "2.0.1" 
		DependsOn            = "[PackageManagementSource]SourceRepository" 
    }
	
    PackageManagement PSModule 
    { 
		Ensure               = "Present"  
		Name                 = "gistprovider"
		Source               = "PSGallery"
		DependsOn            = "[PackageManagementSource]PSGallery" 
    }
}
```