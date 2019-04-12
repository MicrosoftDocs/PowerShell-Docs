---
ms.date:  04/28/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_CimSession
---
# About CimSession

## SHORT DESCRIPTION
Describes a CimSession object and the difference between CIM sessions and
PowerShell sessions.

## LONG DESCRIPTION

A Common Information Model (CIM) session is a client-side object that
represents a connection to a local computer or a remote computer. You can
use CIM sessions as an alternative to PowerShell sessions
(PSSessions). Both approaches have advantages.

You can use the [New-CimSession](../../CimCmdlets/New-CimSession.md) cmdlet to create a CIM session that contains
information about a connection, such as computer name, the protocol used
for the connection, session ID, and instance ID.

After you create a CimSession object that specifies information required to
establish a connection, PowerShell does not establish the
connection immediately. When a cmdlet uses the CIM session,
PowerShell connects to the specified computer, and then, when the
cmdlet finishes, PowerShell terminates the connection.

If you create a PSSession instead of using a CIM session,
PowerShell validates connection settings, and then establishes and
maintains the connection. If you use CIM sessions, PowerShell
does not open a network connection until needed. For more information about
PowerShell sessions, see [about_PSSessions](about_PSSessions.md).

### When to Use a CIM Session

Only cmdlets that work with a Windows Management Instrumentation (WMI)
provider or CIM over WS-Man accept CIM sessions.
For other cmdlets, use PSSessions.

When you use a CIM session, PowerShell runs the cmdlet on the
local client. It connects to the WMI provider by using the CIM session.
The target computer does not require PowerShell, or even any
version of the Windows operating system.

In contrast, a cmdlet run by using a PSSession runs on the target
computer. It requires PowerShell on the target system.
Furthermore, the cmdlet sends data back to the local computer.
PowerShell manages the data sent over the connection, and keeps
the size within the limits set by Windows Remote Management (WinRM). CIM
sessions do not impose the WinRM limits.

CIM-based Cmdlet Definition XML (CDXML) cmdlets can be written to use any
WMI Provider. All WMI providers use CimSession objects.

## SEE ALSO

[New-CimSession](../../CimCmdlets/New-CimSession.md)

[about_PSSessions](about_PSSessions.md)