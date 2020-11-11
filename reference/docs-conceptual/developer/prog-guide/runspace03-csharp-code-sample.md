---
ms.date: 09/13/2016
ms.topic: reference
title: RunSpace03 (C#) Code Sample
description: RunSpace03 (C#) Code Sample
---
# RunSpace03 (C#) Code Sample

Here is the C# source code for the console application described in "Creating a
Console Application That Runs a Specified Script". This sample uses the
[System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke)
class to execute a script that retrieves process information by using the list
of process names passed into the script. It shows how to pass input objects to
a script and how to retrieve error objects as well as the output objects.

> [!NOTE]
> You can download the C# source file (runspace03.cs) for this sample using the
> Microsoft Windows Software Development Kit for Windows Vista and Microsoft
> .NET Framework 3.0 Runtime Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>**
> directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/Runspace03/Runspace03.cs" range="11-88":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
