---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Archive Resource
description: DSC Archive Resource
---
# DSC Archive Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The Archive resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to
unpack archive (.zip) files at a specific path.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Archive [string] #ResourceName
{
    Destination = [string]
    Path = [string]
    [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    [ Credential = [PSCredential] ]
    [ Force = [bool] ]
    [ Validate = [bool] ]
    [ Ensure = [string] { Absent | Present } ]
    [ DependsOn = [string[]] ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
| Destination | Specifies the location where you want to ensure the archive contents are extracted. |
| Path | Specifies the source path of the archive file. |
| Checksum | Defines the type to use when determining whether two files are the same. If **Checksum** is not specified, only the file or directory name is used for comparison. Valid values include: **SHA-1**, **SHA-256**, **SHA-512**, **createdDate**, **modifiedDate**. If you specify **Checksum** without **Validate**, the configuration will fail. |
| Credential | The credential of a user account with permissions to access the specified archive path and destination if needed. |
| Force | Certain file operations (such as overwriting a file or deleting a directory that is not empty) will result in an error. Using the **Force** property overrides such errors. The default value is **False**. |
| Validate| Uses the **Checksum** property to determine if the archive matches the signature. If you specify **Checksum** without **Validate**, the configuration will fail. If you specify **Validate** without **Checksum**, a _SHA-256_ **Checksum** is used by default. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether to check if the content of the archive exists at the **Destination**. Set this property to **Present** to ensure the contents exist. Set it to **Absent** to ensure they do not exist. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

The following example shows how to use the Archive resource to ensure that the contents of an
archive file called `Test.zip` exist and are extracted at a given destination using and authorized.

```powershell
Archive ArchiveExample {
    Ensure = "Present"
    Path = "C:\Users\Public\Documents\Test.zip"
    Destination = "C:\Users\Public\Documents\ExtractionPath"
}
```
