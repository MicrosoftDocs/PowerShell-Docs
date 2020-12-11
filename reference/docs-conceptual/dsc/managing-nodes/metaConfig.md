---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Configuring the Local Configuration Manager
description: The Local Configuration Manager (LCM) is the engine of DSC that is responsible for parsing and applying configurations that are sent to the node.
---
# Configuring the Local Configuration Manager

> Applies To: Windows PowerShell 5.0

The Local Configuration Manager (LCM) is the engine of Desired State Configuration (DSC). The LCM
runs on every target node, and is responsible for parsing and enacting configurations that are sent
to the node. It is also responsible for a number of other aspects of DSC, including the following.

- Determining refresh mode (push or pull).
- Specifying how often a node pulls and enacts configurations.
- Associating the node with pull service.
- Specifying partial configurations.

You use a special type of configuration to configure the LCM to specify each of these behaviors. The
following sections describe how to configure the LCM.

Windows PowerShell 5.0 introduced new settings for managing Local Configuration Manager. For
information about configuring the LCM in Windows PowerShell 4.0, see
[Configuring the Local Configuration Manager in Previous Versions of Windows PowerShell](metaconfig4.md).

## Writing and enacting an LCM configuration

To configure the LCM, you create and run a special type of configuration that applies LCM settings.
To specify an LCM configuration, you use the DscLocalConfigurationManager attribute. The following
shows a simple configuration that sets the LCM to push mode.

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

The process of applying settings to LCM is similar to applying a DSC configuration. You will create
an LCM configuration, compile it to a MOF file, and apply it to the node. Unlike DSC configurations,
you do not enact an LCM configuration by calling the
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
cmdlet. Instead, you call
[Set-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Set-DscLocalConfigurationManager),
supplying the path to the LCM configuration MOF as a parameter. After you enact the LCM
configuration, you can see the properties of the LCM by calling the
[Get-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Get-DscLocalConfigurationManager)
cmdlet.

An LCM configuration can contain blocks only for a limited set of resources. In the previous
example, the only resource called is **Settings**. The other available resources are:

- **ConfigurationRepositoryWeb**: specifies an HTTP pull service for configurations.
- **ConfigurationRepositoryShare**: specifies an SMB share for configurations.
- **ResourceRepositoryWeb**: specifies an HTTP pull service for modules.
- **ResourceRepositoryShare**: specifies an SMB share for modules.
- **ReportServerWeb**: specifies an HTTP pull service to which reports are sent.
- **PartialConfiguration**: provides data to enable partial configurations.

## Basic settings

Other than specifying pull service endpoints/paths and partial configurations, all of the properties
of the LCM are configured in a **Settings** block. The following properties are available in a
**Settings** block.

|  Property  |  Type  |  Description   |
|----------- |------- |--------------- |
| ActionAfterReboot| string| Specifies what happens after a reboot during the application of a configuration. The possible values are __"ContinueConfiguration"__ and __"StopConfiguration"__. <ul><li> __ContinueConfiguration__: Continue applying the current configuration after machine reboot. This is the default value</li><li>__StopConfiguration__: Stop the current configuration after machine reboot.</li></ul>|
| AllowModuleOverwrite| bool| __$TRUE__ if new configurations downloaded from the pull service are allowed to overwrite the old ones on the target node. Otherwise, $FALSE.|
| CertificateID| string| The thumbprint of a certificate used to secure credentials passed in a configuration. For more information see [Want to secure credentials in Windows PowerShell Desired State Configuration?](https://devblogs.microsoft.com/powershell/want-to-secure-credentials-in-windows-powershell-desired-state-configuration/). <br> __Note:__ this is managed automatically if using Azure Automation DSC pull service.|
| ConfigurationDownloadManagers| CimInstance[]| Obsolete. Use __ConfigurationRepositoryWeb__ and __ConfigurationRepositoryShare__ blocks to define configuration pull service endpoints.|
| ConfigurationID| string| For backwards compatibility with older pull service versions. A GUID that identifies the configuration file to get from a pull service. The node will pull configurations on the pull service if the name of the configuration MOF is named ConfigurationID.mof.<br> __Note:__ If you set this property, registering the node with a pull service by using __RegistrationKey__ does not work. For more information, see [Setting up a pull client with configuration names](../pull-server/pullClientConfigNames.md).|
| ConfigurationMode| string | Specifies how the LCM actually applies the configuration to the target nodes. Possible values are __"ApplyOnly"__,__"ApplyAndMonitor"__, and __"ApplyAndAutoCorrect"__. <ul><li>__ApplyOnly__: DSC applies the configuration and does nothing further unless a new configuration is pushed to the target node or when a new configuration is pulled from a service. After initial application of a new configuration, DSC does not check for drift from a previously configured state. Note that DSC will attempt to apply the configuration until it is successful before __ApplyOnly__ takes effect. </li><li> __ApplyAndMonitor__: This is the default value. The LCM applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs. Note that DSC will attempt to apply the configuration until it is successful before __ApplyAndMonitor__ takes effect.</li><li>__ApplyAndAutoCorrect__: DSC applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs, and then re-applies the current configuration.</li></ul>|
| ConfigurationModeFrequencyMins| UInt32| How often, in minutes, the current configuration is checked and applied. This property is ignored if the ConfigurationMode property is set to ApplyOnly. The default value is 15.|
| DebugMode| string| Possible values are __None__, __ForceModuleImport__, and __All__. <ul><li>Set to __None__ to use cached resources. This is the default and should be used in production scenarios.</li><li>Setting to __ForceModuleImport__, causes the LCM to reload any DSC resource modules, even if they have been previously loaded and cached. This impacts the performance of DSC operations as each module is reloaded on use. Typically you would use this value while debugging a resource</li><li>In this release, __All__ is same as __ForceModuleImport__</li></ul> |
| RebootNodeIfNeeded| bool| Set this to `$true` to allow resources to reboot the Node using the `$global:DSCMachineStatus` flag. Otherwise, you will have to manually reboot the node for any configuration that requires it. The default value is `$false`. To use this setting when a reboot condition is enacted by something other than DSC (such as Windows Installer), combine this setting with the __PendingReboot__ resource in the [ComputerManagementDsc](https://github.com/PowerShell/ComputerManagementDsc) module.|
| RefreshMode| string| Specifies how the LCM gets configurations. The possible values are __"Disabled"__, __"Push"__, and __"Pull"__. <ul><li>__Disabled__: DSC configurations are disabled for this node.</li><li> __Push__: Configurations are initiated by calling the [Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration) cmdlet. The configuration is applied immediately to the node. This is the default value.</li><li>__Pull:__ The node is configured to regularly check for configurations from a pull service or SMB path. If this property is set to __Pull__, you must specify an HTTP (service) or SMB (share) path in a __ConfigurationRepositoryWeb__ or __ConfigurationRepositoryShare__ block.</li></ul>|
| RefreshFrequencyMins| Uint32| The time interval, in minutes, at which the LCM checks a pull service to get updated configurations and checks local configuration for drift. The configuration is applied regardless of whether an update was downloaded. This value is ignored if the LCM is not configured in pull mode. The default value is 30.|
| ReportManagers| CimInstance[]| Obsolete. Use __ReportServerWeb__ blocks to define an endpoint to send reporting data to a pull service.|
| ResourceModuleManagers| CimInstance[]| Obsolete. Use __ResourceRepositoryWeb__ and __ResourceRepositoryShare__ blocks to define pull service HTTP endpoints or SMB paths, respectively.|
| PartialConfigurations| CimInstance| Not implemented. Do not use.|
| StatusRetentionTimeInDays | UInt32| The number of days the LCM keeps the status of the current configuration.|

> [!NOTE]
> The LCM starts the **ConfigurationModeFrequencyMins** cycle based on:
>
> - A new metaconfig with a change to **ConfigurationModeFrequencyMins** is applied using
> `Set-DscLocalConfigurationManager`
> - A machine restart
>
> For any condition where the timer process experiences a crash, that will be detected within 30
> seconds and the cycle will be restarted. A concurrent operation could delay the cycle from being
> started, if the duration of this operation exceeds the configured cycle frequency, the next timer
> will not start. Example, the metaconfig is configured at a 15 minute pull frequency and a pull
> occurs at T1. The Node does not finish work for 16 minutes. The first 15 minute cycle is ignored,
> and next pull will happen at T1+15+15.
>
> The original intent in Pull scenarios was that the `RefreshFrequencyMins` is set to a longer
> time than the `ConfigurationModeFrequencyMins`. Local configurations would be manged primarily by
> `ConfigurationModeFrequencyMins` to avoid configuration drift and `RefreshFrequencyMins` is used
> to keep track of actual configuration changes made by administrator.

## Pull service

LCM configuration supports defining the following types of pull service endpoints:

- **Configuration server**: A repository for DSC configurations. Define configuration servers by
  using **ConfigurationRepositoryWeb** (for web-based servers) and **ConfigurationRepositoryShare**
  (for SMB-based servers) blocks.
- **Resource server**: A repository for DSC resources, packaged as PowerShell modules. Define
  resource servers by using **ResourceRepositoryWeb** (for web-based servers) and
  **ResourceRepositoryShare** (for SMB-based servers) blocks.
- **Report server**: A service that DSC sends report data to. Define report servers by using
  **ReportServerWeb** blocks. A report server must be a web service.

For more details on pull service see,
[Desired State Configuration Pull Service](../pull-server/pullServer.md).

## Configuration server blocks

To define a web-based configuration server, you create a **ConfigurationRepositoryWeb** block. A
**ConfigurationRepositoryWeb** defines the following properties.

|Property|Type|Description|
|---|---|---|
|AllowUnsecureConnection|bool|Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication.|
|CertificateID|string|The thumbprint of a certificate used to authenticate to the server.|
|ConfigurationNames|String[]|An array of names of configurations to be pulled by the target node. These are used only if the node is registered with the pull service by using a **RegistrationKey**. For more information, see [Setting up a pull client with configuration names](../pull-server/pullClientConfigNames.md).|
|RegistrationKey|string|A GUID that registers the node with the pull service. For more information, see [Setting up a pull client with configuration names](../pull-server/pullClientConfigNames.md).|
|ServerURL|string|The URL of the configuration service.|
|ProxyURL*|string|The URL of the http proxy to use when communicating with the configuration service.|
|ProxyCredential*|pscredential|Credential to use for the http proxy.|

> [!NOTE]
> Supported in Windows versions 1809 and later.

An example script to simplify configuring the ConfigurationRepositoryWeb value for on-premises nodes
is available - see
[Generating DSC metaconfigurations](/azure/automation/automation-dsc-onboarding#generating-dsc-metaconfigurations)

To define an SMB-based configuration server, you create a **ConfigurationRepositoryShare** block. A
**ConfigurationRepositoryShare** defines the following properties.

|  Property  |      Type       |                      Description                      |
| ---------- | --------------- | ----------------------------------------------------- |
| Credential | MSFT_Credential | The credential used to authenticate to the SMB share. |
| SourcePath | string          | The path of the SMB share.                            |

## Resource server blocks

To define a web-based resource server, you create a **ResourceRepositoryWeb** block.
A **ResourceRepositoryWeb** defines the following properties.

|        Property         |     Type     |                                                              Description                                                               |
| ----------------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| AllowUnsecureConnection | bool         | Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication. |
| CertificateID           | string       | The thumbprint of a certificate used to authenticate to the server.                                                                    |
| RegistrationKey         | string       | A GUID that identifies the node to the pull service.                                                                                   |
| ServerURL               | string       | The URL of the configuration server.                                                                                                   |
| ProxyURL*               | string       | The URL of the http proxy to use when communicating with the configuration service.                                                    |
| ProxyCredential*        | pscredential | Credential to use for the http proxy.                                                                                                  |

> [!NOTE]
> Supported in Windows versions 1809 and later.

An example script to simplify configuring the ResourceRepositoryWeb value for on-premises nodes is
available - see
[Generating DSC metaconfigurations](/azure/automation/automation-dsc-onboarding#generating-dsc-metaconfigurations)

To define an SMB-based resource server, you create a **ResourceRepositoryShare** block.
**ResourceRepositoryShare** defines the following properties.

|Property|Type|Description|
|---|---|---|
|Credential|MSFT_Credential|The credential used to authenticate to the SMB share. For an example of passing credentials, see [Setting up a DSC SMB pull server](../pull-server/pullServerSMB.md)|
|SourcePath|string|The path of the SMB share.|

## Report server blocks

To define a report server, you create a **ReportServerWeb** block. The report server role is not
compatible with SMB based pull service. **ReportServerWeb** defines the following properties.

|        Property         |     Type     |                                                              Description                                                               |
| ----------------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| AllowUnsecureConnection | bool         | Set to **$TRUE** to allow connections from the node to the server without authentication. Set to **$FALSE** to require authentication. |
| CertificateID           | string       | The thumbprint of a certificate used to authenticate to the server.                                                                    |
| RegistrationKey         | string       | A GUID that identifies the node to the pull service.                                                                                   |
| ServerURL               | string       | The URL of the configuration server.                                                                                                   |
| ProxyURL*               | string       | The URL of the http proxy to use when communicating with the configuration service.                                                    |
| ProxyCredential*        | pscredential | Credential to use for the http proxy.                                                                                                  |

> [!NOTE]
> Supported in Windows versions 1809 and later.

An example script to simplify configuring the ReportServerWeb value for on-premises nodes is
available - see
[Generating DSC metaconfigurations](/azure/automation/automation-dsc-onboarding#generating-dsc-metaconfigurations)

## Partial configurations

To define a partial configuration, you create a **PartialConfiguration** block. For more information
about partial configurations, see [DSC Partial configurations](../pull-server/partialConfigs.md).
**PartialConfiguration** defines the following properties.

|Property|Type|Description|
|---|---|---|
|ConfigurationSource|string[]|An array of names of configuration servers, previously defined in **ConfigurationRepositoryWeb** and **ConfigurationRepositoryShare** blocks, where the partial configuration is pulled from.|
|DependsOn|string{}|A list of names of other configurations that must be completed before this partial configuration is applied.|
|Description|string|Text used to describe the partial configuration.|
|ExclusiveResources|string[]|An array of resources exclusive to this partial configuration.|
|RefreshMode|string|Specifies how the LCM gets this partial configuration. The possible values are __"Disabled"__, __"Push"__, and __"Pull"__. <ul><li>__Disabled__: This partial configuration is disabled.</li><li> __Push__: The partial configuration is pushed to the node by calling the [Publish-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Publish-DscConfiguration) cmdlet. After all partial configurations for the node are either pushed or pulled from a service, the configuration can be started by calling `Start-DscConfiguration –UseExisting`. This is the default value.</li><li>__Pull:__ The node is configured to regularly check for partial configuration from a pull service. If this property is set to __Pull__, you must specify a pull service in a __ConfigurationSource__ property. For more information about Azure Automation pull service, see [Azure Automation DSC Overview](/azure/automation/automation-dsc-overview).</li></ul>|
|ResourceModuleSource|string[]|An array of the names of resource servers from which to download required resources for this partial configuration. These names must refer to service endpoints previously defined in **ResourceRepositoryWeb** and **ResourceRepositoryShare** blocks.|

> [!NOTE]
> partial configurations are supported with Azure Automation DSC, but only one configuration can be
> pulled from each automation account per node.

## See Also

### Concepts

[Desired State Configuration Overview](../overview/overview.md)

[Getting started with Azure Automation DSC](/azure/automation/automation-dsc-getting-started)

### Other Resources

[Set-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Set-DscLocalConfigurationManager)

[Setting up a pull client with configuration names](../pull-server/pullClientConfigNames.md)
