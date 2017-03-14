---
title:   Desired State Configuration Quick Start
ms.date:  2017-03-13
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  carmonm
ms.prod:  powershell
---

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

# Desired State Configuration Quick Start

This exercise walks through creating and applying a Desired State Configuration (DSC) configuration from start to finish.
The example we'll use ensures that a server has the `Web-Server` (IIS) feature enabled, 
and that the content for a simple "Hello World" website is present in the `intetpub\wwwroot` directory of that server.

For an overview of what DSC is and how it works, see [Desired State Configuration Overview for Decision Makers](DscForEngineers.md).

## Requirements

To run this example, you will need a computer running Windows Server 2012 or later and PowerShell 4.0 or later.

## Write and place the index.htm file

First, we'll create the HTML file that we will use as the website content.

In your root folder, create a folder named `test`.

In a text editor, type the following text:

```html
<head></head>
<body>
<p>Hello World!</p>
</body>
```

Save this as `index.htm` in the `test` folder you created earlier. 

## Write the configuration

A [DSC configuration](configurations.md) is a special PowerShell function that defines how you want to configure one or more target computers (nodes).

In the PowerShell ISE, type the following:

```powershell
Configuration WebsiteTest {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
	Node 'localhost' {

        # The first resource block ensures that the Web-Server (IIS) feature is enabled.
		WindowsFeature WebServer {
			Ensure = "Present"
			Name =	"Web-Server"
		}

        # The second resource block ensures that the website content copied to the website root folder.
		File WebsiteContent {
			Ensure = 'Present'
			SourcePath = 'c:\test\index.htm'
            DestinationPath = 'c:\inetpub\wwwroot'
		}
	}
} 
```

Save the file as `WebsiteTest.ps1`.

You can see that it looks like a PowerShell function, with the addition of the keyword **Configuration** used before the name of the function.

The **Node** block specifies the target node to be configured, in this case `localhost`.

The configuration calls two [resources](resources.md), [WindowsFeature](windowsFeatureResource.md) and [File](fileResource.md).
Resources do the work of ensuring that the target node is in the state defined by the configuration.

## Compile the configuration

For a DSC configuration to be applied to a node, it must first be compiled into a MOF file.
To do this, you run the configuration like a function.
In a PowerShell console, navigate to the same folder where you saved your configuration and run the following commands to compile the configuration into a MOF file:

```powershell
. .\WebsiteTest.ps1
WebsiteTest
```

This generates the following output:

```
Directory: C:\ConfigurationTest\WebsiteTest


Mode                LastWriteTime         Length Name                                                                                                                                                       
----                -------------         ------ ----                                                                                                                                                       
-a----        3/13/2017   5:20 PM           2746 localhost.mof
```

The first line makes the configuration function available in the console.
The second line runs the configuration.
The result is that a new folder, named `WebsiteTest` is created as a subfolder of the current folder.
The `WebsiteTest` folder contains a file named `localhost.mof`. 
It is this file that can then be applied to the target node.

## Apply the configuration

Now that you have the compiled MOF, you can apply the configuration to the target node (in this case, the local computer) by calling the
[Start-DscConfiguration](/reference/5.1/PSDesiredStateConfiguration/Start-DscConfiguration.md) cmdlet.

The `Start-DscConfiguration` cmdlet tells the [Local Configuration Manager (LCM)](metaConfig.md),
which is the engine of DSC, to apply the configuration.
The LCM does the work of calling the DSC resources to apply the configuration.

In a PowerShell console, navigate to the same folder where you saved your configuration and run the following command:

```powershell
Start-DscConfiguration .\WebsiteTest
```

## Test the configuration

You can call the [Get-DscConfigurationStatus](/reference/5.1/PSDesiredStateConfiguration/Get-DscConfigurationStatus.md)
cmdlet to see whether the configuration succeeded. 

You can also test the results directly, in this case by browsing to `http://localhost/` in a web browser. 
You should see the "Hello World" HTML page you created as the first step in this example.

## Next steps

- Find out more about DSC configurations at [DSC configurations](configurations.md).
- See what DSC resources are available, and how to create custom DSC resources at [DSC resources](resources.md).
- Find DSC configurations and resources in the [PowerShell Gallery](https://www.powershellgallery.com/).



