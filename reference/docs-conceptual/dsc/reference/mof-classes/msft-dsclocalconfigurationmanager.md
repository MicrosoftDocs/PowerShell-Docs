---
ms.date: 07/14/2020
ms.topic: reference
title: MSFT_DSCLocalConfigurationManager class
description: MSFT_DSCLocalConfigurationManager class
---
# MSFT_DSCLocalConfigurationManager class

The Local Configuration Manager (LCM) that controls the states of configuration files and uses
Configuration Agent to apply the configurations.

The following syntax is simplified from Managed Object Format (MOF) code and includes all of the
inherited properties.

## Syntax

```
[ClassVersion("1.0.0"), dynamic, provider("dsccore"), AMENDMENT]
class MSFT_DSCLocalConfigurationManager
{
};
```

## Members

The **MSFT_DSCLocalConfigurationManager** class has the following members:

- [Methods][]

### Methods

The **MSFT_DSCLocalConfigurationManager** class has these methods.

|Methods |Description |
|:--- |:---|
| [ApplyConfiguration(boolean)](msft-dsclocalconfigurationmanager-applyconfiguration.md)| Uses the Configuration Agent to apply the configuration that is pending.|
| [DisableDebugConfiguration()](msft-dsclocalconfigurationmanager-disabledebugconfiguration.md)| Disables DSC resource debugging.|
| [EnableDebugConfiguration(boolean)](msft-dsclocalconfigurationmanager-enabledebugconfiguration.md)| Enables DSC resource debugging.|
| [GetConfiguration()](msft-dsclocalconfigurationmanager-getconfiguration.md)| Sends the configuration document to the managed node and uses the **Get** method of the Configuration Agent to apply the configuration.|
| [GetConfigurationResultOutput](msft-dsclocalconfigurationmanager-getconfigurationresultoutput.md)| Gets the Configuration Agent output relating to a specific job.|
| [GetConfigurationStatus](msft-dsclocalconfigurationmanager-getconfigurationstatus.md)| Get the configuration status history.|
| [GetMetaConfiguration](msft-dsclocalconfigurationmanager-getmetaconfiguration.md)| Gets the LCM settings that are used to control Configuration Agent.|
| [PerformRequiredConfigurationChecks](msft-dsclocalconfigurationmanager-performrequiredconfigurationchecks.md)| Starts the consistency check.|
| [RemoveConfiguration](msft-dsclocalconfigurationmanager-removeconfiguration.md)| Removes the configuration files.|
| [ResourceGet](msft-dsclocalconfigurationmanager-resourceget.md)| Directly calls the **Get** method of a DSC resource.|
| [ResourceSet](msft-dsclocalconfigurationmanager-resourceset.md)| Directly calls the **Set** method of a DSC resource.|
| [ResourceTest](msft-dsclocalconfigurationmanager-resourcetest.md)| Directly calls the **Test** method of a DSC resource.|
| [RollBack](msft-dsclocalconfigurationmanager-rollback.md)| Rolls back to a previous configuration.|
| [SendConfiguration](msft-dsclocalconfigurationmanager-sendconfiguration.md)| Sends the configuration document to the managed node and saves it as a pending change.|
| [SendConfigurationApply](msft-dsclocalconfigurationmanager-sendconfigurationapply.md)| Sends the configuration document to the managed node and uses the Configuration Agent to apply the configuration.|
| [SendConfigurationApplyAsync](msft-dsclocalconfigurationmanager-sendconfigurationapplyasync.md)| Send the configuration document to the managed node and start using the Configuration Agent to apply the configuration. Use GetConfigurationResultOutput to retrieve result output.|
| [SendMetaConfigurationApply](msft-dsclocalconfigurationmanager-sendmetaconfigurationapply.md)| Sets the LCM settings that are used to control the Configuration Agent.|
| [StopConfiguration](msft-dsclocalconfigurationmanager-stopconfiguration.md)| Stops the configuration that is in progress.|
| [TestConfiguration](msft-dsclocalconfigurationmanager-testconfiguration.md)| Sends the configuration document to the managed node and verifies the current configuration against the document.|

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration
