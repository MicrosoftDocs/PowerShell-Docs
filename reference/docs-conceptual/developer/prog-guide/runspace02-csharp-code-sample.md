---
ms.date: 09/13/2016
ms.topic: reference
title: Runspace02 (C#) Code Sample
description: Runspace02 (C#) Code Sample
---
# Runspace02 (C#) Code Sample

Here is the C# source code for the Runspace02 sample. This sample uses the
[System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke)
class to execute the `Get-Process` cmdlet synchronously. Windows Forms and data binding are then
used to display the results in a DataGridView control

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace02/Runspace02.cs" range="11-82":::

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
