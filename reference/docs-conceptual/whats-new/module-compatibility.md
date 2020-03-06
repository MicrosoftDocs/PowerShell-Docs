---
title: PowerShell 7 module compatibility
ms.date: 02/03/2020
---

# PowerShell 7 module compatibility

This article contains a list of PowerShell modules published by Microsoft. This modules provide
management and support for various Microsoft products and services. These modules have been update
to work natively with PowerShell 7 or tested for compatibility with PowerShell 7. This list will be
updated with new information as more modules are identified and tested.

If you have information to share or issues with specific modules, please file an issue in the
[WindowsCompatibility repo](https://github.com/PowerShell/WindowsCompatibility).

## Windows management modules

The Windows management module are installed in different ways dependent on the Edition of Windows
and how the module was packaged for that Edition.

On Windows Server, use the feature name with the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature)
cmdlet as an Administrator. For example:

```powershell
Install-WindowsFeature -Name ActiveDirectory
```

On Windows 10, you have to use one of two cmdlets as an Administrator:
- [Enable-WindowsOptionalFeature](/powershell/module/dism/enable-windowsoptionalfeature)
- [Add-WindowsCapability](/powershell/module/dism/add-windowscapability)

For modules that install as Windows Features:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName FooFeatureName
```

For modules that install as Windows Capabilities you have to append `~~~~0.0.1.0` to the end of the
name. For example:

```powershell
Add-WindowsCapability -Online -Name Rsat.ServerManager.Tools~~~~0.0.1.0
```

### ActiveDirectory

Status: Natively Compatible

Availability:

- Server version: 1809+ with RSAT-AD-PowerShell
- Windows 10 version: 1809+ with Rsat.ActiveDirectory.DS-LDS.Tools

### ADFS

Status: Untested with Compatibility Layer

### AppBackgroundTask

Status: Natively Compatible

Availability:

- Windows 10 version: 1903+

### AppLocker

Status: Untested with Compatibility Layer

### AppvClient

Status: Untested with Compatibility Layer

### Appx

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### AssignedAccess

Status: Natively Compatible

Availability:

- Windows 10 version: 1809+

### BestPractices

Status: Untested with Compatibility Layer

### BitLocker

Status: Natively Compatible

Availability:

- Server version: 1809+ with BitLocker
- Windows 10 version: 1809+

### BitsTransfer

Status: Natively Compatible

Availability:

- Server version: 20H1
- Windows 10 version: 20H1

### BootEventCollector

Status: Untested with Compatibility Layer

### BranchCache

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### CimCmdlets

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### ClusterAwareUpdating

Status: Untested with Compatibility Layer

### ConfigCI

Status: Untested with Compatibility Layer

### Defender

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### DeliveryOptimization

Status: Natively Compatible

Availability:

- Server version: 1903+
- Windows 10 version: 1903+

### DFSN

Status: Natively Compatible

Availability:

- Server version: 1809+ with FS-DFS-Namespace
- Windows 10 version: 1809+ with Rsat.FailoverCluster.Management.Tools

### DFSR

Status: Untested with Compatibility Layer

### DhcpServer

Status: Untested with Compatibility Layer

### DirectAccessClientComponents

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### Dism

Status: Natively Compatible

Availability:

- Server version: 1903+
- Windows 10 version: 1903+

### DnsClient

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### DnsServer

Status: Natively Compatible

Availability:

- Server version: 1809+ with DNS or RSAT-DNS-Server
- Windows 10 version: 1809+ with Rsat.Dns.Tools

### EventTracingManagement

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### FailoverClusters

Status: Untested with Compatibility Layer

### FailoverClusterSet

Status: Untested with Compatibility Layer

### FileServerResourceManager

Status: Natively Compatible

Availability:

- Server version: 1809+ with FS-Resource-Manager

### GroupPolicy

Status: Untested with Compatibility Layer

### HgsClient

Status: Natively Compatible

Availability:

- Server version: 1903+ with Hyper-V or RSAT-Shielded-VM-Tools
- Windows 10 version: 1903+ with Rsat.Shielded.VM.Tools

### HgsDiagnostics

Status: Natively Compatible

Availability:

- Server version: 1809+ with Hyper-V or RSAT-Shielded-VM-Tools
- Windows 10 version: 1809+ with Rsat.Shielded.VM.Tools

### Hyper-V

Status: Natively Compatible

Availability:

- Server version: 1809+ with Hyper-V-PowerShell
- Windows 10 version: 1809+ with Microsoft-Hyper-V-Management-PowerShell

### IISAdministration

Status: Untested with Compatibility Layer

### International

Status: Natively Compatible

Availability:

- Server version: 1903+
- Windows 10 version: 1903+

### IpamServer

Status: Untested with Compatibility Layer

### iSCSI

Status: Untested with Compatibility Layer

### IscsiTarget

Status: Untested with Compatibility Layer

### ISE

Status: Untested with Compatibility Layer

### Kds

Status: Natively Compatible

Availability:

- Server version: 20H1
- Windows 10 version: 20H1

### Microsoft.PowerShell.Archive

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.PowerShell.Diagnostics

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.PowerShell.Host

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.PowerShell.LocalAccounts

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### Microsoft.PowerShell.Management

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.PowerShell.ODataUtils

Status: Untested with Compatibility Layer

### Microsoft.PowerShell.Security

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.PowerShell.Utility

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### Microsoft.WSMan.Management

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### MMAgent

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### MPIO

Status: Natively Compatible

Availability:

- Server version: 1809+ with Multipath-IO

### MsDtc

Status: Untested with Compatibility Layer

### NetAdapter

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetConnection

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetEventPacketCapture

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetLbfo

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetLldpAgent

Status: Untested with Compatibility Layer

### NetNat

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetQos

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetSecurity

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetSwitchTeam

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetTCPIP

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetWNV

Status: Untested with Compatibility Layer

### NetworkConnectivityStatus

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetworkController

Status: Untested with Compatibility Layer

### NetworkControllerDiagnostics

Status: Untested with Compatibility Layer

### NetworkLoadBalancingClusters

Status: Untested with Compatibility Layer

### NetworkSwitchManager

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NetworkTransition

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### NFS

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+ with Rsat.ServerManager.Tools

### PackageManagement

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### PcsvDevice

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### PersistentMemory

Status: Untested with Compatibility Layer

### PKI

Status: Untested with Compatibility Layer

### PnpDevice

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### PowerShellGet

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### PrintManagement

Status: Natively Compatible

Availability:

- Server version: 1903+ with Print-Services
- Windows 10 version: 1903+

### ProcessMitigations

Status: Natively Compatible

Availability:

- Server version: 1903+
- Windows 10 version: 1903+

### Provisioning

Status: Untested with Compatibility Layer

### PSDesiredStateConfiguration

Status: Partially

Availability:

- Built into PowerShell 7

### PSDiagnostics

Status: Natively Compatible

Availability:

- Built into PowerShell 7

### PSScheduledJob

Status: Not working with Compatibility Layer

Availability:

- Built into PowerShell 5.1

### PSWorkflow

Status: Untested with Compatibility Layer

### PSWorkflowUtility

Status: Untested with Compatibility Layer

### RemoteAccess

Status: Untested with Compatibility Layer

### RemoteDesktop

Status: Untested with Compatibility Layer

### ScheduledTasks

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### SecureBoot

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### ServerCore

Status: Untested with Compatibility Layer

### ServerManager

Status: Untested with Compatibility Layer

### ServerManagerTasks

Status: Untested with Compatibility Layer

### ShieldedVMDataFile

Status: Natively Compatible

Availability:

- Server version: 1903+ with RSAT-Shielded-VM-Tools
- Windows 10 version: 1903+ with Rsat.Shielded.VM.Tools

### ShieldedVMProvisioning

Status: Natively Compatible

Availability:

- Server version: 1809+ with HostGuardian
- Windows 10 version: 1809+ with HostGuardian

### ShieldedVMTemplate

Status: Natively Compatible

Availability:

- Server version: 1809+ with RSAT-Shielded-VM-Tools
- Windows 10 version: 1809+ with Rsat.Shielded.VM.Tools

### SmbShare

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### SmbWitness

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### SMISConfig

Status: Natively Compatible

Availability:

- Server version: 1903+ with WindowsStorageManagementService

### SMS

Status: Untested with Compatibility Layer

### SoftwareInventoryLogging

Status: Natively Compatible

Availability:

- Server version: 1809+

### StartLayout

Status: Natively Compatible

Availability:

- Server version: 1809+ with Desktop Experience
- Windows 10 version: 1809+

### Storage

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### StorageBusCache

Status: Untested with Compatibility Layer

### StorageMigrationService

Status: Untested with Compatibility Layer

### StorageQOS

Status: Natively Compatible

Availability:

- Server version: 1809+ with RSAT-Clustering-PowerShell
- Windows 10 version: 1809+ with Rsat.FailoverCluster.Management.Tools

### StorageReplica

Status: Untested with Compatibility Layer

### SyncShare

Status: Natively Compatible

Availability:

- Server version: 1809+ with FS-SyncShareService

### SystemInsights

Status: Untested with Compatibility Layer

### TLS

Status: Untested with Compatibility Layer

### TroubleshootingPack

Status: Natively Compatible

Availability:

- Windows 10 version: 1903+

### TrustedPlatformModule

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### UEV

Status: Natively Compatible

Availability:

- Server version: ??Future version of Server with Desktop Experience??
- Windows 10 version: 1903+

### UpdateServices

Status: Not working with Compatibility Layer

### VpnClient

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### Wdac

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### WebAdministration

Status: Untested with Compatibility Layer

### WHEA

Status: Natively Compatible

Availability:

- Server version: 1903+
- Windows 10 version: 1903+

### WindowsDeveloperLicense

Status: Natively Compatible

Availability:

- Server version: 1809+ with Desktop Experience
- Windows 10 version: 1809+

### WindowsErrorReporting

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### WindowsSearch

Status: Natively Compatible

Availability:

- Windows 10 version: 1903+

### WindowsServerBackup

Status: Natively Compatible

Availability:

- Server version: 19H2 with Windows-Server-Backup

### WindowsUpdate

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+

### WindowsUpdateProvider

Status: Natively Compatible

Availability:

- Server version: 1809+
- Windows 10 version: 1809+
