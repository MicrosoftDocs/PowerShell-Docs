---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Set up a Pull Client using Configuration IDs in PowerShell 4.0
description:  This article explains how to set up a Pull Client using Configuration IDs in PowerShell 4.0
---

# Set up a Pull Client using Configuration IDs in PowerShell 4.0

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

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

The examples below set the **ConfigurationID** property of the LCM to a **Guid** that had been
previously created for this purpose. The **ConfigurationID** is what the LCM uses to find the
appropriate configuration on the pull server. The configuration MOF file on the pull server must be
named `ConfigurationID.mof`, where *ConfigurationID* is the value of the **ConfigurationID**
property of the target node's LCM. For more information, see
[Publish Configurations to a Pull Server (v4/v5)](publishConfigs.md).

You can create a random **Guid** using the example below.

```powershell
[System.Guid]::NewGuid()
```

## Set up a Pull Client to download Configurations

Each client must be configured in **Pull** mode and given the pull server url where its
configuration is stored. To do this, you have to configure the Local Configuration Manager (LCM)
with the necessary information. To configure the LCM, you create a special type of configuration,
with a **LocalConfigurationManager** block. For more information about configuring the LCM, see
[Configuring the Local Configuration Manager](../managing-nodes/metaConfig4.md).

## HTTP DSC Pull Server

If the pull server is set up as a web service, you set the **DownloadManagerName** to
**WebDownloadManager**. The **WebDownloadManager** requires that you specify a **ServerUrl** to the
**DownloadManagerCustomData** key. You can also specify a value for **AllowUnsecureConnection**, as
in the example below. The following script configures the LCM to pull configurations from a server
named "PullServer".

```powershell
Configuration PullClientConfigId
{
    LocalConfigurationManager
    {
        ConfigurationID = "1C707B86-EF8E-4C29-B7C1-34DA2190AE24";
        RefreshMode = "PULL";
        DownloadManagerName = "WebDownloadManager";
        RebootNodeIfNeeded = $true;
        RefreshFrequencyMins = 30;
        ConfigurationModeFrequencyMins = 30;
        ConfigurationMode = "ApplyAndAutoCorrect";
        DownloadManagerCustomData = @{ServerUrl = "http://PullServer:8080/PSDSCPullServer/PSDSCPullServer.svc"; AllowUnsecureConnection = "TRUE"}
    }
}
PullClientConfigId -Output "."
```

## SMB Share

If the pull server is set up as an SMB file share, rather than a web service, you set the
**DownloadManagerName** to **DscFileDownloadManager** rather than the **WebDownLoadManager**. The
**DscFileDownloadManager** requires that you specify a **SourcePath** property in the
**DownloadManagerCustomData**. The following script configures the LCM to pull configurations from
an SMB share named "SmbDscShare" on a server named "CONTOSO-SERVER".

```powershell
Configuration PullClientConfigId
{
    LocalConfigurationManager
    {
        ConfigurationID = "1C707B86-EF8E-4C29-B7C1-34DA2190AE24";
        RefreshMode = "PULL";
        DownloadManagerName = "DscFileDownloadManager";
        RebootNodeIfNeeded = $true;
        RefreshFrequencyMins = 30;
        ConfigurationModeFrequencyMins = 30;
        ConfigurationMode = "ApplyAndAutoCorrect";
        DownloadManagerCustomData = @{ServerUrl = "\\CONTOSO-SERVER\SmbDscShare"}
    }
}
PullClientConfigId -Output "."
```

## Next Steps

Once the pull client has been configured, you can use the following guides to perform the next
steps:

- [Publish Configurations to a Pull Server (v4/v5)](publishConfigs.md)
- [Package and Upload Resources to a Pull Server (v4)](package-upload-resources.md)

## See Also

- [Set up a DSC web pull server](pullServer.md)
- [Set up a DSC SMB pull server](pullServerSMB.md)
