---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Package Resource
---
# DSC Package Resource

_Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0_

The **Package** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to install or uninstall packages, such as Windows Installer and setup.exe packages, on a target node.

## Syntax

```
Package [string] #ResourceName
{
    Name = [string]
    Path = [string]
    ProductId = [string]
    [ Arguments = [string] ]
    [ Credential = [PSCredential] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
    [ ReturnCode = [UInt32[]] ]
}
```

## Properties

| Property | Description |
| --- | --- |
| Name| Indicates the name of the package for which you want to ensure a specific state.|
| Path| Indicates the path where the package resides.|
| ProductId| Indicates the product ID that uniquely identifies the package.|
| Arguments| Lists a string of arguments that will be passed to the package exactly as provided.|
| Credential| Provides access to the package on a remote source. This property is not used to install the package. The package is always installed on the local system.|
| Ensure| Indicates if the package is installed. Set this property to "Absent" to ensure the package is not installed (or uninstall the package if it is installed). Set it to "Present" (the default value) to ensure the package is installed.|
| LogPath| Indicates the full path where you want the provider to save a log file to install or uninstall the package.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| ReturnCode| Indicates the expected return code. If the actual return code does not match the expected value provided here, the configuration will return an error.|

## Example

This example runs the .msi installer that is located at the specified path and has the specified product ID.

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