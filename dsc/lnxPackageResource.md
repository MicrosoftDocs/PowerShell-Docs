# PowerShell Desired State Configuration nxPackage Resource

The __nxPackage__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage packages on a Linux node.

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
| PackageManager| Supported values are "yum", "apt", and "zypper". Specifies the package manager to use when installing packages. If __FilePath__ is specified, the provided path will be used to install the package. Otherwise, a Package Manager will be used to install the package from a pre-configured repository. If neither __PackageManager__ nor __FilePath__ are provided, the default package manager for the system will be used.| 
| FilePath| The file path where the package resides| 
| PackageGroup| If __$true__, the __Name__ is expected to be the name of a package group for use with a __PackageManager__. __PacakgeGroup__ is not valid when providing a __FilePath__.| 
| Arguments| A string of arguments that will be passed to the package exactly as provided.| 
| ReturnCode| The expected return code. If the actual return code does not match the expected value provided here, the configuration will return an error.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the __ID__ of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 


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
