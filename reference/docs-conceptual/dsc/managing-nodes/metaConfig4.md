---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Configuring the LCM in PowerShell 4.0
description: The Local Configuration Manager (LCM) runs on every target node and is responsible for parsing and applying configurations that are sent to the node.
---
# Configuring the LCM in PowerShell 4.0

>Applies To: Windows PowerShell 4.0

**For information related to Windows PowerShell 5.0 and later, see
[Configuring the Local Configuration Manager](metaConfig.md).**

Local Configuration Manager is the Windows PowerShell Desired State Configuration (DSC) engine. It
runs on all target nodes, and it is responsible for calling the configuration resources that are
included in a DSC configuration script. This topic lists the properties of Local Configuration
Manager and describes how you can modify the Local Configuration Manager settings on a target node.

## Local Configuration Manager properties

The following lists the Local Configuration Manager properties that you can set or retrieve.

- **AllowModuleOverwrite**: Controls whether new configurations downloaded from the configuration
  service are allowed to overwrite the old ones on the target node. Possible values are True and
  False.
- **CertificateID**: The thumbprint of a certificate used to secure credentials passed in a
  configuration. For more information see
  [Want to secure credentials in Windows PowerShell Desired State Configuration?](https://devblogs.microsoft.com/powershell/want-to-secure-credentials-in-windows-powershell-desired-state-configuration/).
- **ConfigurationID**: Indicates a GUID which is used to get a particular configuration file from a
  pull service. The GUID ensures that the correct configuration file is accessed.
- **ConfigurationMode**: Specifies how the Local Configuration Manager actually applies the
  configuration to the target nodes. It can take the following values:
  - **ApplyOnly**: With this option, DSC applies the configuration and does nothing further unless a
    new configuration is detected, either by you sending a new configuration directly to the target
    node or if you are connecting to a pull service and DSC discovers a new configuration when it
    checks with the pull service. If the target node's configuration drifts, no action is taken.
  - **ApplyAndMonitor**: With this option (which is the default), DSC applies any new
    configurations, whether sent by you directly to the target node or discovered on a pull service.
    Thereafter, if the configuration of the target node drifts from the configuration file, DSC
    reports the discrepancy in logs. For more about DSC logging, see
    [Using Event Logs to Diagnose Errors in Desired State Configuration](https://devblogs.microsoft.com/powershell/using-event-logs-to-diagnose-errors-in-desired-state-configuration/).
  - **ApplyAndAutoCorrect**: With this option, DSC applies any new configurations, whether sent by
    you directly to the target node or discovered on a pull service. Thereafter, if the
    configuration of the target node drifts from the configuration file, DSC reports the discrepancy
    in logs, and then attempts to adjust the target node configuration to bring in compliance with
    the configuration file.
- **ConfigurationModeFrequencyMins**: Represents the frequency (in minutes) at which the background
  application of DSC attempts to implement the current configuration on the target node. The default
  value is 15. This value can be set in conjunction with RefreshMode. When RefreshMode is set to
  PULL, the target node contacts the configuration service at an interval set by
  RefreshFrequencyMins and downloads the current configuration. Regardless of the RefreshMode value,
  at the interval set by ConfigurationModeFrequencyMins, the consistency engine applies the latest
  configuration that was downloaded to the target node. RefreshFrequencyMins should be set to an
  integer multiple of ConfigurationModeFrequencyMins.
- **Credential**: Indicates credentials (as with Get-Credential) required to access remote
  resources, such as to contact the configuration service.
- **DownloadManagerCustomData**: Represents an array that contains custom data specific to the
  download manager.
- **DownloadManagerName**: Indicates the name of the configuration and module download manager.
- **RebootNodeIfNeeded**: Set this to `$true` to allow resources to reboot the Node using the
  `$global:DSCMachineStatus` flag. Otherwise, you will have to manually reboot the node for any
  configuration that requires it. The default value is `$false`. To use this setting when a reboot
  condition is enacted by something other than DSC (such as Windows Installer), combine this setting
  with the [xPendingReboot](https://github.com/powershell/xpendingreboot) module.
- **RefreshFrequencyMins**: Used when you have set up a pull service. Represents the frequency (in
  minutes) at which the Local Configuration Manager contacts a pull service to download the current
  configuration. This value can be set in conjunction with ConfigurationModeFrequencyMins. When
  RefreshMode is set to PULL, the target node contacts the pull service at an interval set by
  RefreshFrequencyMins and downloads the current configuration. At the interval set by
  ConfigurationModeFrequencyMins, the consistency engine then applies the latest configuration that
  was downloaded to the target node. If RefreshFrequencyMins is not set to an integer multiple of
  ConfigurationModeFrequencyMins, the system will round it up. The default value is 30.
- **RefreshMode**: Possible values are **Push** (the default) and **Pull**. In the "push"
  configuration, you must place a configuration file on each target node, using any client computer.
  In the "pull" mode, you must set up a pull service for Local Configuration Manager to contact and
  access the configuration files.

> [!NOTE]
> The LCM starts the **ConfigurationModeFrequencyMins** cycle based on:
>
> - A new metaconfig is applied using `Set-DscLocalConfigurationManager`
> - A machine restart
>
> For any condition where the timer process experiences a crash, that will be detected within 30
> seconds and the cycle will be restarted. A concurrent operation could delay the cycle from being
> started, if the duration of this operation exceeds the configured cycle frequency, the next timer
> will not start.
>
> Example, the metaconfig is configured at a 15 minute pull frequency and a pull occurs at T1. The
> Node does not finish work for 16 minutes. The first 15 minute cycle is ignored, and next pull will
> happen at T1+15+15.

### Example of updating Local Configuration Manager settings

You can update the Local Configuration Manager settings of a target node by including a
**LocalConfigurationManager** block inside the node block in a configuration script, as shown in the
following example.

```powershell
Configuration ExampleConfig
{
    Node "Server001"
    {
        LocalConfigurationManager
        {
            ConfigurationID = "646e48cb-3082-4a12-9fd9-f71b9a562d4e"
            ConfigurationModeFrequencyMins = 45
            ConfigurationMode = "ApplyAndAutocorrect"
            RefreshMode = "Pull"
            RefreshFrequencyMins = 90
            DownloadManagerName = "WebDownloadManager"
            DownloadManagerCustomData = (@{ServerUrl="https://$PullService/psdscpullserver.svc"})
            CertificateID = "71AA68562316FE3F73536F1096B85D66289ED60E"
            Credential = $cred
            RebootNodeIfNeeded = $true
            AllowModuleOverwrite = $false
        }
# One or more resource blocks can be added here
    }
}

# The following line invokes the configuration and creates a file called
# Server001.meta.mof at the specified path
ExampleConfig -OutputPath "c:\users\public\dsc"
```

Running the script in the previous example generates a MOF file that specifies and stores the
desired settings. To apply the settings, you can use the **Set-DscLocalConfigurationManager**
cmdlet, as shown in the following example.

```powershell
Set-DscLocalConfigurationManager -Path "c:\users\public\dsc"
```

> [!NOTE]
> For the **Path** parameter, you must specify the same path that you specified for the
> **OutputPath** parameter when you invoked the configuration in the previous example.

To see the current Local Configuration Manager settings, you can use the
**Get-DscLocalConfigurationManager** cmdlet. If you invoke this cmdlet with no parameters, by
default it will get the Local Configuration Manager settings for the node on which you run it. To
specify another node, use the **CimSession** parameter with this cmdlet.
