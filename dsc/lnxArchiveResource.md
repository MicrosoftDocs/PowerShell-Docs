# PowerShell Desired State Configuration nxArchive Resource

The __nxArchive__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to unpack archive (.tar, .zip) files at a specific path on a Linux node.

## Syntax

```
nxArchive <string> #ResourceName
{
    SourcePath = <string>
    DestinationPath = <string>
    [ Checksum = <string> { ctime | mtime | md5 }  ]
    [ Force = <bool> ]
    [ DependsOn = <string[]> ]
    [ Ensure = <string> { Absent | Present }  ]
}
```

## Properties

|  Property |  Description | 
|---|---|
| SourcePath| Specifies the source path of the archive file. This should be a .tar, .zip, or .tar.gz file. | 
| DestinationPath| Specifies the location where you want to ensure the archive contents are extracted.| 
| Checksum| Defines the type to use when determining whether the source archive has been updated. Values are: "ctime", "mtime", or "md5". The default value is "md5".| 
| Force| Certain file operations (such as overwriting a file or deleting a directory that is not empty) will result in an error. Using the __Force__ property overrides such errors. The default value is __$false__.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the __ID__ of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 
| Ensure| Determines whether to check if the content of the archive exists at the __Destination__. Set this property to "Present" to ensure the contents exist. Set it to "Absent" to ensure they do not exist. The default value is "Present".| 

## Example

The following example shows how to use the __nxArchive__ resource to ensure that the contents of an archive file called `website.tar` exist and are extracted at a given destination.

```
Import-DSCResource -Module nx 

nxFile SyncArchiveFromWeb
{
   Ensure = "Present"
   SourcePath = “http://release.contoso.com/releases/website.tar”
   DestinationPath = "/usr/release/staging/website.tar"
   Type = "File"
   Checksum = “mtime”
}

nxArchive SyncWebDir
{
   SourcePath = “/usr/release/staging/website.tar”
   DestinationPath = “/usr/local/apache2/htdocs/”
   Force = $false
   DependsOn = "[nxFile]SyncArchiveFromWeb"
} 
```
