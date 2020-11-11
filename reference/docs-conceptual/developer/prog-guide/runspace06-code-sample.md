---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace06 Code Sample
description: RunSpace06 Code Sample
---
# RunSpace06 Code Sample

Here is the source code for the Runspace06 sample described in
[Configuring a Runspace Using a Windows PowerShell Snap-in](https://msdn.microsoft.com/a7289ee8-9732-49ee-91c7-d533e9538b83).
This sample application creates a runspace based on a Windows PowerShell snap-in, which is then used
to run a pipeline with a single command. To do this, the application creates the runspace
configuration information, creates a runspace, creates a pipeline with a single command, and then
executes the pipeline.

> [!NOTE]
> You can download the C# source file (runspace06.cs) by using the Windows Software Development Kit
> for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions,
> see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace06/Runspace06.cs" range="11-85":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
