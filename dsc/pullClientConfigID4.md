---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Setup a Pull Client using Configuration IDs in PowerShell 4.0
---

# Setup a Pull Client using Configuration IDs in PowerShell 4.0

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server
> however there are no plans to offer new features or capabilities. It is recommended to
> begin transitioning managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions
> listed [here](pullserver.md#community-solutions-for-pull-service).

Each target node has to be told to use pull mode and given the URL where it can contact the pull server to get configurations. To do this, you have to configure the Local Configuration Manager (LCM) with the necessary information. To configure the LCM, you create a special type of configuration known as a "metaconfiguration". For more information about configuring the LCM, see [Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager](metaConfig4.md)

## Configuration ID

The examlpes below set the **ConfigurationID** property of the LCM to a **Guid** that had been previously created for this purpose. The **ConfigurationID** is what the LCM uses to find the appropriate configuration on the pull server. The configuration MOF file on the pull server must be named `ConfigurationID.mof`, where *ConfigurationID* is the value of the **ConfigurationID** property of the target node's LCM. For more information see [Publish to a Pull Server using Configuration IDs (v4/v5)](publishConfigId.md).

You can create a random **Guid** using the example below.

```powershell
[System.Guid]::NewGuid()
```

## Setup a Pull Client with a HTTP DSC Pull Server

The following script configures the LCM to pull configurations from a server named "PullServer":

```powershell
Configuration SimpleMetaConfigurationForPull
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
        DownloadManagerCustomData = @{ServerUrl = "http://PullServer:8080/PSDSCPullServer/PSDSCPullServer.svc"; AllowUnsecureConnection = “TRUE”}
    }
}
SimpleMetaConfigurationForPull -Output "."
```

In the script, **DownloadManagerCustomData** passes the URL of the pull server and (for this example) allows an unsecured connection.

After this script runs, it creates a new output folder called **SimpleMetaConfigurationForPull** and puts a metaconfiguration MOF file there.

To apply the configuration, use **Set-DscLocalConfigurationManager** with parameters for **ComputerName** (use “localhost”) and **Path** (the path to the location of the target node’s localhost.meta.mof file). For example:

```powershell
Set-DSCLocalConfigurationManager –ComputerName localhost –Path . –Verbose.
```

For more information about using **Guids** in your environment, see [Plan for GUIDs](secureServer.mof#GUIDs).

## Setup a Pull Client with a SMB DSC Pull Server

If the pull server is set up as an SMB file share, rather than a web service, you specify the **DscFileDownloadManager** rather than the **WebDownLoadManager**.
The **DscFileDownloadManager** takes a **SourcePath** property instead of **ServerUrl**. The following script configures the LCM to pull configurations from an SMB share named
"SmbDscShare" on a server named "CONTOSO-SERVER":

```powershell
Configuration SimpleMetaConfigurationForPull
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
SimpleMetaConfigurationForPull -Output "."
```

## See Also

- [Setting up a DSC web pull server](pullServer.md)
- [Setting up a DSC SMB pull server](pullServerSMB.md)
