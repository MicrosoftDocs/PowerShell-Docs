---
ms.date:  01/08/2020
keywords:  dsc,powershell,configuration,setup
title:  DSC Pull Service
description: Local Configuration Manager (LCM) can be centrally managed by a Pull Service solution. When using this approach, the node that is being managed is registered with a service and assigned a configuration in LCM settings.
---

# Desired State Configuration Pull Service

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server however
> there are no plans to offer new features or capabilities. It is recommended to begin transitioning
> managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions listed
> [here](pullserver.md#community-solutions-for-pull-service).

Local Configuration Manager (LCM) can be centrally managed by a Pull Service solution. When using
this approach, the node that is being managed is registered with a service and assigned a
configuration in LCM settings. The configuration and all DSC resources needed as dependencies for
the configuration are downloaded to the machine and used by LCM to manage the configuration.
Information about the state of the machine being managed is uploaded to the service for reporting.
This concept is referred to as "pull service".

The current options for pull service include:

- Azure Automation Desired State Configuration service
- A pull service running on Windows Server
- Community maintained open-source solutions
- An SMB share

The recommended scale for each solution is as follows:

|                   Solution                   |              Client nodes              |
| -------------------------------------------- | -------------------------------------- |
| Windows Pull Server using MDB/ESENT database | Up to 500 nodes                        |
| Windows Pull Server using SQL database       | Up to 3500 nodes                       |
| Azure Automation DSC                         | Both small and large environments      |

**The recommended solution**, and the option with the most features available, is
[Azure Automation DSC](/azure/automation/automation-dsc-getting-started). An upper limit for number
of nodes per Automation Account has not been identified.

The Azure service can manage nodes on-premises in private datacenters, or in public clouds such as
Azure and AWS. For private environments where servers cannot directly connect to the Internet,
consider limiting outbound traffic to only the published Azure IP range (see
[Azure Datacenter IP Ranges](https://www.microsoft.com/download/details.aspx?id=41653)).

Features of the online service that are not currently available in the pull service on Windows
Server include:

- All data is encrypted in transit and at rest
- Client certificates are created and managed automatically
- Secrets store for centrally managing
  [passwords/credentials](/azure/automation/automation-credentials), or
  [variables](/azure/automation/automation-variables) such as server names or connection strings
- Centrally manage node [LCM configuration](../managing-nodes/metaConfig.md#basic-settings)
- Centrally assign configurations to client nodes
- Release configuration changes to "canary groups" for testing before reaching production
- Graphical reporting
  - Status detail at the DSC resource level of granularity
  - Verbose error messages from client machines for troubleshooting
- [Integration with Azure Log Analytics](/azure/automation/automation-dsc-diagnostics) for alerting,
  automated tasks, Android/iOS app for reporting and alerting

## DSC pull service in Windows Server

It is possible to configure a pull service to run on Windows Server. Be advised that the pull
service solution included in Windows Server includes only capabilities of storing configurations and
modules for download and capturing report data into a database. It does not include many of the
capabilities offered by the service in Azure and so, is not a good tool for evaluating how the
service would be used.

The pull service offered in Windows Server is a web service in IIS that uses an OData interface to
make DSC configuration files available to target nodes when those nodes ask for them.

Requirements for using a pull server:

- A server running:
  - WMF/PowerShell 4.0 or greater
  - IIS server role
  - DSC Service
- Ideally, some means of generating a certificate, to secure credentials passed to the Local
  Configuration Manager (LCM) on target nodes

The best way to configure Windows Server to host pull service is to use a DSC configuration. An
example script is provided below.

### Supported database systems

| WMF 4.0 |       WMF 5.0        |       WMF 5.1        | WMF 5.1 (Windows Server Insider Preview 17090) |
| ------- | -------------------- | -------------------- | ---------------------------------------------- |
| MDB     | ESENT (Default), MDB | ESENT (Default), MDB | ESENT (Default), SQL Server, MDB               |

Starting in release 17090 of Windows Server, SQL Server is a supported option for the Pull Service
(Windows Feature *DSC-Service*). This provides a new option for scaling large DSC environments that
have not migrated to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started).

> [!NOTE]
> SQL Server support will not be added to previous versions of WMF 5.1 (or earlier) and will only be
> available on Windows Server versions greater than or equal to 17090.

To configure the pull server to use SQL Server, set **SqlProvider** to `$true` and
**SqlConnectionString** to a valid SQL Server Connection String. For more information, see
[SqlClient Connection Strings](/dotnet/framework/data/adonet/connection-string-syntax#sqlclient-connection-strings).
For an example of SQL Server configuration with **xDscWebService**, first read
[Using the xDscWebService resource](#using-the-xdscwebservice-resource) and then review
[Sample_xDscWebServiceRegistration_UseSQLProvider.ps1 on GitHub](https://github.com/dsccommunity/xPSDesiredStateConfiguration/blob/master/source/Examples/Sample_xDscWebServiceRegistration_UseSQLProvider.ps1).

### Using the xDscWebService resource

The easiest way to set up a web pull server is to use the **xDscWebService** resource, included in
the **xPSDesiredStateConfiguration** module. The following steps explain how to use the resource in
a `Configuration` that sets up the web service.

1. Call the [Install-Module](/powershell/module/PowerShellGet/Install-Module) cmdlet to install the
   **xPSDesiredStateConfiguration** module.

   > [!NOTE]
   > `Install-Module` is included in the **PowerShellGet** module, which is included in PowerShell
   > 5.0 and higher.

1. Get an SSL certificate for the DSC Pull server from a trusted Certificate Authority, either
   within your organization or a public authority. The certificate received from the authority is
   usually in the PFX format.
1. Install the certificate on the node that will become the DSC Pull server in the default location,
   which should be `CERT:\LocalMachine\My`.
   - Make a note of the certificate thumbprint.
1. Select a GUID to be used as the Registration Key. To generate one using PowerShell enter the
   following at the PS prompt and press enter: `[guid]::newGuid()` or `New-Guid`. This key will be
   used by client nodes as a shared key to authenticate during registration. For more information,
   see the Registration Key section below.
1. In the PowerShell ISE, start (<kbd>F5</kbd>) the following configuration script (included in the
   folder of the **xPSDesiredStateConfiguration** module as `Sample_xDscWebServiceRegistration.ps1`)
   . This script sets up the pull server.

    ```powershell
    configuration Sample_xDscWebServiceRegistration
    {
        param
        (
            [string[]]$NodeName = 'localhost',

            [ValidateNotNullOrEmpty()]
            [string] $certificateThumbPrint,

            [Parameter(HelpMessage='This should be a string with enough entropy (randomness) to protect the registration of clients to the pull server.  We will use new GUID by default.')]
            [ValidateNotNullOrEmpty()]
            [string] $RegistrationKey   # A guid that clients use to initiate conversation with pull server
        )

        Import-DSCResource -ModuleName PSDesiredStateConfiguration
        Import-DSCResource -ModuleName xPSDesiredStateConfiguration

        Node $NodeName
        {
            WindowsFeature DSCServiceFeature
            {
                Ensure = "Present"
                Name   = "DSC-Service"
            }

            xDscWebService PSDSCPullServer
            {
                Ensure                  = "Present"
                EndpointName            = "PSDSCPullServer"
                Port                    = 8080
                PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer"
                CertificateThumbPrint   = $certificateThumbPrint
                ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
                ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
                State                   = "Started"
                DependsOn               = "[WindowsFeature]DSCServiceFeature"
                RegistrationKeyPath     = "$env:PROGRAMFILES\WindowsPowerShell\DscService"
                AcceptSelfSignedCertificates = $true
                UseSecurityBestPractices     = $true
                Enable32BitAppOnWin64   = $false
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

1. Run the configuration, passing the thumbprint of the SSL certificate as the
   **certificateThumbPrint** parameter and a GUID registration key as the **RegistrationKey**
   parameter:

    ```powershell
    # To find the Thumbprint for an installed SSL certificate for use with the pull server list all
    # certificates in your local store and then copy the thumbprint for the appropriate certificate
    # by     reviewing the certificate subjects

    dir Cert:\LocalMachine\my

    # Then include this thumbprint when running the configuration
    Sample_xDscWebServiceRegistration -certificateThumbprint 'A7000024B753FA6FFF88E966FD6E19301FAE9CCC' -RegistrationKey '140a952b-b9d6-406b-b416-e0f759c9c0e4' -OutputPath c:\Configs\PullServer

    # Run the compiled configuration to make the target node a DSC Pull Server
    Start-DscConfiguration -Path c:\Configs\PullServer -Wait -Verbose
    ```

#### Registration Key

To allow client nodes to register with the server so that they can use configuration names instead
of a configuration ID, a registration key that was created by the above configuration is saved in a
file named `RegistrationKeys.txt` in `C:\Program Files\WindowsPowerShell\DscService`. The
registration key functions as a shared secret used during the initial registration by the client
with the pull server. The client will generate a self-signed certificate that is used to uniquely
authenticate to the pull server once registration is successfully completed. The thumbprint of this
certificate is stored locally and associated with the URL of the pull server.

> [!NOTE]
> Registration keys are not supported in PowerShell 4.0.

In order to configure a node to authenticate with the pull server, the registration key needs to be
in the metaconfiguration for any target node that will be registering with this pull server. Note
that the **RegistrationKey** in the metaconfiguration below is removed after the target machine has
successfully registered, and that the value must match the value stored in the
`RegistrationKeys.txt` file on the pull server ('140a952b-b9d6-406b-b416-e0f759c9c0e4' for this
example). Always treat the registration key value securely, because knowing it allows any target
machine to register with the pull server.

```powershell
[DSCLocalConfigurationManager()]
configuration Sample_MetaConfigurationToRegisterWithLessSecurePullServer
{
    param
    (
        [ValidateNotNullOrEmpty()]
        [string] $NodeName = 'localhost',

        [ValidateNotNullOrEmpty()]
        [string] $RegistrationKey, #same as the one used to set up pull server in previous configuration

        [ValidateNotNullOrEmpty()]
        [string] $ServerName = 'localhost' #node name of the pull server, same as $NodeName used in previous configuration
    )

    Node $NodeName
    {
        Settings
        {
            RefreshMode        = 'Pull'
        }

        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL          = "https://$ServerName`:8080/PSDSCPullServer.svc" # notice it is https
            RegistrationKey    = $RegistrationKey
            ConfigurationNames = @('ClientConfig')
        }

        ReportServerWeb CONTOSO-PullSrv
        {
            ServerURL       = "https://$ServerName`:8080/PSDSCPullServer.svc" # notice it is https
            RegistrationKey = $RegistrationKey
        }
    }
}

Sample_MetaConfigurationToRegisterWithLessSecurePullServer -RegistrationKey $RegistrationKey -OutputPath c:\Configs\TargetNodes
```

> [!NOTE]
> The **ReportServerWeb** section allows reporting data to be sent to the pull server.

The lack of the **ConfigurationID** property in the metaconfiguration file implicitly means that
pull server is supporting the V2 version of the pull server protocol so an initial registration is
required. Conversely, the presence of a **ConfigurationID** means that the V1 version of the pull
server protocol is used and there is no registration processing.

> [!NOTE]
> In a PUSH scenario, a bug exists in the current release that makes it necessary to define
> a ConfigurationID property in the metaconfiguration file for nodes that have never registered with
> a pull server. This will force the V1 Pull Server protocol and avoid registration failure
> messages.

## Placing configurations and resources

After the pull server setup completes, the folders defined by the **ConfigurationPath** and
**ModulePath** properties in the pull server configuration are where you will place modules and
configurations that will be available for target nodes to pull. These files need to be in a specific
format in order for the pull server to correctly process them.

### DSC resource module package format

Each resource module needs to be zipped and named according to the following pattern
`{Module Name}_{Module Version}.zip`.

For example, a module named **xWebAdminstration** with a module version of 3.1.2.0 would be named
`xWebAdministration_3.1.2.0.zip`. Each version of a module must be contained in a single zip file.
Since there is only a single version of a resource in each zip file, the module format added in WMF
5.0 with support for multiple module versions in a single directory is not supported. This means
that before packaging up DSC resource modules for use with pull server you will need to make a small
change to the directory structure. The default format of modules containing DSC resource in WMF 5.0
is `{Module Folder}\{Module Version}\DscResources\{DSC Resource Folder}\`. Before packaging up for
the pull server, remove the **{Module version}** folder so the path becomes
`{Module Folder}\DscResources\{DSC Resource Folder}\`. With this change, zip the folder as described
above and place these zip files in the **ModulePath** folder.

Use `New-DscChecksum {module zip file}` to create a checksum file for the newly added module.

### Configuration MOF format

A configuration MOF file needs to be paired with a checksum file so that an LCM on a target node can
validate the configuration. To create a checksum, call the
[New-DscChecksum](/powershell/module/PSDesiredStateConfiguration/New-DSCCheckSum) cmdlet. The cmdlet
takes a **Path** parameter that specifies the folder where the configuration MOF is located. The
cmdlet creates a checksum file named `ConfigurationMOFName.mof.checksum`, where
`ConfigurationMOFName` is the name of the configuration mof file. If there are more than one
configuration MOF files in the specified folder, a checksum is created for each configuration in the
folder. Place the MOF files and their associated checksum files in the **ConfigurationPath** folder.

> [!NOTE]
> If you change the configuration MOF file in any way, you must also recreate the checksum file.

### Tooling

In order to make setting up, validating and managing the pull server easier, the following tools are
included as examples in the latest version of the xPSDesiredStateConfiguration module:

1. A module that will help with packaging DSC resource modules and configuration files for use on
   the pull server.
   [PublishModulesAndMofsToPullServer.psm1](https://github.com/dsccommunity/xPSDesiredStateConfiguration/blob/master/source/Modules/DscPullServerSetup/DscPullServerSetup.psm1).
   Examples below:

    ```powershell
    # Example 1 - Package all versions of given modules installed locally and MOF files are in c:\LocalDepot
    $moduleList = @('xWebAdministration', 'xPhp')
    Publish-DSCModuleAndMof -Source C:\LocalDepot -ModuleNameList $moduleList

    # Example 2 - Package modules and mof documents from c:\LocalDepot
    Publish-DSCModuleAndMof -Source C:\LocalDepot -Force
    ```

1. A script that validates the pull server is configured correctly.
   [PullServerSetupTests.ps1](https://github.com/dsccommunity/xPSDesiredStateConfiguration/blob/master/source/Modules/DscPullServerSetup/DscPullServerSetupTest/DscPullServerSetupTest.ps1).

## Community Solutions for Pull Service

The DSC community has authored multiple solutions to implement the pull service protocol. For
on-premises environments, these offer pull service capabilities and an opportunity to contribute
back to the community with incremental enhancements.

- [Tug](https://github.com/powershellorg/tug)
- [DSC-TRÆK](https://github.com/powershellorg/dsc-traek)

## Pull client configuration

The following topics describe setting up pull clients in detail:

- [Set up a DSC pull client using a configuration ID](pullClientConfigID.md)
- [Set up a DSC pull client using configuration names](pullClientConfigNames.md)
- [Partial configurations](partialConfigs.md)

## See also

- [Windows PowerShell Desired State Configuration Overview](../overview/overview.md)
- [Enacting configurations](enactingConfigurations.md)
- [Using a DSC report server](reportServer.md)
- [[MS-DSCPM]: Desired State Configuration Pull Model Protocol](/openspecs/windows_protocols/ms-dscpm/ea744c01-51a2-4000-9ef2-312711dcc8c9)
- [[MS-DSCPM]: Desired State Configuration Pull Model Protocol Errata](/openspecs/windows_protocols/ms-winerrata/f5fc7ae3-9172-41e8-ac6a-2a5a5b7bfaf5)
