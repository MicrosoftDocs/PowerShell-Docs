### Deliver Configuration Document without Applying
### Publish-DscConfiguration

The Publish-DscConfiguration cmdlet copies a configuration MOF file to a target node, but does not apply the configuration. This configuration is applied during the next consistency pass, or when you run the Update-DscConfiguration cmdlet.

Publish-DscConfiguration \[-Path\] &lt;string&gt; \[\[-ComputerName\] &lt;string\[\]&gt;\] \[-Force\] \[-Credential &lt;pscredential&gt;\]

\[-ThrottleLimit &lt;int&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

Publish-DscConfiguration \[-Path\] &lt;string&gt; -CimSession &lt;CimSession\[\]&gt; \[-Force\] \[-ThrottleLimit &lt;int&gt;\] \[-WhatIf\]

\[-Confirm\] \[&lt;CommonParameters&gt;\]

