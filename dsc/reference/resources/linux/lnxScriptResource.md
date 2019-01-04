---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC for Linux nxScript Resource
---

# DSC for Linux nxScript Resource

The **nxScript** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to run Linux scripts on a Linux node.

## Syntax

```
nxScript <string> #ResourceName
{
    GetScript = <string>
    SetScript = <string>
    TestScript = <string>
    [ User = <string> ]
    [ Group = <string> ]
    [ DependsOn = <string[]> ]

}
```

## Properties

|  Property |  Description |
|---|---|
| GetScript| Provides a script that runs when you invoke the [Get-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521625.aspx) cmdlet. The script must begin with a shebang, such as #!/bin/bash.|
| SetScript| Provides a script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet, the **TestScript** runs first. If the **TestScript** block returns an exit code other than 0, the **SetScript** block will run. If the **TestScript** returns an exit code of 0, the **SetScript** will not run. The script must begin with a shebang, such as `#!/bin/bash`.|
| TestScript| Provides a script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet, this script runs. If it returns an exit code other than 0, the SetScript will run. If it returns an exit code of 0, the **SetScript** will not run. The **TestScript** also runs when you invoke the [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) cmdlet. However, in this case, the **SetScript** will not run, no matter what exit code is returned from the **TestScript**. The **TestScript** must return an exit code of 0 if the actual configuration matches the current desired state configuration, and an exit code other than 0 if it does not match. (The current desired state configuration is the last configuration enacted on the node that is using DSC). The script must begin with a shebang, such as 1#!/bin/bash.1|
| User| The user to run the script as.|
| Group| The group to run the script as.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the **ID** of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|

## Example

The following example demonstrates the use of the **nxScript** resource to perform additional configuration management.

```
Import-DSCResource -Module nx

Node $node {
nxScript KeepDirEmpty{

    GetScript = @"
#!/bin/bash
ls /tmp/mydir/ | wc -l
"@

    SetScript = @"
#!/bin/bash
rm -rf /tmp/mydir/*
"@

    TestScript = @'
#!/bin/bash
filecount=`ls /tmp/mydir | wc -l`
if [ $filecount -gt 0 ]
then
    exit 1
else
    exit 0
fi
'@
}
}
```