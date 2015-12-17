### Desired State Configuration (DSC)

- DSC cmdlets may not work if WMF 5.0 RTM is installed on top of WMF 5.0 Production Preview
	**Resolution:** mofcomp DscCoreConfProv.mof
	1. Open **powershell.exe** with elevated user rights (run as administrator).
	2. Run the following command in the console:
	```powershell
	mofcomp $env:windir\\system32\\wbem\\DscCoreConfProv.mof
	```
- **Start-DscConfiguration** and other DSC cmdlets may fail after installing WMF 5.0 RTM 
	DSC cmdlets may fail with the following error:
	
	```powershell
	LCM failed to retrieve the property PendingJobStep from the object of class dscInternalCache .
	+ CategoryInfo : ObjectNotFound: (root/Microsoft/...gurationManager:String) \[\], CimException
	+ FullyQualifiedErrorId : MI RESULT 6
	+ PSComputerName : localhost
	```
	**Resolution:** Delete DSCEngineCache.mof.
	1.  Open **powershell.exe** with elevated user rights (run as administrator).
	2.  Run the following command in the console:
	```powershell
	Remove-Item -Path $env:SystemRoot\\system32\\Configuration\\DSCEngineCache.mof
	```

- DSC resources can’t be debugged easily when used with **Invoke-DscResource** cmdlet

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

	# Find all the available rusnspace in that process
	Get-Runspace

	Id Name ComputerName Type State Availability
	-- ---- ------------ ---- ----- ------------
	2 Runspace2 localhost Local Opened InBreakpoint
	5 RemoteHost localhost Local Opened Busy

	# Debug the runspace that is in **InBreakpoint** availability state
	Debug-Runspace -Id 2
	```

- Debugging of a class-based DSC resource is not supported
	**Resolution:** None.

- DSC Resource debugging will not work if a resource is using *PSDscRunAsCredential* property in configuration 
	**Resolution:** None.

- **Invoke-DscResource** cmdlet returns verbose, warning and errors messages the very end command execution
	**Resolution:** None.

- **Invoke-DscResource** cmdlet does not return verbose , warning and errors messages in the order they were produced by LCM or DSC resource
	**Resolution:** None.

- In a DSC configuration script, node name can not be an IPv6 address
	**Resolution:** None.

- If DSC Engine (LCM) is in *debugmode*, no verbose messages from DSC resources are displayed
	**Resolution:** Disable *debugMode* to see verbose messages from the resource

- **Get-DscConfigurationStatus** returns pull cycle operations as of type *Consistency*
	When a node is set to PULL refresh mode, for each pull operation performed, **Get-DscConfigurationStatus** cmdlet reports the operation type as *Consistency* instead of *Initial*.
	**Resolution:** None.

- **Get-DscResource** <resource name> -syntax does not reflect *PsDscRunAsCredential* correctly when resource marks it as mandatory or does not support it 
	**Resolution:** None. Authoring configuration in ISE reflects correct meta data about *PsDscRunAsCredential* property when using IntelliSence.
