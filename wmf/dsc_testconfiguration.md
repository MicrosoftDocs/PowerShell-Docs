# Test-DscConfiguration cmdlet supports Reference Configurations

The Test-DscConfiguration cmdlet has been updated to allow testing of desired configuration state of one or more target nodes by specifying a reference configuration document to compare against.

The following new parameter sets use DSC configurations in the path specified to only test and never apply each configuration on the specified target node(s). As with Start-DscConfiguration and other DSC cmdlets, the name of each MOF is used to determine which target node to test the configuration on. 

```PowerShell
Test-DscConfiguration 	[-Path] <string> 
						[[-ComputerName] <string[]>] 
						[-Credential <pscredential>] 
						[-ThrottleLimit <int>] 
						[-AsJob] 
						[<CommonParameters>]

Test-DscConfiguration 	[-Path] <string> 
						-CimSession <CimSession[]> 
						[-ThrottleLimit <int>] 
						[-AsJob] 
						[<CommonParameters>]
```

The following new parameter sets use a single DSC configuration to only test and never apply the configuration on the specified target node(s). 

```PowerShell
Test-DscConfiguration 	-ReferenceConfiguration <string> 
						[[-ComputerName] <string[]>]
						[-Credential <pscredential>] 
						[-ThrottleLimit <int>] 
						[-AsJob] 
						[<CommonParameters>]

Test-DscConfiguration 	-ReferenceConfiguration <string> 
						-CimSession <CimSession[]> 
						[-ThrottleLimit <int>] 
						[-AsJob] 
						[<CommonParameters>]
```
