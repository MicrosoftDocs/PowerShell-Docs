---
title: "Runspace02 (C#) Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 59a7b8b9-f72e-43fd-9a10-77404441a3f2
caps.latest.revision: 6
---
# Runspace02 (C#) Code Sample
Here is the C# source code for the Runspace02 sample. This sample uses the [System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke) class to execute the Get-Process cmdlet synchronously. Windows Forms and data binding are then used to display the results in a DataGridView control

## Code Sample

```csharp
namespace Microsoft.Samples.PowerShell.Runspaces
{
  using System;
  using System.Collections;
  using System.Collections.ObjectModel;
  using System.Management.Automation;
  using System.Management.Automation.Runspaces;
  using System.Windows.Forms;
  using PowerShell = System.Management.Automation.PowerShell;

  /// <summary>
  /// This class contains the Main entry point for this host application.
  /// </summary>
  internal class Runspace02
  {
    /// <summary>
    /// This method creates the form where the output is displayed.
    /// </summary>
    private static void CreateForm()
    {
      Form form = new Form();
      DataGridView grid = new DataGridView();
      form.Controls.Add(grid);
      grid.Dock = DockStyle.Fill;

      // Create a PowerShell object. Creating this object takes care of 
      // building all of the other data structures needed to run the command.
      using (PowerShell powershell = PowerShell.Create())
      {
        powershell.AddCommand("get-process").AddCommand("sort-object").AddArgument("ID");
        if (Runspace.DefaultRunspace == null)
        {
          Runspace.DefaultRunspace = powershell.Runspace;
        }
        
        Collection<PSObject> results = powershell.Invoke();
        
        // The generic collection needs to be re-wrapped in an ArrayList
        // for data-binding to work.
        ArrayList objects = new ArrayList();
        objects.AddRange(results);
        
        // The DataGridView will use the PSObjectTypeDescriptor type
        // to retrieve the properties.
        grid.DataSource = objects;
      }
      
      form.ShowDialog();
    }
    
    /// <summary>
    /// This sample uses a PowerShell object to run the 
    /// Get-Process cmdlet synchronously. Windows Forms and 
    /// data binding are then used to display the results in a
    /// DataGridView control.
    /// </summary>
    /// <param name="args">Parameter not used.</param>
    /// <remarks>
    /// This sample demonstrates the following:
    /// 1. Creating a PowerShell object.
    /// 2. Adding commands and arguments to the pipeline of 
    ///    the powershell object.
    /// 3. Running the commands synchronously.
    /// 4. Using a DataGridView control to display the output 
    ///    of the PowerShell object in a Windows Forms application. 
    /// </remarks>
    private static void Main(string[] args)
    {
      Runspace02.CreateForm();
    }
  }
}
```

[!code-csharp[Runspace02.cs](../../powershell-sdk-samples/SDK-2.0/csharp/Runspace02/Runspace02.cs#L11-L82 "Runspace02.cs")]

## See Also

 [Windows PowerShell SDK](../windows-powershell-reference.md)
