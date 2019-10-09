---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Nesting configurations
---

# Nesting DSC configurations

A nested configuration (also called composite configuration) is a configuration that is called within another configuration as if it were a resource.
Both configurations must be defined in the same file.

Let's look at a simple example:

```powershell
Configuration FileConfig
{
    param (
        [Parameter(Mandatory = $true)]
        [String] $CopyFrom,

        [Parameter(Mandatory = $true)]
        [String] $CopyTo
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    File FileTest
       {
           SourcePath = $CopyFrom
           DestinationPath = $CopyTo
           Ensure = 'Present'
       }

}

Configuration NestedFileConfig
{
    Node localhost
    {
        FileConfig NestedConfig
        {
            CopyFrom = 'C:\Test\TestFile.txt'
            CopyTo = 'C:\Test2'
        }
    }
}
```

In this example, `FileConfig` takes two mandatory parameters,  **CopyFrom** and **CopyTo**,
which are used as the values for the **SourcePath** and **DestinationPath** properties in the `File` resource block.
The `NestedConfig` configuration calls `FileConfig` as if it were a resource.
The properties in the `NestedConfig` resource block (**CopyFrom** and **CopyTo**) are the parameters of the `FileConfig` configuration.

## See Also

- [Composite resources--Using a DSC configuration as a resource](../resources/authoringResourceComposite.md)