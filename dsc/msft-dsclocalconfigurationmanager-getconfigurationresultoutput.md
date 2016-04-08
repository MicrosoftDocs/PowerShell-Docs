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

Return value
------------

TBD

Requirements
------------

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>Minimum supported client</p></td>
<td align="left"><p>Windows 10</p></td>
</tr>
<tr class="even">
<td align="left"><p>Minimum supported server</p></td>
<td align="left"><p>Windows Server 2016 Technical Preview</p></td>
</tr>
<tr class="odd">
<td align="left"><p>Namespace</p></td>
<td align="left"><p>Root\Microsoft\Windows\DesiredStateConfiguration</p></td>
</tr>
<tr class="even">
<td align="left"><p>MOF</p></td>
<td align="left">DscCore.mof</td>
</tr>
</tbody>
</table>

## <span id="see_also"></span>See also


[**MSFT\_DSCLocalConfigurationManager**](msft-dsclocalconfigurationmanager.md)

 

 



