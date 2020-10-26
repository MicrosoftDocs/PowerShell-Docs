---
ms.date: 07/14/2020
ms.topic: reference
title: ApplyConfiguration method
description: ApplyConfiguration method
---
# ApplyConfiguration method

Uses the Configuration Agent to apply the configuration that is pending.

If there is no configuration pending, this method reapplies the current configuration.

## Syntax

```mof
uint32 ApplyConfiguration(
  [in] boolean force
);
```

## Parameters

### force

If this is **true**, the current configuration is reapplied, even if there is a configuration
pending.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
