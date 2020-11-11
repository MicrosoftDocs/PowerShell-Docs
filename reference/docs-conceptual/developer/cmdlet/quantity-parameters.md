---
ms.date: 09/13/2016
ms.topic: reference
title: Quantity Parameters
description: Quantity Parameters
---
# Quantity Parameters

The following table lists the recommended names and functionality for quantity parameters.

|Parameter|Functionality|
|---|---|
|**All**<br>Data type: Boolean|Implement this parameter so that `true` indicates that all resources should be acted upon instead of a default subset of resources. Implement this parameter so that `false` indicates a subset of the resources.|
|**Allocation**<br>Data type: Int32|Implement this parameter so that the user can specify the number of items to allocate.|
|**BlockCount**<br>Data type: Int64|Implement this parameter so that the user can specify the block count.|
|**Count**<br>Data type: Int64|Implement this parameter so that the user can specify the count.|
|**Scope**<br>Data type: Keyword|Implement this parameter so that the user can specify the scope to operate on.|

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
