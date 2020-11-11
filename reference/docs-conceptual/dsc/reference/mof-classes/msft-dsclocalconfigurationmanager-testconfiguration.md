---
ms.date: 07/17/2020
ms.topic: reference
title: TestConfiguration method
description: TestConfiguration method
---
# TestConfiguration method

Sends the configuration document to the managed node and verifies the current configuration against the document.

## Syntax

```mof
uint32 TestConfiguration(
  [in]  uint8                          configurationData[],
  [out] boolean                        InDesiredState,
  [out] MSFT_ResourceInDesiredState    ResourcesInDesiredState[],
  [out] MSFT_ResourceNotInDesiredState ResourcesNotInDesiredState[]
);
```

## Parameters

**configurationData** \[in\] Environment data for the configuration.

**InDesiredState** \[out\] On return, specifies whether the managed node is in the state specified
by the configuration document.

**ResourcesInDesiredState** \[out\] On return, contains an embedded instance of the
**MSFT_ResourceInDesiredState** class that specifies resources that are in the desired state.

**ResourcesNotInDesiredState** \[out\] On return, contains an embedded instance of the
**MSFT_ResourceNotInDesiredState** class that specifies resources that are not in the desired state.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
