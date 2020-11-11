---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace07 Code Sample
description: RunSpace07 Code Sample
---
# RunSpace07 Code Sample

Here is the source code for the Runspace07 sample described in
[Creating a Console Application That Adds Commands to a Pipeline](https://msdn.microsoft.com/01eb7808-e97b-4905-80be-9e2fa38c262e).
This sample application creates a runspace, creates a pipeline, adds two commands to the pipeline,
and then executes the pipeline. The commands added to the pipeline are the `Get-Process` and
`Measure-Object` cmdlets.

> [!NOTE]
> You can download the C# source file (runspace07.cs) using the Microsoft Windows Software
> Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For
> download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace07/Runspace07.cs" range="11-108":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
