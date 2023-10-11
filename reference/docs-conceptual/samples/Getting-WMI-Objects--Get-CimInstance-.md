---
description: This article shows several examples of how to get instances of WMI objects from a computer system.
ms.date: 12/08/2022
title: Getting WMI objects with Get-CimInstance
---
# Getting WMI objects with Get-CimInstance

> This sample only applies to Windows plaforms.

Windows Management Instrumentation (WMI) is a core technology for Windows system administration
because it exposes a wide range of information in a uniform manner. Because of how much WMI makes
possible, the PowerShell cmdlet for accessing WMI objects, `Get-CimInstance`, is one of the most
useful for doing real work. We're going to discuss how to use the CIM cmdlets to access WMI objects
and then how to use WMI objects to do specific things.

## Listing WMI classes

The first problem most WMI users face is trying to find out what can be done with WMI. WMI classes
describe the resources that can be managed. There are hundreds of WMI classes, some of which contain
dozens of properties.

`Get-CimClass` addresses this problem by making WMI discoverable. You can get a list of the WMI
classes available on the local computer by typing:

```powershell
Get-CimClass -Namespace root/CIMV2 | Where-Object CimClassName -like Win32* | Select-Object CimClassName
```

```Output
CimClassName
------------
Win32_DeviceChangeEvent
Win32_SystemConfigurationChangeEvent
Win32_VolumeChangeEvent
Win32_SystemTrace
Win32_ProcessTrace
Win32_ProcessStartTrace
Win32_ProcessStopTrace
Win32_ThreadTrace
Win32_ThreadStartTrace
Win32_ThreadStopTrace
Win32_ModuleTrace
Win32_ModuleLoadTrace
Win32_PowerManagementEvent
Win32_ComputerSystemEvent
Win32_ComputerShutdownEvent
Win32_IP4RouteTableEvent
Win32_OperatingSystem
Win32_Process
Win32_VideoController
Win32_SCSIController
Win32_InfraredDevice
Win32_PCMCIAController
Win32_USBController
Win32_SerialPort
Win32_ParallelPort
Win32_IDEController
Win32_1394Controller
Win32_Processor
Win32_Battery
Win32_PortableBattery
Win32_PnPEntity
Win32_DiskPartition
Win32_CacheMemory
Win32_Volume
Win32_SMBIOSMemory
Win32_MemoryArray
Win32_MemoryDevice
Win32_LogicalDisk
Win32_MappedLogicalDisk
Win32_DiskDrive
Win32_TapeDrive
Win32_CDROMDrive
Win32_TemperatureProbe
Win32_VoltageProbe
Win32_CurrentProbe
Win32_Bus
Win32_Keyboard
Win32_DesktopMonitor
Win32_PointingDevice
Win32_USBHub
Win32_NetworkAdapter
Win32_SoundDevice
Win32_MotherboardDevice
Win32_POTSModem
Win32_HeatPipe
Win32_Refrigeration
Win32_Fan
Win32_Printer
Win32_ComputerSystem
Win32_NTDomain
Win32_BIOS
Win32_SoftwareElement
Win32_Thread
Win32_COMApplication
Win32_DCOMApplication
Win32_ScheduledJob
Win32_PrintJob
Win32_ServerSession
Win32_SoftwareFeature
Win32_OptionalFeature
Win32_DfsNode
Win32_ComponentCategory
Win32_ProgramGroupOrItem
Win32_LogicalProgramGroupItem
Win32_LogicalProgramGroup
Win32_NetworkConnection
Win32_COMClass
Win32_ClassicCOMClass
Win32_Account
Win32_UserAccount
Win32_Group
Win32_SystemAccount
Win32_BaseService
Win32_SystemDriver
Win32_Service
Win32_TerminalService
Win32_PnPSignedDriver
Win32_ApplicationService
Win32_PrinterDriver
Win32_TCPIPPrinterPort
Win32_CommandLineAccess
Win32_SystemMemoryResource
Win32_PortResource
Win32_DeviceMemoryAddress
Win32_IRQResource
Win32_Environment
Win32_DMAChannel
Win32_Share
Win32_ClusterShare
Win32_NetworkProtocol
Win32_ShadowProvider
Win32_QuickFixEngineering
Win32_IP4RouteTable
Win32_ShadowCopy
Win32_LoadOrderGroup
Win32_Session
Win32_LogonSession
Win32_ServerConnection
Win32_DfsTarget
Win32_NetworkClient
Win32_PageFileUsage
Win32_Directory
Win32_ShortcutFile
Win32_CodecFile
Win32_NTEventlogFile
Win32_PageFile
Win32_IP4PersistedRouteTable
Win32_Registry
Win32_BaseBoard
Win32_SystemEnclosure
Win32_PhysicalMemoryArray
Win32_PhysicalMedia
Win32_PhysicalMemory
Win32_OnBoardDevice
Win32_SystemSlot
Win32_PortConnector
Win32_CurrentTime
Win32_LocalTime
Win32_UTCTime
Win32_NTLogEvent
Win32_Perf
Win32_PerfRawData
Win32_PerfFormattedData
Win32_NamedJobObjectActgInfo
Win32_PrivilegesStatus
Win32_JobObjectStatus
Win32_Trustee
Win32_ACE
Win32_SecurityDescriptor
Win32_CollectionStatistics
Win32_NamedJobObjectStatistics
Win32_ActiveRoute
Win32_OfflineFilesUserConfiguration
Win32_AccountSID
Win32_WinSAT
Win32_SecurityDescriptorHelper
Win32_TimeZone
Win32_PageFileSetting
Win32_Desktop
Win32_ShadowContext
Win32_MSIResource
Win32_ServiceControl
Win32_Property
Win32_Patch
Win32_PatchPackage
Win32_Binary
Win32_AutochkSetting
Win32_SerialPortConfiguration
Win32_StartupCommand
Win32_BootConfiguration
Win32_NetworkLoginProfile
Win32_NamedJobObjectLimitSetting
Win32_NamedJobObjectSecLimitSetting
Win32_DisplayConfiguration
Win32_NetworkAdapterConfiguration
Win32_QuotaSetting
Win32_SecuritySetting
Win32_LogicalFileSecuritySetting
Win32_LogicalShareSecuritySetting
Win32_DisplayControllerConfiguration
Win32_WMISetting
Win32_OSRecoveryConfiguration
Win32_COMSetting
Win32_ClassicCOMClassSetting
Win32_DCOMApplicationSetting
Win32_VideoConfiguration
Win32_ODBCAttribute
Win32_ODBCSourceAttribute
Win32_PrinterConfiguration
Win32_ShortcutAction
Win32_ExtensionInfoAction
Win32_CreateFolderAction
Win32_RegistryAction
Win32_ClassInfoAction
Win32_SelfRegModuleAction
Win32_TypeLibraryAction
Win32_BindImageAction
Win32_RemoveIniAction
Win32_MIMEInfoAction
Win32_FontInfoAction
Win32_PublishComponentAction
Win32_MoveFileAction
Win32_DuplicateFileAction
Win32_RemoveFileAction
Win32_ProductResource
Win32_FolderRedirectionHealth
Win32_MountPoint
Win32_OfflineFilesAssociatedItems
Win32_UserProfile
Win32_OfflineFilesChangeInfo
Win32_RoamingProfileMachineConfiguration
Win32_ManagedSystemElementResource
Win32_SoftwareElementResource
Win32_SID
Win32_ActionCheck
Win32_UserDesktop
Win32_DeviceSettings
Win32_PrinterSetting
Win32_NetworkAdapterSetting
Win32_SerialPortSetting
Win32_SystemSetting
Win32_SystemProgramGroups
Win32_SystemBootConfiguration
Win32_SystemTimeZone
Win32_SystemDesktop
Win32_ClassicCOMClassSettings
Win32_VolumeQuota
Win32_WMIElementSetting
Win32_COMApplicationSettings
Win32_VideoSettings
Win32_SecuritySettingOfObject
Win32_SecuritySettingOfLogicalShare
Win32_SecuritySettingOfLogicalFile
Win32_PageFileElementSetting
Win32_OperatingSystemAutochkSetting
Win32_VolumeQuotaSetting
Win32_ProductSoftwareFeatures
Win32_ImplementedCategory
Win32_RoamingProfileUserConfiguration
Win32_InstalledSoftwareElement
Win32_SoftwareFeatureCheck
Win32_LUIDandAttributes
Win32_VolumeUserQuota
Win32_LUID
Win32_DirectorySpecification
Win32_SoftwareElementCondition
Win32_ODBCDriverSpecification
Win32_ServiceSpecification
Win32_FileSpecification
Win32_IniFileSpecification
Win32_LaunchCondition
Win32_ODBCDataSourceSpecification
Win32_ODBCTranslatorSpecification
Win32_ProgIDSpecification
Win32_EnvironmentSpecification
Win32_ReserveCost
Win32_Condition
Win32_ShadowStorage
Win32_DCOMApplicationAccessAllowedSetting
Win32_FolderRedirection
Win32_NamedJobObjectProcess
Win32_TokenPrivileges
Win32_NamedJobObject
Win32_PnPDevice
Win32_ServiceSpecificationService
Win32_OfflineFilesItem
Win32_OfflineFilesBackgroundSync
Win32_InstalledWin32Program
Win32_ShareToDirectory
Win32_SettingCheck
Win32_PatchFile
Win32_ODBCDriverAttribute
Win32_ODBCDataSourceAttribute
Win32_ClientApplicationSetting
Win32_RoamingUserHealthConfiguration
Win32_UserStateConfigurationControls
Win32_OfflineFilesPinInfo
Win32_SecuritySettingOwner
Win32_LogicalFileOwner
Win32_OfflineFilesFileSysInfo
Win32_ShortcutSAP
Win32_OfflineFilesSuspendInfo
Win32_MethodParameterClass
Win32_ProcessStartup
Win32_PingStatus
Win32_SoftwareElementCheck
Win32_ODBCDriverSoftwareElement
Win32_SystemServices
Win32_SystemNetworkConnections
Win32_SystemResources
Win32_SystemBIOS
Win32_SystemLoadOrderGroups
Win32_SystemUsers
Win32_SystemOperatingSystem
Win32_SystemDevices
Win32_ComputerSystemProcessor
Win32_SystemPartitions
Win32_SystemSystemDriver
Win32_SystemProcesses
Win32_COMApplicationClasses
Win32_ClassicCOMApplicationClasses
Win32_UserInDomain
Win32_LoadOrderGroupServiceMembers
Win32_LogicalDiskRootDirectory
Win32_SoftwareFeatureSoftwareElements
Win32_MemoryDeviceArray
Win32_GroupInDomain
Win32_GroupUser
Win32_ProgramGroupContents
Win32_SubDirectory
Win32_PhysicalMemoryLocation
Win32_FolderRedirectionUserConfiguration
Win32_Reliability
Win32_ReliabilityStabilityMetrics
Win32_ReliabilityRecords
Win32_InstalledProgramFramework
Win32_NTLogEventLog
Win32_DiskQuota
Win32_ComClassAutoEmulator
Win32_FolderRedirectionHealthConfiguration
Win32_ComClassEmulator
Win32_SoftwareFeatureAction
Win32_OfflineFilesMachineConfiguration
Win32_SecuritySettingGroup
Win32_LogicalFileGroup
Win32_DCOMApplicationLaunchAllowedSetting
Win32_SecuritySettingAuditing
Win32_LogicalFileAuditing
Win32_LogicalShareAuditing
Win32_PnPDeviceProperty
Win32_PnPDevicePropertyString
Win32_PnPDevicePropertyReal32Array
Win32_PnPDevicePropertyReal64
Win32_PnPDevicePropertyUint16
Win32_PnPDevicePropertySint16Array
Win32_PnPDevicePropertySint64
Win32_PnPDevicePropertyUint8
Win32_PnPDevicePropertySint8
Win32_PnPDevicePropertySecurityDescriptor
Win32_PnPDevicePropertyReal32
Win32_PnPDevicePropertySint32
Win32_PnPDevicePropertyStringArray
Win32_PnPDevicePropertyUint32
Win32_PnPDevicePropertyUint64
Win32_PnPDevicePropertyBoolean
Win32_PnPDevicePropertyUint16Array
Win32_PnPDevicePropertyBinary
Win32_PnPDevicePropertySint32Array
Win32_PnPDevicePropertySint16
Win32_PnPDevicePropertyReal64Array
Win32_PnPDevicePropertyBooleanArray
Win32_PnPDevicePropertyUint32Array
Win32_PnPDevicePropertyDateTime
Win32_PnPDevicePropertySecurityDescriptorArray
Win32_PnPDevicePropertySint8Array
Win32_OfflineFilesCache
Win32_SoftwareElementAction
Win32_ApplicationCommandLine
Win32_SubSession
Win32_ShadowVolumeSupport
Win32_DeviceBus
Win32_SessionConnection
Win32_ShadowFor
Win32_LogonSessionMappedDisk
Win32_PrinterShare
Win32_PnPSignedDriverCIMDataFile
Win32_ConnectionShare
Win32_LoadOrderGroupServiceDependencies
Win32_SessionResource
Win32_SessionProcess
Win32_AssociatedProcessorMemory
Win32_SoftwareFeatureParent
Win32_ShadowOn
Win32_PrinterDriverDll
Win32_DependentService
Win32_LogicalDiskToPartition
Win32_OperatingSystemQFE
Win32_LoggedOnUser
Win32_SystemDriverPNPEntity
Win32_DfsNodeTarget
Win32_CIMLogicalDeviceCIMDataFile
Win32_SCSIControllerDevice
Win32_POTSModemToSerialPort
Win32_USBControllerDevice
Win32_PrinterController
Win32_IDEControllerDevice
Win32_ControllerHasHub
Win32_1394ControllerDevice
Win32_DriverForDevice
Win32_LogicalProgramGroupItemDataFile
Win32_PNPAllocatedResource
Win32_DiskDrivePhysicalMedia
Win32_MemoryDeviceLocation
Win32_MemoryArrayLocation
Win32_ShadowBy
Win32_AllocatedResource
Win32_DiskDriveToDiskPartition
Win32_LogicalProgramGroupDirectory
Win32_ShadowDiffVolumeSupport
Win32_Product
Win32_ComputerSystemProduct
Win32_ProductCheck
Win32_NTLogEventUser
Win32_ProtocolBinding
Win32_NamedJobObjectLimit
Win32_NamedJobObjectSecLimit
Win32_OfflineFilesConnectionInfo
Win32_InstalledStoreProgram
Win32_NTLogEventComputer
Win32_TokenGroups
Win32_DefragAnalysis
Win32_SIDandAttributes
Win32_CheckCheck
Win32_RoamingProfileBackgroundUploadParams
Win32_RoamingProfileSlowLinkParams
Win32_OfflineFilesDiskSpaceLimit
Win32_SecuritySettingAccess
Win32_LogicalFileAccess
Win32_LogicalShareAccess
Win32_OfflineFilesDirtyInfo
Win32_OfflineFilesHealth
...
```

You can retrieve the same information from a remote computer using the **ComputerName** parameter,
specifying a computer name or IP address:

```powershell
Get-CimClass -Namespace root/CIMV2 -ComputerName 192.168.1.29
```

The class listing returned by remote computers may vary due to the specific operating system of the
computer is running and the particular WMI extensions are added by installed applications.

> [!NOTE]
> When using CIM cmdlets to connect to a remote computer, the remote computer must be running WMI
> and the account you are using must be in the local administrator's group on the remote computer.
> The remote system doesn't need to have PowerShell installed. This allows you to administer
> operating systems that aren't running PowerShell, but do have WMI available.

## Displaying WMI class details

If you already know the name of a WMI class, you can use it to get information immediately. For
example, one of the WMI classes commonly used for retrieving information about a computer is
**Win32_OperatingSystem**.

```powershell
Get-CimInstance -Class Win32_OperatingSystem
```

```Output
SystemDirectory     Organization BuildNumber RegisteredUser SerialNumber            Version
---------------     ------------ ----------- -------------- ------------            -------
C:\WINDOWS\system32 Microsoft    22621       USER1          00330-80000-00000-AA175 10.0.22621
```

Although we're showing all of the parameters, the command can be expressed in a more succinct way.
The **ComputerName** parameter isn't necessary when connecting to the local system. We show it to
demonstrate the most general case and remind you about the parameter. The **Namespace** defaults to
`root/CIMV2`, and can be omitted as well. Finally, most cmdlets allow you to omit the name of common
parameters. With `Get-CimInstance`, if no name is specified for the first parameter, PowerShell
treats it as the **Class** parameter. This means the last command could have been issued by typing:

```powershell
Get-CimInstance Win32_OperatingSystem
```

The **Win32_OperatingSystem** class has many more properties than those displayed here. You can use
Get-Member to see all the properties. The properties of a WMI class are automatically available like
other object properties:

```powershell
Get-CimInstance -Class Win32_OperatingSystem | Get-Member -MemberType Property
```

```Output
   TypeName: Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem
Name                                      MemberType Definition
----                                      ---------- ----------
BootDevice                                Property   string BootDevice {get;}
BuildNumber                               Property   string BuildNumber {get;}
BuildType                                 Property   string BuildType {get;}
Caption                                   Property   string Caption {get;}
CodeSet                                   Property   string CodeSet {get;}
CountryCode                               Property   string CountryCode {get;}
CreationClassName                         Property   string CreationClassName {get;}
CSCreationClassName                       Property   string CSCreationClassName {get;}
CSDVersion                                Property   string CSDVersion {get;}
CSName                                    Property   string CSName {get;}
CurrentTimeZone                           Property   int16 CurrentTimeZone {get;}
DataExecutionPrevention_32BitApplications Property   bool DataExecutionPrevention_32BitApplications {get;}
DataExecutionPrevention_Available         Property   bool DataExecutionPrevention_Available {get;}
DataExecutionPrevention_Drivers           Property   bool DataExecutionPrevention_Drivers {get;}
DataExecutionPrevention_SupportPolicy     Property   byte DataExecutionPrevention_SupportPolicy {get;}
Debug                                     Property   bool Debug {get;}
Description                               Property   string Description {get;set;}
Distributed                               Property   bool Distributed {get;}
EncryptionLevel                           Property   uint32 EncryptionLevel {get;}
ForegroundApplicationBoost                Property   byte ForegroundApplicationBoost {get;set;}
FreePhysicalMemory                        Property   uint64 FreePhysicalMemory {get;}
FreeSpaceInPagingFiles                    Property   uint64 FreeSpaceInPagingFiles {get;}
FreeVirtualMemory                         Property   uint64 FreeVirtualMemory {get;}
InstallDate                               Property   CimInstance#DateTime InstallDate {get;}
LargeSystemCache                          Property   uint32 LargeSystemCache {get;}
LastBootUpTime                            Property   CimInstance#DateTime LastBootUpTime {get;}
LocalDateTime                             Property   CimInstance#DateTime LocalDateTime {get;}
Locale                                    Property   string Locale {get;}
Manufacturer                              Property   string Manufacturer {get;}
MaxNumberOfProcesses                      Property   uint32 MaxNumberOfProcesses {get;}
MaxProcessMemorySize                      Property   uint64 MaxProcessMemorySize {get;}
MUILanguages                              Property   string[] MUILanguages {get;}
Name                                      Property   string Name {get;}
NumberOfLicensedUsers                     Property   uint32 NumberOfLicensedUsers {get;}
NumberOfProcesses                         Property   uint32 NumberOfProcesses {get;}
NumberOfUsers                             Property   uint32 NumberOfUsers {get;}
OperatingSystemSKU                        Property   uint32 OperatingSystemSKU {get;}
Organization                              Property   string Organization {get;}
OSArchitecture                            Property   string OSArchitecture {get;}
OSLanguage                                Property   uint32 OSLanguage {get;}
OSProductSuite                            Property   uint32 OSProductSuite {get;}
OSType                                    Property   uint16 OSType {get;}
OtherTypeDescription                      Property   string OtherTypeDescription {get;}
PAEEnabled                                Property   bool PAEEnabled {get;}
PlusProductID                             Property   string PlusProductID {get;}
PlusVersionNumber                         Property   string PlusVersionNumber {get;}
PortableOperatingSystem                   Property   bool PortableOperatingSystem {get;}
Primary                                   Property   bool Primary {get;}
ProductType                               Property   uint32 ProductType {get;}
PSComputerName                            Property   string PSComputerName {get;}
RegisteredUser                            Property   string RegisteredUser {get;}
SerialNumber                              Property   string SerialNumber {get;}
ServicePackMajorVersion                   Property   uint16 ServicePackMajorVersion {get;}
ServicePackMinorVersion                   Property   uint16 ServicePackMinorVersion {get;}
SizeStoredInPagingFiles                   Property   uint64 SizeStoredInPagingFiles {get;}
Status                                    Property   string Status {get;}
SuiteMask                                 Property   uint32 SuiteMask {get;}
SystemDevice                              Property   string SystemDevice {get;}
SystemDirectory                           Property   string SystemDirectory {get;}
SystemDrive                               Property   string SystemDrive {get;}
TotalSwapSpaceSize                        Property   uint64 TotalSwapSpaceSize {get;}
TotalVirtualMemorySize                    Property   uint64 TotalVirtualMemorySize {get;}
TotalVisibleMemorySize                    Property   uint64 TotalVisibleMemorySize {get;}
Version                                   Property   string Version {get;}
WindowsDirectory                          Property   string WindowsDirectory {get;}
...
```

## Displaying non-default properties with Format cmdlets

If you want the information contained in the **Win32_OperatingSystem** class that isn't displayed by
default, you can display it by using the **Format** cmdlets. For example, if you want to display
available memory data, type:

```powershell
Get-CimInstance -Class Win32_OperatingSystem | Format-Table -Property TotalVirtualMemorySize, TotalVisibleMemorySize, FreePhysicalMemory, FreeVirtualMemory, FreeSpaceInPagingFiles
```

```Output
TotalVirtualMemorySize TotalVisibleMemorySize FreePhysicalMemory FreeVirtualMemory FreeSpaceInPagingFiles
---------------------- ---------------------- ------------------ ----------------- ----------------------
              41787920               16622096            9537952          33071884               25056628
```

> [!NOTE]
> Wildcards work with property names in `Format-Table`, so the final pipeline element can be
> reduced to `Format-Table -Property Total*Memory*, Free*`

The memory data might be more readable if you format it as a list by typing:

```powershell
Get-CimInstance -Class Win32_OperatingSystem | Format-List Total*Memory*, Free*
```

```Output
TotalVirtualMemorySize : 41787920
TotalVisibleMemorySize : 16622096
FreePhysicalMemory     : 9365296
FreeSpaceInPagingFiles : 25042952
FreeVirtualMemory      : 33013484
Name                   : Microsoft Windows 11 Pro|C:\WINDOWS|\Device\Harddisk0\Partition2
```
