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

By using the built-in DSC **ConfigurationData** parameter, you can define data that can be used within a configuration. This allows you to create a single configuration
that can be used for multiple nodes or for different environments. For example, if you are developing an application, you can use one configuration for both development and production environments,
and use configuration data to specify data for each environment.

Let's look at a very simple example to see how this works. We'll create a single configuration that ensures that **IIS** is present on some nodes, and that **Hyper-V** is present on others: 

```powershell
Configuration MyDscConfiguration {
    
	Node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
		WindowsFeature IISInstall {
			Ensure = 'Present'
			Name   = 'Web-Server'
		}
		
	}
    Node $AllNodes.Where($_.Role -eq "VMHost").NodeName
    {
        WindowsFeature HyperVInstall {
            Ensure = 'Present'
			Name   = 'Hyper-V'
        }
    }
}

$MyData = 
@{
    AllNodes =
    @(
        @{
            NodeName    = 'VM-1'
            Role = 'WebServer'
        }

        @{
            NodeName    = 'VM-2'
            FeatureName = 'VMHost'
        }
    )
}

MyDscConfiguration -ConfigurationData $MyData
```

The last line in this script compiles the configuration into MOF documents, passing `$MyData` as the value **ConfigurationData** parameter. `$MyData` specifies two different nodes, each with
its own `NodeName` and `Role`. The actual configuration creates **Node** blocks dynamically by filtering the collection of nodes it gets from `$MyData` (a special variable named
**$AllNodes**) by their `Role` properties.

Now let's look at how this works in more detal.

## The ConfigurationData parameter

A DSC configuration takes a parameter named **ConfigurationData**, that you specify when you compile the configuration. For information about compiling configurations, 
see [DSC configurations](configurations.md).

The **ConfigurationData** parameter is a hasthtable that must have at least one key named **AllNodes**. It can also have other keys:

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

To apply a property to all nodes, you can create a member of the **AllNodes** array that has a **NodeName** of `*`. For example, to give every node a `LogPath` property, you could do this:

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

This is the equivalent of adding a property with a name of `LogPath` with a value of `"C:\Logs"` to each of the other blocks (`VM-1`, `VM-2`, and `VM-3`).

## Defining the ConfigurationData hashtable

You can define **ConfigurationData** either as a variable within the same script file as a configuration (as in our previous examples) or in a separate .psd1 file. 
To define **ConfigurationData** in a .psd1 file, create a file that contains only the hashtable that represents the configuration data.

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

To use configuration data that is defined in a .psd1 file, you pass the path and name of that file as the value of the **ConfigurationData** parameter when compiling the configuration:

```powershell
MyDscConfiguration -ConfigurationData .\MyData.psd1
```

## Using ConfigurationData variables in a configuration

DSC provides three special variables that can be used in a configuration script: **$AllNodes**, **$Node**, and **$ConfigurationData**.

- **$AllNodes** refers to the entire collection of nodes defined in **ConfigurationData**. You can filter the **AllNodes** collection by using **.Where()** and **.ForEach()**.
- **Node** refers to a particular entry in the **AllNodes** collection after it is filtered by using **.Where()** or **.ForEach()**.
- **ConfigurationData** refers to the entire hash table that is passed as the parameter when compiling a configuration.

## DevOps example

Let's look at a complete example that uses a single configuration to set up both development and production environments of a website. In the development environment,
both IIS and SQL Server are installed on a single nodes. In the production environment, IIS and SQL Server are installed on separate nodes. We'll use a configuration data .psd1
file to specify the data for the two different environments.

### Configuration data file

We'll define the development and production environment data in a file namd `DevProdEnvData.psd1` as follows:

```powershell
@{

    AllNodes = @(

        @{
            NodeName        = "*"
            SQLServerName   = "MySQLServer"
            SqlSource       = "C:\Software\Sql"
            DotNetSrc       = "C:\Software\sxs"
        },

        @{
            NodeName        = "Prod-SQL"
            Role            = "MSSQL"
        },

        @{
            NodeName        = "Prod-IIS"
            Role            = "Web"
            SiteContents    = "C:\Website\Prod\SiteContents\"
            SitePath        = "\\Prod-IIS\Website\"
        }

        @{
            NodeName         = "Dev"
            Role             = "MSSQL", "Web"
            SiteContents     = "C:\Website\Dev\SiteContents\"
            SitePath         = "\\Dev\Website\"

        }

    )

}

    )

}
```

### Configuration file

Now, in the configuration, we filter the nodes we defined in `DevProdEnvData.psd1` by their role (`MSSQL`, `Dev`, or both), and configure them accordingly. The development environment
has both the SQL Server and IIS on one node, while the production environment has them on two different nodes. The site contents is also different, as specified by the `SiteContents` properties.

At the end of the configuration script, we call the configuration (compile it into a MOF document), passing `DevProdEnvData.psd1` as the `$ConfigurationData` parameter.

```powershell
Configuration MyWebApp
{
    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module xSqlPs

    Node $AllNodes.Where{$_.Role -contains "MSSQL"}.Nodename
   {
        # Install prerequisites
        WindowsFeature installdotNet35
        {            
            Ensure      = "Present"
            Name        = "Net-Framework-Core"
            Source      = "c:\software\sxs"
        }

        # Install SQL Server
        xSqlServerInstall InstallSqlServer
        {
            InstanceName = $Node.SQLServerName
            SourcePath   = $Node.SqlSource
            Features     = "SQLEngine,SSMS"
            DependsOn    = "[WindowsFeature]installdotNet35"

        }
   }

   Node $AllNodes.Where($_.Role -contains "Web")
   {
        # Install the IIS role
        WindowsFeature IIS
        {
            Ensure       = 'Present'
            Name         = 'Web-Server'
        }

        # Install the ASP .NET 4.5 role
        WindowsFeature AspNet45
        {
            Ensure       = 'Present'
            Name         = 'Web-Asp-Net45'

        }

        # Stop the default website
        xWebsite DefaultSite 
        {
            Ensure       = 'Present'
            Name         = 'Default Web Site'
            State        = 'Stopped'
            PhysicalPath = 'C:\inetpub\wwwroot'
            DependsOn    = '[WindowsFeature]IIS'

        }

        # Copy the website content
        File WebContent

        {
            Ensure          = 'Present'
            SourcePath      = $Node.SiteContents
            DestinationPath = $Node.SitePath
            Recurse         = $true
            Type            = 'Directory'
            DependsOn       = '[WindowsFeature]AspNet45'

        }       


        # Create the new Website

        xWebsite NewWebsite

        {

            Ensure          = 'Present'
            Name            = $WebSiteName
            State           = 'Started'
            PhysicalPath    = $Node.SitePath
            DependsOn       = '[File]WebContent'
        }

    }

MyWebApp -ConfigurationData DevProdEnvData.psd1

}
   
## See Also
- [Credentials Options in Configuration Data](configDataCredentials.md)
- [DSC Configurations](configurations.md)