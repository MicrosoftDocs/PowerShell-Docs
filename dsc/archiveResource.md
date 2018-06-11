---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Archive Resource
---

# DSC Archive Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The Archive resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to unpack archive (.zip) files at a specific path.

## Syntax
```MOF
Archive [string] #ResourceName
{
    Destination = [string]
    Path = [string]
    [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present } ]
    [ Force = [bool] ]
    [ Validate = [bool] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| Destination| Specifies the location where you want to ensure the archive contents are extracted.|
| Path| Specifies the source path of the archive file.|
| __Checksum__| Defines the type to use when determining whether two files are the same. If __Checksum__ is not specified, only the file or directory name is used for comparison. Valid values include: SHA-1, SHA-256, SHA-512, createdDate, modifiedDate, none (default). If you specify __Checksum__ without __Validate__, the configuration will fail.|
| Ensure| Determines whether to check if the content of the archive exists at the __Destination__. Set this property to __Present__ to ensure the contents exist. Set it to __Absent__ to ensure they do not exist. The default value is __Present__.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| Validate| Uses the Checksum property to determine if the archive matches the signature. If you specify Checksum without Validate, the configuration will fail. If you specify Validate without Checksum, a SHA-256 checksum is used by default.|
| Force| Certain file operations (such as overwriting a file or deleting a directory that is not empty) will result in an error. Using the Force property overrides such errors. The default value is False.|

## Example

The following example shows how to use the Archive resource to ensure that the contents of an archive file called Test.zip exist and are extracted at a given destination.

```
Archive ArchiveExample {
    Ensure = "Present"  # You can also set Ensure to "Absent"
    Path = "C:\Users\Public\Documents\Test.zip"
    Destination = "C:\Users\Public\Documents\ExtractionPath"
}
```