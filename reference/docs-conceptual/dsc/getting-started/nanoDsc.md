---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Using DSC on Nano Server
description: DSC is an optional package that can be installed when you create a VHD for a Windows Nano Server.
---

# Using DSC on Nano Server

> Applies To: Windows PowerShell 5.0

**DSC on Nano Server** is an optional package in the `NanoServer\Packages` folder of the Windows
Server 2016 media. The package can be installed when you create a VHD for a Nano Server by
specifying **Microsoft-NanoServer-DSC-Package** as the value of the **Packages** parameter of the
**New-NanoServerImage** function. For example, if you are creating a VHD for a virtual machine, the
command would look like the following:

```powershell
New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1\Nano.vhd -ComputerName Nano1 -Packages Microsoft-NanoServer-DSC-Package
```

For information about installing and using Nano Server, as well as how to manage Nano Server with
PowerShell Remoting, see
[Getting Started with Nano Server](/windows-server/get-started/getting-started-with-nano-server).

## DSC features available on Nano Server

Because Nano Server supports only a limited set of APIs compared to a full version of Windows
Server, DSC on Nano Server does not have full functional parity with DSC running on full SKUs for
the time being. DSC on Nano Server is in active development and is not yet feature complete.

The following DSC features are currently available on Nano Server:

Both push and pull modes

- All DSC cmdlets that exist on a full version of Windows Server, including the following:
- [Get-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Get-DscLocalConfigurationManager)
- [Set-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Set-DscLocalConfigurationManager)
- [Enable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Enable-DscDebug)
- [Disable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Disable-DscDebug)
- [Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
- [Stop-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Stop-DscConfiguration)
- [Get-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Get-DscConfiguration)
- [Test-DscConfiguration](/powershell/module/psdesiredstateconfiguration/Test-DSCConfiguration)
- [Publish-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Publish-DscConfiguration)
- [Update-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Update-DscConfiguration)
- [Restore-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Restore-DscConfiguration)
- [Remove-DscConfigurationDocument](/powershell/module/PSDesiredStateConfiguration/Remove-DscConfigurationDocument)
- [Get-DscConfigurationStatus](/powershell/module/PSDesiredStateConfiguration/Get-DscConfigurationStatus)
- [Invoke-DscResource](/powershell/module/PSDesiredStateConfiguration/Invoke-DscResource)
- [Find-DscResource](/powershell/module/powershellget/find-dscresource)
- [Get-DscResource](/powershell/module/PSDesiredStateConfiguration/Get-DscResource)
- [New-DscChecksum](/powershell/module/PSDesiredStateConfiguration/New-DSCCheckSum)

- Compiling configurations (see [DSC configurations](../configurations/configurations.md))

  **Issue:** Password encryption (see [Securing the MOF File](../pull-server/secureMOF.md)) during
  configuration compilation doesn't work.

- Compiling metaconfigurations (see
  [Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md))

- Running a resource under user context (see
  [Running DSC with user credentials (RunAs)](../configurations/runAsUser.md))

- Class-based resources (see
  [Writing a custom DSC resource with PowerShell classes](/previous-versions//dn948461(v=technet.10)))

- Debugging of DSC resources (see [Debugging DSC resources](../troubleshooting/debugResource.md))

  **Issue:** Doesn't work if a resource is using PsDscRunAsCredential (see
  [Running DSC with user credentials](../configurations/runAsUser.md))

- [Specifying cross-node dependencies](../configurations/crossNodeDependencies.md)

- [Resource versioning](../configurations/sxsResource.md)

- Pull client (configurations & resources) (see
  [Setting up a pull client using configuration names](../pull-server/pullClientConfigNames.md))

- [Partial configurations (pull & push)](../pull-server/partialConfigs.md)

- [Reporting to pull server](../pull-server/reportServer.md)

- MOF encryption

- Event logging

- Azure Automation DSC reporting

- Resources that are fully functional

  - **Archive**
  - **Environment**
  - **File**
  - **Log**
  - **ProcessSet**
  - **Registry**
  - **Script**
  - **WindowsPackageCab**
  - **WindowsProcess**
  - **WaitForAll** (see [Specifying cross-node dependencies](../configurations/crossNodeDependencies.md))
  - **WaitForAny** (see [Specifying cross-node dependencies](../configurations/crossNodeDependencies.md))
  - **WaitForSome** (see [Specifying cross-node dependencies](../configurations/crossNodeDependencies.md))

- Resources that are partially functional

  - **Group**
  - **GroupSet**

    **Issue:** Above resources fail if specific instance is called twice (running the same
    configuration twice)

  - **Service**
  - **ServiceSet**

    **Issue:** Only works for starting/stopping (status) service. Fails, if one tries to change
    other service attributes like startuptype, credentials, description etc.. The error thrown is
    similar to:

    ```
    Cannot find type [management.managementobject]: verify that the assembly containing this type is loaded.
    ```

- Resources that are not functional

  - **User**

## DSC features not available on Nano Server

The following DSC features are not currently available on Nano Server:

- Decrypting MOF document with encrypted password(s)
- Pull Server--you cannot currently set up a pull server on Nano Server
- Anything that is not in the list of feature works

## Using custom DSC resources on Nano Server

Due to a limited sets of Windows APIs and CLR libraries available on Nano Server, DSC resources that work on the full CLR version of Windows do not necessarily work on Nano Server.
Complete end-to-end testing before deploying any DSC custom resources to a production environment.

## See Also

- [Getting Started with Nano Server](/windows-server/get-started/getting-started-with-nano-server)
