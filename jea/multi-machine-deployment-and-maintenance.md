---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  multi machine deployment and maintenance
ms.technology:  powershell
---

# Multi-machine Deployment and Maintenance
At this point, you have deployed JEA to local systems several times.
Because your production environment probably consists of more than one machine, it's important to walk through the critical steps in the deployment process that must be repeated on each machine.

## High Level Steps:
1.	Copy your modules (with Role Capabilities) to each node.
2.	Copy your session configuration files to each node.
3.	Run `Register-PSSessionConfiguration` with your session configuration.
4.	Keep a copy of your session configuration and toolkits in a secure location.
As you make modifications, it's good to have a "single source of truth."

## Example Script
Here's an example script for deployment.
To use it in your environment, you'll have to use the names/paths of real file shares and modules.
```PowerShell
# First, copy the session configuration and modules (containing role capability files) onto a file share you have access to.
Copy-Item -Path 'C:\Demo\Demo.pssc' -Destination '\\FileShare\JEA\Demo.pssc'
Copy-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\SomeModule\' -Recurse -Destination '\\FileShare\JEA\SomeModule'

# Next, author a setup script (C:\JEA\Deploy.ps1) to run on each individual node
    # Contents of C:\JEA\Deploy.ps1
    New-Item -ItemType Directory -Path C:\JEADeploy
    Copy-Item -Path '\\FileShare\JEA\Demo.pssc' -Destination 'C:\JEADeploy\'
    Copy-Item -Path '\\FileShare\JEA\SomeModule' -Recurse -Destination 'C:\Program Files\WindowsPowerShell\Modules' # Remember, Role Capability Files are found in modules
    if (Get-PSSessionConfiguration -Name JEADemo -ErrorAction SilentlyContinue)
    {
        Unregister-PSSessionConfiguration -Name JEADemo -ErrorAction Stop
    }

    Register-PSSessionConfiguration -Name JEADemo -Path 'C:\JEADeploy\Demo.pssc'
    Remove-Item -Path 'C:\JEADeploy' # Don't forget to clean up!

# Now, invoke the script on all of the target machines.
# Note: this requires PowerShell Remoting be enabled on each machine. Enabling PowerShell remoting is a requirement to use JEA as well.
# You may need to provide the "-Credential" parameter if your current user account does not have admin permissions on these machines.
Invoke-Command –ComputerName 'Node1', 'Node2', 'Node3', 'NodeN' -FilePath 'C:\JEA\Deploy.ps1'

# Finally, delete the session configuration and role capability files from the file share.
Remove-Item -Path '\\FileShare\JEA\Demo.pssc'
Remove-Item -Path '\\FileShare\JEA\SomeModule' -Recurse
```
## Modifying Capabilities
When dealing with many machines, it's important that modifications are rolled out in a consistent manner.
Once JEA has a DSC Resource, this will help ensure your environment is in sync.
Until that time, we highly recommend you keep a master copy of your session configurations and re-deploy each time you make a modification.

## Removing Capabilities
To remove your JEA configuration from your systems, use the following command on each machine:
```PowerShell
Unregister-PSSessionConfiguration -Name JEADemo
```

