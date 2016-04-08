

# MSFT_DSCLocalConfigurationManager class

The Local Configuration Manager (LCM) that controls the states of configuration files and uses Configuration Agent to apply the configurations.

The following syntax is simplified from Managed Object Format (MOF) code and includes all of the inherited properties.

## Syntax
------

``` syntax
[ClassVersion("1.0.0"), dynamic, provider("dsccore"), AMENDMENT]
class MSFT_DSCLocalConfigurationManager
{
};
```

## Members
-------

The **MSFT_DSCLocalConfigurationManager** class has the follwing members:

-   [Methods][]

### Methods

The **MSFT_DSCLocalConfigurationManager** class has these methods.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Method</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">[<strong>ApplyConfiguration</strong>](msft-dsclocalconfigurationmanager-applyconfiguration.md)</td>
<td align="left"><p>Use Configuration Agent to apply the configuration.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>DisableDebugConfiguration</strong>](msft-dsclocalconfigurationmanager-disabledebugconfiguration.md)</td>
<td align="left"><p>Disable Debug DSC Configuration.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>EnableDebugConfiguration</strong>](msft-dsclocalconfigurationmanager-enabledebugconfiguration.md)</td>
<td align="left"><p>Enable Debug DSC Configuration.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>GetConfiguration</strong>](msft-dsclocalconfigurationmanager-getconfiguration.md)</td>
<td align="left"><p>Send the configuration document to the managed node and use Configuration Agent to apply the configuration using the Get method.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>GetConfigurationResultOutput</strong>](msft-dsclocalconfigurationmanager-getconfigurationresultoutput.md)</td>
<td align="left"><p>Retrieve the Configuration Agent output relating to a specific job.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>GetConfigurationStatus</strong>](msft-dsclocalconfigurationmanager-getconfigurationstatus.md)</td>
<td align="left"><p>Get the configuration status history.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>GetMetaConfiguration</strong>](msft-dsclocalconfigurationmanager-getmetaconfiguration.md)</td>
<td align="left"><p>Get Local Configuration Manager settings that are used to control Configuration Agent.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>PerformRequiredConfigurationChecks</strong>](msft-dsclocalconfigurationmanager-performrequiredconfigurationchecks.md)</td>
<td align="left"><p>Starts the consistency check.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>RemoveConfiguration</strong>](msft-dsclocalconfigurationmanager-removeconfiguration.md)</td>
<td align="left"><p>Removing the configuration files.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>ResourceGet</strong>](msft-dsclocalconfigurationmanager-resourceget.md)</td>
<td align="left"><p>Execute Get on a provider directly</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>ResourceSet</strong>](msft-dsclocalconfigurationmanager-resourceset.md)</td>
<td align="left"><p>Execute Set on a provider directly</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>ResourceTest</strong>](msft-dsclocalconfigurationmanager-resourcetest.md)</td>
<td align="left"><p>Execute Test on a provider directly</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>RollBack</strong>](msft-dsclocalconfigurationmanager-rollback.md)</td>
<td align="left"><p>Rollback to previous configuration.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>SendConfiguration</strong>](msft-dsclocalconfigurationmanager-sendconfiguration.md)</td>
<td align="left"><p>Send the configuration document to the managed node and save it as pending.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>SendConfigurationApply</strong>](msft-dsclocalconfigurationmanager-sendconfigurationapply.md)</td>
<td align="left"><p>Send the configuration document to the managed node and use Configuration Agent to apply the configuration.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>SendConfigurationApplyAsync</strong>](msft-dsclocalconfigurationmanager-sendconfigurationapplyasync.md)</td>
<td align="left"><p>Send the configuration document to the managed node and start using the Configuration Agent to apply the configuration. Use GetConfigurationResultOutput to retrieve result output.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>SendMetaConfigurationApply</strong>](msft-dsclocalconfigurationmanager-sendmetaconfigurationapply.md)</td>
<td align="left"><p>Set Local Configuration Manager settings that are used to control Configuration Agent.</p></td>
</tr>
<tr class="even">
<td align="left">[<strong>StopConfiguration</strong>](msft-dsclocalconfigurationmanager-stopconfiguration.md)</td>
<td align="left"><p>Stopping the configuration in progress.</p></td>
</tr>
<tr class="odd">
<td align="left">[<strong>TestConfiguration</strong>](msft-dsclocalconfigurationmanager-testconfiguration.md)</td>
<td align="left"><p>Send the configuration document to the managed node and test it against the current configuration.</p></td>
</tr>
</tbody>
</table>

 

## Requirements
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

 

 



