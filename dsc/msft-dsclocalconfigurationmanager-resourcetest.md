---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Execute Test on a provider directly.'
MS-HAID: 'cimwin32a.MSFT_DSCLocalConfigurationManager\_resourcetest'
MSHAttr: 'PreferredLib:/library'
title: 'ResourceTest method of the MSFT_DSCLocalConfigurationManager class'
---

# ResourceTest method of the MSFT_DSCLocalConfigurationManager class

Directly calls the **Test** method of a DSC resource.

Syntax
------

```mof
uint32 ResourceTest(
  [in]  string  ResourceType,
  [in]  string  ModuleName,
  [in]  uint8   resourceProperty[],
  [out] boolean InDesiredState
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

*InDesiredState* \[out\]  
On return, this property is set to **true** if the target node is in the desired state.

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


 

 



