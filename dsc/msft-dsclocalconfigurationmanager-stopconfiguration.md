---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Stopping the configuration in progress.'
MS-HAID: 'cimwin32a.MSFT_DSCLocalConfigurationManager\_stopconfiguration'
MSHAttr: 'PreferredLib:/library'
title: 'StopConfiguration method of the MSFT_DSCLocalConfigurationManager class'
---

# StopConfiguration method of the MSFT_DSCLocalConfigurationManager class

Stops the configuration change that is in progress.

Syntax
------

```mof
uint32 StopConfiguration(
  [in] boolean force
);
```

Parameters
----------

*force* \[in\]  
**true** to force the configuration to stop.

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


 

 



