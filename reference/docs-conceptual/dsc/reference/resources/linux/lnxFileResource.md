---
ms.date: 07/17/2020
ms.topic: reference
title: DSC for Linux nxFile Resource
description: DSC for Linux nxFile Resource
---
# DSC for Linux nxFile Resource

The **nxFile** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to
manage files and directories on a Linux node.

## Syntax

```Syntax
nxFile <string> #ResourceName
{
    DestinationPath = <string>
    [ SourcePath = <string> ]
    [ Type = <string> { directory | file | link } ]
    [ Contents = <string> ]
    [ Checksum = <string> { ctime | mtime | md5 }  ]
    [ Recurse = <bool> ]
    [ Force = <bool> ]
    [ Links = <string> { follow | manage | ignore } ]
    [ Group = <string> ]
    [ Mode = <string> ]
    [ Owner = <string> ]
    [ DependsOn = <string[]> ]
    [ Ensure = <string> { Absent | Present }  ]
}
```

## Properties

|Property |Description |
|---|---|
|DestinationPath |Specifies the location where you want to ensure the state for a file or directory. |
|SourcePath |Specifies the path from which to copy the file or folder resource. This path may be a local path, or an `http/https/ftp` URL. Remote `http/https/ftp` URLs are only supported when the value of the **Type** property is **file**. |
|Type |Specifies whether the resource being configured is a directory or a file. Set this property to **directory** to indicate that the resource is a directory. Set it to **file** to indicate that the resource is a file. The default value is **file**. |
|Contents |Specifies the contents of a file, such as a particular string. |
|Checksum |Defines the type to use when determining whether two files are the same. If **Checksum** is not specified, only the file or directory name is used for comparison. Values are: **ctime**, **mtime**, or **md5**. |
|Recurse |Indicates if subdirectories are included. Set this property to `$true` to indicate that you want subdirectories to be included. The default is `$false`. This property is only valid when the **Type** property is set to **directory**. |
|Force |Certain file operations (such as overwriting a file or deleting a directory that is not empty) will result in an error. Using the **Force** property overrides such errors. The default value is `$false`. |
|Links |Specifies the desired behavior for symbolic links. Set this property to **follow** to follow symbolic links and act on the links target. For example, copy the file instead of the link. Set this property to **manage** to act on the link. For example, copy the link itself. Set this property to **ignore** to ignore symbolic links. |
|Group |The name of the **Group** to have permissions to the file or directory. |
|Mode |Specifies the desired permissions for the resource, in octal or symbolic notation. For example, **777** or **rwxrwxrwx**. If using symbolic notation, do not provide the first character which indicates directory or file. |
|Owner |The name of the group to own the file or directory. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether to check if the file exists. Set this property to **Present** to ensure the file exists. Set it to **Absent** to ensure the file does not exist. The default value is **Present**. |

## Additional Information

Linux and Windows use different line break characters in text files by default, and this can cause
unexpected results when configuring some files on a Linux computer with **nxFile**. There are
multiple ways to manage the content of a Linux file while avoiding issues caused by unexpected line
break characters:

1. Copy the file from a remote source (http, https, or ftp)

   Create a file on Linux with the desired contents, and stage it on a web or ftp server accessible
   the node(s) you will configure. Define the **SourcePath** property in the **nxFile** resource
   with the web or ftp URL to the file.

   ```powershell
   Import-DSCResource -Module nx

   Node $Node
   {
      nxFile resolvConf
      {
         SourcePath = "http://10.185.85.11/conf/resolv.conf"
         DestinationPath = "/etc/resolv.conf"
         Mode = "644"
         Type = "file"
      }
   }
   ```

1. Read the file contents in the PowerShell script with
   [Get-Content](xref:Microsoft.PowerShell.Management.Get-Content) after setting the **$OFS**
   property to use the Linux line-break character.

   ```powershell
   Import-DSCResource -Module nx

   Node $Node
   {
      $OFS = "`n"
      $Contents = Get-Content C:\temp\resolv.conf

      nxFile resolvConf
      {
         DestinationPath = "/etc/resolv.conf"
         Mode = "644"
         Type = "file"
         Contents = "$Contents"
      }
   }
   ```

1. Use a PowerShell function to replace Windows line breaks with Linux line-break characters.

   ```powershell
   Function LinuxString($inputStr){
      $outputStr = $inputStr.Replace("`r`n","`n")
      $outputStr += "`n"
      Return $outputStr
   }

   Import-DSCResource -Module nx

   Node $Node
   {
      $Contents = @'
   search contoso.com
   domain contoso.com
   nameserver 10.185.85.11
   '@
       $Contents = LinuxString $Contents

      nxFile resolvConf
      {
         DestinationPath = "/etc/resolv.conf"
         Mode = "644"
         Type = "file"
         Contents = $Contents
      }
   }
   ```

## Example

The following example ensures that the directory `/opt/mydir` exists, and that a file with specified
contents exists this directory.

```powershell
Import-DSCResource -Module nx

Node $node {
    nxFile DirectoryExample
    {
        Ensure = "Present"
        DestinationPath = "/opt/mydir"
        Type = "Directory"
    }

    nxFile FileExample
    {
        Ensure = "Present"
        Destinationpath = "/opt/mydir/myfile"
        Contents=@"
#!/bin/bash`necho "hello world"`n
"@
        Mode = "755"
        DependsOn = "[nxFile]DirectoryExample"
    }
}
```
