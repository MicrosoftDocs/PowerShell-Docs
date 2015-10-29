
# Setting up a DSC web pull server

A DSC web pull server is a web service in IIS that uses an OData interface to make DSC configuration files available to target nodes when those nodes ask for them.

Requirements for using a pull server:

- Any server with at least WMF 4.0
- Server needs the IIS server role
- Server needs the DSC Service
- Ideally, some means of generating a certificate, to secure credentials passed to the Local Configuration Manager (LCM) on target nodes

You can add the IIS server role and DSC Service with the Add Roles and Features wizard in Server Manager, or by using PowerShell. The sample scripts included in this topic will handle both of these steps for you as well.
1. If you are using PowerShell 5.0, 
1. Download the [xPSDesiredStateConfiguration module from the PowerShell Gallery](https://powershellgallery.com/packages/xPSDesiredStateConfiguration), and then unzip DSCPullServerConfiguration.zip to `$env:systemdrive` on the future pull server (in PowerShell 5.0, you can simply use the command `Install-Module xPSDesiredStateConfiguration` .
1. Deploy the DSC Resources module to the Program Files directory.
2. Create a self-signed certificate with the subject `"CN=PSDSCPullServerCert"` in the `CERT:\LocalMachine\MY\` store. You can do this with the command `New-SelfSignedCertificate  -CertStoreLocation 'CERT:\LocalMachine\MY' -Subject 'CN=PSDSCPullServerCert'`.
1. In the PowerShell ISE, start (F5) the following configuration script (included in the unzipped files as Sample_xDscWebService.ps1). This script sets up the pull server and a compliance server.
  
  ```powershell
  Configuration Sample_xDSCService
  {
      param (
        [ValidateNotNullOrEmpty()]
        [String] $certificateThumbPrint
                                   )
     Import-DSCResource –ModuleName DSCService

     Node localhost
     {
        WindowsFeature DSCServiceFeature
        {
           Ensure = “Present”
           Name = “DSC-Service”
        }
        DSCService PSDSCPullServer
              {
              Ensure   = "Present"
              Name     = “PSDSCPullServer”
              Port     = 8080
              PhysicalPath = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer"
              EnableFirewallException = $true
              CertificateThumbprint = $certificateThumbPrint
              ModulePath = “$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules”
              ConfigurationPath = “$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration”
              State = “Started”
              DependsOn = “[WindowsFeature]DSCServiceFeature”
             
          }

      }
  }
  ```
1. Run the configuration, passing the thumbprint of the self-signed certificate you created as the certificateThumbPrint parameter.
  
1. **Deploy the MOF and checksum files to the pull server**
  Now that the pull server exists, copy the MOF and checksum files you created in overview Steps 2 and 3 to **$env:SystemDrive\Program Files\WindowsPowershell\DscService\Configuration** on the pull server.
1. **Configure the target node to use the new pull server**
  Each target node has to be told to use pull mode and given the URL where it can contact the pull server to get configurations. To do this, create a configuration script that includes the DownloadManagerCustomData key/value pair. For example:
  ```powershell
  Configuration SimpleMetaConfigurationForPull 
        { 
                 LocalConfigurationManager 
                 { 
                    ConfigurationID = "1C707B86-EF8E-4C29-B7C1-34DA2190AE24";
                    RefreshMode = "PULL";
                    DownloadManagerName = "WebDownloadManager";
                    RebootNodeIfNeeded = $true;
                    RefreshFrequencyMins = 15;
                    ConfigurationModeFrequencyMins = 30; 
                    ConfigurationMode = "ApplyAndAutoCorrect";
                    DownloadManagerCustomData = @{ServerUrl =                      "http://PullServer:8080/PSDSCPullServer/PSDSCPullServer.svc"; AllowUnsecureConnection = “TRUE”}
                 } 
              } 
     SimpleMetaConfigurationForPull -Output "."
  ```

Note how DownloadManagerCustomData passes the URL of the pull server and (for this example) allows an unsecured connection. The script also sets the __ConfigurationID__ property of LCM to match the value of the configuration MOF file created in overview Step 1.

When this script runs, it creates a new output folder called **SimpleMetaConfigurationForPull** and puts a metaconfiguration MOF file there.

Finally, on each target node that will use the pull server, use **Set-DscLocalConfigurationManager** with parameters for ComputerName (use “localhost”) and Path (the path to the location of the target node’s localhost.meta.mof file). For example: ```Set-DSCLocalConfigurationManager –ComputerName localhost –Path . –Verbose.```

## Query the compliance status

The compliance server set up by the previous steps stores the following information about each node:

**TargetName**: the name of the node
**ConfigurationID**: the node’s configuration ID
**NodeCompliant**: whether or not the last configuration attempt succeeded (that is, whether or not the target node is compliant with the latest configuration)
**ServerCheckSum**: the checksum of the configuration MOF that is stored on the pull server
**TargetCheckSum**: the checksum of the configuration MOF that was applied to the target node
**LastComplianceTime**: the last time that the configuration was successfully applied to the target node
**LastHeartbeatTime**: the last time the node connected to the pull server
**Dirty**: “true” if the node status was successfully recorded in the compliance database; “false” if it was not
**StatusCode**: 
* 
* **0**: Configuration was applied successfully
* **1**: Failure to initialize Download Manager
* **2**: Failure of Get-Configuration command
* **3**: Unexpected response to Get-Configuration from pull server
* **4**: Failure to read the configuration checksum file
* **5**: Failure to validate the configuration checksum file
* **6**: Configuration file is not valid
* **7**: Check of available modules failed
* **8**: Configuration ID in MOF file is not valid
* **9**: Download Manager CustomData in MOF file is not valid
* **10**: Failure of Get-Module command
* **11**: Output of Get-Module is not valid
* **12**: Checksum file for module was not found
* **13**: Module file is not valid
* **14**: Checksum validation of module failed
* **15**: Extraction of module failed
* **16**: Validation of module failed
* **17**: The module that was downloaded is not valid
* **18**: Configuration file not found
* **19**: Multiple configuration files were found
* **20**: Checksum file for configuration was not found
* **21**: Module not found
* **22**: Format of module version is not valid
* **23**: Format of configuration ID is not valid
* **24**: Get-Action command failed
* **25**: Checksum algorithm is not valid
* **26**: Get-LcmUpdate command failed
* **27**: Unexpected response to Get-LcmUpdate from pull server
* **28**: MOF includes Refresh Mode value that is not valid
* **29**: MOF includes Debug Mode value that is not valid

If you haven’t already defined connection endpoints for the compliance server, you can do so with these commands:

```powershell
Set-Webconfig-AppSettings `
          -path $env:HOMEDRIVE\inetpub\wwwroot\$complianceSiteName `
          -key "dbprovider" `
          -value "ESENT"
 
Set-Webconfig-AppSettings `
                -path $env:HOMEDRIVE\inetpub\wwwroot\$complianceSiteName `
          -key "dbconnectionstr" `
           -value
            "$env:PROGRAMFILES\WindowsPowerShell\DscService\Devices.edb"
```

To actually query the compliance server for compliance status, use this function:

```powershell
<#
# DSC function to query node information from pull server.
#>
function QueryNodeInformation
{
  Param (      
       [string] $Uri =
"http://localhost:7070/PSDSCComplianceServer.svc/Status",                         
       [string] $ContentType = "application/json"           
     )

  Write-Host "Querying node information from pull server URI  = $Uri" -ForegroundColor Green

  Write-Host "Querying node status in content type  = $ContentType " -ForegroundColor Green

   $response = Invoke-WebRequest -Uri $Uri -Method Get -ContentType $ContentType -UseDefaultCredentials -Headers 
    @{Accept = $ContentType}

   if($response.StatusCode -ne 200)
 {
     Write-Host "node information was not retrieved." -ForegroundColor Red
 }

 $jsonResponse = ConvertFrom-Json $response.Content

  return $jsonResponse
}
```

Replace the Uri parameter with the URI for your pull server. If you want the node information in XML format, set ContentType to “application/xml”.

To retrieve the node information from the $json parameter, use the following:

```powershell
$json = QueryNodeInformation –Uri http://localhost:7070/PSDSCComplianceServer.svc/Status 

$json.value | Format-Table TargetName, ConfigurationId, ServerChecksum, NodeCompliant, LastComplianceTime, StatusCode 
```

## See also
* [Windows PowerShell Desired State Configuration Overview](dsc/getStarted.md)
* [Push and Pull Configuration Modes](TODO)
* [How to retrieve node information from DSC pull server](TODO)