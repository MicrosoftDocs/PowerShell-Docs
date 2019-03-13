---
title: "Creating a Workflow with Windows PowerShell Activities | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: fb55971a-4ea4-4c51-aeff-4e0bb05a51b2
caps.latest.revision: 6
---
# Creating a Workflow with Windows PowerShell Activities

You can create a Windows PowerShell workflow by selecting activities from the Visual Studio Toolbox and dragging them to the Workflow Designer window. For information about adding Windows PowerShell activities to the Visual Studio Toolbox, see [Adding Windows PowerShell Activities to the Visual Studio Toolbox](./adding-windows-powershell-activities-to-the-visual-studio-toolbox.md).

The following procedures describe how to create a workflow that checks the domain status of a group of user-specified computers, joins them to a domain if they are not already joined, and then checks the status again.

### Setting up the Project

1. Follow the procedure in [Adding Windows PowerShell Activities to the Visual Studio Toolbox](./adding-windows-powershell-activities-to-the-visual-studio-toolbox.md) to create a workflow project and add the activities from the [Microsoft.Powershell.Activities](/dotnet/api/Microsoft.PowerShell.Activities) and [Microsoft.Powershell.Management.Activities](/dotnet/api/Microsoft.PowerShell.Management.Activities) assemblies to the toolbox.

2. Add System.Management.Automation, Microsoft.PowerShell.Activities, System.Management, Microsoft.PowerShell.Management.Activities, and Microsoft.PowerShell.Commands.Management as to the project as reference assemblies.

### Adding Activities to the Workflow

1. Add a **Sequence** activity to the workflow.

2. Create an argument named `ComputerName` with an argument type of `String[]`. This argument represents the names of the computers to check and join.

3. Create an argument named `DomainCred` of type [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential). This argument represents the domain credentials of a domain account that is authorized to join a computer to the domain.

4. Create an argument named `MachineCred` of type [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential). This argument represents the credentials of an administrator on the computers to check and join.

5. Add a **ParallelForEach** activity inside the **Sequence** activity. Enter `comp` and `ComputerName` in the text boxes so that the loop iterates through the elements of the `ComputerName` array.

6. Add a **Sequence** activity to the body of the **ParallelForEach** activity. Set the **DisplayName** property of the sequence to `JoinDomain`.

7. Add a **GetWmiObject** activity to the **JoinDomain** sequence.

8. Edit the properties of the **GetWmiObject** activity as follows.

   |Property|Value|
   |--------------|-----------|
   |**Class**|"Win32_ComputerSystem"|
   |**PSComputerName**|{comp}|
   |**PSCredential**|MachineCred|

9. Add an **AddComputer** activity to the **JoinDomain** sequence after the **GetWmiObject** activity.

10. Edit the properties of the **AddComputer** activity as follows.

    |Property|Value|
    |--------------|-----------|
    |**ComputerName**|{comp}|
    |**DomainCredential**|DomainCred|

11. Add a **RestartComputer** activity to the **JoinDomain** sequence after the **AddComputer** activity.

12. Edit the properties of the **RestartComputer** activity as follows.

    |Property|Value|
    |--------------|-----------|
    |**ComputerName**|{comp}|
    |**Credential**|MachineCred|
    |**For**|Microsoft.PowerShell.Commands.WaitForServiceTypes.PowerShell|
    |**Force**|True|
    |Wait|True|
    |PSComputerName|{""}|

13. Add a **GetWmiObject** activity to the **JoinDomain** sequence after the **RestartComputer** activity. Edit its properties to be the same as the previous **GetWmiObject** activity.

    When you have finished the procedures, the workflow design window should look like this.

    ![JoinDomain XAML in Workflow designer](../media/joindomainworkflow.png)
    ![JoinDomain XAML in Workflow designer](../media/joindomainworkflow.png "JoinDomainWorkflow")