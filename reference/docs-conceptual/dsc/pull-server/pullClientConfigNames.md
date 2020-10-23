---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Set up a Pull Client using Configuration Names in PowerShell 5.0 and later
description: The article explains how to set up a Pull Client using Configuration Names in PowerShell 5.0 and later
---
# Set up a Pull Client using Configuration Names in PowerShell 5.0 and later

> Applies To: Windows PowerShell 5.0

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server however
> there are no plans to offer new features or capabilities. It is recommended to begin transitioning
> managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions listed
> [here](pullserver.md#community-solutions-for-pull-service).

Before setting up a pull client, you should set up a pull server. Though this order is not required,
it helps with troubleshooting, and helps you ensure that the registration was successful. To set up
a pull server, you can use the following guides:

- [Set up a DSC SMB Pull Server](pullServerSmb.md)
- [Set up a DSC HTTP Pull Server](pullServer.md)

Each target node can be configured to download configurations, resources, and even report its
status. The sections below show you how to configure a pull client with an SMB share or HTTP DSC
Pull Server. When the Node's LCM refreshes, it will reach out to the configured location to download
any assigned configurations. If any required resources do not exist on the Node, it will
automatically download them from the configured location. If the Node is configured with a
[Report Server](reportServer.md), it will then report the status of the operation.

> [!NOTE]
> This topic applies to PowerShell 5.0. For information on setting up a pull client in PowerShell
> 4.0, see [Set up a pull client using configuration ID in PowerShell 4.0](pullClientConfigID4.md)

## Configure the pull client LCM

Executing any of the examples below creates a new output folder named **PullClientConfigName** and
puts a metaconfiguration MOF file there. In this case, the metaconfiguration MOF file will be named
`localhost.meta.mof`.

To apply the configuration, call the **Set-DscLocalConfigurationManager** cmdlet, with the **Path**
set to the location of the metaconfiguration MOF file. For example:

```powershell
Set-DSCLocalConfigurationManager –ComputerName localhost –Path .\PullClientConfigName –Verbose.
```

## Configuration Name

The examples below sets the **ConfigurationName** property of the LCM to the name of a previously
compiled Configuration, created for this purpose. The **ConfigurationName** is what the LCM uses to
find the appropriate configuration on the pull server. The configuration MOF file on the pull server
must be named `<ConfigurationName>.mof`, in this case, "ClientConfig.mof". For more information, see
[Publish Configurations to a Pull Server (v4/v5)](publishConfigs.md).

## Set up a Pull Client to download Configurations

Each client must be configured in **Pull** mode and given the pull server url where its
configuration is stored. To do this, you have to configure the Local Configuration Manager (LCM)
with the necessary information. To configure the LCM, you create a special type of configuration,
decorated with the **DSCLocalConfigurationManager** attribute. For more information about
configuring the LCM, see
[Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md).

The following script configures the LCM to pull configurations from a server named "CONTOSO-PullSrv".

- In the script, the **ConfigurationRepositoryWeb** block defines the pull server. The **ServerURL**
  property specifies the endpoint for the pull server.

- The **RegistrationKey** property is a shared key between all client nodes for a pull server and
  that pull server. The same value is stored in a file on the pull server. > [!NOTE] > Registration
  keys work only with **web** pull servers. You must still use **ConfigurationID** with an **SMB**
  pull server. > For information about configuring a pull server by using **ConfigurationID**, see
  [Setting up a pull client using configuration ID](pullClientConfigId.md)

- The **ConfigurationNames** property is an array that specifies the names of the configurations
  intended for the client node. >**Note:** If you specify more than one value in the
  **ConfigurationNames**, you must also specify **PartialConfiguration** blocks in your
  configuration. >For information about partial configurations, see
  [PowerShell Desired State Configuration partial configurations](partialConfigs.md).

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigNames
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
            ConfigurationNames = @('ClientConfig')
        }
    }
}
PullClientConfigNames
```

## Set up a Pull Client to download Resources

If you specify only a **ConfigurationRepositoryWeb** or **ConfigurationRepositoryShare** block in
your LCM configuration (as in the previous example), the pull client will pull resources from same
location where your ".mof" files are stored. You can also specify different locations where clients
can download resources. To specify a resource server, you use either a **ResourceRepositoryWeb**
(for a web pull server) or a **ResourceRepositoryShare** block (for an SMB pull server).

The following example shows a metaconfiguration that sets up a client to download configurations
from a Pull Server, and resources from an SMB share.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigNames
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
            RegistrationKey = 'fbc6ef09-ad98-4aad-a062-92b0e0327562'
        }

        ResourceRepositoryShare SMBResources
        {
            SourcePath = '\\SMBPullServer\Resources'
        }
    }
}
PullClientConfigNames
```

## Set up a Pull Client to report status

You can use a single pull server for configurations, resources, and reporting. Reporting is not
configured for clients by default. To configure a client to report status, you have to create a
**ReportRepositoryWeb** block. The following example shows a metaconfiguration that sets up a client
to pull configurations and resources, and send reporting data, to a single pull server.

> [!NOTE]
> A report server cannot be an SMB share.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigNames
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
            RegistrationKey = 'fbc6ef09-ad98-4aad-a062-92b0e0327562'
        }

        ReportServerWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = 'fbc6ef09-ad98-4aad-a062-92b0e0327562'
        }
    }
}
PullClientConfigNames
```

## See Also

- [Setting up a pull client with configuration ID](PullClientConfigNames.md)
- [Setting up a DSC web pull server](pullServer.md)
