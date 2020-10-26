---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace05 Code Sample
description: RunSpace05 Code Sample
---
# RunSpace05 Code Sample

Here is the source code for the Runspace05 sample that is described in
[Configuring a Runspace Using RunspaceConfiguration](https://msdn.microsoft.com/42681d19-2d05-4975-befd-afb1990e79b2).
This sample shows how to create the runspace configuration information, create a runspace, create a
pipeline with a single command, and then execute the pipeline. The command that is executed is the
`Get-Process` cmdlet.

> [!NOTE]
> You can download the C# source file (runspace05.cs) by using the Microsoft Windows Software
> Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For
> download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace05/Runspace05.cs" range="11-86":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
