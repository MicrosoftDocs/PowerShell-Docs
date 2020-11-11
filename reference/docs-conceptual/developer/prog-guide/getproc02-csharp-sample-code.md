---
ms.date: 09/13/2016
ms.topic: reference
title: GetProc02 (C#) Sample Code
description: GetProc02 (C#) Sample Code
---
# GetProc02 (C#) Sample Code

The following code shows the implementation of a `Get-Process` cmdlet that accepts command-line
input. Notice that this implementation defines a `Name` parameter to allow command-line input, and
it uses the
[WriteObject(System.Object,System.Boolean)](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
method as the output mechanism for sending output objects to the pipeline.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample02/GetProcessSample02.cs" range="11-76":::

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
