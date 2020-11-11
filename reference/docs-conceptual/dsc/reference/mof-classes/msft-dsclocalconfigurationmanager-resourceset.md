---
ms.date: 07/17/2020
ms.topic: reference
title: ResourceSet method
description: ResourceSet method
---
# ResourceSet method

Directly calls the **Set** method of a DSC resource.

## Syntax

```mof
uint32 ResourceSet(
  [in]  string  ResourceType,
  [in]  string  ModuleName,
  [in]  uint8   resourceProperty[],
  [out] boolean RebootRequired
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

**RebootRequired** \[out\]
On return, this property is set to **true** if the target node needs to be rebooted.

## Return value

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements

**MOF:** DscCore.mof

**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration

## See also

[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
