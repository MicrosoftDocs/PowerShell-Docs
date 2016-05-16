---
title:   Setting up a pull client using configuration ID in PowerShell 4.0
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Setting up a pull client using configuration ID in PowerShell 4.0

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

Each target node has to be told to use pull mode and given the URL where it can contact the pull server to get configurations. To do this, you have to configure the Local Configuration Manager (LCM) with the necessary information. To configure the LCM, you create a special type of configuration known as a "metaconfiguration". For more information about configuring the LCM, see [Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager](metaConfig4.md)

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

## Configuration ID
The script sets the **ConfigurationID** property of the LCM to a GUID that had been previously created for this purpose (you can create a GUID by using the **New-Guid** cmdlet). The **ConfigurationID** is what the LCM uses to find the appropriate configuration on the pull server. The configuration MOF file on the pull server must be named `ConfigurationID.mof`, where *ConfigurationID* is the value of the **ConfigurationID** property of the target node's LCM.

## Pulling from an SMB server

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

