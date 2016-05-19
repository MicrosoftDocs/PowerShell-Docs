---
title: ApplyConfiguration method of the MSFT_DSCLocalConfigurationManager class 
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# ApplyConfiguration method of the MSFT_DSCLocalConfigurationManager class

Uses the Configuration Agent to apply the configuration that is pending. 

If there is no configuration pending, this method reapplies the current configuration.


## Syntax
------

```mof
uint32 ApplyConfiguration(
  [in] boolean force
);
```

## Parameters
----------

*force* \[in\]  
If this is **true**, the current configuration is reapplied, even if there is a configuration pending.

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

 

 



