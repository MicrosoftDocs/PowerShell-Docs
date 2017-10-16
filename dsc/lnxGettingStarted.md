---
ms.date:  2017-06-12
author:  eslesar
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Get started with Desired State Configuration (DSC) for Linux
---

# Get started with Desired State Configuration (DSC) for Linux

This topic explains how to get started using PowerShell Desired State Configuration (DSC) for Linux. For general information about DSC, see [Get Started with Windows PowerShell Desired State Configuration](overview.md).

## Supported Linux operation system versions

The following Linux operating system versions are supported for DSC for Linux.
- CentOS 5, 6, and 7 (x86/x64)
- Debian GNU/Linux 6 and 7 (x86/x64)
- Oracle Linux 5, 6 and 7 (x86/x64)
- Red Hat Enterprise Linux Server 5, 6 and 7 (x86/x64)
- SUSE Linux Enterprise Server 10, 11 and 12 (x86/x64)
- Ubuntu Server 12.04 LTS and 14.04 LTS (x86/x64)

The following table describes the required package dependencies for DSC for Linux.

|  Required package |  Description |  Minimum version | 
|---|---|---|
| glibc| GNU Library| 2…4 – 31.30| 
| python| Python| 2.4 – 3.4| 
| omiserver| Open Management Infrastructure| 1.0.8.1| 
| openssl| OpenSSL Libraries| 0.9.8 or 1.0| 
| ctypes| Python CTypes library| Must match Python version| 
| libcurl| cURL http client library| 7.15.1| 

## Installing DSC for Linux

You must install the [Open Management Infrastructure (OMI)](https://github.com/Microsoft/omi) before installing DSC for Linux.

### Installing OMI

Desired State Configuration for Linux requires the Open Management Infrastructure (OMI) CIM server, version 1.0.8.1 or later. OMI can be downloaded from The Open Group: [Open Management Infrastructure (OMI)](https://github.com/Microsoft/omi).

To install OMI, install the package that is appropriate for your Linux system (.rpm or .deb) and OpenSSL version (ssl_098 or ssl_100), and architecture (x64/x86). RPM packages are appropriate for CentOS, Red Hat Enterprise Linux, SUSE Linux Enterprise Server, and Oracle Linux. DEB packages are appropriate for Debian GNU/Linux and Ubuntu Server. The ssl_098 packages are appropriate for computers with OpenSSL 0.9.8 installed while the ssl_100 packages are appropriate for computers with OpenSSL 1.0 installed.

> **Note**: To determine the installed OpenSSL version, run the command `openssl version`.

Run the following command to install OMI on a CentOS 7 x64 system.

`# sudo rpm -Uvh omiserver-1.0.8.ssl_100.rpm`

### Installing DSC

DSC for Linux is available for download [here](https://github.com/Microsoft/PowerShell-DSC-for-Linux/releases/latest). 

To install DSC, install the package that is appropriate for your Linux system (.rpm or .deb) and OpenSSL version (ssl_098 or ssl_100), and architecture (x64/x86). RPM packages are appropriate for CentOS, Red Hat Enterprise Linux, SUSE Linux Enterprise Server, and Oracle Linux. DEB packages are appropriate for Debian GNU/Linux and Ubuntu Server. The ssl_098 packages are appropriate for computers with OpenSSL 0.9.8 installed while the ssl_100 packages are appropriate for computers with OpenSSL 1.0 installed.

> **Note**: To determine the installed OpenSSL version, run the command openssl version.
 
Run the following command to install DSC on a CentOS 7 x64 system.

`# sudo rpm -Uvh dsc-1.0.0-254.ssl_100.x64.rpm`


## Using DSC for Linux

The following sections explain how to create and run DSC configurations on Linux computers.

### Creating a configuration MOF document

The Windows PowerShell Configuration keyword is used to create a configuration for Linux computers, just like for Windows computers. The following steps describe the creation of a configuration document for a Linux computer using Windows PowerShell.

1. Import the nx module. The nx Windows PowerShell module contains the schema for Built-In resources for DSC for Linux, and must be installed to your local computer and imported in the configuration.

    -To install the nx module, copy the nx module directory to either `$env:USERPROFILE\Documents\WindowsPowerShell\Modules\` or `$PSHOME\Modules`. The nx module is included in the DSC for Linux installation package (MSI). To import the nx module in your configuration, use the __Import-DSCResource__ command:
    
```powershell
Configuration ExampleConfiguration{
   
    Import-DSCResource -Module nx

}
```
2. Define a configuration and generate the configuration document:

```powershell
Configuration ExampleConfiguration{
   
    Import-DscResource -Module nx
 
    Node  "linuxhost.contoso.com"{
    nxFile ExampleFile {

        DestinationPath = "/tmp/example"
        Contents = "hello world `n"
        Ensure = "Present"
        Type = "File"
    }

    }
}
ExampleConfiguration -OutputPath:"C:\temp" 
```

### Push the configuration to the Linux computer

Configuration documents (MOF files) can be pushed to the Linux computer using the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet. In order to use this cmdlet, along with the [Get-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407379.aspx), or [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) cmdlets, remotely to a Linux computer, you must use a CIMSession. The [New-CimSession](http://go.microsoft.com/fwlink/?LinkId=227967) cmdlet is used to create a CIMSession to the Linux computer.

The following code shows how to create a CIMSession for DSC for Linux.

```powershell
$Node = "ostc-dsc-01"
$Credential = Get-Credential -UserName:"root" -Message:"Enter Password:"

#Ignore SSL certificate validation
#$opt = New-CimSessionOption -UseSsl:$true -SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true

#Options for a trusted SSL certificate
$opt = New-CimSessionOption -UseSsl:$true 
$Sess=New-CimSession -Credential:$credential -ComputerName:$Node -Port:5986 -Authentication:basic -SessionOption:$opt -OperationTimeoutSec:90 
```

> **Note**:
* For “Push” mode, the user credential must be the root user on the Linux computer.
* Only SSL/TLS connections are supported for DSC for Linux, the New-CimSession must be used with the –UseSSL parameter set to $true.
* The SSL certificate used by OMI (for DSC) is specified in the file: `/opt/omi/etc/omiserver.conf` with the properties: pemfile and keyfile.
If this certificate is not trusted by the Windows computer that you are running the [New-CimSession](http://go.microsoft.com/fwlink/?LinkId=227967) cmdlet on, you can choose to ignore certificate validation with the CIMSession Options: `-SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true`

Run the following command to push the DSC configuration to the Linux node.

`Start-DscConfiguration -Path:"C:\temp" -CimSession:$Sess -Wait -Verbose`

### Distribute the configuration with a pull server

Configurations can be distributed to a Linux computer with a pull server, just like for Windows computers. For guidance on using a pull server, see [Windows PowerShell Desired State Configuration Pull Servers](pullServer.md). For additional information and limitations related to using Linux computers with a pull server, see the Release Notes for Desired State Configuration for Linux.

### Working with configurations locally

DSC for Linux includes scripts to work with configuration from the local Linux computer. These scripts are locate in `/opt/microsoft/dsc/Scripts` and include the following:
* GetDscConfiguration.py

 Returns the current configuration applied to the computer. Similar to the Windows PowerShell cmdlet Get-DscConfiguration cmdlet.

`# sudo ./GetDscConfiguration.py`

* GetDscLocalConfigurationManager.py

 Returns the current meta-configuration applied to the computer. Similar to the cmdlet [Get-DSCLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn407378.aspx) cmdlet.

`# sudo ./GetDscLocalConfigurationManager.py`

* InstallModule.py

 Installs a custom DSC resource module. Requires the path to a .zip file containing the module shared object library and schema MOF files.

`# sudo ./InstallModule.py /tmp/cnx_Resource.zip`

* RemoveModule.py

 Removes a custom DSC resource module. Requires the name of the module to remove.

`# sudo ./RemoveModule.py cnx_Resource`

* StartDscLocalConfigurationManager.py 

 Applies a configuration MOF file to the computer. Similar to the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet. Requires the path to the configuration MOF to apply.

`# sudo ./StartDscLocalConfigurationManager.py –configurationmof /tmp/localhost.mof`

* SetDscLocalConfigurationManager.py

 Applies a Meta Configuration MOF file to the computer. Similar to the [Set-DSCLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn521621.aspx) cmdlet. Requires the path to the Meta Configuration MOF to apply.

`# sudo ./SetDscLocalConfigurationManager.py –configurationmof /tmp/localhost.meta.mof`

## PowerShell Desired State Configuration for Linux Log Files

The following log files are generated for DSC for Linux messages.

|Log file|Directory|Description|
|---|---|---|
|omiserver.log|/var/opt/omi/log|Messages relating to the operation of the OMI CIM server.|
|dsc.log|/var/opt/omi/log|Messages relating to the operation of the Local Configuration Manager (LCM) and DSC resource operations.|

