---
title: "Runspace11 Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 9c90d268-730b-4e73-9dfd-5f288c27aed0
caps.latest.revision: 8
---
# Runspace11 Sample

This sample shows how to use the [System.Management.Automation.Proxycommand](/dotnet/api/System.Management.Automation.ProxyCommand) class to create a proxy command that calls an existing cmdlet, but restricts the set of available parameters. The proxy command is then added to an initial session state that is used to create a constrained runspace. This means that the user can access the functionality of the cmdlet only through the proxy command.

## Requirements

This sample requires Windows PowerShell 2.0.

## Demonstrates

This sample demonstrates the following.

- Creating a [System.Management.Automation.Commandmetadata](/dotnet/api/System.Management.Automation.CommandMetadata) object that describes the metadata of an existing cmdlet.

- Creating an [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object.

- Modifying the cmdlet metadata to remove a parameter of the cmdlet.

- Adding the cmdlet to the [System.Management.Automation.Runspaces.Initialsessionstate](/dotnet/api/System.Management.Automation.Runspaces.InitialSessionState) object and making the cmdlet private.

- Creating a proxy function that calls the existing cmdlet, but exposes only a restricted set of parameters.

- Adding the proxy function to the initial session state.

- Creating a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object that uses the [System.Management.Automation.Runspaces.Runspace](/dotnet/api/System.Management.Automation.Runspaces.Runspace) object.

- Calling the private cmdlet and the proxy function using a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object to demonstrate the constrained runspace.

## Example

This creates a proxy command for a private cmdlet to demonstrate a constrained runspace.

```csharp
namespace Microsoft.Samples.PowerShell.Runspaces
{
  using System;
  using System.Collections.Generic;
  using System.Diagnostics;
  using System.Management.Automation;
  using System.Management.Automation.Runspaces;
  using PowerShell = System.Management.Automation.PowerShell;

  #region GetProcCommand

  /// <summary>
  /// This class implements the get-proc cmdlet. It has been copied
  /// verbatim from the GetProcessSample02.cs sample.
  /// </summary>
  [Cmdlet(VerbsCommon.Get, "Proc")]
  public class GetProcCommand : Cmdlet
  {
    #region Parameters

    /// <summary>
    /// The names of the processes to act on.
    /// </summary>
    private string[] processNames;

    /// <summary>
    /// Gets or sets the list of process names on which
    /// the Get-Proc cmdlet will work.
    /// </summary>
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty]
    public string[] Name
    {
      get { return this.processNames; }
      set { this.processNames = value; }
    }

    #endregion Parameters

    #region Cmdlet Overrides

    /// <summary>
    /// The ProcessRecord method calls the Process.GetProcesses
    /// method to retrieve the processes specified by the Name
    /// parameter. Then, the WriteObject method writes the
    /// associated processes to the pipeline.
    /// </summary>
    protected override void ProcessRecord()
    {
      // If no process names are passed to the cmdlet, get all
      // processes.
      if (this.processNames == null)
      {
        WriteObject(Process.GetProcesses(), true);
      }
      else
      {
        // If process names are passed to cmdlet, get and write
        // the associated processes.
        foreach (string name in this.processNames)
        {
          WriteObject(Process.GetProcessesByName(name), true);
        }
      } // if (processNames...
    } // ProcessRecord

    #endregion Cmdlet Overrides
  } // GetProcCommand

  #endregion GetProcCommand

  /// <summary>
  /// This class contains the Main entry point for this host application.
  /// </summary>
  internal class Runspace11
  {
    /// <summary>
    /// This shows how to use the ProxyCommand class to create a proxy
    /// command that calls an existing cmdlet, but restricts the set of
    /// available parameters. The proxy command is then added to an initial
    /// session state that is used to create a constrained runspace. This
    /// means that the user can access the cmdlet only through the proxy
    /// command.
    /// </summary>
    /// <remarks>
    /// This sample demonstrates the following:
    /// 1. Creating a CommandMetadata object that describes the metadata of an
    ///    existing cmdlet.
    /// 2. Modifying the cmdlet metadata to remove a parameter of the cmdlet.
    /// 3. Adding the cmdlet to an initial session state and making it private.
    /// 4. Creating a proxy function that calls the existing cmdlet, but exposes
    ///    only a restricted set of parameters.
    /// 6. Adding the proxy function to the initial session state.
    /// 7. Calling the private cmdlet and the proxy function to demonstrate the
    ///    constrained runspace.
    /// </remarks>
    private static void Main()
    {
      // Create a default initial session state. The default initial session state
      // includes all the elements that are provided by Windows PowerShell.
      InitialSessionState iss = InitialSessionState.CreateDefault();

      // Add the get-proc cmdlet to the initial session state.
      SessionStateCmdletEntry cmdletEntry = new SessionStateCmdletEntry("get-proc", typeof(GetProcCommand), null);
      iss.Commands.Add(cmdletEntry);

      // Make the cmdlet private so that it is not accessible.
      cmdletEntry.Visibility = SessionStateEntryVisibility.Private;

      // Set the language mode of the initial session state to NoLanguage to
      //prevent users from using language features. Only the invocation of
      // public commands is allowed.
      iss.LanguageMode = PSLanguageMode.NoLanguage;

      // Create the proxy command using cmdlet metadata to expose the
      // get-proc cmdlet.
      CommandMetadata cmdletMetadata = new CommandMetadata(typeof(GetProcCommand));

      // Remove one of the parameters from the command metadata.
      cmdletMetadata.Parameters.Remove("Name");

      // Generate the body of a proxy function that calls the original cmdlet,
      // but does not have the removed parameter.
      string bodyOfProxyFunction = ProxyCommand.Create(cmdletMetadata);

      // Add the proxy function to the initial session state. The name of the proxy
      // function can be the same as the name of the cmdlet, but to clearly
      // demonstrate that the original cmdlet is not available a different name is
      // used for the proxy function.
      iss.Commands.Add(new SessionStateFunctionEntry("get-procProxy", bodyOfProxyFunction));

      // Create the constrained runspace using the initial session state.
      using (Runspace myRunspace = RunspaceFactory.CreateRunspace(iss))
      {
        myRunspace.Open();

        // Call the private cmdlet to demonstrate that it is not available.
        try
        {
          using (PowerShell powershell = PowerShell.Create())
          {
            powershell.Runspace = myRunspace;
            powershell.AddCommand("get-proc").AddParameter("Name", "*explore*");
            powershell.Invoke();
          }
        }
        catch (CommandNotFoundException e)
        {
          System.Console.WriteLine(
                        "Invoking 'get-proc' failed as expected: {0}: {1}",
                        e.GetType().FullName,
                        e.Message);
        }

        // Call the proxy function to demonstrate that the -Name parameter is
        // not available.
        try
        {
          using (PowerShell powershell = PowerShell.Create())
          {
            powershell.Runspace = myRunspace;
            powershell.AddCommand("get-procProxy").AddParameter("Name", "idle");
            powershell.Invoke();
          }
        }
        catch (ParameterBindingException e)
        {
          System.Console.WriteLine(
                        "\nInvoking 'get-procProxy -Name idle' failed as expected: {0}: {1}",
                        e.GetType().FullName,
                        e.Message);
        }

        // Call the proxy function to demonstrate that it calls into the
        // private cmdlet to retrieve the processes.
        using (PowerShell powershell = PowerShell.Create())
        {
          powershell.Runspace = myRunspace;
          powershell.AddCommand("get-procProxy");
          List<Process> processes = new List<Process>(powershell.Invoke<Process>());
          System.Console.WriteLine(
                        "\nInvoking the get-procProxy function called into the get-proc cmdlet and returned {0} processes",
                        processes.Count);
        }

        // Close the runspace to release resources.
        myRunspace.Close();
      }

      System.Console.WriteLine("Hit any key to exit...");
      System.Console.ReadKey();
    }
  }
}
```

## See Also

[Writing a Windows PowerShell Host Application](./writing-a-windows-powershell-host-application.md)