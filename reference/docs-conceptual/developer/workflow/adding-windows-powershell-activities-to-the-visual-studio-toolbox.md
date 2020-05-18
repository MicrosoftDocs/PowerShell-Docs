---
title: "Adding Windows PowerShell Activities to the Visual Studio Toolbox | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 9c8ef289-0659-42d1-9976-044b144201eb
caps.latest.revision: 6
---
# Adding Windows PowerShell Activities to the Visual Studio Toolbox

Before you author a PowerShell Workflow using Workflow Designer, you must first add the PowerShell Activities to the Toolbox in a Visual Studio Workflow console application project. The following procedure shows how to add the activities from the Microsoft.PowerShell.Core.Activities assembly to the Visual Studio toolbox.

### Adding Windows PowerShell Activities to the Toolbox

1. Create a new Workflow console application project in Visual Studio.

2. On the **View** menu, click **Toolbox**.

3. Add a new tab in the Toolbox by right-clicking inside the Toolbox and clicking **Add Tab**, and give the new tab a name such as "PowerShell Activities".

   Adding a tab allows you to group the PowerShell Activities separate from other tools in the Toolbox.

4. On the new Toolbox tab, click **Choose Items...**. The **Choose Toolbox Items** dialog appears.

5. In the **Choose Toolbox Items** dialog, click the **System.Activities** tab.

6. Click **Browse**.

7. Navigate to the %WINDIR%\Microsoft.NET\assembly\GAC_MSIL\Microsoft.PowerShell.Core.Activities\v4.0_3.0.0.0__31bf3856ad364e folder and double-click Microsoft.PowerShell.Core.Activities.dll.

8. Click **OK**. The activities defined by the Microsoft.PowerShell.Core.Activities assembly are now available in the toolbox.

## See Also

[Writing a Windows PowerShell Workflow](./writing-a-windows-powershell-workflow.md)

[Creating a Workflow with Windows PowerShell Activities](./creating-a-workflow-with-windows-powershell-activities.md)
