# On-demand PULL of DSC Configurations

The new Update-DscConfiguration cmdlet triggers a pull from the pull server(s) defined in the meta-configuration. The behavior is often referred to as 'Pull Now'. 

Once triggered, the pull behaves exactly the same as it would have when triggered during the regular frequency:

1. The checksum for current configuration is compared to the checksum for the configuration on the pull server. 
2. If they are the same, it completes successfully without applying the configuration. 
3. If they are different, the configuration is pulled down from the pull server and applied.

**Note:** If the Meta-Configuration RefreshMode = 'Push' an error is returned by this cmdlet so this cmdlet will always do nothing when a target node is in 'Push' Mode.

```PowerShell
Update-DscConfiguration 	[[-ComputerName] <string[]>] 
							[-Wait]
							[-Force] 
							[-JobName <string>] 
							[-Credential<pscredential>] 
							[-ThrottleLimit <int>] 
							[-WhatIf] 
							[-Confirm] 
							[<CommonParameters>]

Update-DscConfiguration 	-CimSession <CimSession[]> 
							[-Wait] 
							[-Force] 
							[-JobName <string>] 
							[-ThrottleLimit <int>]
							[-WhatIf] 
							[-Confirm] 
							[<CommonParameters>]
```