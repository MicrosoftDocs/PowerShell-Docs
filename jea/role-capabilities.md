---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  role capabilities
ms.technology:  powershell
---

# Role Capabilities

## Overview
In the above section, you learned that the "RoleDefinitions" field defined which groups had access to which Role Capabilities.
You may have wondered, "What are Role Capabilities?"
This section will answer that question.  

## Introducing PowerShell Role Capabilities
PowerShell Role Capabilities define "what" a user can do at a JEA endpoint.
They detail a whitelist of things like visible commands, visible applications, and more.
Role Capabilities are defined by files with a ".psrc" extension.

## Role Capability Contents
We will start by examining and modifying the demo Role Capability file you used before.
Imagine you have deployed your Session Configuration across your environment, but you have gotten feedback that you need to change the capabilities exposed to users.
Operators need the ability to restart machines, and they also want to be able to get information about network settings.
In addition, the security team has told you that allowing users to run "Restart-Service" without any restrictions is not acceptable.
You need to restrict the services that operators can restart.

To make these changes, start by running PowerShell ISE as an Administrator and open the following file:

```
C:\Program Files\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities\Maintenance.psrc
```

Now find and update the following lines in the file:

```PowerShell
# OLD: VisibleCmdlets = 'Restart-Service'
VisibleCmdlets = 'Restart-Computer',
                 @{
                     Name = 'Restart-Service'
                     Parameters = @{ Name = 'Name'; ValidateSet = 'Spooler' }
                 },
                 'NetTCPIP\Get-*'

# OLD: VisibleExternalCommands = 'Item1', 'Item2'
VisibleExternalCommands = 'C:\Windows\system32\ipconfig.exe'
```

This contains a few interesting examples:

1.	You have restricted Restart-Service such that operators will only be able to use Restart-Service with the -Name parameter, and they will only be allowed to provide "Spooler" as an argument to that parameter.
If you wanted to, you could also restrict the arguments using a regular expression using "ValidatePattern" instead of "ValidateSet".

2.	You have exposed all commands with the "Get" verb from the NetTCPIP module.
Because "Get" commands typically don't change system state, this is a relatively safe action.
That being said, it is strongly encouraged to closely examinine every command you expose through JEA.

3.	You have expose an executable (ipconfig) using VisibleExternalCommands.
You can also expose full PowerShell scripts with this field.
It is important to always provide the full path to external commands to ensure a similarly named (and potentially malicous) program placed in the user's path does not get executed instead.

Save the file, then connect to the demo endpoint again to confirm the changes worked.

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEADemo2 -Credential $NonAdminCred
Get-Command
```
Because you only modified the Role Capability file, you do not need to re-register the Session Configuration.
PowerShell will automatically find your updated Role Capability when a user connects.
Since Role Capabilities are loaded when the session starts, existing sessions are not affected by updates to Role Capability files.

Now, confirm that you can restart the computer by running Restart-Computer with the -WhatIf parameter (unless you actually want to restart the computer).

```PowerShell
Restart-Computer -WhatIf
```

Confirm that you can run "ipconfig"

```PowerShell
ipconfig
```

And finally, confirm that Restart-Service only works for the Spooler service.

```PowerShell
Restart-Service Spooler # This should work
Restart-Service WSearch # This should fail
```

Exit the session when you are finished.

```PowerShell
Exit-PSSession
```

## Role Capability Creation
In the next section, you will create a JEA endpoint for AD help desk users.
To prepare, we will create a blank Role Capability file to fill in for that section.
Role Capabilities must be created inside a "RoleCapabilities" folder inside a valid PowerShell module in order to be resolved when a session starts.

PowerShell Modules are essentially packages of PowerShell functionality.
They can contain PowerShell functions, cmdlets, DSC Resources, Role Capabilities, and more.
You can find information about modules by running `Get-Help about_Modules` in a PowerShell console.

To create a new PowerShell module with a blank Role Capability file, run the following commands:  

```PowerShell
# Create a new folder for the module.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module' -ItemType Directory

# Add a module manifest to contain metadata for this module.
New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\Contoso_AD_Module.psd1' -RootModule Contoso_AD_Module.psm1

# Create a blank script module. You'll use this for custom functions in the next section.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\Contoso_AD_Module.psm1' -ItemType File

# Create a RoleCapabilities folder in the AD_Module folder. PowerShell expects Role Capabilities to be located in a "RoleCapabilities" folder within a module.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\RoleCapabilities' -ItemType Directory

# Create a blank Role Capability in your RoleCapabilities folder. Running this command without any additional parameters just creates a blank template.
New-PSRoleCapabilityFile -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\RoleCapabilities\ADHelpDesk.psrc'
```

Congratulations, you have created a blank Role Capability File.
It will be used in the next section.

## Key Concepts
**Role Capability (.psrc)**:
A file that define "what" a user can do at a JEA endpoint.
It details a whitelist of things like visible commands, visible console applications, and more.
In order for PowerShell to detect Role Capabilities, you must put them in a "RoleCapabilities" folder in a valid PowerShell module.

**PowerShell Module**:
A package of PowerShell functionality.
It can contain PowerShell functions, cmdlets, DSC Resources, Role Capabilities, and more.
In order to be automatically loaded, PowerShell modules must be located under a path in `$env:PSModulePath`.

