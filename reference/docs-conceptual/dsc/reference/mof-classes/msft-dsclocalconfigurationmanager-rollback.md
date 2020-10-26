---
ms.date: 07/17/2020
ms.topic: reference
title: RollBack method
description: RollBack method
---
# RollBack method

Rolls back the configuration to a previous version.

## Syntax

```mof
uint32 RollBack(
  [in] uint8 configurationNumber
);
```

## Parameters

**configurationNumber** \[in\]
Specifies the requested configuration.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
