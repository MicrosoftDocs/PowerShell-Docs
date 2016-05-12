---
title:  Collecting Information About Computers
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  9e7b6a2d-34f7-4731-a92c-8b3382eb51bb
---

# Collecting Information About Computers
**Get\-WmiObject** is the most important cmdlet for general system management tasks. All critical subsystem settings are exposed through WMI. Furthermore, WMI treats data as objects that are in collections of one or more items. Because Windows PowerShell also works with objects and has a pipeline that allows you to treat single or multiple objects in the same way, generic WMI access allows you to perform some advanced tasks with very little work.

The following examples demonstrate how to collect specific information by using **Get\-WmiObject** against an arbitrary computer. We specify the **ComputerName** parameter with the dot value (**.**), which represents the local computer. You can specify a name or IP address associated with any computer you can reach through WMI. To retrieve information about the local computer, you could omit the **\-ComputerName.**

### Listing Desktop Settings
We'll begin with a command that collects information about the desktops on the local computer.

```
Get-WmiObject -Class Win32_Desktop -ComputerName .
```

This returns information for all desktops, whether they are in use or not.

> [!NOTE]
> Information returned by some WMI classes can be very detailed, and often include metadata about the WMI class. Because most of these metadata properties have names that begin with a double\-underscore, you can filter the properties using Select\-Object. Specify only properties that begin with alphabetic characters by using **\[a\-z]\&#42;** as the Property value. For example:

```
Get-WmiObject -Class Win32_Desktop -ComputerName . | Select-Object -Property [a-z]*
```

To filter out the metadata, use a pipeline operator (|) to send the results of the Get\-WmiObject command to **Select\-Object \-Property \[a\-z]\&#42;**.

### Listing BIOS Information
The WMI Win32\_BIOS class returns fairly compact and complete information about the system BIOS on the local computer:

```
Get-WmiObject -Class Win32_BIOS -ComputerName .
```

### Listing Processor Information
You can retrieve general processor information by using WMI's **Win32\_Processor** class, although you will likely want to filter the information:

```
Get-WmiObject -Class Win32_Processor -ComputerName . | Select-Object -Property [a-z]*
```

For a generic description string of the processor family, you can just return the **Win32\_ComputerSystemSystemType** property:

```
PS> Get-WmiObject -Class Win32_ComputerSystem -ComputerName . | Select-Object -Property SystemType
SystemType
----------
X86-based PC
```

### Listing Computer Manufacturer and Model
Computer model information is also available from **Win32\_ComputerSystem**. The standard displayed output will not need any filtering to provide OEM data:

```
PS> Get-WmiObject -Class Win32_ComputerSystem
Domain              : WORKGROUP
Manufacturer        : Compaq Presario 06
Model               : DA243A-ABA 6415cl NA910
Name                : MyPC
PrimaryOwnerName    : Jane Doe
TotalPhysicalMemory : 804765696
```

Your output from commands such as this, which return information directly from some hardware, is only as good as the data you have. Some information is not correctly configured by hardware manufacturers and may therefore be unavailable.

### Listing Installed Hotfixes
You can list all installed hotfixes by using **Win32\_QuickFixEngineering**:

```
Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName .
```

This class returns a list of hotfixes that looks like this:

```
Description         : Update for Windows XP (KB910437)
FixComments         : Update
HotFixID            : KB910437
Install Date        :
InstalledBy         : Administrator
InstalledOn         : 12/16/2005
Name                :
ServicePackInEffect : SP3
Status              :
```

For more succinct output, you may want to exclude some properties. Although you can use the **Get\-WmiObject Property** parameter to choose only the **HotFixID**, doing so will actually return more information, because all the metadata is displayed by default:

```
PS> Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName . -Property HotFixId
HotFixID         : KB910437
__GENUS          : 2
__CLASS          : Win32_QuickFixEngineering
__SUPERCLASS     :
__DYNASTY        :
__RELPATH        :
__PROPERTY_COUNT : 1
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
```

The additional data is returned, because the Property parameter in **Get\-WmiObject** restricts the properties returned from WMI class instances, not the object returned to Windows PowerShell. To reduce the output, use **Select\-Object**:

```
PS> Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName . -Property Hot
FixId | Select-Object -Property HotFixId
HotFixId
--------
KB910437
```

### Listing Operating System Version Information
The **Win32\_OperatingSystem** class properties include version and service pack information. You can explicitly select only these properties to get a version information summary from **Win32\_OperatingSystem**:

```
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion
```

You can also use wildcards with the **Select\-Object Property** parameter. Because all the properties beginning with either **Build** or **ServicePack** are important to use here, we can shorten this to the following form:

```
PS> Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property Build*,OSType,ServicePack*

BuildNumber             : 2600
BuildType               : Uniprocessor Free
OSType                  : 18
ServicePackMajorVersion : 2
ServicePackMinorVersion : 0
```

### Listing Local Users and Owner
Local general user information—number of licensed users, current number of users, and owner name—can be found with a selection of **Win32\_OperatingSystem** properties. You can explicitly select the properties to display like this:

```
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser
```

A more succinct version using wildcards is:

```
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property *user*
```

### Getting Available Disk Space
To see the disk space and free space for local drives, you can use the WMI Win32\_LogicalDisk class. You need to see only instances with a DriveType of 3—the value WMI uses for fixed hard disks.

```
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName .

DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 65541357568
Size         : 203912880128
VolumeName   : Local Disk

DeviceID     : Q:
DriveType    : 3
ProviderName :
FreeSpace    : 44298250240
Size         : 122934034432
VolumeName   : New Volume

PS> Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName . | Measure-Object -Property FreeSpace,Size -Sum

Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName . | Measure-Object -Property FreeSpace,Size -Sum | Select-Object -Property Property,Sum
```

### Getting Logon Session Information
You can get general information about logon sessions associated with users through the WMI Win32\_LogonSession class:

```
Get-WmiObject -Class Win32_LogonSession -ComputerName .
```

### Getting the User Logged on to a Computer
You can display the user logged on to a particular computer system using Win32\_ComputerSystem. This command returns only the user logged on to the system desktop:

```
Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName .
```

### Getting Local Time from a Computer
You can retrieve the current local time on a specific computer by using the WMI Win32\_LocalTime class. Because this class by default displays all metadata, you may want to filter it using **Select\-Object**:

```
PS> Get-WmiObject -Class Win32_LocalTime -ComputerName . | Select-Object -Property [a-z]*

Day          : 15
DayOfWeek    : 4
Hour         : 12
Milliseconds :
Minute       : 11
Month        : 6
Quarter      : 2
Second       : 52
WeekInMonth  : 3
Year         : 2006
```

### Displaying Service Status
To view the status of all services on a specific computer, you can locally use the **Get\-Service** cmdlet as mentioned earlier. For remote systems, you can use the WMI Win32\_Service class. If you also use **Select\-Object** to filter the results to **Status**, **Name**, and **DisplayName**, the output format will be almost identical to that from **Get\-Service**:

```
Get-WmiObject -Class Win32_Service -ComputerName . | Select-Object -Property Status,Name,DisplayName
```

To allow the complete display of names for the occasional services with extremely long names, you may want to use **Format\-Table** with the **AutoSize** and **Wrap** parameters, to optimize column width and allow long names to wrap instead of being truncated:

```
Get-WmiObject -Class Win32_Service -ComputerName . | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap
```

