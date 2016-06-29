# Report Configuration Status to Central Location

Detailed information about DSC configuration status can be sent to a server running the DSC service. The same information that is returned by the Get-DscConfigurationStatus cmdlet is sent to the DSC Service. By defining the report server in a meta-configuration, this status is sent to the server when an error occurs or the configuration completes successfully. This information is sent when a node is configured in either pull or push mode. Status information is stored in the DSC service database.

## Sample meta-configuration for reporting status
```PowerShell
[DscLocalConfigurationManager()]
Configuration ReportingClientMetaConfig
{
    Settings
        {
            RefreshFrequencyMins = 30
            RefreshMode = "PUSH"
            ConfigurationModeFrequencyMins = 15
            AllowModuleOverwrite = $true
        }

        ReportServerWeb ReportManager
        {
            ServerUrL = "http://localhost:8080/PSDSCPullServer/PSDSCPullserver.svc"
            AllowUnsecureConnection  = $true
        }           
}
```
A new OData endpoint is created with the DSC service which exposes this status information. By passing a configuration ID or agent ID {$guid} to the endpoint, all of the status for a node can be collected and parsed.

## Sample web request to gather configuration status 
```PowerShell
$statusReports = Invoke-WebRequest -Uri "[http://localhost:8080/PSDSCPullserver/PSDSCPullserver.svc/Node(ConfigurationId='$guid')/StatusReport](http://localhost:8080/PSDSCPullserver/psdscpullserver.svc/Node(ConfigurationId='$guid')/StatusReport)s" -UseBasicParsing -UseDefaultCredentials -ContentType "application/json;odata=minimalmetadata;streaming=true;charset=utf-8" -Headers @{Accept = "application/json"; ProtocolVersion = “1.1”}
```