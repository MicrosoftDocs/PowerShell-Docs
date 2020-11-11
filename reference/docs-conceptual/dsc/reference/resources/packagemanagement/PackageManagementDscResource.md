---
ms.date: 07/15/2020
ms.topic: reference
title: DSC PackageManagement Resource
description: DSC PackageManagement Resource
---
# DSC PackageManagement Resource

Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0, Windows PowerShell 5.1

The **PackageManagement** resource in Windows PowerShell Desired State Configuration (DSC) provides
a mechanism to install or uninstall Package Management packages on a target node. This resource
requires the **PackageManagement** module, available from [https://PowerShellGallery.com](https://PowerShellGallery.com).

> [!IMPORTANT]
> The **PackageManagement** module should be at least version 1.1.7.0 for the following property
> information to be correct.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
PackageManagement [string] #ResourceName
{
    Name = [string]
    [ AdditionalParameters = [HashTable] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string]{ Absent | Present } ]
    [ MaximumVersion = [string] ]
    [ MinimumVersion = [string] ]
    [ ProviderName = [string] ]
    [ PsDscRunAsCredential = [PSCredential] ]
    [ RequiredVersion = [string] ]
    [ Source = [string] ]
    [ SourceCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Specifies the name of the Package to be installed or uninstalled. |
|AdditionalParameters |Provider specific hashtable of parameters that would be passed to `Get-Package -AdditionalArguments`. For example, for NuGet provider you can pass additional parameters like DestinationPath. |
|MaximumVersion |Specifies the maximum allowed version of the package that you want to find. If you do not add this parameter, the resource finds the highest available version of the package. |
|MinimumVersion |Specifies the minimum allowed version of the package that you want to find. If you do not add this parameter, the resource finds the highest available version of the package that also satisfies any maximum specified version specified by the **MaximumVersion** parameter. |
|ProviderName |Specifies a package provider name to which to scope your package search. You can get package provider names by running the `Get-PackageProvider` cmdlet. |
|RequiredVersion |Specifies the exact version of the package that you want to install. If you do not specify this parameter, this DSC resource installs the newest available version of the package that also satisfies any maximum version specified by the **MaximumVersion** parameter. |
|Source |Specifies the name of the package source where the package can be found. This can either be a URI or a source registered with `Register-PackageSource` or PackageManagementSource DSC resource. |
|SourceCredential |Specifies a user account that has rights to install a package for a specified package provider or source. |

## Additional Parameters

The following table lists options for the AdditionalParameters property.

|Parameter |Description |
|---|---|
|DestinationPath |Used by providers such as the built-in Nuget Provider. Specifies a file location where you want the package to be installed. |
|InstallationPolicy |Used by providers such as the built-in Nuget Provider. Determines whether you trust the package's source. One of: **Untrusted** or **Trusted**. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether the package is to be installed or uninstalled. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

This example installs the **JQuery** NuGet package and **GistProvider** PowerShell module using the
**PackageManagement** DSC resource. This example first ensures the required package sources are
available then defines the expected state of the **JQuery** and **GistProvider** packages (NuGet and
PowerShell, respectively).

```powershell
Configuration PackageTest
{
    PackageManagementSource SourceRepository
    {
        Ensure      = "Present"
        Name        = "MyNuget"
        ProviderName= "Nuget"
        SourceLocation   = "http://nuget.org/api/v2/"
        InstallationPolicy ="Trusted"
    }

    PackageManagementSource PSGallery
    {
        Ensure      = "Present"
        Name        = "psgallery"
        ProviderName= "PowerShellGet"
        SourceLocation   = "https://www.powershellgallery.com/api/v2"
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
