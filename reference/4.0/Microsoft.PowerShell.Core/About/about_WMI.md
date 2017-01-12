---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_WMI
ms.technology:  powershell
---

# About WMI
## about_WMI


## SHORT DESCRIPTION
Windows Management Instrumentation (WMI) uses the Common Information Model (CIM) to represent systems, applications, networks, devices, and other manageable components of the modern enterprise.


## LONG DESCRIPTION
Windows Management Instrumentation (WMI) is Microsoft’s implementation of Web-Based Enterprise Management (WBEM), the industry standard.

Classic WMI uses DCOM to communicate with networked devices to manage remote systems.  Windows PowerShell® 3.0 introduces a CIM provider model that uses WinRM to remove the dependency on DCOM. This CIM provider model also uses new WMI provider APIs that enable developers to write  Windows PowerShell cmdlets in native code (C\+\+).

Do not confuse WMI providers with  Windows PowerShell providers. Many Windows features have an associated WMI provider that exposes their management capabilities. To get WMI providers, run a WMI query that gets instances of the __Provider WMI class, such as the following query.


```
Get-WmiObject -Class __Provider
```



## THREE COMPONENTS OF WMI
The following three components of WMI interact with  Windows PowerShell: Namespaces, Providers, and Classes.

WMI Namespaces organize WMI providers and WMI classes into groups of related components. In this way, they are similar to .NET Framework namespaces. Namespaces are not physical locations, but are more like logical databases. All WMI namespaces are instances of the __Namespace system class. The default WMI namespace is Root\/CIMV2 (since Microsoft Windows 2000). To use  Windows PowerShell to get WMI namespaces in the current session, use a command with the following format.


```
Get-WmiObject -Class __Namespace
```


To get WMI namespaces in other namespaces, use the Namespace parameter to change the location of the search. The following command finds WMI namespaces that reside in the Root\/Cimv2\/Applications namespace.


```
Get-WmiObject -Class __Namespace -Namespace   
root/CIMv2/applications
```


WMI namespaces are hierarchical. Therefore, obtaining a list of all namespaces on a particular system requires performing a recursive query starting at the root namespace.

WMI Providers expose information about Windows manageable objects. A provider retrieves data from a component, and passes that data through WMI to a management application, such as  Windows PowerShell. Most WMI providers are dynamic providers, which means that they obtain the data dynamically when it is requested through the management application.


## FINDING WMI CLASSES
In a default installation of Windows 8, there are more than 1,100 WMI classes in Root\/Cimv2. With this many WMI classes, the challenge becomes identifying the appropriate WMI class to use to perform a specific task.  Windows PowerShell 3.0 provides two ways to find WMI classes that are related to a specific topic.

For example,to find WMI classes in the root\CIMV2 WMI namespace that are related to disks, you can use a query such as the one shown here.


```
Get-WmiObject -List *disk*
```


To find WMI classes that are related to memory, you might use a query such as the one shown here.


```
Get-WmiObject -List *memory*
```


The CIM cmdlets also provide the ability to discover WMI classes. To do this, use the Get-CIMClass cmdlet. The command shown here lists WMI classes related to video.


```
Get-CimClass *video*
```


Tab expansion works when changing WMI namespaces, and therefore use of tab expansion makes sub-WMI namespaces easily discoverable. In the following example, the Get-CimClass cmdlet lists WMI classes related to power settings. To find it, type the root\/CIMV2\/ WMI namespace, and then press type the root\/CIMV2\/ WMI namespace, and then press the Tab key several times until the power namespace appears. Here is the command:


```
Get-CimClass *power* -Namespace root/cimv2/power
```

