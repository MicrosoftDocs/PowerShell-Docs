---
ms.date: 07/17/2020
ms.topic: reference
title: EnableDebugConfiguration method
description: EnableDebugConfiguration method
---
# EnableDebugConfiguration method

Enables DSC resource debugging.

## Syntax

```mof
uint32 EnableDebugConfiguration(
  [in] boolean BreakAll
);
```

## Parameters

**BreakAll** \[in\]
Sets a breakpoint at every line in the resource script.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
