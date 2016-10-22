---
title:   Configure new virtual machines by using DSC
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

>Applies To: Windows PowerShell 5.0

# Configure new virtual machines by using DSC

## Requirements

To run these examples, you will need:

- A bootable VHD to work with. You can download an ISO with an evaluation copy of Windows Server 2016 at
    [TechNet Evaluation Center](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016). You can find instructions on how to create a VHD
    from an ISO image at [Creating Bootable Virtual Hard Disks](https://technet.microsoft.com/en-us/library/gg318049.aspx).
- A host computer that has Hyper-V enabled. For information, see [Hyper-V overview](https://technet.microsoft.com/library/hh831531.aspx).

By using DSC, you can automate software installation and configuration for a computer at initial boot-up. You do this by either injecting a configuration MOF document 
or a metaconfiguration into bootable media (such as a VHD) so that they are run during the initial boot-up process. You also have to set the value of the 
**DSCAutomationHostEnabled** registry key under **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies** to 1 to enable DSC to run at initial boot-up.

- [Set the DSCAutomationHostEnabled registry key](#Set the DSCAutomationHostEnabled registry key)
- [Inject a configuration MOF document into a VHD](#Inject a configuration MOF document into a VHD)
- [Inject a DSC metaconfiguration into a VHD](#Inject a DSC metaconfiguration into a VHD)

## Set the DSCAutomationHostEnabled registry key

By default, the value of the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DSCAutomationHostEnabled** key is set to 2,
which allows a DSC configuration to run only if the computer is in pending or current state. To allow a configuration to run at initial boot-up, you need
so set the value of this key to 1:

1. Mount the VHD by calling the [Mount-VHD]() cmdlet. For example:
    `Mount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd`
2. Load the registry **HKLM\Software** subkey from the VHD by calling `reg load`. For example, if the 
    `reg load HKLM\Vhd E:\Windows\System32\Config\Software`
3. Navigate to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\*** by using the PowerShell Registry provider. For example:
    `Set-Location HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies`
4. Change the value of `DSCAutomationHostEnabled` to 1:
    `Set-ItemProperty -Path . -Name DSCAutomationHostEnabled -Value 1`
5. Unload the registry by running the following commands:
    ```powershell
    [gc]::Collect()
    reg unload HKLM\Vhd
    ```

## Inject a configuration MOF document into a VHD

To enact a configuration at initial boot-up, you can inject a compiled configuration MOF document into the VHD as its `Pending.mof` file. If the
**DSCAutomationHostEnabled** registry key is set to 1, as described above, DSC will apply the configuration defined by `Pending.mof` when the 
computer boots up for the first time.

For this example, we will use the following configuration, which will install IIS on the new computer:

```powershell
Configuration SampleIISInstall
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    node ('localhost')
    {
        WindowsFeature IIS
        {
            Ensure = 'Present'
            Name   = 'Web-Server' 
        }
    }
}
```
### To inject the configuration MOF document on the VHD

1. On a computer running PowerShell 5.0 or later, save the above configuration (**SampleIISInstall**) as a PowerShell script (.ps1) file.
2. In a PowerShell console, navigate to the folder where you saved the .ps1 file.
3. Run the following PowerShell commands to compile the MOF document (for information about compiling DSC configurations, see [DSC Configurations](configurations.md):
    ```powershell
    . .\SampleIISInstall.ps1
    SampleIISInstall
    ```
4. This will create a `localhost.mof` file in a new folder named `SampleIISInstall`. Rename and move that file into the proper location on the VHD as `Pending.mof` 
    by using the []Move-Item](https://technet.microsoft.comlibrary/hh849852.aspx)
    cmdlet. For example:

        `Move-Item -Path C:\DSCTest\SampleIISInstall\localhost.mof -Destination E:\Windows\Sytem32\Configuration\Pending.mof`
5. Dismount the VHD by calling the [Dismount-VHD](https://technet.microsoft.com/library/hh848562.aspx) cmdlet. For example:
    `Dismount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd`











