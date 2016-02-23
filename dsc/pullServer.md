# Setting up a DSC web pull server

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

A DSC web pull server is a web service in IIS that uses an OData interface to make DSC configuration files available to target nodes when those nodes ask for them.

Requirements for using a pull server:

* A server running:
  - WMF/PowerShell 4.0 or greater
  - IIS server role
  - DSC Service
* Ideally, some means of generating a certificate, to secure credentials passed to the Local Configuration Manager (LCM) on target nodes

You can add the IIS server role and DSC Service with the Add Roles and Features wizard in Server Manager, or by using PowerShell. The sample scripts included in this topic will handle both of these steps for you as well.

## Using the xWebService resource
The easiest way to set up a web pull server is to use the xWebService resource, included in the xPSDesiredStateConfiguration module. The following steps explain how to use the resource in a configuration that sets up the web service.

1. Call the [Install-Module](https://technet.microsoft.com/en-us/library/dn807162.aspx) cmdlet to install the **xPSDesiredStateConfiguration** module. **Note**: **Install-Module** is included in the **PowerShellGet** module, which is included in PowerShell 5.0. You can download the **PowerShellGet** module for PowerShell 3.0 and 4.0 at [PackageManagement PowerShell Modules Preview](https://www.microsoft.com/en-us/download/details.aspx?id=49186). 
1. Create a self-signed certificate with the subject `"CN=PSDSCPullServerCert"` in the `CERT:\LocalMachine\MY\` store. You can do this with the command `New-SelfSignedCertificate  -CertStoreLocation 'CERT:\LocalMachine\MY' -DnsName "PSDSCPullServerCert"`.
1. In the PowerShell ISE, start (F5) the following configuration script (included in the Example folder of the  **xPSDesiredStateConfiguration** module as Sample_xDscWebService.ps1). This script sets up the pull server and a compliance server.
  
```powershell
configuration Sample_xDscWebService 
6 { 
7     param  
8     ( 
9         [string[]]$NodeName = 'localhost', 
10 
 
11         [ValidateNotNullOrEmpty()] 
12         [string] $certificateThumbPrint 
13     ) 
14 
 
15     Import-DSCResource -ModuleName xPSDesiredStateConfiguration 
16 
 
17     Node $NodeName 
18     { 
19         WindowsFeature DSCServiceFeature 
20         { 
21             Ensure = "Present" 
22             Name   = "DSC-Service"             
23         } 
24 
 
25         xDscWebService PSDSCPullServer 
26         { 
27             Ensure                  = "Present" 
28             EndpointName            = "PSDSCPullServer" 
29             Port                    = 8080 
30             PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer" 
31             CertificateThumbPrint   = $certificateThumbPrint          
32             ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
33             ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"             
34             State                   = "Started" 
35             DependsOn               = "[WindowsFeature]DSCServiceFeature"                         
36         } 
```

1. Run the configuration, passing the thumbprint of the self-signed certificate you created as the **certificateThumbPrint** parameter:

```powershell
PS:\>$myCert = Get-ChildItem CERT: | Where-Object {$_.Subject -eq 'CN=PSDSCPullServerCert'}
PS:\>Sample_xDSCService -certificateThumbprint $myCert.Thumbprint 
```

## Registration Key
To allow client nodes to register with the server so that they can use configuration names instead of a configuration ID, a registration key (which is a GUID known to both the server and the client node) must be placed in a file named `RegistrationKeys.txt`. By default, the pull server created by this example expects that file to be located in `C:\Program Files\WindowsPowerShell\DscService`. Create a text file with only one line consisting of the registration key and save it in that folder.
> **Note**: Registration keys are not supported in PowerShell 4.0. 

## Placing configurations and resources
After the pull server setup completes, there is a new folder under `$env:PROGRAMFILES\WindowsPowerShell` named "DscService". In that folder, there are two folders named "Modules" and "Configuration". In the "Modules" folder, place any resources that are needed for configurations that nodes will pull from this server. In the "Configuration" folder, place the configuration MOF files for any configurations that are to be pulled by nodes. The names of the MOF files depend on the type of pull client. The following topics describe setting up pull clients in detail:

* [Setting up a DSC pull client using a configuration ID](pullClientConfigID.md)
* [Setting up a DSC pull client using configuration names](pullClientConfigNames.md)
* [Partial configurations](partialConfigs.md)

## Creating the MOF checksum
A configuration MOF file needs to be paired with a checksum file so that an LCM on a target node can validate the configuration. To create a checksum, call the [New-DSCCheckSum](https://technet.microsoft.com/en-us/library/dn521622.aspx) cmdlet. The cmdlet takes a **Path** parameter that specifies the folder where the configuration MOF is located. The cmdlet creates a checksum file named `ConfigurationMOFName.mof.checksum`, where `ConfigurationMOFName` is the name of the configuration mof file. If there are more than one configuration MOF files in the specified folder, a checksum is created for each configuration in the folder.

The checksum file must be present in the same directory as the configuration MOF file (`$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration` by default), and have the same name with the `.checksum` extension appended.

>**Note**: If you change the configuration MOF file in any way, you must also recreate the checksum file.

## See also
* [Windows PowerShell Desired State Configuration Overview](overview.md)
* [Enacting configurations](enactingConfigurations.md)
* [How to retrieve node information from DSC pull server](retrieveNodeInfo.md)
