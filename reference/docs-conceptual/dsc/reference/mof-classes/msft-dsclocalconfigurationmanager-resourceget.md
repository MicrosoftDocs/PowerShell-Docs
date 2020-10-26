---
ms.date: 07/17/2020
ms.topic: reference
title: ResourceGet method
description: ResourceGet method
---
# ResourceGet method

Directly calls the **Get** method of a DSC resource.

## Syntax

```mof
uint32 ResourceGet(
  [in]  string           ResourceType,
  [in]  string           ModuleName,
  [in]  uint8            resourceProperty[],
  [out] OMI_BaseResource configurations
);
```

## Parameters

**ResourceType** \[in\]
The name of the resource to call.

**ModuleName** \[in\]
The name of the module that contains the resource to call.

**resourceProperty** \[in\] Specifies the resource property name and its value in a hash table as
key and value, respectively. Use the [Get-DscResource](/powershell/module/PSDesiredStateConfiguration/Get-DscResource)
cmdlet to discover resource properties and their types.

**configurations** \[out\]
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
