# PowerShell Desired State Configuration nxFileLine Resource


The __nxFileLine__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to to manage lines within a configuration file on a Linux node.

## Syntax

```
nxFileLine <string> #ResourceName
{
    FilePath = <string>
    ContainsLine = <string>
    [ DoesNotContainPattern = <string> ]
    [ DependsOn = <string[]> ]

}
```


## Properties


|  Property |  Description | 
|---|---|
| FilePath| The full path to the file to manage lines in on the target node.| 
| ContainsLine| A line to ensure exists in the file. This line will be appended to the file if it does not exist in the file. __ContainsLine__ is mandatory, but can be set to an empty string (`ContainsLine = ‘’``) if it is not needed.| 
| DoesNotContainPattern| A regular expression pattern for lines that should not exist in the file. For any lines that exist in the file that match this regular expression, the line will be removed from the file.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the __ID__ of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 

## Example


This example demonstrates using the __nxFileLine__ resource to configure the `/etc/sudoers` file, ensuring that the user: monuser is configured to not requiretty.

```
Import-DSCResource -Module nx 

nxFileLine DoNotRequireTTY
{
   FilePath = “/etc/sudoers”
   ContainsLine = 'Defaults:monuser !requiretty'
   DoesNotContainPattern = "Defaults:monuser[ ]+requiretty"
} 
```

