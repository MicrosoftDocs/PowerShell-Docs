---
ms.date: 07/17/2020
ms.topic: reference
title: GetConfigurationStatus method
description: GetConfigurationStatus method
---
# GetConfigurationStatus method

Get the configuration status history.

## Syntax

```mof
uint32 GetConfigurationStatus(
  [in]  boolean                     All,
  [out] MSFT_DSCConfigurationStatus configurationStatus[]
);
```

## Parameters

**All** \[in\] **true** if this method should return information about all the configuration runs on
the machine, including the configuration application and the consistency check.

**configurationStatus** \[out\] On return, contains an embedded instance of the
**MSFT_DSCConfigurationStatus** class that defines the settings.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
