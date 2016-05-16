---
title:  RemoveConfiguration method of the MSFT_DSCLocalConfigurationManager class
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# RemoveConfiguration method of the MSFT_DSCLocalConfigurationManager class

Removes the configuration files.

Syntax
------

```mof
uint32 RemoveConfiguration(
  [in] uint32  Stage,
  [in] boolean Force
);
```

Parameters
----------

*Stage* \[in\]  
Specifies which configuration document to remove. The following values are valid:

|Value |Description |
|:--- |:---|
|**1** | The **Current** configuration document (current.mof). |
|**2** | The **Pending** configuration document (pending.mof).  |
|**4** | The **Previous** configuration document (previous.mof). |

*Force* \[in\]  
**true** to force the removal of the configuration.

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


 

 



