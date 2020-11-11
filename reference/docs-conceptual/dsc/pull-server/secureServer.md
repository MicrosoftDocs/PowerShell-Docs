---
ms.date:  06/12/2017
description: This document provide best practices to assist engineers that are deploying the DSC Pull Server.
keywords:  dsc,powershell,configuration,setup
title:  Pull server best practices
---
# Pull server best practices

Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server however
> there are no plans to offer new features or capabilities. It is recommended to begin transitioning
> managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions listed
> [here](pullserver.md#community-solutions-for-pull-service).

Summary: This document is intended to include process and extensibility to assist engineers who are
preparing for the solution. Details should provide best practices as identified by customers and
then validated by the product team to ensure recommendations are future facing and considered
stable.

- Author: Michael Greene
- Reviewers: Ben Gelens, Ravikanth Chaganti, Aleksandar Nikolic
- Published: April, 2015

## Abstract

This document is designed to provide official guidance for anyone planning for a Windows PowerShell
Desired State Configuration pull server implementation. A pull server is a simple service that
should take only minutes to deploy. Although this document will offer technical how-to guidance that
can be used in a deployment, the value of this document is as a reference for best practices and
what to think about before deploying. Readers should have basic familiarity with DSC, and the terms
used to describe the components that are included in a DSC deployment. For more information, see the
[Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/overview)
topic. As DSC is expected to evolve at cloud cadence, the underlying technology including pull
server is also expected to evolve and to introduce new capabilities. This document includes a
version table in the appendix that provides references to previous releases and references to future
looking solutions to encourage forward-looking designs.

The two major sections of this document:

- Configuration Planning
- Installation Guide

### Versions of the Windows Management Framework

The information in this document is intended to apply to Windows Management Framework 5.0. While WMF
5.0 is not required for deploying and operating a pull server, version 5.0 is the focus of this
document.

### Windows PowerShell Desired State Configuration

Desired State Configuration (DSC) is a management platform that enables deploying and managing
configuration data by using an industry syntax named the Managed Object Format (MOF) to describe the
Common Information Model (CIM). An open source project, Open Management Infrastructure (OMI), exists
to further development of these standards across platforms including Linux and network hardware
operating systems. For more information, see the
[DMTF page linking to MOF specifications](https://www.dmtf.org/standards/cim), and
[OMI Documents and Source](https://collaboration.opengroup.org/omi/documents.php).

Windows PowerShell provides a set of language extensions for Desired State Configuration that you
can use to create and manage declarative configurations.

### Pull server role

A pull server provides a centralized service to store configurations that will be accessible to
target nodes.

The pull server role can be deployed as either a Web Server instance or an SMB file share. The web
server capability includes an OData interface and can optionally include capabilities for target
nodes to report back confirmation of success or failure as configurations are applied. This
functionality is useful in environments where there are a large number of target nodes. After
configuring a target node (also referred to as a client) to point to the pull server the latest
configuration data and any required scripts are downloaded and applied. This can happen as a
one-time deployment or as a re-occurring job which also makes the pull server an important asset for
managing change at scale. For more information, see
[Windows PowerShell Desired State Configuration Pull Servers](pullserver.md) and
[Push and Pull Configuration Modes](pullserver.md).

## Configuration planning

For any enterprise software deployment there is information that can be collected in advance to help
plan for the correct architecture and to be prepared for the steps required to complete the
deployment. The following sections provide information regarding how to prepare and the
organizational connections that will likely need to happen in advance.

### Software requirements

Deployment of a pull server requires the DSC Service feature of Windows Server. This feature was
introduced in Windows Server 2012, and has been updated through ongoing releases of Windows
Management Framework (WMF).

### Software downloads

In addition to installing the latest content from Windows Update, there are two downloads considered
best practice to deploy a DSC pull server: The latest version of Windows Management Framework, and a
DSC module to automate pull server provisioning.

### WMF

Windows Server 2012 R2 includes a feature named the DSC Service. The DSC Service feature provides
the pull server functionality, including the binaries that support the OData endpoint. WMF is
included in Windows Server and is updated on an agile cadence between Windows Server releases.
[New versions of WMF 5.0](https://www.microsoft.com/download/details.aspx?id=54616) can include
updates to the DSC Service feature. For this reason, it is a best practice to download the latest
release of WMF and to review the release notes to determine if the release includes an update to the
DSC service feature. You should also review the section of the release notes that indicates whether
the design status for an update or scenario is listed as stable or experimental. To allow for an
agile release cycle, individual features can be declared stable, which indicates the feature is
ready to be used in a production environment even while WMF is released in preview. Other features
that have historically been updated by WMF releases (see the WMF Release Notes for further detail):

- Windows PowerShell Windows PowerShell Integrated Scripting
- Environment (ISE) Windows PowerShell Web Services (Management OData
- IIS Extension)  Windows PowerShell Desired State Configuration (DSC)
- Windows Remote Management (WinRM) Windows Management Instrumentation (WMI)

### DSC resource

A pull server deployment can be simplified by provisioning the service using a DSC configuration
script. This document includes configuration scripts that can be used to deploy a production ready
server node. To use the configuration scripts, a DSC module is required that is not included in
Windows Server. The required module name is **xPSDesiredStateConfiguration**, which includes the DSC
resource **xDscWebService**. The xPSDesiredStateConfiguration module can be downloaded
[here](https://github.com/dsccommunity/xPSDesiredStateConfiguration).

Use the `Install-Module` cmdlet from the **PowerShellGet** module.

```powershell
Install-Module xPSDesiredStateConfiguration
```

The **PowerShellGet** module will download the module to:

`C:\Program Files\Windows PowerShell\Modules`

Planning task

- Do you have access to the installation files for Windows Server 2012 R2?
- Will the deployment environment have Internet access to download WMF and the module from the
  online gallery?
- How will you install the latest security updates after installing the operating system?
- Will the environment have Internet access to obtain updates, or will it have a local Windows
  Server Update Services (WSUS) server?
- Do you have access to Windows Server installation files that already include updates through
  offline injection?

### Hardware requirements

Pull server deployments are supported on both physical and virtual servers. The sizing requirements
for pull server align with the requirements for Windows Server 2012 R2.

- CPU: 1.4 GHz 64-bit processor
- Memory: 512 MB
- Disk Space: 32 GB
- Network: Gigabit Ethernet Adapter

Planning task

- Will you deploy on physical hardware or on a virtualization platform?
- What is the process to request a new server for your target environment?
- What is the average turnaround time for a server to become available?
- What size server will you request?

### Accounts

There are no service account requirements to deploy a pull server instance. However, there are
scenarios where the website could run in the context of a local user account. For example, if there
is a need to access a storage share for website content and either the Windows Server or the device
hosting the storage share are not domain joined.

### DNS records

You will need a server name to use when configuring clients to work with a pull server environment.
In test environments, typically the server hostname is used, or the IP address for the server can be
used if DNS name resolution is not available. In production environments or in a lab environment
that is intended to represent a production deployment, the best practice is to create a DNS CNAME
record.

A DNS CNAME allows you to create an alias to refer to your host (A) record. The intent of the
additional name record is to increase flexibility should a change be required in the future. A CNAME
can help to isolate the client configuration so that changes to the server environment, such as
replacing a pull server or adding additional pull servers, will not require a corresponding change
to the client configuration.

When choosing a name for the DNS record, keep the solution architecture in mind. If using load
balancing, the certificate used to secure traffic over HTTPS will need to share the same name as the
DNS record.

|       Scenario        |                                                                                         Best Practice
|:--------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|Test Environment       | Reproduce the planned production environment, if possible. A server hostname is suitable for simple configurations. If DNS is not available, an IP address may be used in lieu of a hostname.
|Single Node Deployment | Create a DNS CNAME record that points to the server hostname.

For more information, see [Configuring DNS Round Robin in Windows Server](/previous-versions/windows/it-pro/windows-server-2003/cc787484(v=ws.10)).

Planning task

- Do you know who to contact to have DNS records created and changed?
- What is the average turnaround for a request for a DNS record?
- Do you need to request static Hostname (A) records for servers?
- What will you request as a CNAME?
- If needed, what type of Load Balancing solution will you utilize? (see section titled Load
  Balancing for details)

### Public Key Infrastructure

Most organizations today require that network traffic, especially traffic that includes such
sensitive data as how servers are configured, must be validated and/or encrypted during transit.
While it is possible to deploy a pull server using HTTP which facilitates client requests in clear
text, it is a best practice to secure traffic using HTTPS. The service can be configured to use
HTTPS using a set of parameters in the DSC resource **xPSDesiredStateConfiguration**.

The certificate requirements to secure HTTPS traffic for pull server are not different than securing
any other HTTPS web site. The **Web Server** template in a Windows Server Certificate Services
satisfies the required capabilities.

Planning task

- If certificate requests are not automated, who will you need to contact to requests a certificate?
- What is the average turnaround for the request?
- How will the certificate file be transferred to you?
- How will the certificate private key be transferred to you?
- How long is the default expiration time?
- Have you settled on a DNS name for the pull server environment, that you can use for the
  certificate name?

### Choosing an architecture

A pull server can be deployed using either a web service hosted on IIS, or an SMB file share. In
most situations, the web service option will provide greater flexibility. It is not uncommon for
HTTPS traffic to traverse network boundaries, whereas SMB traffic is often filtered or blocked
between networks. The web service also offers the option to include a Conformance Server or Web
Reporting Manager (both topics to be addressed in a future version of this document) that provide a
mechanism for clients to report status back to a server for centralized visibility. SMB provides an
option for environments where policy dictates that a web server should not be utilized, and for
other environmental requirements that make a web server role undesirable. In either case, remember
to evaluate the requirements for signing and encrypting traffic. HTTPS, SMB signing, and IPSEC
policies are all options worth considering.

#### Load balancing

Clients interacting with the web service make a request for information that is returned in a single
response. No sequential requests are required, so it is not necessary for the load balancing
platform to ensure sessions are maintained on a single server at any point in time.

Planning task

- What solution will be used for load balancing traffic across servers?
- If using a hardware load balancer, who will take a request to add a new configuration to the
  device?
- What is the average turnaround for a request to configure a new load balanced web service?
- What information will be required for the request?
- Will you need to request an additional IP or will the team responsible for load balancing handle
  that?
- Do you have the DNS records needed, and will this be required by the team responsible for
  configuring the load balancing solution?
- Does the load balancing solution require that PKI be handled by the device or can it load balance
  HTTPS traffic as long as there are no session requirements?

### Staging configurations and modules on the pull server

As part of configuration planning, you will need to think about which DSC modules and configurations
will be hosted by the pull server. For the purpose of configuration planning it is important to have
a basic understanding of how to prepare and deploy content to a pull server.

In the future, this section will be expanded and included in an Operations Guide for DSC Pull
Server. The guide will discuss the day to day process for managing modules and configurations over
time with automation.

#### DSC modules

Clients that request a configuration will need the required DSC modules. A functionality of the pull
server is to automate distribution on demand of DSC modules to clients. If you are deploying a pull
server for the first time, perhaps as a lab or proof of concept, you are likely going to depend on
DSC modules that are available from public repositories such as the PowerShell Gallery or the
PowerShell.org GitHub repositories for DSC modules.

It is critical to remember that even for trusted online sources such as the PowerShell Gallery, any
module that is downloaded from a public repository should be reviewed by someone with PowerShell
experience and knowledge of the environment where the modules will be used prior to being used in
production. While completing this task it is a good time to check for any additional payload in the
module that can be removed such as documentation and example scripts. This will reduce the network
bandwidth per client in their first request, when modules will be downloaded over the network from
server to client.

Each module must be packaged in a specific format, a ZIP file named ModuleName_Version.zip that
contains the module payload. After the file is copied to the server a checksum file must be created.
When clients connect to the server, the checksum is used to verify the content of the DSC module has
not changed since it was published.

```powershell
New-DscChecksum -ConfigurationPath .\ -OutPath .\
```

Planning task

- If you are planning a test or lab environment which scenarios are key to validate?
- Are there publicly available modules that contain resources to cover everything you need or will
  you need to author your own resources?
- Will your environment have Internet access to retrieve public modules?
- Who will be responsible for reviewing DSC modules?
- If you are planning a production environment what will you use as a local repository for storing
  DSC modules?
- Will a central team accept DSC modules from application teams? What will the process be?
- Will you automate packaging, copying, and creating a checksum for production-ready DSC modules to
  the server, from your source repo?
- Will your team be responsible for managing the automation platform as well?

#### DSC configurations

The purpose of a pull server is to provide a centralized mechanism for distributing DSC
configurations to client nodes. The configurations are stored on the server as MOF documents. Each
document will be named with a unique **Guid**. When clients are configured to connect with a pull
server, they are also given the **Guid** for the configuration they should request. This system of
referencing configurations by **Guid** guarantees global uniqueness and is flexible such that a
configuration can be applied with granularity per node, or as a role configuration that spans many
servers that should have identical configurations.

#### Guids

Planning for configuration **Guids** is worth additional attention when thinking through a pull
server deployment. There is no specific requirement for how to handle **Guids** and the process is
likely to be unique for each environment. The process can range from simple to complex: a centrally
stored CSV file, a simple SQL table, a CMDB, or a complex solution requiring integration with
another tool or software solution. There are two general approaches:

- **Assigning Guids per server** — Provides a measure of assurance that every server configuration
  is controlled individually. This provides a level of precision around updates and can work well in
  environments with few servers.
- **Assigning Guids per server role** — All servers that perform the same function, such as web
  servers, use the same GUID to reference the required configuration data. Be aware that if many
  servers share the same GUID, all of them would be updated simultaneously when the configuration
  changes.

  The GUID is something that should be considered sensitive data because it could be leveraged by
  someone with malicious intent to gain intelligence about how servers are deployed and configured
  in your environment. For more information, see
  [Securely allocating Guids in PowerShell Desired State Configuration Pull Mode](https://devblogs.microsoft.com/powershell/securely-allocating-guids-in-powershell-desired-state-configuration-pull-mode/).

Planning task

- Who will be responsible for copying configurations in to the pull server folder when they are
  ready?
- If Configurations are authored by an application team, what will the process be to hand them off?
- Will you leverage a repository to store configurations as they are being authored, across teams?
- Will you automate the process of copying configurations to the server and creating a checksum when
  they are ready?
- How will you map Guids to servers or roles, and where will this be stored?
- What will you use as a process to configure client machines, and how will it integrate with your
  process for creating and storing Configuration Guids?

## Installation Guide

*Scripts given in this document are stable examples. Always review scripts carefully before
executing them in a production environment.*

### Prerequisites

To verify the version of PowerShell on your server use the following command.

```powershell
$PSVersionTable.PSVersion
```

If possible, upgrade to the latest version of Windows Management Framework. Next, download the
`xPsDesiredStateConfiguration` module using the following command.

```powershell
Install-Module xPSDesiredStateConfiguration
```

The command will ask for your approval before downloading the module.

### Installation and configuration scripts

The best method to deploy a DSC pull server is to use a DSC configuration script. This document will
present scripts including both basic settings that would configure only the DSC web service and
advanced settings that would configure a Windows Server end-to-end including DSC web service.

Note: Currently the `xPSDesiredStateConfiguration` DSC module requires the server to be EN-US
locale.

### Basic configuration for Windows Server 2012

```powershell
# This is a very basic Configuration to deploy a pull server instance in a lab environment on Windows Server 2012.

Configuration PullServer {
Import-DscResource -ModuleName xPSDesiredStateConfiguration

        # Load the Windows Server DSC Service feature
        WindowsFeature DSCServiceFeature
        {
          Ensure = 'Present'
          Name = 'DSC-Service'
        }

        # Use the DSC Resource to simplify deployment of the web service
        xDSCWebService PSDSCPullServer
        {
          Ensure = 'Present'
          EndpointName = 'PSDSCPullServer'
          Port = 8080
          PhysicalPath = "$env:SYSTEMDRIVE\inetpub\wwwroot\PSDSCPullServer"
          CertificateThumbPrint = 'AllowUnencryptedTraffic'
          ModulePath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
          ConfigurationPath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
          State = 'Started'
          DependsOn = '[WindowsFeature]DSCServiceFeature'
        }
}
PullServer -OutputPath 'C:\PullServerConfig\'
Start-DscConfiguration -Wait -Force -Verbose -Path 'C:\PullServerConfig\'
```

### Advanced configuration for Windows Server 2012 R2

```powershell
# This is an advanced Configuration example for Pull Server production deployments
# on Windows Server 2012 R2. Many of the features demonstrated are optional and
# provided to demonstrate how to adapt the Configuration for multiple scenarios
# Select the needed resources based on the requirements for each environment.
# Optional scenarios include:
#      * Reduce footprint to Server Core
#      * Rename server and join domain
#      * Switch from SSL to TLS for HTTPS
#      * Automatically load certificate from Certificate Authority
#      * Locate Modules and Configuration data on remote SMB share
#      * Manage state of default websites in IIS

param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullorEmpty()]
        [System.String] $ServerName,
        [System.String] $DomainName,
        [System.String] $CARootName,
        [System.String] $CAServerFQDN,
        [System.String] $CertSubject,
        [System.String] $SMBShare,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullorEmpty()]
        [PsCredential] $Credential
    )

Configuration PullServer {
    Import-DscResource -ModuleName xPSDesiredStateConfiguration, xWebAdministration, xCertificate, xComputerManagement
    Node localhost
    {

        # Configure the server to automatically corret configuration drift including reboots if needed.
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeifNeeded = $node.RebootNodeifNeeded
            CertificateId = $node.Thumbprint
        }

        # Remove all GUI interfaces so the server has minimum running footprint.
        WindowsFeature ServerCore
        {
            Ensure = 'Absent'
            Name = 'User-Interfaces-Infra'
        }

        # Set the server name and if needed, join a domain. If not joining a domain, remove the DomainName parameter.
        xComputer DomainJoin
        {
            Name = $Node.ServerName
            DomainName = $Node.DomainName
            Credential = $Node.Credential
        }

        # The next series of settings disable SSL and enable TLS, for environments where that is required by policy.
        Registry TLS1_2ServerEnabled
        {
            Ensure = 'Present'
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
            ValueName = 'Enabled'
            ValueData = 1
            ValueType = 'Dword'
        }

        Registry TLS1_2ServerDisabledByDefault
        {
            Ensure = 'Present'
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
            ValueName = 'DisabledByDefault'
            ValueData = 0
            ValueType = 'Dword'
        }

        Registry TLS1_2ClientEnabled
        {
            Ensure = 'Present'
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
            ValueName = 'Enabled'
            ValueData = 1
            ValueType = 'Dword'
        }

        Registry TLS1_2ClientDisabledByDefault
        {
            Ensure = 'Present'
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
            ValueName = 'DisabledByDefault'
            ValueData = 0
            ValueType = 'Dword'
        }

        Registry SSL2ServerDisabled
        {
            Ensure = 'Present'
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
            ValueName = 'Enabled'
            ValueData = 0
            ValueType = 'Dword'
        }

        # Install the Windows Server DSC Service feature
        WindowsFeature DSCServiceFeature
        {
            Ensure = 'Present'
            Name = 'DSC-Service'
        }

        # If using a certificate from a local Active Directory Enterprise Root Certificate Authority,
        # complete a request and install the certificate
        xCertReq SSLCert
        {
            CARootName = $Node.CARootName
            CAServerFQDN = $Node.CAServerFQDN
            Subject = $Node.CertSubject
            AutoRenew = $Node.AutoRenew
            Credential = $Node.Credential
        }

        # Use the DSC resource to simplify deployment of the web service.  You might also consider
        # modifying the default port, possibly leveraging port 443 in environments where that is
        # enforced as a standard.
        xDSCWebService PSDSCPullServer
        {
            Ensure = 'Present'
            EndpointName = 'PSDSCPullServer'
            Port = 8080
            PhysicalPath = "$env:SYSTEMDRIVE\inetpub\wwwroot\PSDSCPullServer"
            CertificateThumbPrint = 'CertificateSubject'
            CertificateSubject = $Node.CertSubject
            ModulePath = "$($Node.SMBShare)\DscService\Modules"
            ConfigurationPath = "$($Node.SMBShare)\DscService\Configuration"
            State = 'Started'
            DependsOn = '[WindowsFeature]DSCServiceFeature'
        }

        # Validate web config file contains current DB settings
        xWebConfigKeyValue CorrectDBProvider
        {
            ConfigSection = 'AppSettings'
            Key = 'dbprovider'
            Value = 'System.Data.OleDb'
            WebsitePath = 'IIS:\sites\PSDSCPullServer'
            DependsOn = '[xDSCWebService]PSDSCPullServer'
        }
        xWebConfigKeyValue CorrectDBConnectionStr
        {
            ConfigSection = 'AppSettings'
            Key = 'dbconnectionstr'
            Value = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Program Files\WindowsPowerShell\DscService\Devices.mdb;'
            WebsitePath = 'IIS:\sites\PSDSCPullServer'
            DependsOn = '[xDSCWebService]PSDSCPullServer'
        }

        # Stop the default website
        xWebsite StopDefaultSite
        {
            Ensure = 'Present'
            Name = 'Default Web Site'
            State = 'Stopped'
            PhysicalPath = 'C:\inetpub\wwwroot'
            DependsOn = '[WindowsFeature]DSCServiceFeature'
        }
    }
}

$configData = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            ServerName = $ServerName
            DomainName = $DomainName
            CARootName = $CARootName
            CAServerFQDN = $CAServerFQDN
            CertSubject = $CertSubject
            AutoRenew = $true
            SMBShare = $SMBShare
            Credential = $Credential
            RebootNodeifNeeded = $true
            CertificateFile = 'c:\PullServerConfig\Cert.cer'
            Thumbprint = 'B9A39921918B466EB1ADF2509E00F5DECB2EFDA9'
            }
        )
    }

PullServer -ConfigurationData $configData -OutputPath 'C:\PullServerConfig\'
Set-DscLocalConfigurationManager -ComputerName localhost -Path 'C:\PullServerConfig\'
Start-DscConfiguration -Wait -Force -Verbose -Path 'C:\PullServerConfig\'

# .\Script.ps1 -ServerName web1 -domainname 'test.pha' -carootname 'test-dc01-ca' -caserverfqdn 'dc01.test.pha' -certsubject 'CN=service.test.pha' -smbshare '\\sofs1.test.pha\share'
```

### Verify pull server functionality

```powershell
# This function is meant to simplify a check against a DSC pull server. If you do not use the
# default service URL, you will need to adjust accordingly.
function Verify-DSCPullServer ($fqdn) {
    ([xml](Invoke-WebRequest "https://$($fqdn):8080/psdscpullserver.svc" | % Content)).service.workspace.collection.href
}

Verify-DSCPullServer 'INSERT SERVER FQDN'
```

```output
Expected Result:
Action
Module
StatusReport
Node
```

### Configure clients

```powershell
Configuration PullClient {
    param(
    $ID,
    $Server
    )
        LocalConfigurationManager
                {
                    ConfigurationID = $ID;
                    RefreshMode = 'PULL';
                    DownloadManagerName = 'WebDownloadManager';
                    RebootNodeIfNeeded = $true;
                    RefreshFrequencyMins = 30;
                    ConfigurationModeFrequencyMins = 15;
                    ConfigurationMode = 'ApplyAndAutoCorrect';
                    DownloadManagerCustomData = @{ServerUrl = "http://"+$Server+":8080/PSDSCPullServer.svc"; AllowUnsecureConnection = $true}
                }
}

PullClient -ID 'INSERTGUID' -Server 'INSERTSERVER' -Output 'C:\DSCConfig\'
Set-DscLocalConfigurationManager -ComputerName 'Localhost' -Path 'C:\DSCConfig\' -Verbose
```

## Additional references, snippets, and examples

This example shows how to manually initiate a client connection (requires WMF5) for testing.

```powershell
Update-DscConfiguration –Wait -Verbose
```

The [Add-DnsServerResourceRecordName](/powershell/module/dnsserver/add-dnsserverresourcerecordcname)
cmdlet is used to add a type CNAME record to a DNS zone.

The PowerShell Function to
[Create a Checksum and Publish DSC MOF to SMB Pull Server](https://gallery.technet.microsoft.com/scriptcenter/PowerShell-Function-to-3bc4b7f0)
automatically generates the required checksum, and then copies both the MOF configuration and
checksum files to the SMB pull server.

## Appendix - Understanding ODATA service data file types

A data file is stored to create information during deployment of a pull server that includes the
OData web service. The type of file depends on the operating system, as described below.

- **Windows Server 2012** - The file type will always be `.mdb`
- **Windows Server 2012 R2** - The file type will default to `.edb` unless a `.mdb` is specified in
  the configuration

In the [Advanced example script](https://github.com/mgreenegit/Whitepapers/blob/Dev/PullServerCPIG.md#installation-and-configuration-scripts)
for installing a Pull Server, you will also find an example of how to automatically control the
web.config file settings to prevent any chance of error caused by file type.
