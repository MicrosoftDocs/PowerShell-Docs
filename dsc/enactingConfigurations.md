---
title:   Enacting configurations
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Enacting configurations

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

There are two ways to enact PowerShell Desired State Configuration (DSC) configurations: push mode and pull mode.

## Push mode

![Push mode](images/Push.png "How push mode works")

Push mode refers to a user actively applying a configuration to a target node by calling the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet.

After creating and compiling a configuration, you can enact it in push mode by calling the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet, 
setting the -Path parameter of the cmdlet to the path where the configuration MOF is located. For example, if the configuration MOF is located at `C:\DSC\Configurations\localhost.mof`, 
you would apply it to the local machine with the following command: `Start-DscConfiguration -Path 'C:\DSC\Configurations'`

> __Note__: By default, DSC runs a configuration as a background job. To run the configuration interactively, call the 
>[Start-DscConfiguration](https://technet.microsoft.com/library/dn521623.aspx) with the __-Wait__ parameter.


## Pull mode

![Pull Mode](images/Pull.png "How pull mode works")

In pull mode, pull clients are configured to get their desired state configurations from a remote pull server. Likewise, the pull server has been set up to host the DSC service, and 
has been provisioned with the configurations and resources that are required by the pull clients. Each one of the pull clients has a scheduled task that performs a periodic compliance 
check on the configuration of the node. When the event is triggered the first time, it causes the Local Configuration Manager (LCM) on the pull client to validate the configuration. 
If the pull client is configured as desired, nothing happens. Otherwise, the LCM makes a request to the pull server to get a given configuration. If that configuration exists on the pull 
server, and it passes initial validation checks, the configuration is transmitted to the pull client, where it is then executed by the LCM.

For more information on deploying a DSC Pull Server on premises, see the DSC Pull Server Configuration and Planning Guide.

If you would prefer to take advantage of an online service to host Pull Server functionality, see the [Azure Automation DSC](https://azure.microsoft.com/en-us/documentation/articles/automation-dsc-overview/) service.

The following topics explain how to set up pull servers and clients:

- [Setting up a web pull server](pullServer.md)
- [Setting up an SMB pull server](pullServerSMB.md)
- [Configuring a pull client](pullClientConfigID.md)

