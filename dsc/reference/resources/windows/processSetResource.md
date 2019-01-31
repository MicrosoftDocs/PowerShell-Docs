---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC ProcessSet Resource
---
# DSC WindowsProcess Resource

_Applies To: Windows PowerShell 5.0_

The **ProcessSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to configure processes on a target node. This resource is a [composite resource](../../../resources/authoringResourceComposite.md)
that calls the [WindowsProcess resource](windowsProcessResource.md) for each group specified in the
`GroupName` parameter.

## Syntax

```
WindowsProcess [string] #ResourceName
{
    Arguments = [string]
    Path = [string]
    [ Credential = [PSCredential] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ StandardOutputPath = [string] ]
    [ StandardErrorPath = [string] ]
    [ StandardInputPath = [string] ]
    [ WorkingDirectory = [string] ]
    [ DependsOn = [string[]] ]
}
```

## Properties

| Property | Description |
| --- | --- |
| Arguments| A string that contains arguments to pass to the process as-is. If you need to pass several arguments, put them all in this string.|
| Path| The paths to the process executables. If these are the names of the executable files (not fully qualified paths), the DSC resource will search the environment **Path** variable (`$env:Path`) to find the files. If the values of this property are fully qualified paths, DSC will not use the **Path** environment variable to find the files, and will throw an error if any of the paths do not exist. Relative paths are not allowed.|
| Credential| Indicates the credentials for starting the process.|
| Ensure| Specifies whether the processes exists. Set this property to "Present" to ensure that the process exists. Otherwise, set it to "Absent". The default is "Present".|
| StandardErrorPath| The path to which the processes write standard error. Any existing file there will be overwritten.|
| StandardInputPath| The stream from which the process receives standard input.|
| StandardOutputPath| The path of the file to which the processes write standard output. Any existing file there will be overwritten.|
| WorkingDirectory| The location used as the current working directory for the processes.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **_ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"` .|
