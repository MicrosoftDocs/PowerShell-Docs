---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC for Linux nxPackage Resource
---

# DSC for Linux nxPackage Resource

The **nxPackage** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to manage packages on a Linux node.

## Syntax

```
nxPackage <string> #ResourceName
{
    Name = <string>
    [ Ensure = <string> { Absent | Present }  ]
    [ PackageManager = <string> { Yum | Apt | Zypper } ]
    [ PackageGroup = <bool>]
    [ Arguments = <string> ]
    [ ReturnCode = <uint32> ]
    [ LogPath = <string> ]
    [ DependsOn = <string[]> ]

}
```

## Properties

|  Property |  Description |
|---|---|
| Name| The name of the package for which you want to ensure a specific state.|
| Ensure| Determines whether to check if the package exists. Set this property to "Present" to ensure the package exists. Set it to "Absent" to ensure the package does not exist. The default value is "Present".|
| PackageManager| Supported values are "yum", "apt", and "zypper". Specifies the package manager to use when installing packages. If **FilePath** is specified, the provided path will be used to install the package. Otherwise, a Package Manager will be used to install the package from a pre-configured repository. If neither **PackageManager** nor **FilePath** are provided, the default package manager for the system will be used.|
| FilePath| The file path where the package resides|
| PackageGroup| If **$true**, the **Name** is expected to be the name of a package group for use with a **PackageManager**. **PacakgeGroup** is not valid when providing a **FilePath**.|
| Arguments| A string of arguments that will be passed to the package exactly as provided.|
| ReturnCode| The expected return code. If the actual return code does not match the expected value provided here, the configuration will return an error.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the **ID** of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|

## Example

The following example ensures that the package named "httpd" is installed on a Linux computer, using the “Yum” package manager.

```
Import-DSCResource -Module nx

Node $node {
nxPackage httpd
{
    Name = "httpd"
    Ensure = "Present"
    PackageManager = "Yum"
}
}
```