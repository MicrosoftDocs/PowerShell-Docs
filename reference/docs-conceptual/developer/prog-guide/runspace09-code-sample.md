---
title: "RunSpace09 Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 136e451f-767b-42e0-bd6f-6486693abd5e
caps.latest.revision: 6
---
# RunSpace09 Code Sample

Here is the source code for the Runspace09 sample described in
[Creating a Console Application That Invokes a Pipeline Asynchronously](https://msdn.microsoft.com/198c1c94-2a06-457e-93ce-c0d910618e47).
This sample application creates and opens a runspace, creates and asynchronously invokes a pipeline,
and then uses pipeline events to process the script asynchronously. The script that is run by this
application creates the integers 1 through 10 in 0.5-second intervals (500 ms).

## Code Sample

[!code-csharp[Runspace09.cs](../../../../powershell-sdk-samples/SDK-2.0/csharp/Runspace09/Runspace09.cs#L11-L113 "Runspace09.cs")]

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
