---
ms.date: 09/13/2016
ms.topic: reference
title: Resource Parameters
description: Resource Parameters
---
# Resource Parameters

The following table lists the recommended names and functionality for resource parameters. For these parameters, the resources could be the assembly that contains the cmdlet class or the host application that is running the cmdlet.

|Parameter|Functionality|
|---|---|
|**Application**<br>Data type: String|Implement this parameter so that the user can specify an application.|
|**Assembly**<br>Data type: String|Implement this parameter so that the user can specify an assembly.|
|**Attribute**<br>Data type: String|Implement this parameter so that the user can specify an attribute.|
|**Class**<br>Data type: String|Implement this parameter so that the user can specify a Microsoft .NET Framework class.|
|**Cluster**<br>Data type: String|Implement this parameter so that the user can specify a cluster.|
|**Culture**<br>Data type: String|Implement this parameter so that the user can specify the culture in which to run the cmdlet.|
|**Domain**<br>Data type: String|Implement this parameter so that the user can specify the domain name.|
|**Drive**<br>Data type: String|Implement this parameter so that the user can specify a drive name.|
|**Event**<br>Data type: String|Implement this parameter so that the user can specify an event name.|
|**Interface**<br>Data type: String|Implement this parameter so that the user can specify a network interface name.|
|**IpAddress**<br>Data type: String|Implement this parameter so that the user can specify an IP address.|
|**Job**<br>Data type: String|Implement this parameter so that the user can specify a job.|
|**LiteralPath**<br>Data type: String|Implement this parameter so that the user can specify the path to a resource when wildcard characters are not supported. (Use the **Path** parameter when wildcard characters are supported.)|
|**Mac**<br>Data type: String|Implement this parameter so that the user can specify a media access controller (MAC) address.|
|**ParentId**<br>Data type: String|Implement this parameter so that the user can specify the parent identifier.|
|**Path**<br>Data type: String, String[]|Implement this parameter so that the user can indicate the paths to a resource when wildcard characters are supported. (Use the **LiteralPath** parameter when wildcard characters are not supported.) We recommend that you develop this parameter so that it supports the full `provider:path` syntax used by providers. We also recommend that you develop it so that it works with as many providers as possible.|
|**Port**<br>Data type: Integer, String|Implement this parameter so that the user can specify an integer value for networking or a string value such as "biztalk" for other types of port.|
|**Printer**<br>Data type: Integer, String|Implement this parameter so that the user can specify the printer for the cmdlet to use.|
|**Size**<br>Data type: Int32|Implement this parameter so that the user can specify a size.|
|**TID**<br>Data type: String|Implement this parameter so that the user can specify a transaction identifier (TID) for the cmdlet.|
|**Type**<br>Data type: String|Implement this parameter so that the user can specify the type of resource on which to operate.|
|**URL**<br>Data type: String|Implement this parameter so that the user can specify a Uniform Resource Locator (URL).|
|**User**<br>Data type: String|Implement this parameter so that the user can specify their name or the name of another user.|

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
