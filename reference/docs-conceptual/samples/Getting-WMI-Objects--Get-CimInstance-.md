---
description: This article shows several examples of how to get instances of WMI objects from a computer system.
ms.date: 12/08/2022
title: Getting WMI objects with Get-CimInstance
---
# Getting WMI objects with Get-CimInstance

> This sample only applies to Windows platforms.

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
Get-CimClass -Namespace root/CIMV2 | 
    Where-Object CimClassName -like Win32* | 
    Select-Object CimClassName
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
...
```

You can retrieve the same information from a remote computer using the **ComputerName** parameter,
specifying a computer name or IP address:

```powershell
Get-CimClass -Namespace root/CIMV2 -ComputerName 192.168.1.29
```

The class listing returned by remote computers may vary due to the specific operating system the
computer is running and the particular WMI extensions are added by installed applications.

> [!NOTE]
> When using CIM cmdlets to connect to a remote computer, the remote computer must be running WMI
> and the account you are using must be in the local **Administrators** group on the remote
> computer. The remote system doesn't need to have PowerShell installed. This allows you to
> administer operating systems that aren't running PowerShell, but do have WMI available.

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
Name                   : Microsoft Windows 11 Pro|C:\Windows|\Device\Harddisk0\Partition2
```
