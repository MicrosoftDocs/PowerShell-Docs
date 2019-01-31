---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  SendMetaConfigurationApply method of the MSFT_DSCLocalConfigurationManager class
---
# SendMetaConfigurationApply method of the MSFT_DSCLocalConfigurationManager class

Sets the Local Configuration Manager settings that are used to control the Configuration Agent.

## Syntax

```mof
uint32 SendMetaConfigurationApply(
  [in] uint8   ConfigurationData[],
  [in] boolean force
);
```

## Parameters

*ConfigurationData* \[in\]
The environment data for the configuration.

*force* \[in\]
**true** to force the configuration to stop.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)