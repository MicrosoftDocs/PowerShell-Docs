---
title:   Separating Configuration and Environment Data
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Separating Configuration and Environment Data

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

By using the built-in DSC **ConfigurationData** parameter, you can separate 
to consider the structural configuration (for example, a configuration might require that IIS be installed) as separate from the environmental configuration (that is, whether the situation is a 
test environment vs. a production one—the node names would be different, but the configuration applied to them would be the same). This has the following advantages:

* It allows you to reuse your configuration data for different resources, nodes, and configurations.
* Configuration logic is more reusable if it does not contain hard-coded data. This is similar to good scripting guidelines for functions.
* If some of the data needs to change, you can make the changes in one location, thereby saving time and reducing errors.



## The ConfigurationData parameter

A DSC configuration takes a parameter named **ConfigurationData**. You can see this if you call the [Get-Command](https://technet.microsoft.com/en-us/library/hh849711.aspx) cmdlet
on a configuration and specify the `-Syntax` switch.

For example, if you define the following configuration:

```powershell
Configuration MyDscConfiguration {

	Node "TEST-PC1" {
		WindowsFeature MyFeatureInstance {
			Ensure = "Present"
			Name =	"RSAT"
		}
		WindowsFeature My2ndFeatureInstance {
			Ensure = "Present"
			Name = "Bitlocker"
		}
	}
}
```

And then call `Get-Command` on that configuration:

```powershell
PS C:\DscTests> Get-Command MyDscConfiguration -Syntax

MyDscConfiguration [[-InstanceName] <string>] [[-DependsOn] <string[]>] [[-PsDscRunAsCredential] <pscredential>] [[-OutputPath] <string>] [[-ConfigurationData] <hashtable>] [<CommonParameters
>]
```

You can see that the configuration takes a parameter named  **ConfigurationData** of type **hashtable**.
The **ConfigurationData** hasthtable must have at least one key named **AllNodes**. It can also have other keys:

```powershell
$MyData = 
@{
    AllNodes = @()
    NonNodeData = ""   
}
```

The value of the **AllNodes** key is an array. Each element of this array is also a hash table that must have at least one key named **NodeName**:

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

**ConfigurationData** can be defined as a variable within in the same script file as a configuration, or in separate .psd1 file. You specify **ConfigurationData** when you compile the configuration
by passing the name of either the variable or the file in which you defined it. For information about compiling configurations, see [DSC configurations](configurations.md).

## Defining ConfigurationData as a variable

You can define **ConfigurationData** as a variable within the same script file as a configuration. For example:

```powershell
Configuration MyDscConfiguration {
    
	Node $AllNodes.NodeName
    {
		WindowsFeature MyFeatureInstance {
			Ensure = "Present"
			Name =	$Node.FeatureName
		}
		
	}
}

$MyData = 
@{
    AllNodes =
    @(
        @{
            NodeName    = 'VM-1'
            FeatureName = 'Web-Server'
        }

        @{
            NodeName    = 'VM-2'
            FeatureName = 'Hyper-V'
        }
    )
}
```

You would compile this configuration as follows:

```powershell
MyConfiguration -ConfigurationData $MyData
```

This would create two different MOF documents, named `VM-1.mof` and `VM-2.mof`. When `VM-1.mof` is applied (by calling [Start-DscConfiguration](https://technet.microsoft.com/library/dn521623.aspx)),
it ensures that IIS is installed on `VM-1`. When `VM-2.mof` is applied, it ensures that Hyper-V is installed on `VM-2`.

## Defining ConfigurationData in a separate file

You can also define **ConfigurationData** in a separate .psd1 file. The file should contain only the hashtable that represents the configuration data.

For example, you could create a file named `MyData.psd1` with the following contents:

```powershell
@{
    AllNodes =
    @(
        @{
            NodeName    = 'VM-1'
            FeatureName = 'Web-Server'
        }

        @{
            NodeName    = 'VM-2'
            FeatureName = 'Hyper-V'
        }
    )
}
```

If you create a DSC configuration as follows:

```powershell
Configuration MyDscConfiguration {
    
	Node $AllNodes.NodeName
    {
		WindowsFeature MyFeatureInstance {
			Ensure = "Present"
			Name =	$Node.FeatureName
		}
		
	}
}
```

You can compile it with the following:

```powershell
MyDscConfiguration -ConfigurationData .\MyData.psd1
```

As in the previous example, his would create two different MOF documents, named `VM-1.mof` and `VM-2.mof`. When `VM-1.mof` is applied 
(by calling [Start-DscConfiguration](https://technet.microsoft.com/library/dn521623.aspx)), it ensures that IIS is installed on `VM-1`. When `VM-2.mof` is applied, it ensures 
that Hyper-V is installed on `VM-2`.

## Using ConfigurationData variables in a configuration

DSC provides three special variables that can be used in a configuration script: **$AllNodes**, **$Node**, and **$ConfigurationData**.

- **$AllNodes** refers to the entire collection of nodes defined in **ConfigurationData**. You can filter the **AllNodes** collection by using **.Where()** and **.ForEach()**.
- **Node** refers to a particular entry in the **AllNodes** collection after it is filtered by using **.Where()** or **.ForEach()**.
- **ConfigurationData** refers to the entire hash table that is passed as the parameter when compiling a configuration.

### Example 1: Filter nodes by role

Suppose you are deploying a website that uses data from a SQL Server database, and you want to the website itself to be hosted on one or more nodes, and the SQL server database to be
hosted on another node. You can use **ConfigurationData** to define server roles, and then create a configuration that filters nodes by role, and applies the appropriate configuration to
each node.

Create a file named `MyData.psd1` with the following contents:

```powershell
$MyData = 
@{
    AllNodes = 
    @(
        @{
            NodeName     = "VM-1"
            Role         = "WebServer"
            SiteName     = "Website1"
            SiteContents = "C:\Site1"
        },

 
        @{
            NodeName     = "VM-2"
            Role         = "SQLServer"
        },

 
        @{
            NodeName     = "VM-3"
            Role         = "WebServer"
            SiteName     = "Website1"
            SiteContents = "C:\Site1"
        }
    );

}
```

Now, in your configuration, you can filter nodes based on the roles defined in `MyData.psd1`, and configure each node appropriately:

```powershell
configuration MyConfiguration
{
    Import-DscResource -ModuleName xWebAdministration -Name MSFT_xWebsite

    node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
        xWebsite Site
        {
            Name         = $Node.SiteName
            PhysicalPath = $Node.SiteContents
            Ensure       = "Present"
        }
    }


}
```

* **$Node**: Once the set of nodes is filtered, you can use $Node to refer to the particular entry. For example:



To apply a property to all nodes, you can set NodeName = “*”. For example, to give every node the LogPath property, you could do this:

```
$MyData = 
@{
    AllNodes = 
    @(
        @{
            NodeName           = "*"
            LogPath            = "C:\Logs"
        },

 
        @{
            NodeName = "VM-1"
            Role     = "WebServer"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },

 
        @{
            NodeName = "VM-2"
            Role     = "SQLServer"
        },

 
        @{
            NodeName = "VM-3"
            Role     = "WebServer"
            SiteContents = "C:\Site2"
            SiteName = "Website3"
        }
    );
}
```

* **$ConfigurationData**: You can use this variable inside a configuration to access the configuration data hash table passed as a parameter. For example:

```powershell
$MyData = 
@{
    AllNodes = 
    @(
        @{
            NodeName           = "*"
            LogPath            = "C:\Logs"
        },

 
        @{
            NodeName = "VM-1"
            Role     = "WebServer"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },

 
        @{
            NodeName = "VM-2"
            Role     = "SQLServer"
        },
 

        @{
            NodeName = "VM-3"
            Role     = "WebServer"
            SiteContents = "C:\Site2"
            SiteName = "Website3"
        }
    );

    NonNodeData = 
    @{
        ConfigFileContents = (Get-Content C:\Template\Config.xml)
     }   
} 

configuration MyConfiguration
{
    Import-DscResource -ModuleName xWebAdministration -Name MSFT_xWebsite

    node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
        xWebsite Site
        {
            Name         = $Node.SiteName
            PhysicalPath = $Node.SiteContents
            Ensure       = "Present"
        }

        File ConfigFile
        {
            DestinationPath = $Node.SiteContents + "\\config.xml"
            Contents = $ConfigurationData.NonNodeData.ConfigFileContents
        }
    }
}
```

You can find a full example included in the [xWebAdministration module](https://powershellgallery.com/packages/xWebAdministration).

