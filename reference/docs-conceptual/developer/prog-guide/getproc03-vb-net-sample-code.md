---
ms.date: 09/12/2016
ms.topic: reference
title: GetProc03 (VB.NET) Sample Code
description: GetProc03 (VB.NET) Sample Code
---
# GetProc03 (VB.NET) Sample Code

The following code shows the implementation of a `Get-Process` cmdlet that can accept pipelined
input. This implementation defines a `Name` parameter that accepts pipeline input, retrieves process
information from the local computer based on the supplied names, and then uses the
[WriteObject(System.Object,System.Boolean)](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
method as the output mechanism for sending objects to the pipeline.

## Code Sample

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesgetproc03#getproc03vbAll](Msh_samplesgetproc03#getproc03vbAll)]  -->
