---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Retrieve the Configuration Agent output relating to a specific job.'
MS-HAID: 'cimwin32a.msft\_dsclocalconfigurationmanager\_getconfigurationresultoutput'
MSHAttr: 'PreferredLib:/library'
title: 'GetConfigurationResultOutput method of the MSFT\_DSCLocalConfigurationManager class'
---

# GetConfigurationResultOutput method of the MSFT\_DSCLocalConfigurationManager class


\[Some information relates to pre-released product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.\]

Retrieve the Configuration Agent output relating to a specific job.

Syntax
------

```mof
uint32 GetConfigurationResultOutput(
  [in]  string                      jobId,
  [in]  uint8                       resumeOutputBookmark[],
  [out] MSFT_DSCConfigurationOutput output[]
);
```

Parameters
----------

*jobId* \[in\]  
TBD

*resumeOutputBookmark* \[in\]  
TBD

*output* \[out\]  
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

 

 



