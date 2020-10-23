---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  PowerShell Desired State Configuration partial configurations
description: DSC allows configurations to be delivered in fragments and from multiple sources. The LCM on the target node puts the fragments together before applying them as a single configuration.
---
# PowerShell Desired State Configuration partial configurations

> Applies To: Windows PowerShell 5.0 and later.

In PowerShell 5.0, Desired State Configuration (DSC) allows configurations to be delivered in
fragments and from multiple sources. The Local Configuration Manager (LCM) on the target node puts
the fragments together before applying them as a single configuration. This capability allows
sharing control of configuration between teams or individuals. For example, if two or more teams of
developers are collaborating on a service, they might each want to create configurations to manage
their part of the service. Each of these configurations could be pulled from different pull
servers, and they could be added at different stages of development. Partial configurations also
allow different individuals or teams to control different aspects of configuring nodes without
having to coordinate the editing of a single configuration document. For example, one team might be
responsible for deploying a VM and operating system, while another team might deploy other
applications and services on that VM. With partial configurations, each team can create its own
configuration, without either of them being unnecessarily complicated.

You can use partial configurations in push mode, pull mode, or a combination of the two.

## Partial configurations in push mode

To use partial configurations in push mode, you configure the LCM on the target node to receive the
partial configurations. Each partial configuration must be pushed to the target by using the
`Publish-DSCConfiguration` cmdlet. The target node then combines the partial configuration into a
single configuration, and you can apply the configuration by calling the
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
cmdlet.

### Configuring the LCM for push-mode partial configurations

To configure the LCM for partial configurations in push mode, you create a
**DSCLocalConfigurationManager** configuration with one **PartialConfiguration** block for each
partial configuration. For more information about configuring the LCM, see
[Windows Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md). The
following example shows an LCM configuration that expects two partial configurations—one that
deploys the OS, and one that deploys and configures SharePoint.

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemo
{
    Node localhost
    {

        PartialConfiguration ServiceAccountConfig
        {
            Description = 'Configuration to add the SharePoint service account to the Administrators group.'
            RefreshMode = 'Push'
        }
           PartialConfiguration SharePointConfig
        {
            Description = 'Configuration for the SharePoint server'
            RefreshMode = 'Push'
        }
    }
}

PartialConfigDemo
```

The **RefreshMode** for each partial configuration is set to "Push". The names of the
**PartialConfiguration** blocks (in this case, "ServiceAccountConfig" and "SharePointConfig") must
match exactly the names of the configurations that are pushed to the target node.

> [!Note]
> The named of each **PartialConfiguration** block must match the actual name of the configuration
> as it is specified in the configuration script, not the name of the MOF file, which should be
> either the name of the target node or `localhost`.

### Publishing and starting push-mode partial configurations

You then call [Publish-DSCConfiguration](/powershell/module/PSDesiredStateConfiguration/Publish-DscConfiguration)
for each configuration, passing the folders that contain the configuration documents as the
**Path** parameters. `Publish-DSCConfiguration`places the configuration MOF files to the target
nodes. After publishing both configurations, you can call `Start-DSCConfiguration –UseExisting` on
the target node.

For example, if you have compiled the following configuration MOF documents on the authoring node:

```powershell
Get-ChildItem -Recurse
```

```output
    Directory: C:\PartialConfigTest

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        8/11/2016   1:55 PM                ServiceAccountConfig
d-----       11/17/2016   4:14 PM                SharePointConfig

    Directory: C:\PartialConfigTest\ServiceAccountConfig

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        8/11/2016   2:02 PM           2034 TestVM.mof

    Directory: C:\PartialConfigTest\SharePointConfig

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       11/17/2016   4:14 PM           1930 TestVM.mof
```

You would publish and run the configurations as follows:

```powershell
Publish-DscConfiguration .\ServiceAccountConfig -ComputerName 'TestVM'
Publish-DscConfiguration .\SharePointConfig -ComputerName 'TestVM'
Start-DscConfiguration -UseExisting -ComputerName 'TestVM'
```

```output
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
17     Job17           Configuratio... Running       True            TestVM            Start-DscConfiguration...
```

> [!Note]
> The user running the [Publish-DSCConfiguration](/powershell/module/PSDesiredStateConfiguration/Publish-DscConfiguration)
> cmdlet must have administrator privileges on the target node.

## Partial configurations in pull mode

Partial configurations can be pulled from one or more pull servers (for more information about pull
servers, see [Windows PowerShell Desired State Configuration Pull Servers](pullServer.md). To do
this, you have to configure the LCM on the target node to pull the partial configurations, and name
and locate the configuration documents properly on the pull servers.

### Configuring the LCM for pull node configurations

To configure the LCM to pull partial configurations from a pull server, you define the pull server
in either a **ConfigurationRepositoryWeb** (for an HTTP pull server) or
**ConfigurationRepositoryShare** (for an SMB pull server) block. You then create
**PartialConfiguration** blocks that refer to the pull server by using the **ConfigurationSource**
property. You also need to create a **Settings** block to specify that the LCM uses pull mode, and
to specify the **ConfigurationNames** or **ConfigurationID** that the pull server and target node
use to identify the configurations. The following meta-configuration defines an HTTP pull server
named CONTOSO-PullSrv and two partial configurations that use that pull server.

For more information about configuring the LCM using **ConfigurationNames**, see
[Setting up a pull client using configuration names](pullClientConfigNames.md). For information
about configuring the LCM using **ConfigurationID**, see
[Setting up a pull client using configuration ID](pullClientConfigID.md).

#### Configuring the LCM for pull mode configurations using configuration names

```powershell
[DscLocalConfigurationManager()]
Configuration PartialConfigDemoConfigNames
{
        Settings
        {
            RefreshFrequencyMins            = 30;
            RefreshMode                     = "PULL";
            ConfigurationMode               ="ApplyAndAutocorrect";
            AllowModuleOverwrite            = $true;
            RebootNodeIfNeeded              = $true;
            ConfigurationModeFrequencyMins  = 60;
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL                       = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey                 = 5b41f4e6-5e6d-45f5-8102-f2227468ef38
            ConfigurationNames              = @("ServiceAccountConfig", "SharePointConfig")
        }

        PartialConfiguration ServiceAccountConfig
        {
            Description                     = "ServiceAccountConfig"
            ConfigurationSource             = @("[ConfigurationRepositoryWeb]CONTOSO-PullSrv")
        }

        PartialConfiguration SharePointConfig
        {
            Description                     = "SharePointConfig"
            ConfigurationSource             = @("[ConfigurationRepositoryWeb]CONTOSO-PullSrv")
            DependsOn                       = '[PartialConfiguration]ServiceAccountConfig'
        }
}
```

#### Configuring the LCM for pull mode configurations using ConfigurationID

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemoConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode                     = 'Pull'
            ConfigurationID                 = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins            = 30
            RebootNodeIfNeeded              = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL                       = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'

        }

           PartialConfiguration ServiceAccountConfig
        {
            Description                     = 'Configuration for the Base OS'
            ConfigurationSource             = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            RefreshMode                     = 'Pull'
        }
           PartialConfiguration SharePointConfig
        {
            Description                     = 'Configuration for the Sharepoint Server'
            ConfigurationSource             = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            DependsOn                       = '[PartialConfiguration]ServiceAccountConfig'
            RefreshMode                     = 'Pull'
        }
    }
}
PartialConfigDemo
```

You can pull partial configurations from more than one pull server—you would just need to define
each pull server, and then refer to the appropriate pull server in each **PartialConfiguration**
block.

After creating the meta-configuration, you must run it to create a configuration document (a MOF
file), and then call [Set-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Set-DscLocalConfigurationManager)
to configure the LCM.

### Naming and placing the configuration documents on the pull server (ConfigurationNames)

The partial configuration documents must be placed in the folder specified as the
**ConfigurationPath** in the `web.config` file for the pull server (typically `C:\Program
Files\WindowsPowerShell\DscService\Configuration`).

#### Naming configuration documents on the pull server in PowerShell 5.1

If you are pulling only one partial configuration from an individual pull server, the configuration
document can have any name. If you are pulling more than one partial configuration from a pull
server, the configuration document can be named either `<ConfigurationName>.mof`, where
*ConfigurationName* is the name of the partial configuration, or
`<ConfigurationName>.<NodeName>.mof`, where *ConfigurationName* is the name of the partial
configuration, and *NodeName* is the name of the target node. This allows you to pull
configurations from Azure Automation DSC pull server.

#### Naming configuration documents on the pull server in PowerShell 5.0

The configuration documents must be named as follows: `ConfigurationName.mof`, where
*ConfigurationName* is the name of the partial configuration. For our example, the configuration
documents should be named as follows:

```
ServiceAccountConfig.mof
ServiceAccountConfig.mof.checksum
SharePointConfig.mof
SharePointConfig.mof.checksum
```

### Naming and placing the configuration documents on the pull server (ConfigurationID)

The partial configuration documents must be placed in the folder specified as the
**ConfigurationPath** in the `web.config` file for the pull server
(typically `C:\Program Files\WindowsPowerShell\DscService\Configuration`). The configuration
documents must be named as follows: `<ConfigurationName>.<ConfigurationID>.mof`, where
_ConfigurationName_ is the name of the partial configuration and _ConfigurationID_ is the
configuration ID defined in the LCM on the target node. For our example, the configuration
documents should be named as follows:

```
ServiceAccountConfig.1d545e3b-60c3-47a0-bf65-5afc05182fd0.mof
ServiceAccountConfig.1d545e3b-60c3-47a0-bf65-5afc05182fd0.mof.checksum
SharePointConfig.1d545e3b-60c3-47a0-bf65-5afc05182fd0.mof
SharePointConfig.1d545e3b-60c3-47a0-bf65-5afc05182fd0.mof.checksum
```

### Running partial configurations from a pull server

After the LCM on the target node has been configured, and the configuration documents have been
created and properly named on the pull server, the target node will pull the partial
configurations, combine them, and apply the resulting configuration at regular intervals as
specified by the **RefreshFrequencyMins** property of the LCM. If you want to force a refresh, you
can call the
[Update-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Update-DscConfiguration)
cmdlet, to pull the configurations, and then `Start-DSCConfiguration –UseExisting` to apply them.

## Partial configurations in mixed push and pull modes

You can also mix push and pull modes for partial configurations. That is, you could have one
partial configuration that is pulled from a pull server, while another partial configuration is
pushed. Specify the refresh mode for each partial configuration as described in the previous
sections. For example, the following meta-configuration describes the same example, with the
`ServiceAccountConfig` partial configuration in pull mode and the `SharePointConfig` partial
configuration in push mode.

### Mixed push and pull modes using ConfigurationNames

```powershell
[DscLocalConfigurationManager()]
Configuration PartialConfigDemoConfigNames
{
        Settings
        {
            RefreshFrequencyMins            = 30;
            RefreshMode                     = "PULL";
            ConfigurationMode               = "ApplyAndAutocorrect";
            AllowModuleOverwrite            = $true;
            RebootNodeIfNeeded              = $true;
            ConfigurationModeFrequencyMins  = 60;
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL                       = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey                 = 5b41f4e6-5e6d-45f5-8102-f2227468ef38
            ConfigurationNames              = @("ServiceAccountConfig", "SharePointConfig")
        }

        PartialConfiguration ServiceAccountConfig
        {
            Description                     = "ServiceAccountConfig"
            ConfigurationSource             = @("[ConfigurationRepositoryWeb]CONTOSO-PullSrv")
            RefreshMode                     = 'Pull'
        }

        PartialConfiguration SharePointConfig
        {
            Description                     = "SharePointConfig"
            DependsOn                       = '[PartialConfiguration]ServiceAccountConfig'
            RefreshMode                     = 'Push'
        }

}
```

### Mixed push and pull modes using ConfigurationID

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemo
{
    Node localhost
    {
        Settings
        {
            RefreshMode             = 'Pull'
            ConfigurationID         = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins    = 30
            RebootNodeIfNeeded      = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL               = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'

        }

           PartialConfiguration ServiceAccountConfig
        {
            Description             = 'Configuration for the Base OS'
            ConfigurationSource     = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            RefreshMode             = 'Pull'
        }
           PartialConfiguration SharePointConfig
        {
            Description             = 'Configuration for the Sharepoint Server'
            DependsOn               = '[PartialConfiguration]ServiceAccountConfig'
            RefreshMode             = 'Push'
        }
    }
}
PartialConfigDemo
```

Note that the **RefreshMode** specified in the Settings block is "Pull", but the **RefreshMode**
for the `SharePointConfig` partial configuration is "Push".

Name and locate the configuration MOF files as described above for their respective refresh modes.
Call `Publish-DSCConfiguration` to publish the `SharePointConfig` partial configuration, and either
wait for the `ServiceAccountConfig` configuration to be pulled from the pull server, or force a
refresh by calling [Update-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Update-DscConfiguration).

## Example ServiceAccountConfig Partial Configuration

```powershell
Configuration ServiceAccountConfig
{
    Param (
        [Parameter(Mandatory,
                   HelpMessage="Domain credentials required to add domain\sharepoint_svc to the local Administrators group.")]
        [ValidateNotNullOrEmpty()]
        [pscredential]$Credential
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        Group LocalAdmins
        {
            GroupName           = 'Administrators'
            MembersToInclude    = 'domain\sharepoint_svc',
                                  'admins@example.domain'
            Ensure              = 'Present'
            Credential          = $Credential
        }

        WindowsFeature Telnet
        {
            Name                = 'Telnet-Server'
            Ensure              = 'Absent'
        }
    }
}
ServiceAccountConfig
```

## Example SharePointConfig Partial Configuration

```powershell
Configuration SharePointConfig
{
    Param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential]$ProductKey
    )

    Import-DscResource -ModuleName xSharePoint

    Node localhost
    {
        xSPInstall SharePointDefault
        {
            Ensure      = 'Present'
            BinaryDir   = '\\FileServer\Installers\Sharepoint\'
            ProductKey  = $ProductKey
        }
    }
}
SharePointConfig
```

## See Also

[Windows PowerShell Desired State Configuration Pull Servers](pullServer.md)

[Windows Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md)
