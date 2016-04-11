---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Enable Debug DSC Configuration.'
MS-HAID: 'cimwin32a.msft\_dsclocalconfigurationmanager\_enabledebugconfiguration'
MSHAttr: 'PreferredLib:/library'
title: 'EnableDebugConfiguration method of the MSFT\_DSCLocalConfigurationManager class'
---

# EnableDebugConfiguration method of the MSFT\_DSCLocalConfigurationManager class


\[Some information relates to pre-released product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.\]

Enable Debug DSC Configuration.

Syntax
------

```mof
uint32 EnableDebugConfiguration(
  [in] boolean BreakAll
);
```

Parameters
----------

*BreakAll* \[in\]  
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
 

 



