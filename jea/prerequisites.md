---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  prerequisites
ms.technology:  powershell
---

# Prerequisites

## Initial State
Before starting this section, please ensure the following:

1. JEA is available on your system. Check out the [README](./README.md) for the current supported operating systems and required downloads.
2. You have administrative rights on the computer where you are trying out JEA.
3. The computer is domain joined.
See the [Creating a Domain Controller](#creating-a-domain-controller) section to quickly set up a new domain on a server if you don't already have one.

## Enable PowerShell Remoting
Management with JEA occurs through PowerShell Remoting.
Run the following in an Administrator PowerShell window to ensure that this is enabled and configured properly:

```PowerShell
Enable-PSRemoting
```

If you are unfamiliar with PowerShell remoting, it would be a good idea to run `Get-Help about_Remote` to learn about this important foundational concept.

## Identify Your Users or Groups
To show JEA in action, you need to identify the non-administrator users and groups you are going to use throughout this guide.

If you're using an existing domain, please identify or create some unprivileged users and groups.
You will give these non-administrators access to JEA.
Anytime you see the `$NonAdministrator` variable in a top of a script, assign it to your selected non-administrator users or groups.

If you created a new domain from scratch, it's much easier.
Please use the [Set Up Users and Groups](creating-a-domain-controller.md#set-up-users-and-groups) section in the appendix to create a non-administrator users and groups.
The default values of `$NonAdministrator` will be the groups created in that section.

## Set Up Maintenance Role Capability File
Run the following commands in PowerShell to create the demo Role Capability file we will be using for the next section.
Later in this guide, you will learn about what this file does.

```PowerShell
# Fields in the role capability
$MaintenanceRoleCapabilityCreationParams = @{
    Author = 'Contoso Admin'
    CompanyName = 'Contoso'
    VisibleCmdlets = 'Restart-Service'
    FunctionDefinitions =
            @{ Name = 'Get-UserInfo'; ScriptBlock = { $PSSenderInfo } }
}

# Create the demo module, which will contain the maintenance Role Capability File
New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module" -ItemType Directory
New-ModuleManifest -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\Demo_Module.psd1"
New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities" -ItemType Directory

# Create the Role Capability file
New-PSRoleCapabilityFile -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities\Maintenance.psrc" @MaintenanceRoleCapabilityCreationParams
```

## Create and Register Demo Session Configuration File
Run the following commands to create and register the demo Session Configuration file we will be using for the next section.
Later in this guide, you will learn about what this file does.

```PowerShell
# Determine domain
$domain = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain

# Replace with your non-admin group name
$NonAdministrator = "$domain\JEA_NonAdmin_Operator"

# Specify the settings for this JEA endpoint
# Note: You will not be able to use a virtual account if you are using WMF 5.0 on Windows 7 or Windows Server 2008 R2
$JEAConfigParams = @{
    SessionType = 'RestrictedRemoteServer'
    RunAsVirtualAccount = $true
    RoleDefinitions = @{
        $NonAdministrator = @{ RoleCapabilities = 'Maintenance' }
    }
    TranscriptDirectory = "$env:ProgramData\JEAConfiguration\Transcripts"
}

# Set up a folder for the Session Configuration files
if (-not (Test-Path "$env:ProgramData\JEAConfiguration"))
{
    New-Item -Path "$env:ProgramData\JEAConfiguration" -ItemType Directory
}

# Specify the name of the JEA endpoint
$sessionName = 'JEA_Demo'

if (Get-PSSessionConfiguration -Name $sessionName -ErrorAction SilentlyContinue)
{
    Unregister-PSSessionConfiguration -Name $sessionName -ErrorAction Stop
}

New-PSSessionConfigurationFile -Path "$env:ProgramData\JEAConfiguration\JEADemo.pssc" @JEAConfigParams

# Register the session configuration
Register-PSSessionConfiguration -Name $sessionName -Path "$env:ProgramData\JEAConfiguration\JEADemo.pssc"
```

## Enable PowerShell Module Logging (Optional)
The following steps enable logging for all PowerShell actions on your system.
You don't need to enable this for JEA to work, but it will be useful in the [Reporting on JEA](reporting-on-jea.md) section.

1. Open the Local Group Policy Editor
2. Navigate to "Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell"
3. Double Click on "Turn on Module Logging"
4. Click "Enabled"
5. In the Options section, click on "Show" next to Module Names
6. Type "\*" in the pop up window. This means PowerShell will log commands from all modules.
7. Click OK and apply the policy

Note: you can also enable system-wide PowerShell transcription through Group Policy.

**Congratulations, you have now configured your computer with the demo endpoint and are ready to get started with JEA!**

