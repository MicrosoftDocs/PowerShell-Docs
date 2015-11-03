# DSC WindowsProcess Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **WindowsProcess** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to configure processes on a target node.

## Syntax

```
WindowsProcess [string] #ResourceName
{
    Arguments = [string]
    Path = [string]
    [ Credential = [PSCredential] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ DependsOn = [string[]] ]
    [ StandardErrorPath = [string] ]
    [ StandardInputPath = [string] ]
    [ StandardOutputPath = [string] ]
    [ WorkingDirectory = [string] ]
}
```

## Properties
|  Property  |  Description   | 
|---|---| 
| Arguments| Indicates a string of arguments to pass to the process as-is. If you need to pass several arguments, put them all in this string.| 
| Path| Indicates the path to the process executable. If you set this property to the name of the executable, DSC will look in the __Path__ variable. If you give a fully qualified domain name, the process must exist there because DSC will not check the __Path__ variable in this case.| 
| Credential| Indicates the credentials for starting the process.| 
| Ensure| Indicates if the process exists. Set this property to "Present" to ensure that the process exists. Otherwise, set it to "Absent". The default is "Present".| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`` .| 
| StandardErrorPath| Indicates the directory path to write the standard error. Any existing file there will be overwritten.| 
| StandardInputPath| Indicates the standard input location.| 
| StandardOutputPath| Indicates the location to write the standard output. Any existing file there will be overwritten.| 
| WorkingDirectory| Indicates the location that will be used as the current working directory for the process.| 
