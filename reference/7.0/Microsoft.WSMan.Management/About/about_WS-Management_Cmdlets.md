---
description:  Provides an overview of Web Services for Management (WS-Management) as background for using the WS-Management cmdlets in Windows PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/04/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/about/about_ws-management_cmdlets?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_WS Management_Cmdlets
---

# About WS-Management Cmdlets

## SHORT DESCRIPTION

Provides an overview of Web Services for Management (WS-Management) as
background for using the WS-Management cmdlets in Windows PowerShell.

## LONG DESCRIPTION

This topic provides an overview of Web Services for Management (WS-Management)
as background for using the WS-Management cmdlets in Windows PowerShell. This
topic also provides links to more information about WS-Management. The
Microsoft implementation of WS-Management is also known as Windows Remote
Management (WinRM).

## About WS-Management

Windows Remote Management is the Microsoft implementation of the WS-Management
protocol, a standard SOAP-based, firewall-friendly protocol that allows
hardware and operating systems from different vendors to interoperate. The
WS-Management protocol specification provides a common way for systems to
access and exchange management information across an information technology
(IT) infrastructure. WS-Management and Intelligent Platform Management
Interface (IPMI), along with the Event Collector, are components of the
Windows Hardware Management features.

The WS-Management protocol is based on the following standard Web service
specifications: HTTPS, SOAP over HTTP (WS-I profile), SOAP 1.2, WS-Addressing,
WS-Transfer, WS-Enumeration, and WS-Eventing.

## WS-Management and WMI

WS-Management can be used to retrieve data exposed by Windows Management
Instrumentation (WMI). You can obtain WMI data with scripts or applications
that use the WS-Management Scripting API or through the WinRM command-line
tool. WS-Management supports most of the familiar WMI classes and operations,
including embedded objects. WS-Management can leverage WMI to collect data
about resources or to manage resources on a Windows-based computers. That
means that you can obtain data about objects such as disks, network adapters,
services, or processes in your enterprise through the existing set of WMI
classes. You can also access the hardware data that is available from the
standard WMI IPMI provider.

## WS-Management Windows PowerShell Provider (WSMan)

The WSMan provider provides a hierarchical view into the available
WS-Management configuration settings. The provider allows you to explore and
set the various WS-Management configuration options.

## WS-Management Configuration

If WS-Management is not installed and configured, Windows PowerShell remoting
is not available, the WS-Management cmdlets do not run, WS-Management scripts
do not run, and the WSMan provider cannot perform data operations. The
WS-Management command-line tool, WinRM, and event forwarding also depend on
the WS-Management configuration.

## WS-Management Cmdlets

WS-Management functionality is implemented in Windows PowerShell through a
module that contains a set of cmdlets and the WSMan provider. You can use
these cmdlets to complete the end-to-end tasks necessary to manage
WS-Management settings on local and remote computers.

The following WS-Management cmdlets are available.

## Connection Cmdlets

- Connect-WSMan: Connects the local computer to the WS-Management (WinRM)
  service on a remote computer.

- Disconnect-WSMan: Disconnects the local computer from the WS-Management
  (WinRM) service on a remote computer.

## Management-Data Cmdlets

- Get-WSManInstance: Displays management information for a resource instance
  that is specified by a resource URI.

- Invoke-WSManAction: Invokes an action on the target object that is specified
  by the resource URI and by the selectors.

- New-WSManInstance: Creates a new management resource instance.

- Remove-WSManInstance: Deletes a management resource instance.

- Set-WSManInstance: Modifies the management information that is related to a
  resource.

## Setup and Configuration Cmdlets

- Set-WSManQuickConfig: Configures the local computer for remote management.
  You can use the Set-WSManQuickConfig cmdlet to configure WS-Management to
  allow remote connections to the WS-Management (WinRM) service. The
  Set-WSManQuickConfig cmdlet performs the following operations:
  - It determines whether the WS-Management (WinRM) service is running. If the
    WinRM service is not running, the Set-WSManQuickConfig cmdlet starts the
    service.
  - It sets the WS-Management (WinRM) service startup type to automatic.
  - It creates a listener that accepts requests from any IP address. The
    default transport protocol is HTTP.
  - It enables a firewall exception for WS-Management traffic.

  Note: To run this cmdlet in Windows Vista, Windows Server 2008, and later
  versions of Windows, you must start Windows PowerShell with the "Run as
  administrator" option.

- Test-WSMan: Verifies that WS-Management is installed and configured. The
  Test-WSMan cmdlet tests whether the WS-Management (WinRM) service is running
  and configured on a local or remote computer.

- Disable-WSManCredSSP: Disables CredSSP authentication on a client computer.

- Enable-WSManCredSSP: Enables CredSSP authentication on a client computer.

- Get-WSManCredSSP: Gets the CredSSP-related configuration for a client
  computer.

## WS-Management-Specific Cmdlets

- New-WSManSessionOption: Creates a WSManSessionOption object to use as input
  to one or more parameters of a WS-Management cmdlet.

## Additional WS-Management Information

For more information about WS-Management, see the following topics in the
Windows documentation.

[Windows Remote Management](/windows/win32/winrm/portal)

[About Windows Remote Management](/windows/win32/winrm/about-windows-remote-management)

[Installation and Configuration for Windows Remote Management](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management)

[Windows Remote Management Architecture](/windows/win32/winrm/windows-remote-management-architecture)

[WS-Management Protocol](/windows/win32/winrm/ws-management-protocol)

[Windows Remote Management and WMI](/windows/win32/winrm/windows-remote-management-and-wmi)

[Resource URIs](/windows/win32/winrm/resource-uris)

[Remote Hardware Management](/windows/win32/winrm/remote-hardware-management)

[Events](/windows/win32/winrm/events)

## SEE ALSO

[Connect-WSMan](xref:Microsoft.WSMan.Management.Connect-WSMan)

[Disable-WSManCredSSP](xref:Microsoft.WSMan.Management.Disable-WSManCredSSP)

[Disconnect-WSMan](xref:Microsoft.WSMan.Management.Disconnect-WSMan)

[Enable-WSManCredSSP](xref:Microsoft.WSMan.Management.Enable-WSManCredSSP)

[Get-WSManCredSSP](xref:Microsoft.WSMan.Management.Get-WSManCredSSP)

[Get-WSManInstance](xref:Microsoft.WSMan.Management.Get-WSManInstance)

[Invoke-WSManAction](xref:Microsoft.WSMan.Management.Invoke-WSManAction)

[New-WSManInstance](xref:Microsoft.WSMan.Management.New-WSManInstance)

[Remove-WSManInstance](xref:Microsoft.WSMan.Management.Remove-WSManInstance)

[Set-WSManInstance](xref:Microsoft.WSMan.Management.Set-WSManInstance)

[Set-WSManQuickConfig](xref:Microsoft.WSMan.Management.Set-WSManQuickConfig)

[Test-WSMan](xref:Microsoft.WSMan.Management.Test-WSMan)
