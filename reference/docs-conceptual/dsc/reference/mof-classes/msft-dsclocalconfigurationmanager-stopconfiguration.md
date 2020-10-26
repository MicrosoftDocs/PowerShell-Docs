---
ms.date: 07/17/2020
ms.topic: reference
title: StopConfiguration method
description: StopConfiguration method
---
# StopConfiguration method

Stops the configuration change that is in progress.

## Syntax

```mof
uint32 StopConfiguration(
  [in] boolean force
);
```

## Parameters

**force** \[in\]
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
