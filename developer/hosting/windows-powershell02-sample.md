---
title: "Windows PowerShell02 Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 92492a7e-257d-47d3-b119-89df3c5545e8
caps.latest.revision: 9
---
# Windows PowerShell02 Sample
This sample shows how to run commands asynchronously by using the runspaces of a runspace pool. The sample generates a list of commands, and then runs those commands while the Windows PowerShell engine opens a runspace from the pool when it is needed.

## Requirements

-   This sample requires Windows PowerShell 2.0.

## Demonstrates
 This sample demonstrates the following:

-   Creating a RunspacePool object with a minimum and maximum number of runspaces allowed to be open at the same time.

-   Creating a list of commands.

-   Running the commands asynchronously.

-   Calling the [System.Management.Automation.Runspaces.Runspacepool.Getavailablerunspaces*](/dotnet/api/System.Management.Automation.Runspaces.RunspacePool.GetAvailableRunspaces) method to see how many runspaces are free.

-   Capturing the command output with the [System.Management.Automation.Powershell.Endinvoke*](/dotnet/api/System.Management.Automation.PowerShell.EndInvoke) method.

## Example
 This sample shows how to open the runspaces of a runspace pool, and how to asynchronously run commands in those runspaces.

```csharp
namespace Sample
{
  using System;
  using System.Collections;
  using System.Collections.Generic;
  using System.Management.Automation;
  using System.Management.Automation.Runspaces;

  /// <summary>
  /// This class contains the Main entry point for the application.
  /// </summary>
  internal class PowerShell02
  {
    /// <summary>
    /// Runs numerous commands with the help of a runspace pool.
    /// </summary>
    /// <param name="args">This parameter is unused.</param>
    private static void Main(string[] args)
    {
      // Creating and opening runspace pool. A minimum of 1 runspace and a maximum of
      // 5 runspaces can be opened at the same time.
      RunspacePool runspacePool = RunspaceFactory.CreateRunspacePool(1, 5);
      runspacePool.Open();

      using (runspacePool)
      {
        // Define the commands to be run.
        List<PowerShell> powerShellCommands = new List<PowerShell>();

        // The command results.
        List<IAsyncResult> powerShellCommandResults = new List<IAsyncResult>();

        // The maximum number of runspaces that can be opened at one tine is
        // is 5, but we can queue up many more commands that will use the
        // runspace pool.
        for (int i = 0; i < 100; i++)
        {
          // Using a PowerShell object, run the commands.
          PowerShell powershell = PowerShell.Create();

          // Instead of setting the Runspace property of powershell,
          // the RunspacePool property is used. That is the only difference
          // between running commands with a runspace and running commands
          // with a runspace pool.
          powershell.RunspacePool = runspacePool;

          // The script to be run outputs a sequence number and the number of available runspaces
          // in the pool.
          string script = String.Format(
                        "write-output ' Command: {0}, Available Runspaces: {1}'",
                        i,
                        runspacePool.GetAvailableRunspaces());

          // The three lines below look the same running with a runspace or
          // with a runspace pool.
          powershell.AddScript(script);
          powerShellCommands.Add(powershell);
          powerShellCommandResults.Add(powershell.BeginInvoke());
        }

        // Collect the results.
        for (int i = 0; i < 100; i++)
        {
          // EndInvoke will wait for each command to finish, so we will be getting the commands
          // in the same 0 to 99 order that they have been invoked with BeginInvoke.
          PSDataCollection<PSObject> results = powerShellCommands[i].EndInvoke(powerShellCommandResults[i]);

          // Print all the results. One PSObject with a plain string is the expected result.
          PowerShell02.PrintCollection(results);
        }
      }
    }

    /// <summary>
    /// Iterates through a collection printing all items.
    /// </summary>
    /// <param name="collection">collection to be printed</param>
    private static void PrintCollection(IList collection)
    {
      foreach (object obj in collection)
      {
        Console.WriteLine("PowerShell Result: {0}", obj);
      }
    }
  }
}

```

[!code-csharp[PowerShell02.cs](../../powershell-sdk-samples/SDK-2.0/csharp/PowerShell02/PowerShell02.cs#L11-L96 "PowerShell02.cs")]

## See Also

 [Writing a Windows PowerShell Host Application](./writing-a-windows-powershell-host-application.md)
