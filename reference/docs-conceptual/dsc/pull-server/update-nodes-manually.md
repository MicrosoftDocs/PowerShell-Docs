---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Update Nodes from a Pull Server
description: This article explains how to update DSC managed nodes from a Pull Server
---

# Update Nodes from a Pull Server

The sections below assume that you have already set up a Pull Server. If you have not set up your
Pull Server, you can use the following guides:

- [Set up a DSC SMB Pull Server](pullServerSmb.md)
- [Set up a DSC HTTP Pull Server](pullServer.md)

Each target node can be configured to download configurations, resources, and even report its
status. This article will show you how to upload resources so they are available to be downloaded,
and configure clients to download resources automatically. When the Node's receives an assigned
Configuration, through **Pull** or **Push** (v5), it automatically downloads any resources required
by the Configuration from the location specified in the LCM.

## Using the Update-DSCConfiguration cmdlet

Beginning in PowerShell 5.0, the
[Update-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/update-dscconfiguration)
cmdlet, forces a Node to update its configuration from the Pull Server configured in the LCM.

```powershell
Update-DSCConfiguration -ComputerName "Server01"
```

## Using Invoke-CIMMethod

In PowerShell 4.0, you can still manually force a Pull Client to update its Configuration using
[Invoke-CIMMethod](/powershell/module/cimcmdlets/invoke-cimmethod). The following example creates a
CIM session with specified credentials, invokes the appropriate CIM method, and removes the session.

```powershell
$cimSession = New-CimSession -ComputerName "Server01" -Credential $(Get-Credential)
Invoke-CimMethod -CimSession $cimSession -Namespace 'root/microsoft/windows/desiredstateconfiguration' -Class 'MSFT_DscLocalConfigurationManager' -MethodName 'PerformRequiredConfigurationChecks' -Arguments @{ 'Flags' = [uint32]1 } -Verbose
$cimSession | Remove-CimSession
```

## See Also

[PerformRequiredConfigurationChecks](../reference/mof-classes/msft-dsclocalconfigurationmanager-performrequiredconfigurationchecks.md)
