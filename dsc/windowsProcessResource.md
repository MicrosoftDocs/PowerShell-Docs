---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsProcess Resource
---
# DSC WindowsProcess Resource

_Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0_

The **WindowsProcess** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to configure processes on a target node.

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

| Property | Description |
| --- | --- |
| Arguments| Indicates a string of arguments to pass to the process as-is. If you need to pass several arguments, put them all in this string.|
| Path| The path to the process executable. If this the file name of the executable (not the fully qualified path), the DSC resource will search the environment **Path** variable (`$env:Path`) to find the executable file. If the value of this property is a fully qualified path, DSC will not use the **Path** environment variable to find the file, and will throw an error if the path does not exist. Relative paths are not allowed.|
| Credential| Indicates the credentials for starting the process.|
| Ensure| Indicates if the process exists. Set this property to "Present" to ensure that the process exists. Otherwise, set it to "Absent". The default is "Present".|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"` .|
| StandardErrorPath| Indicates the directory path to write the standard error. Any existing file there will be overwritten.|
| StandardInputPath| Indicates the standard input location.|
| StandardOutputPath| Indicates the location to write the standard output. Any existing file there will be overwritten.|
| WorkingDirectory| Indicates the location that will be used as the current working directory for the process.|