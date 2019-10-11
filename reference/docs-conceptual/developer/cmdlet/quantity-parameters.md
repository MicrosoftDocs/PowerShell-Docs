---
title: "Quantity Parameters | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 8c0bd8a9-1749-4885-ab24-38c0a4d9f2cb
caps.latest.revision: 6
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
