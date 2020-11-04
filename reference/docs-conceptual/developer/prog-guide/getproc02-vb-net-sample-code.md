---
ms.date: 09/13/2016
ms.topic: reference
title: GetProc02 (VB.NET) Sample Code
description: GetProc02 (VB.NET) Sample Code
---
# GetProc02 (VB.NET) Sample Code

The following code shows the implementation of a `Get-Process` cmdlet that accepts command-line
input. Notice that this implementation defines a `Name` parameter to allow command-line input, and
it uses the
[WriteObject(System.Object,System.Boolean)](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
method as the output mechanism for sending output objects to the pipeline.

## Code Sample

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesgetproc02#getproc02vball](Msh_samplesgetproc02#getproc02vball)]  -->

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
