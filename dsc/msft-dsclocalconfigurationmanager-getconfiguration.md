---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Send the configuration document to the managed node and use Configuration Agent to apply the configuration using the Get method.'
MS-HAID: 'cimwin32a.msft\_dsclocalconfigurationmanager\_getconfiguration'
MSHAttr: 'PreferredLib:/library'
title: 'GetConfiguration method of the MSFT\_DSCLocalConfigurationManager class'
---

# GetConfiguration method of the MSFT\_DSCLocalConfigurationManager class


\[Some information relates to pre-released product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.\]

Send the configuration document to the managed node and use Configuration Agent to apply the configuration using the Get method.

Syntax
------

```mof
uint32 GetConfiguration(
  [in]  uint8            configurationData[],
  [out] OMI_BaseResource configurations[]
);
```

Parameters
----------

*configurationData* \[in\]  
TBD

*configurations* \[out\]  
TBD

Returns zero on success; otherwise returns an error code.

## Remarks

This is a static method.

## Requirements
------------
>**MOF:** DscCore.mof

>**Namespace**: Root\Microsoft\Windows\DesiredStateConfiguration


## See also


[**MSFT\_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)
 

 



