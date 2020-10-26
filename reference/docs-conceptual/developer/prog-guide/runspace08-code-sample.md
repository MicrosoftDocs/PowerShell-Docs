---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace08 Code Sample
description: RunSpace08 Code Sample
---
# RunSpace08 Code Sample

Here is the source code for the Runspace08 sample described in
[Creating a Console Application That Adds Parameters to a Command](https://msdn.microsoft.com/848b2b46-60f1-4a86-b448-cfc7c0cccfba).
This sample application creates a runspace, creates a pipeline, adds two commands to the pipeline,
adds two parameters to the second command, and then executes the pipeline. The commands that are
added to the pipeline are the `Get-Process` and `Sort-Object` cmdlets.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace08/Runspace08.cs" range="11-86":::

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
