---
title:   Setting up a pull client using configuration names
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Setting up a pull client using configuration names

> Applies To: Windows PowerShell 5.0

Each target node has to be told to use pull mode and given the URL where it can contact the pull server to get configurations. To do this, you have to configure the Local Configuration Manager (LCM) with the necessary information.To configure the LCM, you create a special type of configuration, decorated with the **DSCLocalConfigurationManager** attribute. For more information about configuring the LCM, see [Configuring the Local Configuration Manager](metaConfig.md).

> **Note**: This topic applies to PowerShell 5.0. For information on setting up a pull client in PowerShell 4.0, see [Setting up a pull client using configuration ID in PowerShell 4.0](pullClientConfigID4.md)

The following script configures the LCM to pull configurations from a server named "CONTOSO-PullSrv":

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
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
PullClientConfigID
```

In the script, the **ConfigurationRepositoryWeb** block defines the pull server. The **ServerURL** property specifies the endpoint for the pull server.

The **RegistrationKey** property is a shared key between all client nodes for a pull server and that pull server. The same value is stored in a file on the pull server. The **ConfigurationNames** property specifies the name of the configuration intended for the client node. On the pull server, the configuration MOF file for this client node must be named *ConfigurationNames*.mof, where *ConfigurationNames* matches the value of the **ConfigurationNames** property you set in this metaconfiguration.

After this script runs, it creates a new output folder named **PullClientConfigID** and puts a metaconfiguration MOF file there. In this case, the metaconfiguration MOF file will be named `localhost.meta.mof`.

To apply the configuration, call the **Set-DscLocalConfigurationManager** cmdlet, with the **Path** set to the location of the metaconfiguration MOF file. For example: `Set-DSCLocalConfigurationManager localhost –Path .\PullClientConfigID –Verbose.`

> **Note**: Registration keys work only with web pull servers. You must still use **ConfigurationID** with an SMB pull server. For information about configuring a pull server by using **ConfigurationID**, see [Setting up a pull client using configuration ID](pullClientConfigID.md)

## Resource and report servers

If you specify only a **ConfigurationRepositoryWeb** or **ConfigurationRepositoryShare** block in your LCM configuration (as in the previous example), the pull client will pull 
resources from the specified server, but it will not send reports to it. You can use a single pull server for configurations, resources, and reporting, but you have to create a 
**ReportRepositoryWeb** block to set up reporting. The following example shows a metaconfiguration that sets up a client to pull configurations and resources, and send reporting data, to a single
pull server.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
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
        }
    }
}
PullClientConfigID
```


You can also specify different pull servers for resources and reporting. To specify a resource server, you use either a **ResourceRepositoryWeb** (for a web pull server) or a 
**ResourceRepositoryShare** block (for an SMB pull server).
To specify a report server, you use a **ReportRepositoryWeb** block. A report server cannot be an SMB server.
The following metaconfiguration configures a pull client to get its configurations from **CONTOSO-PullSrv** and its resources from **CONTOSO-ResourceSrv**, and to send status reports to **CONTOSO-ReportSrv**:

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
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
        
        ResourceRepositoryWeb CONTOSO-ResourceSrv
        {
            ServerURL = 'https://CONTOSO-ResourceSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = '30ef9bd8-9acf-4e01-8374-4dc35710fc90'
        }

        ReportServerWeb CONTOSO-ReportSrv
        {
            ServerURL = 'https://CONTOSO-ReportSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = '6b392c6a-818c-4b24-bf38-47124f1e2f14'
        }
    }
}
PullClientConfigID
```

## See Also

* [Setting up a pull client with configuration ID](pullClientConfigID.md)
* [Setting up a DSC web pull server](pullServer.md)

