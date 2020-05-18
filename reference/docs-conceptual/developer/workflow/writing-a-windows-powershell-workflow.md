---
title: "Writing a Windows PowerShell Workflow | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 2551ceed-836f-4275-9fc0-ea68446d6a35
caps.latest.revision: 7
---
# Writing a Windows PowerShell Workflow

You can create a XAML workflow by adding activities exposed by Windows PowerShell assemblies to the Workflow designer in Visual Studio. The following Windows PowerShell assemblies expose workflow-enabled activities.

> [!IMPORTANT]
> A XAML workflow must be packaged as a module if you want to provide help for the workflow. For information about modules, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

- [Microsoft.Powershell.Activities](/dotnet/api/Microsoft.PowerShell.Activities)

- [Microsoft.Powershell.Core.Activities](/dotnet/api/Microsoft.PowerShell.Core.Activities)

- [Microsoft.Powershell.Diagnostics.Activities](/dotnet/api/Microsoft.PowerShell.Diagnostics.Activities)

- [Microsoft.Powershell.Management.Activities](/dotnet/api/Microsoft.PowerShell.Management.Activities)

- [Microsoft.Powershell.Security.Activities](/dotnet/api/Microsoft.PowerShell.Security.Activities)

- [Microsoft.Powershell.Utility.Activities](/dotnet/api/Microsoft.PowerShell.Utility.Activities)

  The following topics describe how to create a Workflow by using Windows PowerShell activities.

- [Adding Windows PowerShell Activities to the Visual Studio Toolbox](./adding-windows-powershell-activities-to-the-visual-studio-toolbox.md)

- [Creating a Workflow with Windows PowerShell Activities](./creating-a-workflow-with-windows-powershell-activities.md)

- [Creating a Workflow by Using a Windows PowerShell Script](./creating-a-workflow-by-using-a-windows-powershell-script.md)

- [Importing and Invoking a Windows PowerShell Workflow](./importing-and-invoking-a-windows-powershell-workflow.md)

- [Creating a Workflow Activity from a Windows PowerShell Cmdlet](./creating-a-workflow-activity-from-a-windows-powershell-cmdlet.md)
