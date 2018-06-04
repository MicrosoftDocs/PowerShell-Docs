---
ms.date:  06/20/2018
keywords:  dsc,powershell,configuration,setup
title:  DSC PackageManagementSource Resource
---
# DSC PackageManagementSource Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0, Windows PowerShell 5.1

The **PackageManagementSource** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to register or unregister Package Management sources on a target node. **Package Management sources registered in this way are registered under the System context, usable by the System account or by the DSC engine.** This resource requires the **PackageManagement** module, available from http://PowerShellGallery.com.

> [!IMPORTANT]
> The **PackageManagement** module should be at least version 1.1.7.0 for the following property information to be correct.

## Syntax

```
PackageManagementSource [String] #ResourceName
{
    Name = [string]
    ProviderName = [string]
    SourceLocation = [string]
    [DependsOn = [string[]]]
    [Ensure = [string]{ Absent | Present }]
    [InstallationPolicy = [string]{ Trusted | Untrusted }]
    [PsDscRunAsCredential = [PSCredential]]
    [SourceCredential = [PSCredential]]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Specifies the name of the package source to be registered or unregistered on your system.|
| ProviderName| Specifies the name of the OneGet provider through which you can interop with the package source.|
| SourceLocation| Specifies the URI of the package source.|
| Ensure| Determines whether the package source is to be registered or unregistered.|
| InstallationPolicy| Used by providers such as the built-in Nuget Provider. Determines whether you trust the package's source. One of: "Untrusted", "Trusted".|
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
        SourceLocation   = "http://nuget.org/api/v2/"
        InstallationPolicy ="Trusted"
    }
}
```