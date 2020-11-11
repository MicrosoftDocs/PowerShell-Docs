---
ms.date: 07/17/2020
ms.topic: reference
title: DSC for Linux nxScript Resource
description: DSC for Linux nxScript Resource
---
# DSC for Linux nxScript Resource

The **nxScript** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to
run Linux scripts on a Linux node.

## Syntax

```Syntax
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

|Property |Description |
|---|---|
|GetScript |Provides a script to return current status of the machine. This script runs when you invoke the [GetDscConfiguration.py](https://github.com/Microsoft/PowerShell-DSC-for-Linux#performing-dsc-operations-from-the-linux-computer) script. The script must begin with a shebang, such as `#!/bin/bash`. |
|SetScript |Provides a script that puts the machine in the correct state. When you invoke the [StartDscConfiguration.py](https://github.com/Microsoft/PowerShell-DSC-for-Linux#performing-dsc-operations-from-the-linux-computer) script, the **TestScript** runs first. If the **TestScript** block returns an exit code other than 0, the **SetScript** block will run. If the **TestScript** returns an exit code of 0, the **SetScript** will not run. The script must begin with a shebang, such as `#!/bin/bash`. |
|TestScript |Provides a script that evaluates whether the node is currently in the correct state. When you invoke the [StartDscConfiguration.py](https://github.com/Microsoft/PowerShell-DSC-for-Linux#performing-dsc-operations-from-the-linux-computer) script, this script runs. If it returns an exit code other than 0, the **SetScript** will run. If it returns an exit code of 0, the **SetScript** will not run. The **TestScript** also runs when you invoke the [TestDscConfiguration](https://github.com/Microsoft/PowerShell-DSC-for-Linux#performing-dsc-operations-from-the-linux-computer) script. However, in this case, the **SetScript** will not run, no matter what exit code is returned from the **TestScript**. The **TestScript** must contain content and must return an exit code of 0 if the actual configuration matches the current desired state configuration, and an exit code other than 0 if it does not match. The current desired state configuration is the last configuration enacted on the node that is using DSC. The script must begin with a shebang, such as `#!/bin/bash`. |
|User |The user to run the script as. |
|Group |The group to run the script as. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |

## Example

The following example demonstrates the use of the **nxScript** resource to perform additional
configuration management.

```powershell
Import-DSCResource -Module nx

Node $node
{
    nxScript KeepDirEmpty {

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
