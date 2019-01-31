---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  SendConfiguration method of the MSFT_DSCLocalConfigurationManager class
---
# SendConfiguration method of the MSFT_DSCLocalConfigurationManager class

Sends the configuration document to the managed node and saves it as a pending change.

## Syntax

```mof
uint32 SendConfiguration(
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