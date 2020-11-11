---
description:  Provides background information about Windows Management Instrumentation (WMI) and Windows PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 12/01/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wmi_cmdlets?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_WMI_Cmdlets
---

# About WMI Cmdlets

## SHORT DESCRIPTION

Provides background information about Windows Management Instrumentation (WMI)
and Windows PowerShell.

## LONG DESCRIPTION

This topic provides information about WMI technology, the WMI cmdlets for
Windows PowerShell, WMI-based remoting, WMI accelerators, and WMI
troubleshooting. This topic also provides links to more information about WMI.

### ABOUT WMI

Windows Management Instrumentation (WMI) is the Microsoft implementation of
Web-Based Enterprise Management (WBEM), which is an industry initiative to
develop a standard technology for accessing management information in an
enterprise environment. WMI uses the Common Information Model (CIM) industry
standard to represent systems, applications, networks, devices, and other
managed components. CIM is developed and maintained by the Distributed
Management Task Force (DMTF). You can use WMI to manage both local and remote
computers. For example, you can use WMI to do the following:

- Start a process on a remote computer.
- Restart a computer remotely.
- Get a list of the applications that are installed on a local or remote
  computer.
- Query the Windows event logs on a local or remote computer.

### THE WMI CMDLETS FOR WINDOWS POWERSHELL

Windows PowerShell implements WMI functionality through a set of cmdlets that
are available in Windows PowerShell by default. You can use these cmdlets to
complete the end-to-end tasks necessary to manage local and remote computers.

The following WMI cmdlets are included.

|Cmdlet           |Description                                   |
|-----------------|----------------------------------------------|
|Get-WmiObject    |Gets instances of WMI classes or information  |
|                 |about the available classes.                  |
|Invoke-WmiMethod |Calls WMI methods.                            |
|Register-WmiEvent|Subscribes to a WMI event.                    |
|Remove-WmiObject |Deletes WMI classes and instances.            |
|Set-WmiInstance  |Creates or modifies instances of WMI classes. |

### SAMPLE COMMANDS
The following command displays the BIOS information for the local computer.

```powershell
C:\PS> get-wmiobject win32_bios | format-list *
```

The following command displays information about the WinRM service for three
remote computers.

```powershell
$wql = "select * from win32_service where name='WinRM'"
get-wmiobject -query $wql -computername server01, server01, server03
```

The following more complex command exits all instances of a program.

```powershell
C:\PS> notepad.exe
C:\PS> $wql = "select * from win32_process where name='notepad.exe'"
C:\PS> $np = get-wmiobject -query $wql
C:\PS> $np | remove-wmiobject
```

### WMI-BASED REMOTING

While the ability to manage a local system through WMI is useful, it is the
remoting capabilities that make WMI a powerful administrative tool. WMI uses
Microsoft's Distributed Component Object Model (DCOM) to connect to and manage
systems. You might have to configure some systems to allow DCOM connections.
Firewall settings and locked-down DCOM permissions can block WMI's ability to
remotely manage systems.

### WMI TYPE ACCELERATORS

Windows PowerShell includes WMI type accelerators. These WMI type accelerators
(shortcuts) allow more direct access to a WMI objects than a non-type
accelerator approach would allow.

The following type accelerators are supported with WMI:

[WMISEARCHER] - A shortcut for searching for WMI objects.

[WMICLASS] - A shortcut for accessing the static properties and methods of a class.

[WMI] - A shortcut for getting a single instance of a class.

[WMISEARCHER] is a type accelerator for a ManagementObjectSearcher. It can
take a string constructor to create a searcher that you can then do a GET()
on.

For example:

```powershell
PS> $s = [WmiSearcher]'Select * from Win32_Process where Handlecount > 1000'
PS> $s.Get() |sort handlecount |ft handlecount,__path,name -auto

count  __PATH                                              name
-----  ------                                              ----
1105   \\SERVER01\root\cimv2:Win32_Process.Handle="3724"   PowerShell...
1132   \\SERVER01\root\cimv2:Win32_Process.Handle="1388"   winlogon.exe
1495   \\SERVER01\root\cimv2:Win32_Process.Handle="2852"   iexplore.exe
1699   \\SERVER01\root\cimv2:Win32_Process.Handle="1204"   OUTLOOK.EXE
1719   \\SERVER01\root\cimv2:Win32_Process.Handle="1912"   iexplore.exe
2579   \\SERVER01\root\cimv2:Win32_Process.Handle="1768"   svchost.exe
```

[WMICLASS] is a type accelerator for ManagementClass. This has a string
constructor that takes a local or absolute WMI path to a WMI class and returns
an object that is bound to that class.

For example:

```powershell
PS> $c = [WMICLASS]"root\cimv2:WIn32_Process"
PS> $c |fl *
Name             : Win32_Process
__GENUS          : 1
__CLASS          : Win32_Process
__SUPERCLASS     : CIM_Process
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Process
__PROPERTY_COUNT : 45
__DERIVATION     : {CIM_Process, CIM_LogicalElement,
                   CIM_ManagedSystemElement}
__SERVER         : SERVER01
__NAMESPACE      : ROOT\cimv2
__PATH           : \\SERVER01\ROOT\cimv2:Win32_Process
```

[WMI] is a type accelerator for ManagementObject. This has a string
constructor that takes a local or absolute WMI path to a WMI instance and
returns an object that is bound to that instance.

For example:

```powershell
PS> $p = [WMI]'\\SERVER01\root\cimv2:Win32_Process.Handle="1204"'
PS> $p.Name
OUTLOOK.EXE
```

### WMI TROUBLESHOOTING

The following problems are the most common problems that might occur when you
try to connect to a remote computer.

Problem 1: The remote computer is not online.

If a computer is offline, you will not be able to connect to it by using WMI.
You may receive the following error message:

```
Remote server machine does not exist or is unavailable
```

If you receive this error message, verify that the computer is online. Try to
ping the remote computer.

Problem 2: You do not have local administrator rights on the remote computer.

To use WMI remotely, you must have local administrator rights on the remote
computer. If you do not, access to that computer will be denied.

To verify namespace security:

1. Click Start, right-click My Computer, and then click Manage.
2. In Computer Management, expand Services and Applications, right-click WMI
   Control, and then click Properties.
3. In the WMI Control Properties dialog box, click  the Security tab.

Problem 3: A firewall is blocking access to the remote computer.

WMI uses the DCOM (Distributed COM) and RPC (Remote Procedure Call) protocols
to traverse the network. By default, many firewalls block DCOM and RPC
traffic. If your firewall is blocking these protocols, your connection will
fail. For example, Windows Firewall in Microsoft Windows XP Service Pack 2 is
configured to automatically block all unsolicited network traffic, including
DCOM and WMI. In its default configuration, Windows Firewall rejects an
incoming WMI request, and you receive the following error message:

```
Remote server machine does not exist or is unavailable
```

## SEE ALSO

[About WMI](/windows/win32/wmisdk/about-wmi)

[WMI Troubleshooting](/windows/win32/wmisdk/wmi-troubleshooting)

[Get-WmiObject](xref:Microsoft.PowerShell.Management.Get-WmiObject)

[Invoke-WmiMethod](xref:Microsoft.PowerShell.Management.Invoke-WmiMethod)

[Register-WmiEvent](xref:Microsoft.PowerShell.Management.Register-WmiEvent)

[Remove-WmiObject](xref:Microsoft.PowerShell.Management.Remove-WmiObject)

[Set-WmiInstance](xref:Microsoft.PowerShell.Management.Set-WmiInstance)
