---
title:   DSC PackageManagementSource Resource
ms.date:  
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  brywang-msft
manager:  kriscv
ms.prod:  powershell
---

# DSC PackageManagementSource Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **PackageManagementSource** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to register or unregister Package Management sources on a target node. **Package Management sources registered in this way are registered under the System context, usable by the System account or by the DSC engine.** This resource requires the **PackageManagement** module, available from http://PowerShellGallery.com.

## Syntax

```
PSModule [string] #ResourceName
{
    Name = [string]
	[ Ensure = [string] { Absent | Present }  ]
	[ InstallationPolicy = [string] ]
    [ ProviderName = [string] ]
    [ SourceUri = [string] ]
	[ SourceCredential = [PSCredential] ]
}
```

## Properties
|  Property  |  Description   | 
|---|---| 
| Name| Specifies the name of the package source to be registered or unregistered on your system.| 
| Ensure| Determines whether the package source is to be registered or unregistered.| 
| InstallationPolicy| Determines whether you trust the package source. One of: "Untrusted", "Trusted".| 
| ProviderName| Specifies the name of the OneGet provider through which you can interop with the package source.| 
| SourceUri| Specifies the URI of the package source.| 
| SourceCredential| Provides access to the package on a remote source.| 

## Example

This example registers the http://nuget.org package source using the **PackageManagementSource** DSC resource.

```powershell
Configuration PackageManagementSourceTest
{    
	PackageManagementSource SourceRepository
	{
		Ensure      = "Present" 
		Name        = "MyNuget" 
		ProviderName= "Nuget" 
		SourceUri   = "http://nuget.org/api/v2/"   
		InstallationPolicy ="Trusted" 
	}
}
```
