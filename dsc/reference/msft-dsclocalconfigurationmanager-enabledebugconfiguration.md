---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  EnableDebugConfiguration method of the MSFT_DSCLocalConfigurationManager class
---
# EnableDebugConfiguration method of the MSFT_DSCLocalConfigurationManager class

Enables DSC resource debugging.

## Syntax

```mof
uint32 EnableDebugConfiguration(
  [in] boolean BreakAll
);
```

## Parameters

*BreakAll* \[in\]
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