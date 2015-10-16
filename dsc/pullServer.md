Outline:

* What is it?       
    - Service for central management of DSC configurations, resources, and reports
    - Implemented on REST (OData), PSWS
    - Windows Feature that can turn it on 
* Setting it up
    - xDscWebService
* Reporting server [v2]

# Windows PowerShell Desired State Configuration Pull Servers

Windows PowerShell Desired State Configuration (DSC) offers two ways to let target nodes know what configuration they should have. In “push” mode (the default), you have to transmit configuration files to each target node yourself, keeping track of which configurations go with which nodes. In “pull” mode, the Local Configuration Manager (LCM) target node (a pull client, if so configured) performs a compliance check on the configuration of the node. If the client is configured as desired, nothing happens. If not, the LCM requests the pull server for the current configuration. If it finds a configuration marked for itself (and the configuration passes validation checks) the configuration is transmitted to the pull client, where the LCM executes it. If the configuration requires resources that the pull client is missing, they get downloaded as well.

## Setting up and using a pull server
Basically, a pull server is a website in IIS that uses an OData interface to make DSC configuration files available to target nodes when those nodes ask for them. You can also set up a pull server that uses SMB, but this example uses HTTP.

Requirements for using a pull server:

* Any server with at least WMF 4.0
* Server needs the IIS server role
* Server needs the DSC Service
* Ideally, some means of generating a certificate, to secure credentials passed to the Local Configuration Manager on target nodes

You can add the IIS server role and DSC Service with the Add Roles and Features wizard in Server Manager, or by using Windows PowerShell. The sample scripts included in this topic will handle both of these steps for you as well.

In overview, setting up and using a pull server involves these steps:

1. Write a configuration to be applied to a target node
1. Use the configuration to generate a MOF file
1. Generate a checksum file to accompany the MOF
1. Create the pull server itself
1. Deploy the MOF and checksum files to the pull server
1. Configure the target node to use the pull server

## TODO
1. **Write a configuration to be applied to a target node**
You can write a new configuration or use an existing one that you already created for use in push mode. Basic information about writing a configuration is in Get Started with Windows PowerShell Desired State Configuration, but here’s an example as well:
  ```
  Configuration SimpleConfigurationForPullSample
   { 
      Node 1C707B86-EF8E-4C29-B7C1-34DA2190AE24 
      {      
         Computer ManagedNode
         {
            Ensure   = "Present"
            Name     = “DomainClient1”
            DomainName = “TestDomain”
         }
      }
   }
  SimpleConfigurationForPullSample-output "."
  ```
  **Important**: An important difference in configuration for pull mode is that you identify the target node not by name, but with a GUID. This ensures that each target node gets the proper configuration file. To generate a GUID, you can use [Create GUID (guidgen.exe)](https://msdn.microsoft.com/library/ms241442.aspx) or [Guid.NewGuid Method](https://msdn.microsoft.com/library/system.guid.newguid.aspx).
1. **Generate a MOF file from the configuration**
As shown in [Get Started with Windows PowerShell Desired State Configuration](dsc/getStarted.md), create the MOF file by invoking the configuration script, in this case: `PS C:\Scripts> SimpleConfigurationForPullSample`. The MOF file, called <yournewGUID>.mof, appears in a new directory with the same name as the configuration script. It’s a good idea to check the MOF file to make sure it matches the contents of the configuration.
1. **Generate a checksum file**
The GUID ensures that the target node’s Local Configuration Manager picks up the right configuration from the pull server; the checksum file allows the LCM to confirm that the MOF file didn’t get garbled. Generate the checksum with New-DSCChecksum, making sure to specify the path where the configuration MOF file was generated:
  ```
  PS D:\Samples> New-DSCCheckSum –ConfigurationPath .\SimpleConfigurationForPullSample -OutPath .\SimpleConfigurationForPullSample -Verbose -Force
  VERBOSE: Create checksum file 'D:\Samples\SimpleConfigurationForPullSample\1C707B86-EF8E-4C29-B7C1-34DA2190AE24.mof.checksum'
  ```
1. **Create the pull server**

#### To set up the pull server

1. Any server with WMF 4.0 installed can be used as a pull server. On the computer you want to be the pull server, if you haven’t already, add the DSC Service, which is a Windows Server feature, either with the Add Roles and Features wizard in Server Manager, or with WindowsFeature. See [Install or Uninstall Roles, Role Services, or Features](https://technet.microsoft.com/library/hh831809.aspx) for the different ways you can add a server feature. If you add the feature using the Add Roles and Features wizard of Server Manager, you will find the DSC Service listed under the Windows PowerShell feature in the menu.
1. Obtain the [xPSDesiredStateConfiguration module from the PowerShell Gallery](https://powershellgallery.com/packages/xPSDesiredStateConfiguration), and then unzip DSCPullServerConfiguration.zip to $env:systemdrive on the future pull server.
1. Deploy the DSC Resources module to the Program Files directory.
1. Run this configuration script (included in the unzipped files as Sample_xDscWebService.ps1). This script sets up the pull server and a compliance server.
  **Note**: This sample script configures the pull server to use HTTPS, and so requires that you have created a certificate called “CN=PSDSCPullServerCert” stored in the "CERT:\LocalMachine\MY\" store. You can generate a self-signed certificate with MakeCert.exe. There is additional information about securing credentials to MOF files in Securing the MOF file.

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

        DSCService PSDSCComplianceServer
        {
              Ensure   = "Present"
              Name     = “PSDSCComplianceServer”
              Port     = 9080
              PhysicalPath = "$env:SystemDrive\inetpub\wwwroot\PSDSCComplianceServer"
              EnableFirewallException = $true
              CertificateThumbprint = “AllowUnencryptedTraffic”
              State = “Started”
                                         IsComplianceServer = $true
              DependsOn = “[WindowsFeature]DSCServiceFeature”

      }
  }
  ```

  When you run this script, a new subfolder named **Sample_xDSCService** is created on the pull server and in that subfolder is a MOF file called [TODO].

  **Note**: This script actually creates two IIS web servers, the pull server itself (PSDSCPullServer) and a compliance server (PSDSCComplianceServer). The target nodes report to the compliance server whether or not they are compliant with the specified configuration. You can query the compliance status yourself from the compliance server at any time. See the **Query the compliance status** section later in this topic for instructions.
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

Note how DownloadManagerCustomData passes the URL of the pull server and (for this example) allows an unsecured connection. The script also sets the ConfigurationID property of LCM to match the value of the configuration MOF file created in overview Step 1.

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