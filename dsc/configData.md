# Separating Configuration and Environment Data

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

In Windows PowerShell Desired State Configuration (DSC), it is possible to separate configuration data from the logic of your configuration. Another way to look at this is to consider the structural configuration (for example, a configuration might require that IIS be installed) as separate from the environmental configuration (that is, whether the situation is a test environment vs. a production one—the node names would be different, but the configuration applied to them would be the same). This has the following advantages:

* It allows you to reuse your configuration data for different resources, nodes, and configurations.
* Configuration logic is more reusable if it does not contain hard-coded data. This is similar to good scripting guidelines for functions.
* If some of the data needs to change, you can make the changes in one location, thereby saving time and reducing errors.

## Basic concepts and examples

To specify the environmental part of the configuration, DSC uses the **ConfigurationData** parameter, which is a hash table (or it can take a .psd1 file which contains the hash table). This hash table must have at least one key **AllNodes**, which has a structured value. For example:

```powershell
$MyData = 
@{
    AllNodes = @();
    NonNodeData = ""   
}
```

Note the AllNodes key, whose value is an array. Each element of this array is also a hash table, which requires NodeName as a key:

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

Each hash table entry in AllNodes corresponds to configuration data to a node in the configuration. In addition to the required NodeName key, you can add other keys to the hash table as well, for example:

```powershell
$MyData = 
@{
    AllNodes = 
    @(
        @{
            NodeName = "VM-1";
            
        },

 
        @{
            NodeName = "VM-2";
            Role     = "SQLServer"
        },

 
        @{
            NodeName = "VM-3";
            Role     = "WebServer"
        }
    );

    NonNodeData = ""   
}
```

DSC offers three special variables to use in the configuration script:

* **$AllNodes**: Refers to all of the nodes. You can use filtering with **.Where()** and **.ForEach()**, so instead of hard-coding node names to select particular nodes for action, you could write something like this to select VM-1 and VM-3 in the above example:

```powershell
configuration MyConfiguration
{
    node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
    }
}
```

* **$Node**: Once the set of nodes is filtered, you can use $Node to refer to the particular entry. For example:

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
            NodeName = "VM-1";
            Role     = "WebServer"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },

 
        @{
            NodeName = "VM-2";
            Role     = "SQLServer"
        },

 
        @{
            NodeName = "VM-3";
            Role     = "WebServer";
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
            NodeName = "VM-1";
            Role     = "WebServer"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },

 
        @{
            NodeName = "VM-2";
            Role     = "SQLServer"
        },
 

        @{
            NodeName = "VM-3";
            Role     = "WebServer";
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