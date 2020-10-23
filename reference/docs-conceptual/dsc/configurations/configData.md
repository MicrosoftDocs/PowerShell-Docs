---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Using configuration data
description: This topic describes the structure of the ConfigurationData hashtable. This allows you to create a single configuration that can be used for multiple nodes or for different environments.
---

# Using configuration data in DSC

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

By using the built-in DSC **ConfigurationData** parameter, you can define data that can be used
within a configuration. This allows you to create a single configuration that can be used for
multiple nodes or for different environments. For example, if you are developing an application, you
can use one configuration for both development and production environments, and use configuration
data to specify data for each environment.

This topic describes the structure of the **ConfigurationData** hashtable. For examples of how to
use configuration data, see [Separating configuration and environment data](separatingEnvData.md).

## The ConfigurationData common parameter

A DSC configuration takes a common parameter, **ConfigurationData**, that you specify when you
compile the configuration. For information about compiling configurations, see
[DSC configurations](configurations.md).

The **ConfigurationData** parameter is a hashtable that must have at least one key named
**AllNodes**. It can also have one or more other keys.

> [!NOTE]
> The examples in this topic use a single additional key (other than the named **AllNodes** key)
> named `NonNodeData`, but you can include any number of additional keys, and name them whatever you
> want.

```powershell
$MyData =
@{
    AllNodes = @()
    NonNodeData = ""
}
```

The value of the **AllNodes** key is an array. Each element of this array is also a hash table that
must have at least one key named **NodeName**:

```powershell
$MyData =
@{
    AllNodes =
    @(
        @{
            NodeName = "VM-1"
        },


        @{
            NodeName = "VM-2"
        },


        @{
            NodeName = "VM-3"
        }
    );

    NonNodeData = ""
}
```

You can add other keys to each hash table as well:

```powershell
$MyData =
@{
    AllNodes =
    @(
        @{
            NodeName = "VM-1"
            Role     = "WebServer"
        },


        @{
            NodeName = "VM-2"
            Role     = "SQLServer"
        },


        @{
            NodeName = "VM-3"
            Role     = "WebServer"
        }
    );

    NonNodeData = ""
}
```

To apply a property to all nodes, you can create a member of the **AllNodes** array that has a
**NodeName** of `*`. For example, to give every node a `LogPath` property, you could do this:

```powershell
$MyData =
@{
    AllNodes =
    @(
        @{
            NodeName     = "*"
            LogPath      = "C:\Logs"
        },


        @{
            NodeName     = "VM-1"
            Role         = "WebServer"
            SiteContents = "C:\Site1"
            SiteName     = "Website1"
        },


        @{
            NodeName     = "VM-2"
            Role         = "SQLServer"
        },


        @{
            NodeName     = "VM-3"
            Role         = "WebServer"
            SiteContents = "C:\Site2"
            SiteName     = "Website3"
        }
    );
}
```

This is the equivalent of adding a property with a name of `LogPath` with a value of `"C:\Logs"` to
each of the other blocks (`VM-1`, `VM-2`, and `VM-3`).

## Defining the ConfigurationData hashtable

You can define **ConfigurationData** either as a variable within the same script file as a
configuration (as in our previous examples) or in a separate `.psd1` file. To define
**ConfigurationData** in a `.psd1` file, create a file that contains only the hashtable that
represents the configuration data.

For example, you could create a file named `MyData.psd1` with the following contents:

```powershell
@{
    AllNodes =
    @(
        @{
            NodeName    = 'VM-1'
            FeatureName = 'Web-Server'
        },

        @{
            NodeName    = 'VM-2'
            FeatureName = 'Hyper-V'
        }
    )
}
```

## Compiling a configuration with configuration data

To compile a configuration for which you have defined configuration data, you pass the configuration
data as the value of the **ConfigurationData** parameter.

This will create a MOF file for each entry in the **AllNodes** array. Each MOF file will be named
with the `NodeName` property of the corresponding array entry.

For example, if you define configuration data as in the `MyData.psd1` file above, compiling a
configuration would create both `VM-1.mof` and `VM-2.mof` files.

### Compiling a configuration with configuration data using a variable

To use configuration data that is defined as a variable in the same `.ps1` file as the
configuration, you pass the variable name as the value of the **ConfigurationData** parameter when
compiling the configuration:

```powershell
MyDscConfiguration -ConfigurationData $MyData
```

### Compiling a configuration with configuration data using a data file

To use configuration data that is defined in a .psd1 file, you pass the path and name of that file
as the value of the **ConfigurationData** parameter when compiling the configuration:

```powershell
MyDscConfiguration -ConfigurationData .\MyData.psd1
```

## Using ConfigurationData variables in a configuration

DSC provides the following special variables that can be used in a configuration script:

- **$AllNodes** refers to the entire collection of nodes defined in **ConfigurationData**. You can
  filter the **AllNodes** collection by using **.Where()** and **.ForEach()**.
- **ConfigurationData** refers to the entire hash table that is passed as the parameter when
  compiling a configuration.
- **MyTypeName** contains the [configuration](configurations.md) name the variable is used in. For
  example, in the configuration `MyDscConfiguration`, the `$MyTypeName` will have a value of
  `MyDscConfiguration`.
- **Node** refers to a particular entry in the **AllNodes** collection after it is filtered by using
  **.Where()** or **.ForEach()**.
  - You can read more about these methods in
    [about_arrays](/powershell/module/microsoft.powershell.core/about/about_arrays)

## Using non-node data

As we've seen in previous examples, the **ConfigurationData** hashtable can have one or more keys in
addition to the required **AllNodes** key. In the examples in this topic, we have used only a single
additional node, and named it `NonNodeData`. However, you can define any number of additional keys,
and name them anything you want.

For an example of using non-node data, see
[Separating configuration and environment data](separatingEnvData.md).

## See Also

- [Credentials Options in Configuration Data](configDataCredentials.md)
- [DSC Configurations](configurations.md)
