---
title:  
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Send the configuration document to the managed node and use Configuration Agent to apply the configuration.'
MS-HAID: 'cimwin32a.MSFT_DSCLocalConfigurationManager\_sendconfigurationapply'
MSHAttr: 'PreferredLib:/library'
title: 'SendConfigurationApply method of the MSFT_DSCLocalConfigurationManager class'
---

# SendConfigurationApply method of the MSFT_DSCLocalConfigurationManager class

Sends the configuration document to the managed node and uses the Configuration Agent to apply the configuration.

Syntax
------

```mof
uint32 SendConfigurationApply(
  [in] uint8   ConfigurationData[],
  [in] boolean force
);
```

Parameters
----------

*ConfigurationData* \[in\]  
The environment data for the configuration.

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


 

 



