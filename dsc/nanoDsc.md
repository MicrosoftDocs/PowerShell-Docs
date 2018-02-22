---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Using DSC on Nano Server
---

# Using DSC on Nano Server

> Applies To: Windows PowerShell 5.0

**DSC on Nano Server** is an optional package in the `NanoServer\Packages` folder of the Windows Server 2016 media. The package can be installed when you create a VHD for a Nano Server by
specifying **Microsoft-NanoServer-DSC-Package** as the value of the **Packages** parameter of the **New-NanoServerImage** function. For example, if you are creating a VHD for a virtual
machine, the command would look like the following:

```powershell
New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1\Nano.vhd -ComputerName Nano1 -Packages Microsoft-NanoServer-DSC-Package
```

For information about installing and using Nano Server, as well as how to manage Nano Server with PowerShell Remoting, see 
[Getting Started with Nano Server](https://technet.microsoft.com/library/mt126167.aspx).


## DSC features available on Nano Server

 Because Nano Server supports only a limited set of APIs compared to a full version of Windows Server, DSC on Nano Server does not have full functional parity with DSC running on 
 full SKUs for the time being. DSC on Nano Server is in active development and is not yet feature complete.
 
 The following DSC features are currently available on Nano Server: 


* Both push and pull modes

* All DSC cmdlets that exist on a full version of Windows Server, including the following: 
  * [Get-DscLocalConfigurationManager](https://technet.microsoft.com/library/dn407378.aspx)
  * [Set-DscLocalConfigurationManager](https://technet.microsoft.com/library/dn521621.aspx)  	
  * [Enable-DscDebug](https://technet.microsoft.com/en-us/library/mt517870.aspx)
  * [Disable-DscDebug](https://technet.microsoft.com/en-us/library/mt517872.aspx)		
  * [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx)
  * [Stop-DscConfiguration](https://technet.microsoft.com/en-us/library/mt143542.aspx)
  * [Get-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407379.aspx)
  * [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx)		
  * [Publish-DscConfiguraiton](https://technet.microsoft.com/en-us/library/mt517875.aspx) 
  * [Update-DscConfiguration](https://technet.microsoft.com/en-us/library/mt143541.aspx)
  * [Restore-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407383.aspx)
  * [Remove-DscConfigurationDocument](https://technet.microsoft.com/en-us/library/mt143544.aspx)
  * [Get-DscConfigurationStatus](https://technet.microsoft.com/en-us/library/mt517868.aspx)
  * [Invoke-DscResource](https://technet.microsoft.com/en-us/library/mt517869.aspx)
  * [Find-DscResource](https://technet.microsoft.com/en-us/library/mt517874.aspx)
  * [Get-DscResource](https://technet.microsoft.com/en-us/library/dn521625.aspx)
  * [New-DscChecksum](https://technet.microsoft.com/en-us/library/dn521622.aspx) 	

* Compiling configurations (see [DSC configurations](configurations.md))

  **Issue:** Password encryption (see [Securing the MOF File](securemof.md)) during configuration compilation doesn't work.

* Compiling metaconfigurations (see [Configuring the Local Configuration Manager](metaConfig.md))

* Running a resource under user context (see [Running DSC with user credentials (RunAs)](runAsUser.md))

* Class-based resources (see [Writing a custom DSC resource with PowerShell classes](authoringResourceClass.md))

* Debugging of DSC resources (see [Debugging DSC resources](debugresource.md))
  
  **Issue:** Doesn't work if a resource is using PsDscRunAsCredential (see [Running DSC with user credentials](runAsUser.md))

* [Specifying cross-node dependencies](crossNodeDependencies.md) 

* [Resource versioning](sxsResource.md)

* Pull client (configurations & resources) (see [Setting up a pull client using configuration names](pullClientConfigNames.md))

* [Partial configurations (pull & push)](partialConfigs.md)

* [Reporting to pull server](reportServer.md) 

* MOF encryption

* Event logging

* Azure Automation DSC reporting

* Resources that are fully functional
  * [Archive](archiveResource.md)
  * [Environment](environmentResource.md)
  * [File](fileResource.md)
  * [Log](logResource.md)
  * ProcessSet
  * [Registry](registryResource.md)
  * [Script](scriptResource.md)
  * WindowsPackageCab
  * [WindowsProcess](windowsProcessResource.md)
  * WaitForAll (see [Specifying cross-node dependencies](crossNodeDependencies.md))
  * WaitForAny (see [Specifying cross-node dependencies](crossNodeDependencies.md))
  * WaitForSome (see [Specifying cross-node dependencies](crossNodeDependencies.md))

* Resources that are partially functional
  * [Group](groupResource.md)
  * GroupSet
  
  **Issue:** Above resources fail if specific instance is called twice (running the same configuration twice)
  
  * [Service](serviceResource.md)
  * ServiceSet
  
  **Issue:** Only works for starting/stopping (status) service. Fails, if one tries to change other service attributes like startuptype, credentials, description etc.. The error thrown is similar to:
  
  *Cannot find type [management.managementobject]: verify that the assembly containing this type is loaded.*
  
* Resources that are not functional
  * [User](userResource.md)
  

## DSC features not available on Nano Server

The following DSC features are not currently available on Nano Server:

* Decrypting MOF document with encrypted password(s) 
* Pull Server--you cannot currently set up a pull server on Nano Server
* Anything that is not in the list of feature works

## Using custom DSC resources on Nano Server
 
Due to a limited sets of Windows APIs and CLR libraries available on Nano Server, DSC resources that work on the full CLR version of Windows do not necessarily work on Nano Server. 
Complete end-to-end testing before deploying any DSC custom resources to a production environment.

## See Also
- [Getting Started with Nano Server](https://technet.microsoft.com/library/mt126167.aspx)

