# Desired State Configuration (DSC) Known Issues and Limitations

Breaking Change: Certificates used to encrypt/decrypt passwords in DSC configurations may not work after installing WMF 5.0 RTM
--------------------------------------------------------------------------------------------------------------------------------

In WMF 4.0 and WMF 5.0 Preview releases, DSC would not allow passwords in the configuration to be of length more than 121 characters. DSC was forcing to use short passwords even if lengthy and strong password was desired. This breaking change allows passwords to be of arbitrary length in the DSC configuration.

**Resolution:** Re-create the certificate with Data Encipherment or Key Encipherment Key usage, and Document Encryption Enhanced Key usage (1.3.6.1.4.1.311.80.1). Technet article <https://technet.microsoft.com/en-us/library/dn807171.aspx> has more information.


DSC cmdlets may fail after installing WMF 5.0 RTM
------------------------------------------------------------------------------------
Start-DscConfiguration and other DSC cmdlets may fail after installing WMF 5.0 RTM with the following error:
```powershell
	LCM failed to retrieve the property PendingJobStep from the object of class dscInternalCache .
	+ CategoryInfo : ObjectNotFound: (root/Microsoft/...gurationManager:String) [], CimException
	+ FullyQualifiedErrorId : MI RESULT 6
	+ PSComputerName : localhost
```

**Resolution:** Delete DSCEngineCache.mof by running the following command in an elevated PowerShell session (Run as Administrator):
	
```powershell
Remove-Item -Path $env:SystemRoot\system32\Configuration\DSCEngineCache.mof
```


DSC cmdlets may not work if WMF 5.0 RTM is installed on top of WMF 5.0 Production Preview
------------------------------------------------------
**Resolution:** Run the following command in an elevated PowerShell session (run as administrator):
```powershell
	mofcomp $env:windir\system32\wbem\DscCoreConfProv.mof
```


LCM can go into an unstable state while using Get-DscConfiguration in DebugMode
-------------------------------------------------------------------------------

If LCM is in DebugMode, pressing CTRL+C to stop the processing of Get-DscConfiguration can cause LCM to go into an unstable state such that majority of DSC cmdlets won’t work.

**Resolution:** Don’t press CTRL+C while debugging Get-DscConfiguration cmdlet.


Stop-DscConfiguration may hang in DebugMode
------------------------------------------------------------------------------------------------------------------------
If LCM is in DebugMode, Stop-DscConfiguration may hang while trying to stop an operation started by Get-DscConfiguration

**Resolution:** Finish the debugging of the operation started by Get-DscConfiguration as outlined in section ‘[DSC RESOURCE SCRIPT DEBUGGING](#dsc-resource-script-debugging)’.


No Verbose Error Messages are shown in DebugMode
-----------------------------------------------------------------------------------
If LCM is in DebugMode, no verbose error messages are displayed from DSC Resources.

**Resolution:** Disable *DebugMode* to see verbose messages from the resource


Invoke-DscResource operations cannot be retrieved by Get-DscConfigurationStatus cmdlet
--------------------------------------------------------------------------------------
After using Invoke-DscResource cmdlet to directly invoke any resource’s methods, the records of such operation cannot be retrieved through Get-DscConfigurationStatus at a later time.

**Resolution:** None.


Get-DscConfigurationStatus returns pull cycle operations as type *Consistency*
---------------------------------------------------------------------------------
When a node is set to PULL refresh mode, for each pull operation performed, Get-DscConfigurationStatus cmdlet reports the operation type as *Consistency* instead of *Initial*

**Resolution:** None.

Invoke-DscResource cmdlet does not return message in the order they were produced
---------------------------------------------------------------------------------
The Invoke-DscResource cmdlet does not return verbose, warning, and error messages in the order they were produced by LCM or the DSC resource.

**Resolution:** None.


DSC Resources cannot be debugged easily when used with Invoke-DscResource
-----------------------------------------------------------------------
When LCM is running in debug mode (see [DSC RESOURCE SCRIPT DEBUGGING](#dsc-resource-script-debugging) for more details), Invoke-DscResource cmdlet does not give information about runspace to connect to for debugging.
**Resolution:** Discover and attach to the runspace using cmdlets **Get-PSHostProcessInfo**, **Enter-PSHostProcess** , **Get-Runspace** and **Debug-Runspace** to debug the DSC resource.

```powershell
# Find all the processes hosting PowerShell
Get-PSHostProcessInfo

ProcessName ProcessId AppDomainName
----------- --------- -------------
powershell 3932 DefaultAppDomain
powershell_ise 2304 DefaultAppDomain
WmiPrvSE 3396 DscPsPluginWkr_AppDomain

# Enter the process that is hosting DSC engine (WMI process with DscPsPluginWkr_Appdomain)
Enter-PSHostProcess -Id 3396 -AppDomainName DscPsPluginWkr_AppDomain

# Find all the available rusnspaces in that process
Get-Runspace

Id Name ComputerName Type State Availability
-- ---- ------------ ---- ----- ------------
2 Runspace2 localhost Local Opened InBreakpoint
5 RemoteHost localhost Local Opened Busy

# Debug the runspace that is in **InBreakpoint** availability state
Debug-Runspace -Id 2
```


Various Partial Configuration documents for same node cannot have identical resource names
------------------------------------------------------------------------------------------

For several partial configurations that are deployed onto a single node, identical names of resources cause run time error.

**Resolution:** Use different names for even same resources in different partial configurations.


Start-DscConfiguration –UseExisting does not work with -Credential
------------------------------------------------------------------

When using Start-DscConfiguration with –UseExisting parameter, the –Credential parameter is ignored. DSC uses default process identity to proceed the operation. This causes error when a different credential is needed to proceed on remote node.

**Resolution:** Use CIM session for remote DSC operations:
```powershell
$session = New-CimSession -ComputerName $node -Credential $credential
Start-DscConfiguration -UseExisting -CimSession $session
```


IPv6 Addresses as Node Names in DSC configurations
--------------------------------------------------
IPv6 addresses as node names in DSC configuration scripts are not supported in this release.

**Resolution:** None.


Debugging of Class-Based DSC Resources
--------------------------------------
Debugging of class-based DSC Resources is not supported in this release.

**Resolution:** None.


Variables & Functions defined in $script scope in DSC Class-Based Resource are not preserved across multiple calls to a DSC Resource 
-------------------------------------------------------------------------------------------------------------------------------------

Multiple consecutive calls to Start-DSCConfiguration will fail if configuration is using any class-based resource which has variables or functions defined in $script scope.

**Resolution:** Define all variables and functions in DSC Resource class itself. No $script scope variables/functions.


DSC Resource Debugging when a resource is using PSDscRunAsCredential
----------------------------------------------------------------------
DSC Resource debugging when a resource is using the *PSDscRunAsCredential* property in the configuration is not suported in this release.

**Resolution:** None.


PsDscRunAsCredential is not supported for DSC Composite Resources
----------------------------------------------------------------

**Resolution:** Use Credential property if available. Example ServiceSet and WindowsFeatureSet


*Get-DscResource -Syntax* does not reflect PsDscRunAsCredential correctly
-------------------------------------------------------------------------
Get-DscResource -Syntax does not reflect PsDscRunAsCredential correctly when resource marks it as mandatory or does not support it.

**Resolution:** None. However, authoring configuration in ISE reflects correct metadata about PsDscRunAsCredential property when using IntelliSense.


WindowsOptionalFeature is not available in Windows 7
-----------------------------------------------------

The WindowsOptionalFeature DSC resource is not available in Windows 7. This resource requires the DISM module, and DISM cmdlets that are available starting in Windows 8 and newer releases of the Windows operating system.


Running Set-DscLocalConfigurationManager to set Meta Configuration against WMF 4.0 or WMF 5.0 Production Preview builds will not work
---------------------------------------------------------------------------------------------------------------------------------------

There is a backward compatibility issue when running Set-DscLocalConfiguration against previous WMFs. You will see this error complaining about newly added -Force parameter not being available on the target machine.
```powershell
Set-DscLocalConfigurationManager -Path . -Verbose -ComputerName WIN-3B576EM3669
VERBOSE: Performing the operation "Start-DscConfiguration: SendMetaConfigurationApply" on target "MSFT_DSCLocalConfigurationManager".
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' = SendMetaConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' = root/Microsoft/Windows/DesiredStateConfiguration'.
The WinRM client cannot process the request. The object contains an unrecognized argument: "Force". Verify that the spelling of the argument name is correct.
+ CategoryInfo : MetadataError: (root/Microsoft/...gurationManager:String) [], CimException
+ FullyQualifiedErrorId : HRESULT 0x803381e1
+ PSComputerName : WIN-3B576EM3669
VERBOSE: Operation 'Invoke CimMethod' complete.
VERBOSE: Set-DscLocalConfigurationManager finished in 0.121 seconds.
```
**Resolution:** Follow these steps to use Invoke-CimMethod to call underlying CIM method directly to set meta configuration.
```powershell
$computerName = "WIN-3B576EM3669"
$mofPath = "C:\$computerName.meta.mof"
$configurationData = [Byte[]][System.IO.File]::ReadAllBytes($mofPath)
$totalSize = [System.BitConverter]::GetBytes($configurationData.Length + 4 )
$configurationData = $totalSize + $configurationData
Invoke-CimMethod -Namespace root/microsoft/windows/desiredstateconfiguration -Class MSFT_DSCLocalConfigurationManager -Name SendMetaConfigurationApply -Arguments @{ConfigurationData = [Byte[]]$configurationData} -Verbose -ComputerName $computerName
VERBOSE: Performing the operation "Invoke-CimMethod: SendMetaConfigurationApply" on target "MSFT_DSCLocalConfigurationManager".
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' = SendMetaConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' = root/microsoft/windows/desiredstateconfiguration'.
VERBOSE: An LCM method call arrived from computer WIN-3B576EM3669 with user sid S-1-5-21-2127521184-1604012920-1887927527-5557045.
VERBOSE: [WIN-3B576EM3669]: LCM: [ Start Set ]
VERBOSE: [WIN-3B576EM3669]: LCM: [ Start Resource ] [MSFT_DSCMetaConfiguration]
VERBOSE: [WIN-3B576EM3669]: LCM: [ Start Set ] [MSFT_DSCMetaConfiguration]
VERBOSE: [WIN-3B576EM3669]: LCM: [ End Set ] [MSFT_DSCMetaConfiguration] in 0.4060 seconds.
VERBOSE: [WIN-3B576EM3669]: LCM: [ End Resource ] [MSFT_DSCMetaConfiguration]
VERBOSE: [WIN-3B576EM3669]: LCM: [ End Set ] in 0.4807 seconds.
VERBOSE: Operation 'Invoke CimMethod' complete.
```

