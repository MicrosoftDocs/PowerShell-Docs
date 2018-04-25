---
title: "GetProc02 (C#) Sample Code | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: e4e1eee3-316b-43a4-8a60-313391619be6
caps.latest.revision: 6
---
# GetProc02 (C#) Sample Code
The following code shows the implementation of a Get-Process cmdlet that accepts command-line input. Notice that this implementation defines a `Name` parameter to allow command-line input, and it uses the [System.Management.Automation.Cmdlet.Writeobject%28System.Object%2Csystem.Boolean%29](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject%28System.Object%2CSystem.Boolean%29) method as the output mechanism for sending output objects to the pipeline.

## Code Sample
<!-- TODO: review snippet reference  [!CODE [Msh_samplesgetproc02#GetProc02GetProcAll](Msh_samplesgetproc02#GetProc02GetProcAll)]  -->

## See Also
 [Windows PowerShell SDK](../windows-powershell-reference.md)
