---
ms.date: 09/13/2016
ms.topic: reference
title: Runspace01 (C#) Code Sample
description: Runspace01 (C#) Code Sample
---
# Runspace01 (C#) Code Sample

Here are the code samples for the runspace described in
[Creating a Console Application That Runs a Specified Command](/dotnet/csharp/programming-guide/inside-a-program/hello-world-your-first-program).
To do this, the application invokes a runspace, and then invokes a command. (Note that this
application does not specify runspace configuration information, nor does it explicitly create a
pipeline). The command that is invoked is the `Get-Process` cmdlet.

> [!NOTE]
> You can download the C# source file (runspace01.cs) for this runspace using the Microsoft Windows
> Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components.
> For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace01/Runspace01.cs" range="11-62":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
