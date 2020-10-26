---
ms.date: 09/13/2016
ms.topic: reference
title: Runspace07 Sample
description: Runspace07 Sample
---
# Runspace07 Sample

This sample shows how to create a runspace, and then use that runspace to run two cmdlets synchronously by using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

## Requirements

This sample requires Windows PowerShell 2.0.

## Demonstrates

This sample demonstrates the following.

- Creating a [System.Management.Automation.Runspaces.Runspace](/dotnet/api/System.Management.Automation.Runspaces.Runspace) object by using the [System.Management.Automation.Runspaces.Runspacefactory](/dotnet/api/System.Management.Automation.Runspaces.RunspaceFactory) class.

- Creating a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object that uses the runspace.

- Adding cmdlets to the pipeline of the [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

- Running the cmdlets synchronously.

- Extracting properties from the [System.Management.Automation.PSObject](/dotnet/api/System.Management.Automation.PSObject) objects returned by the command.

## Example

This sample creates a runspace that used by a [System.Management.Automation.PSObject](/dotnet/api/System.Management.Automation.PSObject) object to run the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) and [Measure-Object](/powershell/module/microsoft.powershell.utility/measure-object) cmdlets.

```csharp
namespace Microsoft.Samples.PowerShell.Runspaces
{
  using System;
  using System.Collections.ObjectModel;
  using System.Management.Automation;
  using System.Management.Automation.Runspaces;
  using PowerShell = System.Management.Automation.PowerShell;

  /// <summary>
  /// This class contains the Main entry point for this host application.
  /// </summary>
  internal class Runspace07
  {
    /// <summary>
    /// This sample shows how to create a runspace and how to run commands
    /// using a PowerShell object. It builds a pipeline that runs the
    /// get-process cmdlet, which is piped to the measure-object
    /// cmdlet to count the number of processes running on the system.
    /// </summary>
    /// <param name="args">The parameter is not used.</param>
    /// <remarks>
    /// This sample demonstrates the following:
    /// 1. Creating a runspace using the RunspaceFactory class.
    /// 2. Creating a PowerShell object that uses the runspace.
    /// 3. Adding cmdlets to the pipeline of the PowerShell object.
    /// 4. Running the cmdlets synchronously.
    /// 5. Working with PSObject objects to extract properties
    ///    from the objects returned by the cmdlets.
    /// </remarks>
    private static void Main(string[] args)
    {
      Collection<PSObject> result;     // Will hold the result
                                       // of running the cmdlets.

      // Create a runspace. We can not use the RunspaceInvoke class
      // because we need to get at the underlying runspace to
      // explicitly add the commands. Notice that no PSHost object is
      // supplied to the CreateRunspace method so the default host is
      // used. See the Host samples for more information on creating
      // your own custom host.
      using (Runspace myRunSpace = RunspaceFactory.CreateRunspace())
      {
        myRunSpace.Open();

        // Create a PowerShell object and specify the runspace.
        PowerShell powershell = PowerShell.Create();
        powershell.Runspace = myRunSpace;

        // Use the using statement so we dispose of the PowerShell object
        // when we're done.
        using (powershell)
        {
          // Add the get-process cmdlet to the PowerShell object. Notice
          // we are specify the name of the cmdlet, not a script.
          powershell.AddCommand("get-process");

          // Add the measure-object cmdlet to count the number
          // of objects being returned. Commands are always added to the end
          // of the pipeline.
          powershell.AddCommand("measure-object");

          // Run the cmdlets synchronously and save the objects returned.
          result = powershell.Invoke();
        }

        // Even after disposing of the pipeLine, we still need to set
        // the powershell variable to null so that the garbage collector
        // can clean it up.
        powershell = null;

        // Display the results of running the commands (checking that
        // everything is ok first.
        if (result == null || result.Count != 1)
        {
          throw new InvalidOperationException(
                    "pipeline.Invoke() returned the wrong number of objects");
        }

        PSMemberInfo count = result[0].Properties["Count"];
        if (count == null)
        {
          throw new InvalidOperationException(
                    "The object returned doesn't have a 'count' property");
        }

        Console.WriteLine(
                   "Runspace07: The Get-Process cmdlet returned {0} objects",
                   count.Value);

        // Close the runspace to release any resources.
        myRunSpace.Close();
      }

      System.Console.WriteLine("Hit any key to exit...");
      System.Console.ReadKey();
    }
  }
}
```

## See Also

[Writing a Windows PowerShell Host Application](./writing-a-windows-powershell-host-application.md)
