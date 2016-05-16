---
title:  ResourceSet method of the MSFT_DSCLocalConfigurationManager class
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---


# ResourceSet method of the MSFT_DSCLocalConfigurationManager class

Directly calls the **Set** method of a DSC resource.

Syntax
------

```mof
uint32 ResourceSet(
  [in]  string  ResourceType,
  [in]  string  ModuleName,
  [in]  uint8   resourceProperty[],
  [out] boolean RebootRequired
);
```

Parameters
----------

*ResourceType* \[in\]  
The name of the resource to call.

*ModuleName* \[in\]  
The name of the module that contains the resource to call.

*resourceProperty* \[in\]  
Specifies the resource property name and its value in a hash table as key and value, respectively. Use the
[Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx) cmdlet to discover resource properties and their types.

*RebootRequired* \[out\]  
On return, this property is set to **true** if the target node needs to be rebooted.

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

 

 



