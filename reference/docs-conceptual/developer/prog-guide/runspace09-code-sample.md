---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace09 Code Sample
description: RunSpace09 Code Sample
---
# RunSpace09 Code Sample

Here is the source code for the Runspace09 sample described in
[Creating a Console Application That Invokes a Pipeline Asynchronously](https://msdn.microsoft.com/198c1c94-2a06-457e-93ce-c0d910618e47).
This sample application creates and opens a runspace, creates and asynchronously invokes a pipeline,
and then uses pipeline events to process the script asynchronously. The script that is run by this
application creates the integers 1 through 10 in 0.5-second intervals (500 ms).

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace09/Runspace09.cs" range="11-113":::

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
