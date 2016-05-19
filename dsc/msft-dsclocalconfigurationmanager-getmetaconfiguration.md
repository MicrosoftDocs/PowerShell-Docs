---
title:  GetMetaConfiguration method of the MSFT_DSCLocalConfigurationManager class
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---


# GetMetaConfiguration method of the MSFT_DSCLocalConfigurationManager class

Gets the local Configuration Manager settings that are used to control the Configuration Agent.

Syntax
------

```mof
uint32 GetMetaConfiguration(
  [out] MSFT_DSCMetaConfiguration MetaConfiguration
);
```

Parameters
----------

*MetaConfiguration* \[out\]  
On return, contains an embedded instance of the **MSFT_DSCMetaConfiguration** class that defines the settings.

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


 

 



