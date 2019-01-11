---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC File Resource
---

# DSC File Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The File resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage files and folders on the target node. The **DestinationPath** and **SourcePath** must both be accessible by the target Node.

## Syntax

```
File [string] #ResourceName
{
    DestinationPath = [string]
    [ Attributes = [string[]] { Archive | Hidden | ReadOnly | System }]
    [ Checksum = [string] { CreatedDate | ModifiedDate | SHA-1 | SHA-256 | SHA-512 } ]
    [ Contents = [string] ]
    [ Credential = [PSCredential] ]
    [ Ensure = [string] { Absent | Present } ]
    [ Force = [bool] ]
    [ Recurse = [bool] ]
    [ DependsOn = [string[]] ]
    [ SourcePath = [string] ]
    [ Type = [string] { Directory | File } ]
    [ MatchSource = [bool] ]
}
```

## Properties

|Property       |Description                                                                   |Required|Default|
|---------------|------------------------------------------------------------------------------|--------|-------|
|DestinationPath|The location, on the target node, you want to ensure is `Present` or `Absent`.|Yes|No|
|Attributes     |The desired state of the attributes for the targeted file or directory. Valid values are **Archive**, **Hidden**, **ReadOnly**, and **System**.|No|None|
|Checksum      |The checksum type to use when determining whether two files are the same. Valid values include: SHA-1, SHA-256, SHA-512, createdDate, modifiedDate.|No|Only the file or directory name is compared.|
|Contents       |Only valid when used with `File` type. Indicates the contents to Ensure are `Present` or `Absent` from the targeted file. |No|None|
|Credential     |The credentials that are required to access resources, such as source files.|No|The target node's Computer Account. (*see note*)|
|Ensure         |The desired state of the target file or directory. |No|**Present**|
|Force          |Overrides access operations that would result in an error (such as overwriting a file or deleting a directory that is not empty).|No|`$false`|
|Recurse        |Only valid when used with `Directory` type. Performs the state operation recursively to all subdirectories.|No|`$false`|
|DependsOn      |Sets a dependency on specified resource(s). This resource will only execute after successful execution of any dependent resources. You can specify dependent resources using the syntax `"[ResourceType]ResourceName"`. See [about_DependsOn](../../../configurations/resource-depends-on.md)|No|None|
|SourcePath     |The path from which to copy the file or folder resource.|No|None|
|Type           |The type of resource being configured. Valid values are `Directory` and `File`.|No|`File`|
|MatchSource    |Determines if the resource should monitor for new files added to the source directory after the initial copy. A value of `$true` indicates that, after the initial copy, any new source files should be copied to the destination. If set to `$False`, the resource caches the contents of the source directory and ignores any files added after the initial copy.|No|`$false`|

> [!WARNING]
> If you do not specify a value for `Credential` or `PSRunAsCredential` (PS V.5), the resource will use the computer account of the target node to access the `SourcePath`.  When the `SourcePath` is a UNC share, this could result in an "Access Denied" error. Please ensure your permissions are set accordingly, or use the `Credential` or `PSRunAsCredential` properties to specify the account that should be used.

## Present vs. Absent

Each DSC resource performs different operations based on the value you specify for the `Ensure` property. The values you specify for the above properties determines the state operation performed.

### Existence

When you only specify a `DestinationPath`, the resource ensures that the path exists (`Present`) or does not exist (`Absent`).

### Copy Operations

When you specify a `SourcePath` and a `DestinationPath` with a `Type` value of **Directory**, the resource copies source directory to the destination path. The properties `Recurse`, `Force`, and `MatchSource` change the type of copy operation performed, while `Credential` determines which account to use to access the source directory.

### Limitations

If you specified a value of `ReadOnly` for the `Attributes` property alongside a `DestinationPath`, `Ensure = "Present"` would create the path specified, while `Contents` would set the contents of the file.  An `Absent` state operation would ignore the `Attributes` property entirely, and remove any file at the specified path.

## Example

The following example copies a directory and its subdirectories from a pull server to a target node using the File Resource. If the operation succeeds, the Log resource writes a confirmation message to the event log.

The source directory is a UNC path (`\\PullServer\DemoSource`) shared from the Pull Server. The `Recurse` property ensures that all subdirectories are copied as well.

> [!IMPORTANT]
> The LCM on the target Node executes in the context of the local system account by default. To grant access to the **SourcePath**, give the target Node's computer account appropriate permissions. The **Credential** and **PSDSCRunAsCredential** (v5) both change the context the LCM uses to access the **SourcePath**. You still need to grant access to the account that will be used to access the **SourcePath**.

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
