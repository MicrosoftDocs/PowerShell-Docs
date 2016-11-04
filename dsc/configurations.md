---
title:   DSC Configurations
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# DSC Configurations

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

DSC configurations are PowerShell scripts that define a special type of function. 
To define a configuration, you use the PowerShell keyword __Configuration__.

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

Save the script as a .ps1 file.

## Configuration syntax

A configuration script consists of the following parts:

- The **Configuration** block. This is the outermost script block. You define it by using the **Configuration** keyword and providing a name. In this case, the name of the configuration is "MyDscConfiguration".
- One or more **Node** blocks. These define the nodes (computers or VMs) that you are configuring. In the above configuration, there is one **Node** block that targets a computer named "TEST-PC1".
- One or more resource blocks. This is where the configuration sets the properties for the resources that it is configuring. In this case, there are two resource blocks, each of which call the "WindowsFeature" resource.

Within a **Configuration** block, you can do anything that you normally could in a PowerShell function. For example, in the previous example, if you didn't want to hard code the name of the 
target computer in the configuration, you could add a parameter for the node name:

```powershell
Configuration MyDscConfiguration {

	param(
        [string[]]$ComputerName="localhost"
    )
	Node $ComputerName {
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

In this example, you specify the name of the node by passing it as the $ComputerName parameter when you [compile the configuraton](# Compiling the configuration). The name defaults to "localhost".

## Compiling the configuration
Before you can enact a configuration, you have to compile it into a MOF document. You do this by calling the configuration like you would a PowerShell function.
>__Note:__ To call a configuration, the function must be in global scope (as with any other PowerShell function). You can make this happen either by "dot-sourcing" the script, or by running the 
>configuration script by using F5 or clicking on the __Run Script__ button in the ISE. To dot-source the script, run the command `. .\myConfig.ps1` where `myConfig.ps1` is the name of the 
>script file that contains your configuration.

When you call the configuration, it:

- Resolves all variables 
- Creates a folder in the current directory with the same name as the configuration.
- Creates a file named _NodeName_.mof in the new directory, where _NodeName_ is the name of the target node of the configuration. If there are more than one nodes, a MOF file will be created for each node.

>__Note__: The MOF file contains all of the configuration information for the target node. Because of this, it’s important to keep it secure. For more information, see 
>[Securing the MOF file](secureMOF.md).

Compiling the first configuration above results in the following folder structure:

```powershell
PS C:\users\default\Documents\DSC Configurations> . .\MyDscConfiguration.ps1
PS C:\users\default\Documents\DSC Configurations> MyDscConfiguration
    Directory: C:\users\default\Documents\DSC Configurations\MyDscConfiguration
Mode                LastWriteTime         Length Name                                                                                              
----                -------------         ------ ----                                                                                         
-a----       10/23/2015   4:32 PM           2842 TEST-PC1.mof
```  

If the configuration takes a parameter, as in the second example, that has to be provided at compile time. Here's how that would look:

```powershell
PS C:\users\default\Documents\DSC Configurations> . .\MyDscConfiguration.ps1
PS C:\users\default\Documents\DSC Configurations> MyDscConfiguration -ComputerName 'MyTestNode'
    Directory: C:\users\default\Documents\DSC Configurations\MyDscConfiguration
Mode                LastWriteTime         Length Name                                                                                              
----                -------------         ------ ----                                                                                         
-a----       10/23/2015   4:32 PM           2842 MyTestNode.mof
```      

## Using DependsOn
A useful DSC keyword is __DependsOn__. Typically (though not necessarily always), DSC applies the resources in the order that they appear within the configuration. However, __DependsOn__ specifies which resources depend on other resources, and the LCM ensures that they are applied in the correct order, regardless of the order in which resource instances are defined. For example, a configuration might specify that an instance of the __User__ resource depends on the existence of a __Group__ instance:

```powershell
Configuration DependsOnExample {
    Node Test-PC1 {
        Group GroupExample {
            Ensure = "Present"
            GroupName = "TestGroup"
        }

        User UserExample {
            Ensure = "Present"
            UserName = "TestUser"
            FullName = "TestUser"
            DependsOn = "[Group]GroupExample"
        }
    }
}
```

## Using New Resources in Your Configuration
If you ran the previous examples, you might have noticed that you were warned that you were using a resource without explicitly importing it.
Today, DSC ships with 12 resources as part of the PSDesiredStateConfiguration module. Other resources in external modules must be placed in `$env:PSModulePath` in order to be recognized by the LCM. A new cmdlet, [Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx), can be used to determine what resources are installed on the system and available for use by the LCM. 
Once these modules have been placed in `$env:PSModulePath` and are properly recognized by [Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx), they still need to be loaded within your configuration. __Import-DscResource__ is a dynamic keyword that can only be recognized within a __Configuration__ block (i.e. it is not a cmdlet). __Import-DscResource__ supports two parameters:
* __ModuleName__ is the recommended way of using __Import-DscResource__. It accepts the name of the module that contains the resources to be imported (as well as a string array of module names). 
* __Name__ is the name of the resource to import. This is not the friendly name returned as "Name" by [Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx), but the class name used when defining the resource schema (returned as __ResourceType__ by [Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx)). 

## See Also
* [Windows PowerShell Desired State Configuration Overview](overview.md)
* [DSC Resources](resources.md)
* [Configuring The Local Configuration Manager](metaConfig.md)

