---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Getting Started with PowerShell Desired State Configuration
---

# Getting Started with PowerShell Desired State Configuration #

This guide describes how to begin creating PowerShell Desired State Configuration documents and apply them to machines. It assumes basic familiarity with PowerShell cmdlets, modules, and functions. 


## Create a Configuration ##

[**Configurations**](https://msdn.microsoft.com/powershell/dsc/configurations) are documents that describe an environment. Environments consist of "**nodes**", which are commonly virtual or physical machines. 

Configurations can come in a variety of forms. The easiest way to create a new configuration is to create a .ps1 (PowerShell script) file. To do this, open your editor of choice. The PowerShell ISE is a good choice, since it understands DSC natively. Save the following as a PS1:

```powershell
configuration MyFirstConfiguration
{
    Import-DscResource -Name WindowsFeature

    Node localhost
    {
        WindowsFeature IIS
        {
            Name = "IIS"

        }
        
    }

}
```
## Parts of a Configuration ##
**Configuration** is a keyword that has been added to PowerShell 4.0. It signifies a special kind of PowerShell function used by Desired State Configuration. In this example, the function is named myFirstConfiguration. 

The next line is an import statement, similar to importing a module. It will be discussed later on.

"Node" defines the machine name this configuration will act on. Although this configuration is edited locally, configurations can reach out to remote nodes and configure them. 

Nodes can be machine names or IP addresses. You can have multiple nodes in a single configuration document. Using [configuration data](https://msdn.microsoft.com/powershell/dsc/configdata), you can also have the same configuration apply to multiple nodes. In this case, the node is "localhost" - which means the local computer. 

The next item is a [**resource**](https://msdn.microsoft.com/powershell/dsc/resources). Resources are building blocks of configurations. Each resource is a module that defines the implementation logic of a single aspect of a machine. You can view every resource on your machine by running **Get-DscResource** in PowerShell. Resources must be present on the local machine and imported before they can be used in a configuration with **Import-DscResource** which is on the second line of this configuration. 

**Enacting a Configuration**

If the script above is saved and run, no output will be produced. This is because a configuration is just a function, and the script above has defined the function but not yet run it. After the function is defined, it must be invoked:
```powershell
myFirstConfiguration
```

When executed, configuration functions validate the configuration is valid. It should have no syntax errors, resources should have all mandatory parameters defined, and all resources should be imported before execution.

Once the configuration is executed, it creates a folder with the name of the configuration containing a **.MOF file** for every node in the configuration. The .MOF file is a standards-based management format which is used by PowerShell DSC to communicate over the network.

To enact the configuration:
```powershell
Start-DscConfiguration -Path ./myFirstConfiguration
```
This creates a PowerShell job that reaches out to the nodes in the configuration and configures them. To see the output of the job, use -Wait. 
```powershell
Start-DscConfiguration -Path ./myFirstConfiguration -Wait
```

