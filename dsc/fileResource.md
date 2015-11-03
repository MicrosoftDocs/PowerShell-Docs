# DSC File Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The File resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage files and folders on the target node.

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

|  Property  |  Description   | 
|---|---| 
| DestinationPath| Indicates the location where you want to ensure the state for a file or directory.| 
| Attributes| Specifies the desired state of the attributes for the targeted file or directory.| 
| Checksum| Indicates the checksum type to use when determining whether two files are the same. If __Checksum__ is not specified, only the file or directory name is used for comparison. Valid values include: SHA-1, SHA-256, SHA-512, createdDate, modifiedDate.| 
| Contents| Specifies the contents of a file, such as a particular string.| 
| Credential| Indicates the credentials that are required to access resources, such as source files, if such access is required.| 
| Ensure| Indicates if the file or directory exists. Set this property to "Absent" to ensure that the file or directory does not exist. Set it to "Present" to ensure that the file or directory does exist. The default is "Present".| 
| Force| Certain file operations (such as overwriting a file or deleting a directory that is not empty) will result in an error. Using the Force property overrides such errors. The default value is __$false__.| 
| Recurse| Indicates if subdirectories are included. Set this property to __$true__ to indicate that you want subdirectories to be included. The default is __$false__. **Note**: This property is only valid when the Type property is set to Directory.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 
| SourcePath| Indicates the path from which to copy the file or folder resource.| 
| Type| Indicates if the resource being configured is a directory or a file. Set this property to "Directory" to indicate that the resource is a directory. Set it to "File" to indicate that the resource is a file. The default value is “File”.| 
| MatchSource| If set to the default value of __$false__, then any files on the source (say, files A, B, and C) will be added to the destination the first time the configuration is applied. If a new file (D) is added to the source, it will not be added to the destination, even when the configuration is re-applied later. If the value is __$true__, then each time the configuration is applied, new files subsequently found on the source (such as file D in this example) are added to the destination.| 

## Example

The following example shows how to use the File resource to ensure that a directory with the path `C:\Users\Public\Documents\DSCDemo\DemoSource` on a source computer (such as the “pull” server) is also present (along with all subdirectories) on the target node. It also writes a confirmatory message to the log when complete and includes a statement to ensure that the file-checking operation runs prior to the logging operation.

```powershell
Configuration FileResourceDemo
{
    Node "localhost"
    {
        File DirectoryCopy
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Type = "Directory" # Default is "File".
            Recurse = $true # Ensure presence of subdirectories, too
            SourcePath = "C:\Users\Public\Documents\DSCDemo\DemoSource"
            DestinationPath = "C:\Users\Public\Documents\DSCDemo\DemoDestination"    
        }

        Log AfterDirectoryCopy
        {
            # The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
            Message = "Finished running the file resource with ID DirectoryCopy"
            DependsOn = "[File]DirectoryCopy" # This means run "DirectoryCopy" first.
        }
    }
}
```
