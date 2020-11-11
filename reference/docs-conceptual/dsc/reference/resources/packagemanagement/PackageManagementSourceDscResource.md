---
ms.date: 07/15/2020
ms.topic: reference
title: DSC PackageManagementSource Resource
description: DSC PackageManagementSource Resource
---
# DSC PackageManagementSource Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **PackageManagementSource** resource in Windows PowerShell Desired State Configuration (DSC)
provides a mechanism to register or unregister Package Management sources on a target node.
**Package Management sources registered in this way are registered under the System context, usable
by the System account or by the DSC engine.** This resource requires the **PackageManagement**
module, available from the [PowerShell Gallery](https://PowerShellGallery.com).

> [!IMPORTANT]
> The **PackageManagement** module should be at least version 1.1.7.0 for the following property
> information to be correct.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
PackageManagementSource [String] #ResourceName
{
    Name = [string]
    ProviderName = [string]
    SourceLocation = [string]
    [ InstallationPolicy = [string]{ Trusted | Untrusted } ]
    [ SourceCredential = [PSCredential] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string]{ Absent | Present } ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Specifies the name of the package source to be registered or unregistered on your system. |
|ProviderName |Specifies the name of the OneGet provider through which you can interop with the package source. |
|SourceLocation |Specifies the URI of the package source. |
|InstallationPolicy |Used by providers such as the built-in Nuget Provider. Determines whether you trust the package's source. One of: **Untrusted** or **Trusted**. |
|SourceCredential |Provides access to the package on a remote source. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether the package source is to be registered or unregistered. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

This example registers the `https://nuget.org` package source using the **PackageManagementSource**
DSC resource.

```powershell
Configuration PackageManagementSourceTest
{
    PackageManagementSource SourceRepository
    {
        Ensure      = "Present"
        Name        = "MyNuget"
        ProviderName= "Nuget"
        SourceLocation   = "https://api.nuget.org/api/v3/"
        InstallationPolicy ="Trusted"
    }
}
```
