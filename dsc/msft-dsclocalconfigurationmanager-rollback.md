---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Rollback to previous configuration.'
MS-HAID: 'cimwin32a.MSFT_DSCLocalConfigurationManager\_rollback'
MSHAttr: 'PreferredLib:/library'
title: 'RollBack method of the MSFT_DSCLocalConfigurationManager class'
---

# RollBack method of the MSFT_DSCLocalConfigurationManager class

Rolls back the configuration to a previous version.

Syntax
------

```mof
uint32 RollBack(
  [in] uint8 configurationNumber
);
```

Parameters
----------

*configurationNumber* \[in\]  
Specifies the requested configuration. 

## Return value
------------

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements
------------
>**MOF:** DscCore.mof

>**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration


## See also


[**MSFT_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)


 

 



