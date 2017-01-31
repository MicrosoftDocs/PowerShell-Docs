---
title:   Configure a virtual machines at initial boot-up by using DSC
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

>Applies To: Windows PowerShell 5.0

>**Note:** The **DSCAutomationHostEnabled** registry key described in this topic is not available in PowerShell 4.0.
For information on how to configure new virtual machines at initial boot-up in PowerShell 4.0, see
[Want to Automatically Configure Your Machines Using DSC at Initial Boot-up?](https://blogs.msdn.microsoft.com/powershell/2014/02/28/want-to-automatically-configure-your-machines-using-dsc-at-initial-boot-up/)

# Configure a virtual machines at initial boot-up by using DSC

## Requirements

To run these examples, you will need:

- A bootable VHD to work with. You can download an ISO with an evaluation copy of Windows Server 2016 at
    [TechNet Evaluation Center](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016). You can find instructions on how to create a VHD
    from an ISO image at [Creating Bootable Virtual Hard Disks](https://technet.microsoft.com/en-us/library/gg318049.aspx).
- A host computer that has Hyper-V enabled. For information, see [Hyper-V overview](https://technet.microsoft.com/library/hh831531.aspx).

By using DSC, you can automate software installation and configuration for a computer at initial boot-up.
You do this by either injecting a configuration MOF document or a metaconfiguration into bootable media (such as a VHD) so that they are run during the initial boot-up process.
This behavior is specified by the [DSCAutomationHostEnabled registry key](DSCAutomationHostEnabled.md) registry key under **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies**.
By default, the value of this key is 2, which allows DSC to run at boot time.

If you do not want DSC to run at boot time, set the value of the [DSCAutomationHostEnabled registry key](DSCAutomationHostEnabled.md) registry key to 0.

- Inject a configuration MOF document into a VHD
- Inject a DSC metaconfiguration into a VHD
- Disable DSC at boot time

>**Note:** You can inject both `Pending.mof` and `MetaConfig.mof` into a computer at the same time.
If both files are present, the settings specified in `MetaConfig.mof` take precedence.

## Inject a configuration MOF document into a VHD

To enact a configuration at initial boot-up, you can inject a compiled configuration MOF document into the VHD as its `Pending.mof` file.
If the **DSCAutomationHostEnabled** registry key is set to 2 (the default value), DSC will apply the configuration defined by `Pending.mof` when the computer boots up for the first time.

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

1. Mount the VHD into which you want to inject the configuration by calling the [Mount-VHD](https://technet.microsoft.com/library/hh848551.aspx) cmdlet. For example:

    ```powershell
    Mount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd
    ```
2. On a computer running PowerShell 5.0 or later, save the above configuration (**SampleIISInstall**) as a PowerShell script (.ps1) file.

3. In a PowerShell console, navigate to the folder where you saved the .ps1 file.

4. Run the following PowerShell commands to compile the MOF document (for information about compiling DSC configurations, see [DSC Configurations](configurations.md):

    ```powershell
    . .\SampleIISInstall.ps1
    SampleIISInstall
    ```

5. This will create a `localhost.mof` file in a new folder named `SampleIISInstall`.
Rename and move that file into the proper location on the VHD as `Pending.mof` by using the [Move-Item](https://technet.microsoft.comlibrary/hh849852.aspx) cmdlet. For example:

    ```powershell
        Move-Item -Path C:\DSCTest\SampleIISInstall\localhost.mof -Destination E:\Windows\Sytem32\Configuration\Pending.mof
    ```
6. Dismount the VHD by calling the [Dismount-VHD](https://technet.microsoft.com/library/hh848562.aspx) cmdlet. For example:

    ```powershell
    Dismount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd
    ```

7. Create a VM by using the VHD where you installed the DSC MOF document. 
After intial boot-up and operating system installation, IIS will be installed.
You can verify this by calling the [Get-WindowsFeature](https://technet.microsoft.com/library/jj205469.aspx) cmdlet.

## Inject a DSC metaconfiguration into a VHD

You can also configure a computer to pull a configuration at intial boot-up by injecting a metaconfiguration (see [Configuring the Local Configuration Manager (LCM)](metaConfig.md)) into the VHD as its `MetaConfig.mof` file.
If the **DSCAutomationHostEnabled** registry key is set to 2 (the default value),  DSC will apply the metaconfiguration defined by `MetaConfig.mof` to the LCM when the computer boots up for the first time.
If the metaconfiguration specifies that the LCM should pull configurations from a pull server, the computer will attempt to pull a configuration from that pull server at inital boot-up.
For information about setting up a DSC pull server, see [Setting up a DSC web pull server](pullServer.md).

For this example, we will use both the configuration described in the previous section (**SampleIISInstall**), and the following metaconfiguration:

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientBootstrap
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = '140a952b-b9d6-406b-b416-e0f759c9c0e4'
            ConfigurationNames = @('SampleIISInstall')
        }
    }
}
```

### To inject the metaconfiguration MOF document on the VHD

1. Mount the VHD into which you want to inject the metaconfiguration by calling the [Mount-VHD](https://technet.microsoft.com/library/hh848551.aspx) cmdlet. For example:

    ```powershell
    Mount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd
    ```

2. [Set up a DSC web pull server](pullServer.md), and save the **SampleIISInistall** configuration to the appropriate folder.

3. On a computer running PowerShell 5.0 or later, save the above metaconfiguration (**PullClientBootstrap**) as a PowerShell script (.ps1) file.

4. In a PowerShell console, navigate to the folder where you saved the .ps1 file.

5. Run the following PowerShell commands to compile the  metaconfiguration MOF document (for information about compiling DSC configurations, see [DSC Configurations](configurations.md):

    ```powershell
    . .\PullClientBootstrap.ps1
    PullClientBootstrap
    ```

6. This will create a `localhost.meta.mof` file in a new folder named `PullClientBootstrap`.
Rename and move that file into the proper location on the VHD as `MetaConfig.mof` by using the [Move-Item](https://technet.microsoft.comlibrary/hh849852.aspx) cmdlet.

    ```powershell
    Move-Item -Path C:\DSCTest\PullClientBootstrap\localhost.meta.mof -Destination E:\Windows\Sytem32\Configuration\MetaConfig.mof
    ```

7. Dismount the VHD by calling the [Dismount-VHD](https://technet.microsoft.com/library/hh848562.aspx) cmdlet. For example:

    ```powershell
    Dismount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd
    ```

8. Create a VM by using the VHD where you installed the DSC MOF document.
After intial boot-up and operating system installation, DSC will pull the configuration from the pull server, and IIS will be installed.
You can verify this by calling the [Get-WindowsFeature](https://technet.microsoft.com/library/jj205469.aspx) cmdlet.

## Disable DSC at boot time

By default, the value of the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DSCAutomationHostEnabled** key is set to 2,
which allows a DSC configuration to run if the computer is in pending or current state. If you do not want a configuration to run at initial boot-up, you need
so set the value of this key to 0:

1. Mount the VHD by calling the [Mount-VHD](https://technet.microsoft.com/library/hh848551.aspx) cmdlet. For example:

    ```powershell
    Mount-VHD -Path C:\users\public\documents\vhd\Srv16.vhd
    ```

2. Load the registry **HKLM\Software** subkey from the VHD by calling `reg load`.

    ```
    reg load HKLM\Vhd E:\Windows\System32\Config\Software`
    ```

3. Navigate to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\*** by using the PowerShell Registry provider.

    ```powershell
    Set-Location HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies`
    ```

4. Change the value of `DSCAutomationHostEnabled` to 0.

    ```powershell
    Set-ItemProperty -Path . -Name DSCAutomationHostEnabled -Value 0
    ```

5. Unload the registry by running the following commands:

    ```powershell
    [gc]::Collect()
    reg unload HKLM\Vhd
    ```

## See Also

- [DSC Configurations](configurations.md)
- [DSCAutomationHostEnabled registry key](DSCAutomationHostEnabled.md)
- [Configuring the Local Configuration Manager (LCM)](metaConfig.md)
- [Setting up a DSC web pull server](pullServer.md)
