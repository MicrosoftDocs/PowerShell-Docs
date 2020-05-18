---
title: "Creating a Workflow by Using a Windows PowerShell Script | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 70532e7e-9cac-43c3-9687-e77011ecc878
caps.latest.revision: 4
---
# Creating a Workflow by Using a Windows PowerShell Script

You can create a workflow by writing a Windows PowerShell script. To create a workflow, use the
workflow keyword followed by a name for the workflow before the body of the script. For example:

```powershell

workflow Invoke-HelloWorld {"Hello World from workflow"}
```

You find the workflow in the same way you would any other Windows PowerShell command.

## Implementing Parallel and Sequence

[Windows Workflow Foundation](/previous-versions/dotnet/netframework-3.5/ms735967(v=vs.90)) supports
execution of activities in parallel. To implement this capability in a Windows PowerShell script,
use the `parallel` keyword in front of a script block. You can also use the `foreach -parallel`
construction to iterate through a collection of objects in parallel. To execute a group of
activities in sequential order within a parallel block, enclose that group of activities in a script
block and precede the block with the sequence keyword.

## Joining Computers to a Domain

The following script creates a workflow that checks the domain status of a group of user-specified
computers, joins them to a domain if they are not already joined, and then checks the status again.
This is a script version of the XAML workflow explained in
[Creating a Workflow with Windows PowerShell Activities](./creating-a-workflow-with-windows-powershell-activities.md).

```powershell
workflow Join-Domain
{
    param([string[]] $ComputerName, [PSCredential] $DomainCred, [PsCredential] $MachineCred)

    foreach -parallel($Computer in $ComputerName)
    {
        sequence {
        Get-WmiObject -PSComputerName $Computer -PSCredential $MachineCred
        Add-Computer -PSComputerName $Computer -PSCredential $DomainCred
        Restart-Computer -ComputerName $Computer -Credential $MachineCred -For PowerShell -Force -Wait -PSComputerName ""
        Get-WmiObject -PSComputerName $Computer -PSCredential $MachineCred
        }
    }
}
```
