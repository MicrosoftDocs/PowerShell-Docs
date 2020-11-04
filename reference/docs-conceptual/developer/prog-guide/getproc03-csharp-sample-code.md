---
ms.date: 09/13/2016
ms.topic: reference
title: GetProc03 (C#) Sample Code
description: GetProc03 (C#) Sample Code
---
# GetProc03 (C#) Sample Code

The following code shows the implementation of a `Get-Process` cmdlet that can accept pipelined
input. This implementation defines a `Name` parameter that accepts pipeline input, retrieves process
information from the local computer based on the supplied names, and then uses the
[WriteObject(System.Object,System.Boolean)](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
method as the output mechanism for sending objects to the pipeline.

> [!NOTE]
> You can download the C# source file (getprov03.cs) for this Get-Proc cmdlet using the Microsoft
> Windows Software Development Kit for Windows Vista and .NET Framework 3.0 Runtime Components. For
> download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample03/GetProcessSample03.cs" range="11-78":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
