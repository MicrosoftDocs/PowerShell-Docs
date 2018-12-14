---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  SendConfigurationApplyAsync method of the MSFT_DSCLocalConfigurationManager class
---
# SendConfigurationApplyAsync method of the MSFT_DSCLocalConfigurationManager class

Sends the configuration document asynchronously to the managed node and uses the Configuration Agent to apply the configuration.

## Syntax

```mof
uint32 SendConfigurationApplyAsync(
  [in] uint8   ConfigurationData[],
  [in] boolean force,
  [in] string  jobId
);
```

## Parameters

*ConfigurationData* \[in\]
The environment data for the configuration.

*force* \[in\]
**true** to force the configuration to stop.

*jobId* \[in\]
The ID of the job for which to send the configuration.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)