---
ms.date: 07/17/2020
ms.topic: reference
title: PerformRequiredConfigurationChecks method
description: PerformRequiredConfigurationChecks method
---
# PerformRequiredConfigurationChecks method

Starts a consistency check by using the Task Scheduler.

## Syntax

```mof
uint32 PerformRequiredConfigurationChecks(
  [in] uint32 Flags
);
```

## Parameters

**Flags** \[in\] A bitmask that specifies the type of consistency check to run. The following values
are valid, and can be combined by using a bitwise **OR** operation:

|Value |Description |
|:--- |:---|
|**1** | A normal consistency check. |
|**2** | A continuation of a consistency check after a reboot. This value should not be combined with other values. |
|**4** | The configuration should be pulled from the pull server specified in the metaconfiguration for the node. This value should always be combined with **1**, for a value of **5**. |
|**8** | Send status to the report server. |

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
