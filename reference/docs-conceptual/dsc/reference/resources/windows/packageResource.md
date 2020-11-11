---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Package Resource
description: DSC Package Resource
---
# DSC Package Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Package** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to install or uninstall packages, such as Windows Installer and setup.exe packages, on a
target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Package [string] #ResourceName
{
    Name = [string]
    Path = [string]
    ProductId = [string]
    [ Arguments = [string] ]
    [ Credential = [PSCredential] ]
    [ LogPath = [string] ]
    [ ReturnCode = [UInt32[]] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the package for which you want to ensure a specific state. |
|Path |Indicates the path where the package resides. |
|ProductId |Indicates the product ID that uniquely identifies the package. |
|Arguments |Lists a string of arguments that will be passed to the package exactly as provided. |
|Credential |Provides access to the package on a remote source. This property is not used to install the package. The package is always installed on the local system. |
|LogPath |Indicates the full path where you want the provider to save a log file to install or uninstall the package. |
|ReturnCode |Indicates the expected return code. If the actual return code does not match the expected value provided here, the configuration will return an error. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if the package is installed. Set this property to **Absent** to ensure the package is not installed (or uninstall the package if it is installed). Set it to **Present** to ensure the package is installed. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

This example runs the .msi installer that is located at the specified path and has the specified
product ID.

```powershell
Configuration PackageTest
{
    Package PackageExample
    {
        Ensure      = "Present"  # You can also set Ensure to "Absent"
        Path        = "$Env:SystemDrive\TestFolder\TestProject.msi"
        Name        = "TestPackage"
        ProductId   = "ACDDCDAF-80C6-41E6-A1B9-8ABD8A05027E"
    }
}
```
