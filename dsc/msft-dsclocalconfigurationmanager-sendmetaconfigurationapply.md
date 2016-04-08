---
DCS.appliesToProduct: 'WindowsServer\_Dev'
Description: 'Set Local Configuration Manager settings that are used to control Configuration Agent.'
MS-HAID: 'cimwin32a.msft\_dsclocalconfigurationmanager\_sendmetaconfigurationapply'
MSHAttr: 'PreferredLib:/library'
title: 'SendMetaConfigurationApply method of the MSFT\_DSCLocalConfigurationManager class'
---

# SendMetaConfigurationApply method of the MSFT\_DSCLocalConfigurationManager class


\[Some information relates to pre-released product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.\]

Set Local Configuration Manager settings that are used to control Configuration Agent.

Syntax
------

```mof
uint32 SendMetaConfigurationApply(
  [in] uint8   ConfigurationData[],
  [in] boolean force
);
```

Parameters
----------

*ConfigurationData* \[in\]  
TBD

*force* \[in\]  
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

 

 



