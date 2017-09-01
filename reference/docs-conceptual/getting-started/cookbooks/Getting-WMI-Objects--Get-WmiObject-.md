---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Getting WMI Objects Get WmiObject
ms.assetid:  f0ddfc7d-6b5e-4832-82de-2283597ea70d
---

# Getting WMI Objects (Get-WmiObject)

## Getting WMI Objects (Get-WmiObject)
Windows Management Instrumentation (WMI) is a core technology for Windows system administration because it exposes a wide range of information in a uniform manner. Because of how much WMI makes possible, the Windows PowerShell cmdlet for accessing WMI objects, **Get-WmiObject**, is one of the most useful for doing real work. We are going to discuss how to use Get-WmiObject to access WMI objects and then how to use WMI objects to do specific things.

### Listing WMI Classes
The first problem most WMI users encounter is trying to find out what can be done with WMI. WMI classes describe the resources that can be managed. There are hundreds of WMI classes, some of which contain dozens of properties.

**Get-WmiObject** addresses this problem by making WMI discoverable. You can get a list of the WMI classes available on the local computer by typing:

```
PS> Get-WmiObject -List

__SecurityRelatedClass                  __NTLMUser9X
__PARAMETERS                            __SystemSecurity
__NotifyStatus                          __ExtendedStatus
Win32_PrivilegesStatus                  Win32_TSNetworkAdapterSettingError
Win32_TSRemoteControlSettingError       Win32_TSEnvironmentSettingError
...
```

You can retrieve the same information from a remote computer by using the ComputerName parameter, specifying a computer name or IP address:

```
PS> Get-WmiObject -List -ComputerName 192.168.1.29

__SystemClass                           __NAMESPACE
__Provider                              __Win32Provider
__ProviderRegistration                  __ObjectProviderRegistration
...
```

The class listing returned by remote computers may vary due to the specific operating system the computer is running and the particular WMI extensions added by installed applications.

> [!NOTE]
> When using Get-WmiObject to connect to a remote computer, the remote computer must be running WMI and, under the default configuration, the account you are using must be in the local administrators group on the remote computer. The remote system does not need to have Windows PowerShell installed. This allows you to administer operating systems that are not running Windows PowerShell, but do have WMI available.

You can even include the ComputerName when connecting to the local system. You can use the local computer's name, its IP address (or the loopback address 127.0.0.1), or the WMI-style '.' as the computer name. If you are running Windows PowerShell on a computer named Admin01 with IP address 192.168.1.90, the following commands will all return the WMI class listing for that computer:

```
Get-WmiObject -List
Get-WmiObject -List -ComputerName .
Get-WmiObject -List -ComputerName Admin01
Get-WmiObject -List -ComputerName 192.168.1.90
Get-WmiObject -List -ComputerName 127.0.0.1
Get-WmiObject -List -ComputerName localhost
```

Get-WmiObject uses the root/cimv2 namespace by default. If you want to specify another WMI namespace, use the **Namespace** parameter and specify the corresponding namespace path:

```
PS> Get-WmiObject -List -ComputerName 192.168.1.29 -Namespace root

__SystemClass                           __NAMESPACE
__Provider                              __Win32Provider
...
```

### Displaying WMI Class Details
If you already know the name of a WMI class, you can use it to get information immediately. For example, one of the WMI classes commonly used for retrieving information about a computer is **Win32_OperatingSystem**.

```
PS> Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2 -ComputerName .

SystemDirectory : C:\WINDOWS\system32
Organization    : Global Network Solutions
BuildNumber     : 2600
RegisteredUser  : Oliver W. Jones
SerialNumber    : 12345-678-9012345-67890
Version         : 5.1.2600
```

Although we are showing all of the parameters, the command can be expressed in a more succinct way. The **ComputerName** parameter is not necessary when connecting to the local system. We show it to demonstrate the most general case and remind you about the parameter. The **Namespace** defaults to root/cimv2, and can be omitted as well. Finally, most cmdlets allow you to omit the name of common parameters. With Get-WmiObject, if no name is specified for the first parameter, Windows PowerShell treats it as the **Class** parameter. This means the last command could have been issued by typing:

```
Get-WmiObject Win32_OperatingSystem
```

The **Win32_OperatingSystem** class has many more properties than those displayed here. You can use Get-Member to see all the properties. The properties of a WMI class are automatically available like other object properties:

```
PS> Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2 -ComputerName . | Get-Member -MemberType Property

   TypeName: System.Management.ManagementObject#root\cimv2\Win32_OperatingSyste
m

Name                                      MemberType Definition
----                                      ---------- ----------
__CLASS                                   Property   System.String __CLASS {...
...
BootDevice                                Property   System.String BootDevic...
BuildNumber                               Property   System.String BuildNumb...
...
```

#### Displaying Non-Default Properties with Format Cmdlets
If you want information contained in the **Win32_OperatingSystem** class that is not displayed by default, you can display it by using the **Format** cmdlets. For example, if you want to display available memory data, type:

```
PS> Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2 -ComputerName . | Format-Table -Property TotalVirtualMemorySize,TotalVisibleMemorySize,FreePhysicalMemory,FreeVirtualMemory,FreeSpaceInPagingFiles

TotalVirtualMemorySize TotalVisibleMemory FreePhysicalMemory FreeVirtualMemory FreeSpaceInPagingFiles
---------------------- ---------------    ------------------ -==--------------------- ---------------
               2097024          785904                305808           2056724                1558232
```

> [!NOTE]
> Wildcards work with property names in **Format-Table**, so the final pipeline element can be reduced to **Format-Table -Property Total*,Free*

The memory data might be more readable if you format it as a list by typing:

```
PS> Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2 -ComputerName . | Format-List TotalVirtualMemorySize,TotalVisibleMemorySize,FreePhysicalMemory,FreeVirtualMemory,FreeSpaceInPagingFiles

TotalVirtualMemorySize : 2097024
TotalVisibleMemorySize : 785904
FreePhysicalMemory     : 301876
FreeVirtualMemory      : 2056724
FreeSpaceInPagingFiles : 1556644
```

