---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Set up a Pull Client using Configuration IDs in PowerShell 5.0 and later
description:  This article explains how to set up a Pull Client using Configuration IDs in PowerShell 5.0 and later
---

# Set up a Pull Client using Configuration IDs in PowerShell 5.0 and later

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
> 4.0, see
> [Setting up a pull client using configuration ID in PowerShell 4.0](pullClientConfigID4.md)

## Configure the pull client LCM

Executing any of the examples below creates a new output folder named **PullClientConfigID** and
puts a metaconfiguration MOF file there. In this case, the metaconfiguration MOF file will be named
`localhost.meta.mof`.

To apply the configuration, call the **Set-DscLocalConfigurationManager** cmdlet, with the **Path**
set to the location of the metaconfiguration MOF file. For example:

```powershell
Set-DSCLocalConfigurationManager –ComputerName localhost –Path .\PullClientConfigId –Verbose.
```

## Configuration ID

The examples below sets the **ConfigurationID** property of the LCM to a **Guid** that had been
previously created for this purpose. The **ConfigurationID** is what the LCM uses to find the
appropriate configuration on the pull server. The configuration MOF file on the pull server must be
named `ConfigurationID.mof`, where *ConfigurationID* is the value of the **ConfigurationID**
property of the target node's LCM. For more information see
[Publish Configurations to a Pull Server (v4/v5)](publishConfigs.md).

You can create a random **Guid** using the example below, or by using the
[New-Guid](/powershell/module/microsoft.powershell.utility/new-guid) cmdlet.

```powershell
[System.Guid]::NewGuid()
```

For more information about using **Guids** in your environment, see
[Plan for Guids](secureserver.md#guids).

## Set up a Pull Client to download Configurations

Each client must be configured in **Pull** mode and given the pull server url where its
configuration is stored. To do this, you have to configure the Local Configuration Manager (LCM)
with the necessary information. To configure the LCM, you create a special type of configuration,
decorated with the **DSCLocalConfigurationManager** attribute. For more information about
configuring the LCM, see
[Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md).

### HTTP DSC Pull Server

The following script configures the LCM to pull configurations from a server named
"CONTOSO-PullSrv".

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'

        }
    }
}
PullClientConfigID
```

In the script, the **ConfigurationRepositoryWeb** block defines the pull server. The **ServerUrl**
specifies the url of the DSC Pull

### SMB Share

The following script configures the LCM to pull configurations from the SMB Share
`\\SMBPullServer\Pull`.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryShare SMBPullServer
        {
            SourcePath = '\\SMBPullServer\Pull'
        }
    }
}
PullClientConfigID
```

In the script, the **ConfigurationRepositoryShare** block defines the pull server, which in this
case, is just an SMB share.

## Set up a Pull Client to download Resources

If you specify only the **ConfigurationRepositoryWeb** or **ConfigurationRepositoryShare** block in
your LCM configuration (as in the previous examples), the pull client will pull resources from the
same location it retrieves its configurations. You can also specify separate locations for
resources. To specify a resource location as a separate server, use the **ResourceRepositoryWeb**
block. To specify a resource location as an SMB share, use the **ResourceRepositoryShare** block.

> [!NOTE]
> You can combine **ConfigurationRepositoryWeb** with **ResourceRepositoryShare** or
> **ConfigurationRepositoryShare** with **ResourceRepositoryWeb**. Examples of this are not shown
> below.

### HTTP DSC Pull Server

The following metaconfiguration configures a pull client to get its configurations from
**CONTOSO-PullSrv** and its resources from **CONTOSO-ResourceSrv**.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'

        }

        ResourceRepositoryWeb CONTOSO-ResourceSrv
        {
            ServerURL = 'https://CONTOSO-REsourceSrv:8080/PSDSCPullServer.svc'
        }
    }
}
PullClientConfigID
```

### SMB Share

The following example shows a metaconfiguration that sets up a client to pull configurations from
the SMB share `\\SMBPullServer\Configurations`, and resources from the SMB share
`\\SMBPullServer\Resources`.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryShare SMBPullServer
        {
            SourcePath = '\\SMBPullServer\Configurations'
        }

        ResourceRepositoryShare SMBResourceServer
        {
            SourcePath = '\\SMBPullServer\Resources'
        }
    }
}
PullClientConfigID
```

#### Automatically download Resources in Push Mode

Beginning in PowerShell 5.0, your pull clients can download modules from an SMB share, even when
they are configured for **Push** mode. This is especially useful in scenarios where you do not want
to set up a Pull Server. The **ResourceRepositoryShare** block can be used without specifying a
**ConfigurationRepositoryShare**. The following example shows a metaconfiguration that sets up a
client to pull resources from an SMB Share `\\SMBPullServer\Resources`. When the Node is **PUSHED**
a configuration, it will automatically download any required resources, from the share specified.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
        }

        ResourceRepositoryShare SMBResourceServer
        {
            SourcePath = '\\SMBPullServer\Resources'
        }
    }
}
PullClientConfigID
```

## Set up a Pull Client to report status

By default, Nodes will not send reports to a configured Pull Server. You can use a single pull
server for configurations, resources, and reporting, but you have to create a
**ReportRepositoryWeb** block to set up reporting.

### HTTP DSC Pull Server

The following example shows a metaconfiguration that sets up a client to pull configurations and
resources, and send reporting data, to a single pull server.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
        }

        ReportServerWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
        }
    }
}
PullClientConfigID
```

To specify a report server, you use a **ReportRepositoryWeb** block. A report server cannot be an
SMB server. The following metaconfiguration configures a pull client to get its configurations from
**CONTOSO-PullSrv** and its resources from **CONTOSO-ResourceSrv**, and to send status reports to
**CONTOSO-ReportSrv**:

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'

        }

        ResourceRepositoryWeb CONTOSO-ResourceSrv
        {
            ServerURL = 'https://CONTOSO-REsourceSrv:8080/PSDSCPullServer.svc'
        }

        ReportServerWeb CONTOSO-ReportSrv
        {
            ServerURL = 'https://CONTOSO-REsourceSrv:8080/PSDSCPullServer.svc'
        }
    }
}
PullClientConfigID
```

### SMB Share

A report server cannot be an SMB share.

## Next Steps

Once the pull client has been configured, you can use the following guides to perform the next
steps:

- [Publish Configurations to a Pull Server (v4/v5)](publishConfigs.md)
- [Package and Upload Resources to a Pull Server (v4)](package-upload-resources.md)

## See Also

- [Setting up a pull client with configuration names](pullClientConfigNames.md)
