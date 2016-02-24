# Deliver a configuration document without applying

The **Publish-DscConfiguration** cmdlet copies a configuration MOF file to a target node, but does not apply the configuration. This configuration is applied during the next consistency pass, or when you run the `Update-DscConfiguration` cmdlet.

```powershell
Publish-DscConfiguration [-Path] <string> [[-ComputerName] <string[]>] [-Force] [-Credential <pscredential>] [-ThrottleLimit <int>] [-WhatIf] [-Confirm] [<CommonParameters>]

Publish-DscConfiguration [-Path] <string> -CimSession <CimSession[]> [-Force] [-ThrottleLimit <int>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
