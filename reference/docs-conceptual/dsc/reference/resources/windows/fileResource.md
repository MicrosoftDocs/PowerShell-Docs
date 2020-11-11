---
ms.date: 07/16/2020
ms.topic: reference
title: DSC File Resource
description: DSC File Resource
---
# DSC File Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **File** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism
to manage files and folders on the target node. **DestinationPath** and **SourcePath** must both be
accessible by the target Node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
File [string] #ResourceName
{
    DestinationPath = [string]
    [ Attributes = [string[]] { Archive | Hidden | ReadOnly | System }]
    [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    [ Contents = [string] ]
    [ Credential = [PSCredential] ]
    [ Force = [bool] ]
    [ Recurse = [bool] ]
    [ SourcePath = [string] ]
    [ Type = [string] { Directory | File } ]
    [ MatchSource = [bool] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present } ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|DestinationPath |The location, on the target node, you want to ensure is **Present** or **Absent** with **Ensure**. |
|Attributes |The desired state of the attributes for the targeted file or directory. Valid values are _Archive_, _Hidden_, _ReadOnly_, and _System_. |
|Checksum |The checksum type to use when determining whether two files are the same. Valid values include: **SHA-1**, **SHA-256**, **SHA-512**, **createdDate**, **modifiedDate**. |
|Contents |Only valid when used with **Type** **File**. Indicates the contents to **Ensure** are **Present** or **Absent** from the targeted file. |
|Credential |The credentials that are required to access resources, such as source files. |
|Force |Overrides access operations that would result in an error (such as overwriting a file or deleting a directory that is not empty). Default value is `$false`. |
|Recurse |Only valid when used with **Type** **Directory**. Performs the state operation recursively to all directory content, subdirectories, and subdirectory content. Default value is `$false`. |
|SourcePath |The path from which to copy the file or folder resource. |
|Type |The type of resource being configured. Valid values are **Directory** and **File**. Default value is **File**. |
|MatchSource |Determines if the resource should monitor for new files added to the source directory after the initial copy. A value of `$true` indicates that, after the initial copy, any new source files should be copied to the destination. If set to `$false`, the resource caches the contents of the source directory and ignores any files added after the initial copy. Default value is `$false`. |

> [!WARNING]
> If you do not specify a value for **Credential** or **PSRunAsCredential**, the resource will use
> the computer account of the target node to access the **SourcePath**. When the **SourcePath** is a
> UNC share, this could result in an "Access Denied" error. Please ensure your permissions are set
> accordingly, or use the **Credential** or **PSRunAsCredential** properties to specify the account
> that should be used.

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether the file and **Contents** at the **Destination** should exist or not. Set this property to **Present** to ensure the file exists. Set it to **Absent** to ensure they do not exist. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

### Additional information

- When you only specify a **DestinationPath**, the resource ensures that the path exists if
  **Present** or does not exist if **Absent**.
- When you specify a **SourcePath** and a **DestinationPath** with a **Type** value of
  **Directory**, the resource copies source directory to the destination path. The properties
  **Recurse**, **Force**, and **MatchSource** change the type of copy operation performed, while
  **Credential** determines which account to use to access the source directory.
- If you do not set the **Recurse** property to `$true` when copying a directory, none of the
  contents of the existing directory will be copied. Only the directory specified will be copied.
- If you specified a value of **ReadOnly** for the **Attributes** property alongside a
  **DestinationPath**, **Ensure** **Present** would create the path specified, while **Contents**
  would set the contents of the file. An **Ensure** **Absent** setting would ignore the **Attributes**
  property entirely, and remove any file at the specified path.

## Example

The following example copies a directory and its subdirectories from a pull server to a target node
using the File Resource. If the operation succeeds, the Log resource writes a confirmation message
to the event log.

The source directory is a UNC path (`\\PullServer\DemoSource`) shared from the Pull Server. The
**Recurse** property ensures that all subdirectories are copied as well.

> [!IMPORTANT]
> The LCM on the target Node executes in the context of the local system account by default. To
> grant access to the **SourcePath**, give the target Node's computer account appropriate
> permissions. The **Credential** and **PSDSCRunAsCredential** both change the context the LCM uses
> to access the **SourcePath**. You still need to grant access to the account that will be used to
> access the **SourcePath**.

```powershell
Configuration FileResourceDemo
{
    Node "localhost"
    {
        File DirectoryCopy
        {
            Ensure = "Present" # Ensure the directory is Present on the target node.
            Type = "Directory" # The default is File.
            Recurse = $true # Recursively copy all subdirectories.
            SourcePath = "\\PullServer\DemoSource"
            DestinationPath = "C:\Users\Public\Documents\DSCDemo\DemoDestination"
        }

        Log AfterDirectoryCopy
        {
            # The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
            Message = "Finished running the file resource with ID DirectoryCopy"
            DependsOn = "[File]DirectoryCopy" # Depends on successful execution of the File resource.
        }
    }
}
```

For more on using **Credentials** in DSC see [Run As User](../../../configurations/runAsUser.md) or [Config Data Credentials](../../../configurations/configDataCredentials.md).
