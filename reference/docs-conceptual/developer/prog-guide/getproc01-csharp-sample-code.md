---
ms.date: 09/13/2016
ms.topic: reference
title: GetProc01 (C#) Sample Code
description: GetProc01 (C#) Sample Code
---
# GetProc01 (C#) Sample Code

The following code shows the implementation of the GetProc01 sample cmdlet. Notice that the cmdlet
is simplified by leaving the actual work of process retrieval to the
[System.Diagnostics.Process.Getprocesses*](/dotnet/api/System.Diagnostics.Process.GetProcesses)
method.

> [!NOTE]
> You can download the C# source file (getproc01.cs) for this Get-Proc cmdlet using the Microsoft
> Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime Components. For
> download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample01/GetProcessSample01.cs" range="11-126":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
