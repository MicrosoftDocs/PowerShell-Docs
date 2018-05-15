---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsPackageCab Resource
---

# DSC WindowsPackageCab Resource

> Applies To: Windows PowerShell 5.1 and later

The **WindowsPackageCab** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to install or uninstall
Windows cabinet (.cab) packages on a target node.

The target node must have the DISM PowerShell module installed. For information, see
[Use DISM in Windows PowerShell](https://msdn.microsoft.com/en-us/windows/hardware/commercialize/manufacture/desktop/use-dism-in-windows-powershell-s14).


## Syntax

```
{
    Name = [string]
    Ensure = [string] { Absent | Present }
    SourcePath = [string]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Indicates the name of the package for you want to ensure a specific state.|
| Ensure| Indicates if the package is installed. Set this property to "Absent" to ensure the package is not installed (or uninstall the package if it is installed). Set it to "Present" (the default value) to ensure the package is installed.|
| Path| Indicates the path where the package resides.|
| LogPath| Indicates the full path where you want the provider to save a log file to install or uninstall the package.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"``.|

## Example

The following example configuration takes input parameters, and ensures that the .cab file specified by the `$Name` parameter is installed.

```powershell
Configuration Sample_WindowsPackageCab
{
    param
    (
        [Parameter (Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,

        [Parameter (Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $SourcePath,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $LogPath
    )

    Import-DscResource -ModuleName 'PSDscResources'

    WindowsPackageCab WindowsPackageCab1
    {
        Name = $Name
        Ensure = 'Present'
        SourcePath = $SourcePath
        LogPath = $LogPath
    }
}
```