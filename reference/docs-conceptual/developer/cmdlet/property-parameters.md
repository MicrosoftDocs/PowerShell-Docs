---
ms.date: 09/13/2016
ms.topic: reference
title: Property Parameters
description: Property Parameters
---
# Property Parameters

The following table lists the recommended names and functionality for property parameters.

|Parameter|Functionality|
|---|---|
|**Count**<br>Data type: Int32|Implement this parameter so that the user can specify the number of objects to be processed.|
|**Description**<br>Data type: String|Implement this parameter so that the user can specify a description for a resource.|
|**From**<br>Data type: String|Implement this parameter so that the user can specify the reference object to get information from.|
|**Id**<br>Data type: Resource dependent|Implement this parameter so that the user can specify the identifier of a resource.|
|**Input**<br>Data type: String|Implement this parameter so that the user can specify the input file specification.|
|**Location**<br>Data type: String|Implement this parameter so that the user can specify the location of the resource.|
|**LogName**<br>Data type: String|Implement this parameter so that the user can specify the name of the log file to process or use.|
|**Name**<br>Data type: String|Implement this parameter so that the user can specify the name of the resource.|
|**Output**<br>Data type: String|Implement this parameter so that the user can specify the output file.|
|**Owner**<br>Data type: String|Implement this parameter so that the user can specify the name of the owner of the resource.|
|**Property**<br>Data type: String|Implement this parameter so that the user can specify the name or the names of the properties to use.|
|**Reason**<br>Data type: String|Implement this parameter so that the user can specify why this cmdlet is being invoked.|
|**Regex**<br>Data type: SwitchParameter|Implement this parameter so that regular expressions are used when the parameter is specified. When this parameter is specified, wildcard characters are not resolved.|
|**Speed**<br>Data type: Int32|Implement this parameter so that the user can specify the baud rate. The user sets this parameter to the speed of the resource.|
|**State**<br>Data type: Keyword array|Implement this parameter so that the user can specify the names of states, such as KEYDOWN.|
|**Value**<br>Data type: Object|Implement this parameter so that the user can  specify a value to provide to the cmdlet.|
|**Version**<br>Data type: String|Implement this parameter so that the user can specify the version of the property.|

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
