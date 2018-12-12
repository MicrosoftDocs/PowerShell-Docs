---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  GetConfiguration method of the MSFT_DSCLocalConfigurationManager class
---
# GetConfiguration method of the MSFT_DSCLocalConfigurationManager class

Sends the configuration document to the managed node and uses the **Get** method of the Configuration Agent to apply the configuration.

## Syntax

```mof
uint32 GetConfiguration(
  [in]  uint8            configurationData[],
  [out] OMI_BaseResource configurations[]
);
```

## Parameters

*configurationData* \[in\]
Specifies the configuration data to send.

*configurations* \[out\]
On return, contains an embedded instance of the configurations.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)