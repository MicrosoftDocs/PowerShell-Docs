---
ms.date: 07/17/2020
ms.topic: reference
title: GetMetaConfiguration method
description: GetMetaConfiguration method
---
# GetMetaConfiguration method

Gets the local Configuration Manager settings that are used to control the Configuration Agent.

## Syntax

```mof
uint32 GetMetaConfiguration(
  [out] MSFT_DSCMetaConfiguration MetaConfiguration
);
```

## Parameters

**MetaConfiguration** \[out\] On return, contains an embedded instance of the
**MSFT_DSCMetaConfiguration** class that defines the settings.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
