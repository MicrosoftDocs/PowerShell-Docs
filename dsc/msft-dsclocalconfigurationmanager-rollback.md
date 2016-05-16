---
title: RollBack method of the MSFT_DSCLocalConfigurationManager class 
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
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


 

 



