---
description: Describes a **CimSession** object and the difference between CIM sessions and PowerShell sessions. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 05/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_cimsession?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_CimSession
---
# About CimSession

## Short description
Describes a **CimSession** object and the difference between CIM sessions and
PowerShell sessions.

## Long description

A Common Information Model (CIM) session is a client-side object that
represents a connection to a local computer or a remote computer. You can use
CIM sessions as an alternative to PowerShell sessions (PSSessions). Both
approaches have advantages.

You can use the `New-CimSession` cmdlet to create a CIM session that contains
information about a connection, such as computer name, the protocol used for
the connection, session ID, and instance ID.

After you create a **CimSession** object that specifies information required to
establish a connection, PowerShell does not establish the connection
immediately. When a cmdlet uses the CIM session, PowerShell connects to the
specified computer, and then, when the cmdlet finishes, PowerShell terminates
the connection.

If you create a **PSSession** instead of using a CIM session, PowerShell
validates connection settings, and then establishes and maintains the
connection. If you use CIM sessions, PowerShell does not open a network
connection until needed. For more information about PowerShell sessions, see
[about_PSSessions](about_PSSessions.md).

## When to use a CIM session

Only cmdlets that work with a Windows Management Instrumentation (WMI) provider
or CIM over WS-Man accept CIM sessions. For other cmdlets, use **PSSessions**.

When you use a CIM session, PowerShell runs the cmdlet on the local client. It
connects to the WMI provider using the CIM session. The target computer does
not require PowerShell, or even any version of the Windows operating system.

In contrast, a cmdlet run using a **PSSession** runs on the target computer.
It requires PowerShell on the target system. Furthermore, the cmdlet sends data
back to the local computer. PowerShell manages the data sent over the
connection, and keeps the size within the limits set by Windows Remote
Management (WinRM). CIM sessions do not impose the WinRM limits.

## Using CDXML cmdlets

CIM-based Cmdlet Definition XML (CDXML) cmdlets can be written to use any WMI
Provider. All WMI providers use **CimSession** objects. For more information
about CDXML, see [CDXML definition and terms](/previous-versions/windows/desktop/wmi_v2/cdxml-overview).

CDXML cmdlets have an automatic **CimSession** parameter that can take an array
of **CimSession** objects. By default, PowerShell limits number of concurrent
CIM Connections to 15. This limit can be overridden by CDXML cmdlets that
implement the **ThrottleLimit**. See the individual cmdlet documentation to
understand the **ThrottleLimit**.

## SEE ALSO

[New-CimSession](xref:CimCmdlets.New-CimSession)

[about_PSSessions](about_PSSessions.md)
