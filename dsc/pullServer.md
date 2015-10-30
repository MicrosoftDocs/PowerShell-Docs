
# Setting up a DSC web pull server

A DSC web pull server is a web service in IIS that uses an OData interface to make DSC configuration files available to target nodes when those nodes ask for them.

Requirements for using a pull server:

- Any server with at least WMF 4.0
- Server needs the IIS server role
- Server needs the DSC Service
- Ideally, some means of generating a certificate, to secure credentials passed to the Local Configuration Manager (LCM) on target nodes

You can add the IIS server role and DSC Service with the Add Roles and Features wizard in Server Manager, or by using PowerShell. The sample scripts included in this topic will handle both of these steps for you as well.

## Using the xWebService resource
The easiest way to set up a web pull server is to use the xWebService resource, included in the xPSDesiredStateConfiguration module. The following steps explain how to use the resource in a configuration that sets up the web service.

1. If you are using PowerShell 5.0, use the [Install-Module](https://technet.microsoft.com/en-us/library/dn807162.aspx) cmdlet to install the xPSDesiredStateConfiguration module. You can skip to step 4.
1. Download the [xPSDesiredStateConfiguration module from the PowerShell Gallery](https://powershellgallery.com/packages/xPSDesiredStateConfiguration), and then unzip DSCPullServerConfiguration.zip to `$env:systemdrive` on the future pull server (in PowerShell 5.0, you can simply use the command `Install-Module xPSDesiredStateConfiguration`.
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
1. Run the configuration, passing the thumbprint of the self-signed certificate you created as the certificateThumbPrint parameter:

```powershell
PS:\>$myCert = Get-ChildItem CERT: | Where {$_.Subject -eq 'CN=PSDSCPullServerCert'}
PS:\>Sample_xDSCService -certificateThumbprint $myCert.Thumbprint 
```
## Placing configurations and resources
After the pull server setup completes, there is a new folder under $env:PROGRAMFILES\WindowsPowerShell named "DscService". In that folder, there are two folders named "Modules" and "Configuration". In the "Modules" folder, place any resources that are needed for configurations that nodes will pull from this server. In the "Configuration" folder, place the configuration MOF files for any configurations that are to be pulled by nodes. The names of the MOF files depend on the type of pull client. The following topics describe setting up pull clients in detail:
- [Setting up a DSC pull client using a configuration ID](pullClientConfigID.md)
- [Setting up a DSC pull client using configuration names](pullClientConfigNames.md)
- [Partial configurations](partialConfigs.md)

## See also
* [Windows PowerShell Desired State Configuration Overview](dsc/overview.md)
* [Enacting configurations](enactingConfigurations.md)
* [How to retrieve node information from DSC pull server](retrieveNodeInfo.md)