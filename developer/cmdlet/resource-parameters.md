---
title: "Resource Parameters | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 460c43aa-f5c5-4a1a-a6f2-5e07db143de1
caps.latest.revision: 5
---
# Resource Parameters

The following table lists the recommended names and functionality for resource parameters. For these parameters, the resources could be the assembly that contains the cmdlet class or the host application that is running the cmdlet.

Application
Data type: String

Implement this parameter so that the user can specify an application.

Assembly
Data type: String

Implement this parameter so that the user can specify an assembly.

Attribute
Data type: String

Implement this parameter so that the user can specify an attribute.

Class
Data type: String

Implement this parameter so that the user can specify a Microsoft .NET Framework class.

Cluster
Data type: String

Implement this parameter so that the user can specify a cluster.

Culture
Data type: String

Implement this parameter so that the user can specify the culture in which to run the cmdlet.

Domain
Data type: String

Implement this parameter so that the user can specify the domain name.

Drive
Data type: String

Implement this parameter so that the user can specify a drive name.

Event
Data type: String

Implement this parameter so that the user can specify an event name.

Interface
Data type: String

Implement this parameter so that the user can specify a network interface name.

IpAddress
Data type: String

Implement this parameter so that the user can specify an IP address.

Job
Data type: String

Implement this parameter so that the user can specify a job.

LiteralPath
Data type: String

Implement this parameter so that the user can specify the path to a resource when wildcard characters are not supported. (Use the `Path` parameter when wildcard characters are supported.)

Mac
Data type: String

Implement this parameter so that the user can specify a media access controller (MAC) address.

ParentId
Data type: String

Implement this parameter so that the user can specify the parent identifier.

Path
Data type: String, String[]

Implement this parameter so that the user can indicate the paths to a resource when wildcard characters are supported. (Use the `LiteralPath` parameter when wildcard characters are not supported.)

We recommend that you develop this parameter so that it supports the full "provider:path" syntax used by providers. We also recommend that you develop it so that it works with as many providers as possible.

Port
Data type: Integer, String

Implement this parameter so that the user can specify an integer value for networking or a string value such as "biztalk" for other types of port.

Printer
Data type: Integer, String

Implement this parameter so that the user can specify the printer for the cmdlet to use.

Size
Data type: Int32

Implement this parameter so that the user can specify a size.

TID
Data type: String

Implement this parameter so that the user can specify a transaction identifier (TID) for the cmdlet.

Type
Data type: String

Implement this parameter so that the user can specify the type of resource on which to operate.

URL
Data type: String

Implement this parameter so that the user can specify a Uniform Resource Locator (URL).

User
Data type: String

Implement this parameter so that the user can specify their name or the name of another user.

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
