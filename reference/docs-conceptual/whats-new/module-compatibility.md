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

### Module list

| Module name                        | Status                               | Supported OS                       |
| ---------------------------------- | ------------------------------------ | ---------------------------------- |
| ActiveDirectory                    | Natively Compatible                  | Windows Server 1809+ with RSAT-AD-PowerShell<br>Windows 10 1809+ with Rsat.ActiveDirectory.DS-LDS.Tools |
| ADFS                               | Untested with Compatibility Layer    |                                    |
| AppBackgroundTask                  | Natively Compatible                  | Windows 10 1903+                   |
| AppLocker                          | Untested with Compatibility Layer    |                                    |
| AppvClient                         | Untested with Compatibility Layer    |                                    |
| Appx                               | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+ |
| AssignedAccess                     | Natively Compatible                  | Windows 10 1809+                   |
| BestPractices                      | Untested with Compatibility Layer    |                                    |
| BitLocker                          | Natively Compatible                  | Windows Server 1809+ with BitLocker<br>Windows 10 1809+ |
| BitsTransfer                       | Natively Compatible                  | Windows Server 20H1<br>Windows 10 20H1 |
| BootEventCollector                 | Untested with Compatibility Layer    |                                        |
| BranchCache                        | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+ |
| CimCmdlets                         | Natively Compatible                  | Built into PowerShell 7 |
| ClusterAwareUpdating               | Untested with Compatibility Layer    |                         |
| ConfigCI                           | Untested with Compatibility Layer    |                         |
| Defender                           | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+  |
| DeliveryOptimization               | Natively Compatible                  | Windows Server 1903+<br>Windows 10 1903+  |
| DFSN                               | Natively Compatible                  | Windows Server 1809+ with FS-DFS-Namespace<br>Windows 10 1809+ with Rsat.FailoverCluster.Management.Tools |
| DFSR                               | Untested with Compatibility Layer    |                                   |
| DhcpServer                         | Untested with Compatibility Layer    |                                   |
| DirectAccessClientComponents       | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+  |
| Dism                               | Natively Compatible                  | Windows Server 1903+<br>Windows 10 1903+  |
| DnsClient                          | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+  |
| DnsServer                          | Natively Compatible                  | Windows Server 1809+ with DNS or RSAT-DNS-Server<br>Windows 10 1809+ with Rsat.Dns.Tools |
| EventTracingManagement             | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+  |
| FailoverClusters                   | Untested with Compatibility Layer    |                                  |
| FailoverClusterSet                 | Untested with Compatibility Layer    |                                  |
| FileServerResourceManager          | Natively Compatible                  | Windows Server 1809+ with FS-Resource-Manager |
| GroupPolicy                        | Untested with Compatibility Layer    |                                               |
| HgsClient                          | Natively Compatible                  | Windows Server 1903+ with Hyper-V or RSAT-Shielded-VM-Tools<br>Windows 10 1903+ with Rsat.Shielded.VM.Tools |
| HgsDiagnostics                     | Natively Compatible                  | Windows Server 1809+ with Hyper-V or RSAT-Shielded-VM-Tools<br>Windows 10 1809+ with Rsat.Shielded.VM.Tools |
| Hyper-V                            | Natively Compatible                  | Windows Server 1809+ with Hyper-V-PowerShell<br>Windows 10 1809+ with Microsoft-Hyper-V-Management-PowerShell |
| IISAdministration                  | Untested with Compatibility Layer    |                                               |
| International                      | Natively Compatible                  | Windows Server 1903+<br>Windows 10 1903+      |
| IpamServer                         | Untested with Compatibility Layer    |                                               |
| iSCSI                              | Untested with Compatibility Layer    |                                               |
| IscsiTarget                        | Untested with Compatibility Layer    |                                               |
| ISE                                | Untested with Compatibility Layer    |                                               |
| Kds                                | Natively Compatible                  | Windows Server 20H1<br>Windows 10 20H1        |
| Microsoft.PowerShell.Archive       | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.PowerShell.Diagnostics   | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.PowerShell.Host          | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.PowerShell.LocalAccounts | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| Microsoft.PowerShell.Management    | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.PowerShell.ODataUtils    | Untested with Compatibility Layer    |                                               |
| Microsoft.PowerShell.Security      | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.PowerShell.Utility       | Natively Compatible                  | Built into PowerShell 7                       |
| Microsoft.WSMan.Management         | Natively Compatible                  | Built into PowerShell 7                       |
| MMAgent                            | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| MPIO                               | Natively Compatible                  | Windows Server 1809+ with Multipath-IO        |
| MsDtc                              | Untested with Compatibility Layer    |                                               |
| NetAdapter                         | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetConnection                      | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetEventPacketCapture              | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetLbfo                            | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetLldpAgent                       | Untested with Compatibility Layer    |                                               |
| NetNat                             | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetQos                             | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetSecurity                        | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetSwitchTeam                      | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetTCPIP                           | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetWNV                             | Untested with Compatibility Layer    |                                               |
| NetworkConnectivityStatus          | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetworkController                  | Untested with Compatibility Layer    |                                               |
| NetworkControllerDiagnostics       | Untested with Compatibility Layer    |                                               |
| NetworkLoadBalancingClusters       | Untested with Compatibility Layer    |                                               |
| NetworkSwitchManager               | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NetworkTransition                  | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| NFS                                | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+ with Rsat.ServerManager.Tools |
| PackageManagement                  | Natively Compatible                  | Built into PowerShell 7                       |
| PcsvDevice                         | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| PersistentMemory                   | Untested with Compatibility Layer    |                                               |
| PKI                                | Untested with Compatibility Layer    |                                               |
| PnpDevice                          | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| PowerShellGet                      | Natively Compatible                  | Built into PowerShell 7                       |
| PrintManagement                    | Natively Compatible                  | Windows Server 1903+ with Print-Services<br>Windows 10 1903+  |
| ProcessMitigations                 | Natively Compatible                  | Windows Server 1903+<br>Windows 10 1903+      |
| Provisioning                       | Untested with Compatibility Layer    |                                               |
| PSDesiredStateConfiguration        | Partially                            | Built into PowerShell 7                       |
| PSDiagnostics                      | Natively Compatible                  | Built into PowerShell 7                       |
| PSScheduledJob                     | Not working with Compatibility Layer | Built into PowerShell 5.1                     |
| PSWorkflow                         | Untested with Compatibility Layer    |                                               |
| PSWorkflowUtility                  | Untested with Compatibility Layer    |                                               |
| RemoteAccess                       | Untested with Compatibility Layer    |                                               |
| RemoteDesktop                      | Untested with Compatibility Layer    |                                               |
| ScheduledTasks                     | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| SecureBoot                         | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| ServerCore                         | Untested with Compatibility Layer    |                                               |
| ServerManager                      | Untested with Compatibility Layer    |                                               |
| ServerManagerTasks                 | Untested with Compatibility Layer    |                                               |
| ShieldedVMDataFile                 | Natively Compatible                  | Windows Server 1903+ with RSAT-Shielded-VM-Tools<br>Windows 10 1903+ with Rsat.Shielded.VM.Tools |
| ShieldedVMProvisioning             | Natively Compatible                  | Windows Server 1809+ with HostGuardian<br>Windows 10 1809+ with HostGuardian  |
| ShieldedVMTemplate                 | Natively Compatible                  | Windows Server 1809+ with RSAT-Shielded-VM-Tools<br>Windows 10 1809+ with Rsat.Shielded.VM.Tools |
| SmbShare                           | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| SmbWitness                         | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| SMISConfig                         | Natively Compatible                  | Windows Server 1903+ with WindowsStorageManagementService |
| SMS                                | Untested with Compatibility Layer    |                                               |
| SoftwareInventoryLogging           | Natively Compatible                  | Windows Server 1809+                          |
| StartLayout                        | Natively Compatible                  | Windows Server 1809+ with Desktop Experience<br>Windows 10 1809+ |
| Storage                            | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| StorageBusCache                    | Untested with Compatibility Layer    |                                               |
| StorageMigrationService            | Untested with Compatibility Layer    |                                               |
| StorageQOS                         | Natively Compatible                  | Windows Server 1809+ with RSAT-Clustering-PowerShell<br>Windows 10 1809+ with Rsat.FailoverCluster.Management.Tools |
| StorageReplica                     | Untested with Compatibility Layer    |                                               |
| SyncShare                          | Natively Compatible                  | Windows Server 1809+ with FS-SyncShareService |
| SystemInsights                     | Untested with Compatibility Layer    |                                               |
| TLS                                | Untested with Compatibility Layer    |                                               |
| TroubleshootingPack                | Natively Compatible                  | Windows 10 1903+                              |
| TrustedPlatformModule              | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| UEV                                | Natively Compatible                  | Windows Server ??Future version of Server with Desktop Experience??<br>Windows 10 1903+ |
| UpdateServices                     | Not working with Compatibility Layer |                                               |
| VpnClient                          | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| Wdac                               | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| WebAdministration                  | Untested with Compatibility Layer    |                                               |
| WHEA                               | Natively Compatible                  | Windows Server 1903+<br>Windows 10 1903+      |
| WindowsDeveloperLicense            | Natively Compatible                  | Windows Server 1809+ with Desktop Experience<br>Windows 10 1809+ |
| WindowsErrorReporting              | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+      |
| WindowsSearch                      | Natively Compatible                  | Windows 10 1903+                              |
| WindowsServerBackup                | Natively Compatible                  | Windows Server 19H2 with Windows-Server-Backup |
| WindowsUpdate                      | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+       |
| WindowsUpdateProvider              | Natively Compatible                  | Windows Server 1809+<br>Windows 10 1809+       |
