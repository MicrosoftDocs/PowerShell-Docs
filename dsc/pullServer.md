---
ms.date:  2017-06-12
author:  eslesar
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Setting up a DSC web pull server
---

# Setting up a DSC web pull server

> Applies To: Windows PowerShell 5.0

A DSC web pull server is a web service in IIS that uses an OData interface to make DSC configuration files available to target nodes when those nodes ask for them.

Requirements for using a pull server:

* A server running:
  - WMF/PowerShell 5.0 or greater
  - IIS server role
  - DSC Service
* Ideally, some means of generating a certificate, to secure credentials passed to the Local Configuration Manager (LCM) on target nodes

You can add the IIS server role and DSC Service with the Add Roles and Features wizard in Server Manager, or by using PowerShell. The sample scripts included in this topic will handle both of these steps 
for you as well.

## Using the xDSCWebService resource
The easiest way to set up a web pull server is to use the xWebService resource, included in the xPSDesiredStateConfiguration module. The following steps explain how to use the resource in a configuration that sets up the web service.

1. Call the [Install-Module](https://technet.microsoft.com/en-us/library/dn807162.aspx) cmdlet to install the **xPSDesiredStateConfiguration** module. **Note**: **Install-Module** is included in the **PowerShellGet** module, which is included in PowerShell 5.0. You can download the **PowerShellGet** module for PowerShell 3.0 and 4.0 at [PackageManagement PowerShell Modules Preview](https://www.microsoft.com/en-us/download/details.aspx?id=49186). 
1. Get an SSL certificate for the DSC Pull server from a trusted Certificate Authority, either within your organization or a public authority. The certificate received from the authority is usually in the PFX format. Install the certificate on the node that will become the DSC Pull server in the default location which should be CERT:\LocalMachine\My. Make a note of the certificate thumbprint.
1. Select a GUID to be used as the Registration Key. To generate one using PowerShell enter the following at the PS prompt and press enter: '``` [guid]::newGuid()```' or '```New-Guid```'. This key will be used by client nodes as a shared key to authenticate during registration. For more information see the Registration Key section below.
1. In the PowerShell ISE, start (F5) the following configuration script (included in the Example folder of the  **xPSDesiredStateConfiguration** module as Sample_xDscWebService.ps1). This script sets up the pull server.
  
    ```powershell
    configuration Sample_xDscPullServer
    { 
        param  
        ( 
                [string[]]$NodeName = 'localhost', 

                [ValidateNotNullOrEmpty()] 
                [string] $certificateThumbPrint,

                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string] $RegistrationKey 
         ) 
         
         Import-DSCResource -ModuleName xPSDesiredStateConfiguration
         Import-DSCResource –ModuleName PSDesiredStateConfiguration

         Node $NodeName 
         { 
             WindowsFeature DSCServiceFeature 
             { 
                 Ensure = 'Present'
                 Name   = 'DSC-Service'             
             } 

             xDscWebService PSDSCPullServer 
             { 
                 Ensure                   = 'Present' 
                 EndpointName             = 'PSDSCPullServer' 
                 Port                     = 8080 
                 PhysicalPath             = "$env:SystemDrive\inetpub\PSDSCPullServer" 
                 CertificateThumbPrint    = $certificateThumbPrint          
                 ModulePath               = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
                 ConfigurationPath        = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" 
                 State                    = 'Started'
                 DependsOn                = '[WindowsFeature]DSCServiceFeature'     
                 UseSecurityBestPractices = $false
             } 

            File RegistrationKeyFile
            {
                Ensure          = 'Present'
                Type            = 'File'
                DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
                Contents        = $RegistrationKey
            }
        }
    }

    ```

1. Run the configuration, passing the thumbprint of the SSL certificate as the **certificateThumbPrint** parameter and a GUID registration key as the **RegistrationKey** parameter:

    ```powershell
    # To find the Thumbprint for an installed SSL certificate for use with the pull server list all certificates in your local store 
    # and then copy the thumbprint for the appropriate certificate by reviewing the certificate subjects
    dir Cert:\LocalMachine\my

    # Then include this thumbprint when running the configuration
    Sample_xDSCPullServer -certificateThumbprint 'A7000024B753FA6FFF88E966FD6E19301FAE9CCC' -RegistrationKey '140a952b-b9d6-406b-b416-e0f759c9c0e4' -OutputPath c:\Configs\PullServer

    # Run the compiled configuration to make the target node a DSC Pull Server
    Start-DscConfiguration -Path c:\Configs\PullServer -Wait -Verbose
    ```

## Registration Key
To allow client nodes to register with the server so that they can use configuration names instead of a configuration ID, a registration key which was created by the above configuration is saved in a file named `RegistrationKeys.txt` in `C:\Program Files\WindowsPowerShell\DscService`. The registration key functions as a shared secret used during the initial registration by the client with the pull server. The client will generate a self-signed certificate which is used to uniquely authenticate to the pull server once registration is successfully completed. The thumbprint of this certificate is stored locally and associated with the URL of the pull server.
> **Note**: Registration keys are not supported in PowerShell 4.0. 

In order to configure a node to authenticate with the pull server the registration key needs to be in the metaconfiguration for any target node that will be registering with this pull server. Note that the **RegistrationKey** in the metaconfiguration below is removed after the target machine has successfully registered, and that the value '140a952b-b9d6-406b-b416-e0f759c9c0e4' must match the value stored in the RegistrationKeys.txt file on the pull server. Always treat the registration key value securely, because knowing it allows any target machine to register with the pull server.

```powershell
[DSCLocalConfigurationManager()]
configuration PullClientConfigID
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
            ServerURL          = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey    = '140a952b-b9d6-406b-b416-e0f759c9c0e4'
            ConfigurationNames = @('ClientConfig')
        }   
        
        ReportServerWeb CONTOSO-PullSrv
        {
            ServerURL       = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = '140a952b-b9d6-406b-b416-e0f759c9c0e4'
        }
    }
}

PullClientConfigID -OutputPath c:\Configs\TargetNodes
```
> **Note**: The **ReportServerWeb** section allows reporting data to be sent to the pull server. 

The lack of the **ConfigurationID** property in the metaconfiguration file implicitly means that pull server is supporting the V2 version of the pull server protocol so an initial registration 
is required. Conversely, the presence of a **ConfigurationID** means that the V1 version of the pull server protocol is used and there is no registration processing.

>**Note**: In a PUSH scenario, a bug exists in the current relase that makes it necessary to define a ConfigurationID property in the metaconfiguration file for nodes that have never 
registered with a pull server. This will force the V1 Pull Server protocol and avoid registration failure messages.

## Placing configurations and resources

After the pull server setup completes, the folders defined by the **ConfigurationPath** and **ModulePath** properties in the pull server configuration are where you will place modules and 
configurations that will be available for target nodes to pull. These files need to be in a specific format in order for the pull server to correctly process them. 

### DSC resource module package format

Each resource module needs to be zipped and named according the following pattern `{Module Name}_{Module Version}.zip`. For example, a module named xWebAdminstration with a module version 
of 3.1.2.0 would be named 'xWebAdministration_3.2.1.0.zip'. Each version of a module must be contained in a single zip file. Since there is only a single version of a resource in each zip 
file the module format added in WMF 5.0 with support for multiple module versions in a single directory is not supported. This means that before packaging up DSC resource modules for use with 
pull server you will need to make a small change to the directory structure. The default format of modules containing DSC resource in WMF 5.0 is 
'{Module Folder}\{Module Version}\DscResources\{DSC Resource Folder}\'. Before packaging up for the pull server simply remove the **{Module version}** folder so the path becomes 
'{Module Folder}\DscResources\{DSC Resource Folder}\'. With this change, zip the folder as described above and place these zip files in the **ModulePath** folder.

Use `new-dscchecksum {module zip file}` to create a checksum file for the newly-added module.

### Configuration MOF format 
A configuration MOF file needs to be paired with a checksum file so that an LCM on a target node can validate the configuration. To create a checksum, call the 
[New-DSCCheckSum](https://technet.microsoft.com/en-us/library/dn521622.aspx) cmdlet. The cmdlet takes a **Path** parameter that specifies the folder where the configuration MOF is 
located. The cmdlet creates a checksum file named `ConfigurationMOFName.mof.checksum`, where `ConfigurationMOFName` is the name of the configuration mof file. If there are more than 
one configuration MOF files in the specified folder, a checksum is created for each configuration in the folder. Place the MOF files and their associated checksum files in the 
the **ConfigurationPath** folder.

>**Note**: If you change the configuration MOF file in any way, you must also recreate the checksum file.

## Tooling
In order to make setting up, validating and managing the pull server easier, the following tools are included as examples in the latest version of the xPSDesiredStateConfiguration module:
1. A module that will help with packaging DSC resource modules and configuration files for use on the pull server. [PublishModulesAndMofsToPullServer.psm1](https://github.com/PowerShell/xPSDesiredStateConfiguration/blob/dev/DSCPullServerSetup/PublishModulesAndMofsToPullServer.psm1). Examples below:

    ```powershell
        # Example 1 - Package all versions of given modules installed locally and MOF files are in c:\LocalDepot
         $moduleList = @("xWebAdministration", "xPhp") 
         Publish-DSCModuleAndMof -Source C:\LocalDepot -ModuleNameList $moduleList 

         # Example 2 - Package modules and mof documents from c:\LocalDepot
         Publish-DSCModuleAndMof -Source C:\LocalDepot -Force
    ```

1. A script that validates the pull server is configured correctly. [PullServerSetupTests.ps1](https://github.com/PowerShell/xPSDesiredStateConfiguration/blob/dev/DSCPullServerSetup/PullServerDeploymentVerificationTest/PullServerSetupTests.ps1).


## Pull client configuration 
The following topics describe setting up pull clients in detail:

* [Setting up a DSC pull client using a configuration ID](pullClientConfigID.md)
* [Setting up a DSC pull client using configuration names](pullClientConfigNames.md)
* [Partial configurations](partialConfigs.md)


## See also
* [Windows PowerShell Desired State Configuration Overview](overview.md)
* [Enacting configurations](enactingConfigurations.md)
* [Using a DSC report server](reportServer.md)

