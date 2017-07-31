---
ms.date:  2017-06-12
author:  eslesar
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Configuring the Local Configuration Manager
---

# Configuring the Local Configuration Manager

> Applies To: Windows PowerShell 5.0

The Local Configuration Manager (LCM) is the engine of Windows PowerShell Desired State Configuration (DSC). The LCM runs on every target node, and is responsible for parsing and enacting configurations that are sent to the node. It is also responsible for a number of other aspects of DSC, including the following.

* Determining refresh mode (push or pull).
* Specifying how often a node pulls and enacts configurations.
* Associating the node with pull servers.
* Specifying partial configurations.

You use a special type of configuration to configure the LCM to specify each of these behaviors. The following sections describe how to configure the LCM.

> **Note**: This topic applies to the LCM introduced in Windows PowerShell 5.0. For information about configuring the LCM in Windows PowerShell 4.0, see [Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager](metaconfig4.md).

## Writing and enacting an LCM configuration

To configure the LCM, you create and run a special type of configuration. To specify an LCM configuration, you use the DscLocalConfigurationManager attribute. The following shows a simple configuration that sets the LCM to push mode.

```powershell
[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
        }
    }
} 
```

You call and run the configuration to create the configuration MOF, just as you would a normal configuration (for information on creating the configuration MOF, see [Compiling the configuration](configurations.md#compiling-the-configuration)). 
Unlike normal configurations, you do not enact an LCM configuration by calling the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet. 
Instead, you call the [Set-DscLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn521621.aspx) cmdlet, supplying the path to the configuration MOF as a parameter. 
After you enact the configuration, you can see the properties of the LCM by calling the [Get-DscLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn407378.aspx) cmdlet.

An LCM configuration can contain blocks only for a limited set of resources. In the previous example, the only resource called is **Settings**. The other available resources are:

* **ConfigurationRepositoryWeb**: specifies an HTTP pull server for configurations. 
* **ConfigurationRepositoryShare**: specifies an SMB pull server for configurations.
* **ResourceRepositoryWeb**: specifies an HTTP pull server for modules.
* **ResourceRepositoryShare**: specifies an SMB pull server for modules.
* **ReportServerWeb**: specifies an HTTP pull server to which reports are sent.
* **PartialConfiguration**: specifies partial configurations.

## Basic settings

Other than specifying pull servers and partial configurations, all of the properties of the LCM are configured in a **Settings** block. The following properties are available in a **Settings** block.

|  Property  |  Type  |  Description   | 
|----------- |------- |--------------- | 
| ConfigurationModeFrequencyMins| UInt32| How often, in minutes, the current configuration is checked and applied. This property is ignored if the ConfigurationMode property is set to ApplyOnly. The default value is 15.| 
| RebootNodeIfNeeded| bool| Set this to __$true__ to automatically reboot the node after a configuration that requires reboot is applied. Otherwise, you will have to manually reboot the node for any configuration that requires it. The default value is __$false__.| 
| ConfigurationMode| string | Specifies how the LCM actually applies the configuration to the target nodes. Possible values are __"ApplyOnly"__,__"ApplyandMonitior"__, and __"ApplyandAutoCorrect"__. <ul><li>__ApplyOnly__: DSC applies the configuration and does nothing further unless a new configuration is pushed to the target node or when a new configuration is pulled from a server. After initial application of a new configuration, DSC does not check for drift from a previously configured state. Note that DSC will attempt to apply the configuration until it is successful before __ApplyOnly__ takes effect. </li><li> __ApplyAndMonitor__: This is the default value. The LCM applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs. Note that DSC will attempt to apply the configuration until it is successful before __ApplyAndMonitor__ takes effect.</li><li>__ApplyAndAutoCorrect__: DSC applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs, and then re-applies the current configuration.</li></ul>| 
| ActionAfterReboot| string| Specifies what happens after a reboot during the application of a configuration. The possible values are __"ContinueConfiguration"__ and __"StopConfiguration"__. <ul><li> __ContinueConfiguration__: Continue applying the current configuration after machine reboot. This is the default falue</li><li>__StopConfiguration__: Stop the current configuration after machine reboot.</li></ul>| 
| RefreshMode| string| Specifies how the LCM gets configurations. The possible values are __"Disabled"__, __"Push"__, and __"Pull"__. <ul><li>__Disabled__: DSC configurations are disabled for this node.</li><li> __Push__: Configurations are initiated by calling the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet. The configuration is applied immediately to the node. This is the default value.</li><li>__Pull:__ The node is configured to regularly check for configurations from a pull server. If this property is set to __Pull__, you must specify a pull server in a __ConfigurationRepositoryWeb__ or __ConfigurationRepositoryShare__ block. For more information about pull servers, see [Setting up a DSC pull server](pullServer.md).</li></ul>|  
| CertificateID| string| The thumbprint of a certificate used to secure credentials passed in a configuration. For more information see [Want to secure credentials in Windows PowerShell Desired State Configuration](http://blogs.msdn.com/b/powershell/archive/2014/01/31/want-to-secure-credentials-in-windows-powershell-desired-state-configuration.aspx)?.| 
| ConfigurationID| string| A GUID that identifies the configuration file to get from a pull server in pull mode. The node will pull configurations on the pull server if the name of the configuration MOF is named ConfigurationID.mof.<br> __Note:__ If you set this property, registering the node with a pull server by using __RegistrationKey__ does not work. For more information, see [Setting up a pull client with configuration names](pullClientConfigNames.md).| 
| RefreshFrequencyMins| Uint32| The time interval, in minutes, at which the LCM checks a pull server to get updated configurations. This value is ignored if the LCM is not configured in pull mode. The default value is 30.| 
| AllowModuleOverwrite| bool| __$TRUE__ if new configurations downloaded from the configuration server are allowed to overwrite the old ones on the target node. Otherwise, $FALSE.| 
| DebugMode| string| Possible values are __None__, __ForceModuleImport__, and __All__. <ul><li>Set to __None__ to use cached resources. This is the default and should be used in production scenarios.</li><li>Setting to __ForceModuleImport__, causes the LCM to reload any DSC resource modules, even if they have been previously loaded and cached. This impacts the performance of DSC operations as each module is reloaded on use. Typically you would use this value while debugging a resource</li><li>In this release, __All__ is same as __ForceModuleImport__</li></ul> |
| ConfigurationDownloadManagers| CimInstance[]| Obsolete. Use __ConfigurationRepositoryWeb__ and __ConfigurationRepositoryShare__ blocks to define configuration pull servers.| 
| ResourceModuleManagers| CimInstance[]| Obsolete. Use __ResourceRepositoryWeb__ and __ResourceRepositoryShare__ blocks to define resource pull servers.| 
| ReportManagers| CimInstance[]| Obsolete. Use __ReportServerWeb__ blocks to define report pull servers.| 
| PartialConfigurations| CimInstance| Not implemented. Do not use.| 
| StatusRetentionTimeInDays | UInt32| The number of days the LCM keeps the status of the current configuration.| 

## Pull servers

A pull server is either an OData web service or an SMB share that is used as a central location for DSC files. LCM configuration supports defining the following types of pull servers:

* **Configuration server**: A repository for DSC configurations. Define configuration servers by using **ConfigurationRepositoryWeb** (for web-based servers) and **ConfigurationRepositoryShare** (for SMB-based servers) blocks.
* Resource server—A repository for DSC resources, packaged as PowerShell modules. Define resource servers by using **ResourceRepositoryWeb** (for web-based servers) and **ResourceRepositoryShare** (for SMB-based servers) blocks.
* Report server—A service that DSC sends report data to. Define report servers by using **ReportServerWeb** blocks. A report server must be a web service.

For information about setting up and using pull servers, see [Setting up a DSC pull server](pullServer.md).

## Configuration server blocks

To define a web-based configuration server, you create a **ConfigurationRepositoryWeb** block. A **ConfigurationRepositoryWeb** defines the following properties.

|Property|Type|Description|
|---|---|---| 
|AllowUnsecureConnection|bool|Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication.|
|CertificateID|string|The thumbprint of a certificate used to authenticate to the server.|
|ConfigurationNames|String[]|An array of names of configurations to be pulled by the target node. These are used only if the node is registered with the pull server by using a **RegistrationKey**. For more information, see [Setting up a pull client with configuration names](pullClientConfigNames.md).|
|RegistrationKey|string|A GUID that registers the node with the pull server. For more information, see [Setting up a pull client with configuration names](pullClientConfigNames.md).|
|ServerURL|string|The URL of the configuration server.|

To define an SMB-based configuration server, you create a **ConfigurationRepositoryShare** block. A **ConfigurationRepositoryShare** defines the following properties.

|Property|Type|Description|
|---|---|---|
|Credential|MSFT_Credential|The credential used to authenticate to the SMB share.|
|SourcePath|string|The path of the SMB share.|

## Resource server blocks

To define a web-based resource server, you create a **ResourceRepositoryWeb** block. A **ResourceRepositoryWeb** defines the following properties.

|Property|Type|Description|
|---|---|---|
|AllowUnsecureConnection|bool|Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication.|
|CertificateID|string|The thumbprint of a certificate used to authenticate to the server.|
|RegistrationKey|string|A GUID that identifies the node to the pull server. For more information, see How to register a node with a DSC pull server.|
|ServerURL|string|The URL of the configuration server.|
 
To define an SMB-based resource server, you create a **ResourceRepositoryShare** block. **ResourceRepositoryShare** defines the following properties.

|Property|Type|Description|
|---|---|---|
|Credential|MSFT_Credential|The credential used to authenticate to the SMB share. For an example of passing credentials, see [Setting up a DSC SMB pull server](pullServerSMB.md)|
|SourcePath|string|The path of the SMB share.|

## Report server blocks

A report server must be an OData web service. To define a report server, you create a **ReportServerWeb** block. **ReportServerWeb** defines the following properties.

|Property|Type|Description|
|---|---|---|
|AllowUnsecureConnection|bool|Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication.|
|CertificateID|string|The thumbprint of a certificate used to authenticate to the server.|
|RegistrationKey|string|A GUID that identifies the node to the pull server. For more information, see How to register a node with a DSC pull server.|
|ServerURL|string|The URL of the configuration server.|

## Partial configurations

To define a partial configuration, you create a **PartialConfiguration** block. For more information about partial configurations, see [DSC Partial configurations](partialConfigs.md). **PartialConfiguration** defines the following properties.

|Property|Type|Description|
|---|---|---| 
|ConfigurationSource|string[]|An array of names of configuration servers, previously defined in **ConfigurationRepositoryWeb** and **ConfigurationRepositoryShare** blocks, where the partial configuration is pulled from.|
|DependsOn|string{}|A list of names of other configurations that must be completed before this partial configuration is applied.|
|Description|string|Text used to describe the partial configuration.|
|ExclusiveResources|string[]|An array of resources exclusive to this partial configuration.|
|RefreshMode|string|Specifies how the LCM gets this partial configuration. The possible values are __"Disabled"__, __"Push"__, and __"Pull"__. <ul><li>__Disabled__: This partial configuration is disabled.</li><li> __Push__: The partial configuration is pushed to the node by calling the [Publish-DscConfiguration](https://technet.microsoft.com/en-us/library/mt517875.aspx) cmdlet. After all partial configurations for the node are either pushed or pulled from a server, the configuration can be started by calling `Start-DscConfiguration –UseExisting`. This is the default value.</li><li>__Pull:__ The node is configured to regularly check for partial configuration from a pull server. If this property is set to __Pull__, you must specify a pull server in a __ConfigurationSource__ property. For more information about pull servers, see [Setting up a DSC pull server](pullServer.md).</li></ul>|
|ResourceModuleSource|string[]|An array of the names of resource servers from which to download required resources for this partial configuration. These names must refer to resource servers previously defined in **ResourceRepositoryWeb** and **ResourceRepositoryShare** blocks.|

## See Also 

### Concepts
[Windows PowerShell Desired State Configuration Overview](overview.md)
 
[Setting up a DSC pull server](pullServer.md)

[Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager](metaConfig4.md)

### Other Resources
[Set-DscLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn521621.aspx)

[Setting up a pull client with configuration names](pullClientConfigNames.md)

