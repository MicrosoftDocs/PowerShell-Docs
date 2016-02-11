# Using a DSC report server

> Applies To: Windows PowerShell 5.0

> **Note:** The report server described in this topic is not availalbe in PowerShell 4.0. For reporting in PowerShell 4.0, see [Using a DSC compliance server](complianceServer.md).

The Local Configuration Manager (LCM) of a node can be configured to send reports about its configuration status to a pull server, which can then be queried to retrieve that data. Each time the node checks and applies
a configuration, it sends a report to the report server. These reports are stored in a database on the server, and can be retrieved by calling the reporting web service. Each report contains
information such as what configurations were applied and whether they succeeded, the resources used, any errors that were thrown, and start and finish times.

## Configuring a node to send reports

You tell a node to send reports to a server by using a **ReportServerWeb** block in the node's LCM configuration (for information about configuring the LCM,
 see [Configuring the Local Configuration Manager](megaConfig.md)). The server to which the node sends reports must be set up as a web pull server (you cannot send reports
 to an SMB share). For information about setting up a pull server, see [Setting up a DSC web pull server](pullServer.md). The report server can be the same service from which
 the node pulls configurations and gets resources, or it can be a different service.
 
 In the **ReportServerWeb** block, you specify the URL of the pull service
 and a registration key that is known to the server.
 
  The following configuration configures a node to pull configurations from one service, and send reports
 to a service on a different server. 
 
 ```powershell
  [DSCLocalConfigurationManager()]
configuration ReportClientConfig
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
            ServerURL = 'https://CONTOSO-PULL:8080/PSDSCPullServer.svc'
            RegistrationKey = 'bbb9778f-43f2-47de-b61e-a0daff474c6d'
            ConfigurationNames = @('ClientConfig')
            
        }

        

        ReportServerWeb CONTOSO-ReportSrv
        {
            ServerURL = 'http://CONTOSO-REPORT:8080/PSDSCReportServer.svc'
            RegistrationKey = 'ba39daaa-96c5-4f2f-9149-f95c46460faa'
            AllowUnsecureConnection = $true
        }
    }
}
PullClientConfigID
```

## Getting report data

Reports sent to the pull server are entered into a database on the server. The reports are available through calls to the web service. To retrieve reports for a specific node, 
send an HTTP request to the report web service in the following form:
`http://CONTOSO-REPORT:8080/PSDSCReportServer.svc/Nodes(AgentID = MyNodeAgentId)/Reports` 
where `MyNodeAgentId` is the AgentId of the node for which you want to get reports.

Reports are returned in an array of JSON objects. Each object in the array has the following fields:




