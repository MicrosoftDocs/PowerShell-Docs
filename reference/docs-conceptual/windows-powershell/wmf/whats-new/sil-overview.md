---
ms.date:  06/12/2017
title: Software Inventory Logging (SIL)
description: WMF 5.x add Software Inventory Logging features that allow you to collect information about installed software in a central location for easier management and auditing.
---

# Software Inventory Logging (SIL)

> [!IMPORTANT]
> When installing WMF 5.x on a Windows Server 2012 R2 Server that is already running SIL, it is
> necessary to run the Start-SilLogging cmdlet once after the WMF install, as the installation
> process will errantly stop the Software Inventory Logging feature.

Software Inventory Logging helps reduce the operational costs of getting accurate information about
the Microsoft software installed locally on a server, but especially across many servers in an IT
environment (assuming the software is installed and running across the IT environment). Provided one
is set up, you can forward this data to an aggregation server, and collect the log data in one place
by using a uniform, automatic process.

While you can also log software inventory data by querying each computer directly, Software
Inventory Logging, by employing a forwarding (over the network) architecture initiated by each
server, can overcome server discovery challenges that are typical for many software inventory and
asset management scenarios. Software Inventory Logging uses SSL to secure data that is forwarded
over HTTPS to an aggregation server. Storing the data in one place makes the data easier to analyze,
manipulate, and share when necessary.

None of this data is sent to Microsoft as part of the feature functionality. Software Inventory
Logging data and functionality is meant for the sole use of the server software's licensed owner and
administrators.

For more information and documentation about Software Inventory Logging cmdlets, see
[Manage Software Inventory Logging in Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383584(v=ws.11)).
