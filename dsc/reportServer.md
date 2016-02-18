# Using a DSC report server

> Applies To: Windows PowerShell 5.0

> **Note:** The report server described in this topic is not availalbe in PowerShell 4.0. For reporting in PowerShell 4.0, see Using a DSC compliance server.

The Local Configuration Manager (LCM) of a node can be configured to send reports about its configuration status to a pull server, which can then be queried to retrieve that data. Each time the node checks and applies
a configuration, it sends a report to the report server. These reports are stored in a database on the server, and can be retrieved by calling the reporting web service. Each report contains
information such as what configurations were applied and whether they succeeded, the resources used, any errors that were thrown, and start and finish times.

## Configuring a node to send reports

You tell a node to send reports to a server by using a **ReportServerWeb** block in the node's LCM configuration (for information about configuring the LCM,
 see [Configuring the Local Configuration Manager](metaConfig.md)). The server to which the node sends reports must be set up as a web pull server (you cannot send reports
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
            RefreshMode          = 'Pull'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded   = $true
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL          = 'https://CONTOSO-PULL:8080/PSDSCPullServer.svc'
            RegistrationKey    = 'bbb9778f-43f2-47de-b61e-a0daff474c6d'
            ConfigurationNames = @('ClientConfig')
        }

        ReportServerWeb CONTOSO-ReportSrv
        {
            ServerURL               = 'http://CONTOSO-REPORT:8080/PSDSCReportServer.svc'
            RegistrationKey         = 'ba39daaa-96c5-4f2f-9149-f95c46460faa'
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
where `MyNodeAgentId` is the AgentId of the node for which you want to get reports. You can get the AgentID for a node by calling [Get-DscLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn407378.aspx)
on that node.

The reports are returned as an array of JSON objects.

The following script returns the reports for the node on which it is run:

```powershell
function GetReport
{
    param($AgentId = "$((glcm).AgentId)", $serviceURL = "http://CONTOSO-REPORT:8080/PSDSCReportServer.svc")
    $requestUri = "$serviceURL/Nodes(AgentId= '$AgentId')/Reports"
    $request = Invoke-WebRequest -Uri $requestUri  -ContentType "application/json;odata=minimalmetadata;streaming=true;charset=utf-8" `
               -UseBasicParsing -Headers @{Accept = "application/json";ProtocolVersion = "2.0"} `
               -ErrorAction SilentlyContinue -ErrorVariable ev
    $object = ConvertFrom-Json $request.content
    return $object.value
}
```
    
## Viewing report data

If you set a variable to the result of the **GetReport** function, you can view the individual fields in an element of the array that is returned:

```powershell
$reports = GetReport
$reports[1]

JobId                : 71515ae8-7294-40a3-8137-fc85bf4b678f
OperationType        : Consistency
RefreshMode          : 
Status               : 
ReportFormatVersion  : 1.0
ConfigurationVersion : 2.0.0
StartTime            : 02/08/2016 01:28:54
EndTime              : 02/08/2016 01:28:57
RebootRequested      : False
Errors               : {}
StatusData           : {{"NumberOfResources":"2","Locale":"en-US","ResourcesInDesiredState":[{"ResourceId":"[WindowsFeature]MyFeatureInstance","SourceI
                       nfo":"C:\\ReportTest\\ClientConfig.ps1::4::9::WindowsFeature","ModuleName":"PsDesiredStateConfiguration","ModuleVersion":"1.0","
                       ConfigurationName":"ClientConfig","ResourceName":"WindowsFeature"},{"ResourceId":"[WindowsFeature]My2ndFeatureInstance","SourceI
                       nfo":"C:\\ReportTest\\ClientConfig.ps1::8::9::WindowsFeature","ModuleName":"PsDesiredStateConfiguration","ModuleVersion":"1.0","
                       ConfigurationName":"ClientConfig","ResourceName":"WindowsFeature"}]}}
```

Notice that the **StatusData** field is an object with three properties: **NumberOfResources**, **Locale**, and **ResourcesInDesiredState**. The **ResourcesInDesiredState**
property is an array of objects that each have a number of properties. The following script takes a single report as a parameter, iterates through its **ResourcesInDesiredState**
array, and writes them to the console:
 
```powershell
function GetStatusData
{
    param ($Report)
    $statusData = $Report.StatusData | ConvertFrom-Json

    $Resources = $statusData.ResourcesInDesiredState

    Foreach ($Resource in $Resources)
    {
        Write-Host 'ResourceId: ' $Resource.ResourceId
        Write-Host 'SourceInfo: ' $Resource.SourceInfo
        Write-Host 'ModuleName: ' $Resource.ModuleName
        Write-Host 'ModuleVersion: ' $Resource.ModuleVersion
        Write-Host 'ConfigurationName: ' $Resource.ConfigurationName
        Write-Host 'ResourceName: ' $Resource.ResourceName
        Write-Host
    }
}
```

Here is a sample output after calling the **GetStatusData** function:

```powershell
GetStatusData -Report $report[1]

ResourceId:  [WindowsFeature]MyFeatureInstance
SourceInfo:  C:\ReportTest\ClientConfig.ps1::4::9::WindowsFeature
ModuleName:  PsDesiredStateConfiguration
ModuleVersion:  1.0
ConfigurationName:  ClientConfig
ResourceName:  WindowsFeature

ResourceId:  [WindowsFeature]My2ndFeatureInstance
SourceInfo:  C:\ReportTest\ClientConfig.ps1::8::9::WindowsFeature
ModuleName:  PsDesiredStateConfiguration
ModuleVersion:  1.0
ConfigurationName:  ClientConfig
ResourceName:  WindowsFeature
```

Note that these examples are meant to give you an idea of what you can do with report data. For an introduction on working with JSON in PowerShell, see
[Playing with JSON and PowerShell](https://blogs.technet.microsoft.com/heyscriptingguy/2015/10/08/playing-with-json-and-powershell/).

## See Also
>[Configuring the Local Configuration Manager](metaConfig.md)
>[Setting up a DSC web pull server](pullServer.md)
>[Setting up a pull client using configuration names](pullClientConfigNames.md)
