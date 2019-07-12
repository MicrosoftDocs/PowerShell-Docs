---
title: "GetProc04 (C#) Sample Code | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 439ba3f3-91b1-46a4-8d07-9af6edb71bc4
caps.latest.revision: 5
---
# GetProc04 (C#) Sample Code

The following code shows the implementation of a `Get-Process` cmdlet that reports nonterminating errors. This implementation calls the [System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) method to report nonterminating errors.

> [!NOTE]
> You can download the C# source file (getprov04.cs) for this Get-Proc cmdlet using the Microsoft Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/developer/installing-the-windows-powershell-sdk).
>
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

[!code-csharp[GetProcessSample04.cs](../../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample04/GetProcessSample04.cs#L11-L98 "GetProcessSample04.cs")]

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)