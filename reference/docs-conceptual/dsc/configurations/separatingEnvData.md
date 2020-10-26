---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Separating configuration and environment data
description: It can be useful to separate the data used in a DSC configuration from the configuration itself by using configuration data. By doing this, you can use a single configuration for multiple environments.
---

# Separating configuration and environment data

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

It can be useful to separate the data used in a DSC configuration from the configuration itself by
using configuration data. By doing this, you can use a single configuration for multiple
environments.

For example, if you are developing an application, you can use one configuration for both
development and production environments, and use configuration data to specify data for each
environment.

## What is configuration data?

Configuration data is data that is defined in a hashtable and passed to a DSC configuration when you
compile that configuration.

For a detailed description of the **ConfigurationData** hashtable, see
[Using configuration data](configData.md).

## A simple example

Let's look at a very simple example to see how this works. We'll create a single configuration that
ensures that **IIS** is present on some nodes, and that **Hyper-V** is present on others:

```powershell
Configuration MyDscConfiguration {

  Node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
  WindowsFeature IISInstall {
    Ensure = 'Present'
    Name   = 'Web-Server'
  }

 }
    Node $AllNodes.Where{$_.Role -eq "VMHost"}.NodeName
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
        },

        @{
            NodeName    = 'VM-2'
            Role = 'VMHost'
        }
    )
}

MyDscConfiguration -ConfigurationData $MyData
```

The last line in this script compiles the configuration, passing `$MyData` as the value
**ConfigurationData** parameter.

The result is that two MOF files are created:

```
    Directory: C:\DscTests\MyDscConfiguration


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        3/31/2017   5:09 PM           1968 VM-1.mof
-a----        3/31/2017   5:09 PM           1970 VM-2.mof
```

`$MyData` specifies two different nodes, each with its own `NodeName` and `Role`. The configuration
dynamically creates **Node** blocks by taking the collection of nodes it gets from `$MyData`
(specifically, `$AllNodes`) and filters that collection against the `Role` property..

## Using configuration data to define development and production environments

Let's look at a complete example that uses a single configuration to set up both development and
production environments of a website. In the development environment, both IIS and SQL Server are
installed on a single nodes. In the production environment, IIS and SQL Server are installed on
separate nodes. We'll use a configuration data .psd1 file to specify the data for the two different
environments.

### Configuration data file

We'll define the development and production environment data in a file named `DevProdEnvData.psd1`
as follows:

```powershell
@{

    AllNodes = @(

        @{
            NodeName        = "*"
            SQLServerName   = "MySQLServer"
            SqlSource       = "C:\Software\Sql"
            DotNetSrc       = "C:\Software\sxs"
            WebSiteName     = "New website"
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
        },

        @{
            NodeName         = "Dev"
            Role             = "MSSQL", "Web"
            SiteContents     = "C:\Website\Dev\SiteContents\"
            SitePath         = "\\Dev\Website\"
        }
    )
}
```

### Configuration script file

Now, in the configuration, which is defined in a `.ps1` file, we filter the nodes we defined in
`DevProdEnvData.psd1` by their role (`MSSQL`, `Dev`, or both), and configure them accordingly. The
development environment has both the SQL Server and IIS on one node, while the production
environment has them on two different nodes. The site contents is also different, as specified by
the `SiteContents` properties.

At the end of the configuration script, we call the configuration (compile it into a MOF document),
passing `DevProdEnvData.psd1` as the `$ConfigurationData` parameter.

> **Note:** This configuration requires the modules `xSqlPs` and `xWebAdministration` to be
> installed on the target node.

Let's define the configuration in a file named `MyWebApp.ps1`:

```powershell
Configuration MyWebApp
{
    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module xSqlPs
    Import-DscResource -Module xWebAdministration

    Node $AllNodes.Where{$_.Role -contains "MSSQL"}.NodeName
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

   Node $AllNodes.Where{$_.Role -contains "Web"}.NodeName
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
            Name            = $Node.WebSiteName
            State           = 'Started'
            PhysicalPath    = $Node.SitePath
            DependsOn       = '[File]WebContent'
        }

    }

}

MyWebApp -ConfigurationData DevProdEnvData.psd1
```

When you run this configuration, three MOF files are created (one for each named entry in the
**AllNodes** array):

```
    Directory: C:\DscTests\MyWebApp


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        3/31/2017   5:47 PM           2944 Prod-SQL.mof
-a----        3/31/2017   5:47 PM           6994 Dev.mof
-a----        3/31/2017   5:47 PM           5338 Prod-IIS.mof
```

## Using non-node data

You can add additional keys to the **ConfigurationData** hashtable for data that is not specific to
a node. The following configuration ensures the presence of two websites. Data for each website are
defined in the **AllNodes** array. The file `Config.xml` is used for both websites, so we define it
in an additional key with the name `NonNodeData`. Note that you can have as many additional keys as
you want, and you can name them anything you want. `NonNodeData` is not a reserved word, it is just
what we decided to name the additional key.

You access additional keys by using the special variable **$ConfigurationData**. In this example,
`ConfigFileContents` is accessed with the line:

```powershell
 Contents = $ConfigurationData.NonNodeData.ConfigFileContents
 ```

 in the `File` resource block.

```powershell
$MyData =
@{
    AllNodes =
    @(
        @{
            NodeName           = "*"
            LogPath            = "C:\Logs"
        },

        @{
            NodeName = "VM-1"
            SiteContents = "C:\Site1"
            SiteName = "Website1"
        },


        @{
            NodeName = "VM-2"
            SiteContents = "C:\Site2"
            SiteName = "Website2"
        }
    );

    NonNodeData =
    @{
        ConfigFileContents = (Get-Content C:\Template\Config.xml)
     }
}

configuration WebsiteConfig
{
    Import-DscResource -ModuleName xWebAdministration -Name MSFT_xWebsite

    node $AllNodes.NodeName
    {
        xWebsite Site
        {
            Name         = $Node.SiteName
            PhysicalPath = $Node.SiteContents
            Ensure       = "Present"
        }

        File ConfigFile
        {
            DestinationPath = $Node.SiteContents + "\\config.xml"
            Contents = $ConfigurationData.NonNodeData.ConfigFileContents
        }
    }
}
```

## See Also

- [Using configuration data](configData.md)
- [Credentials Options in Configuration Data](configDataCredentials.md)
- [DSC Configurations](configurations.md)
