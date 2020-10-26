---
ms.date: 09/12/2016
ms.topic: reference
title: Creating remote runspaces
description: Creating remote runspaces
---

# Creating remote runspaces

PowerShell commands that take a **ComputerName** parameter can be run on any computer that runs
PowerShell. To run commands that don't take a **ComputerName** parameter, you can use WS-Management
to configure a runspace that connects to a specified computer, and run commands on that computer.

## Using a WSManConnection to create a remote runspace

 To create a runspace that connects to a remote computer, you create a
 [System.Management.Automation.Runspaces.WSManConnectionInfo](/dotnet/api/System.Management.Automation.Runspaces.WSManConnectionInfo)
 object. You specify the target endpoint for the connection by setting the
 [System.Management.Automation.Runspaces.WSManConnectionInfo.ConnectionUri](/dotnet/api/System.Management.Automation.Runspaces.WSManConnectionInfo.ConnectionUri)
 property of the object. You then create a runspace by calling the
 [System.Management.Automation.Runspaces.RunspaceFactory.CreateRunspace](/dotnet/api/System.Management.Automation.Runspaces.RunspaceFactory.CreateRunspace)
 method, specifying the
 [System.Management.Automation.Runspaces.WSManConnectionInfo](/dotnet/api/System.Management.Automation.Runspaces.WSManConnectionInfo)
 object as the `connectionInfo` parameter.

 The following example shows how to create a runspace that connects to a remote computer. In the
 example, `RemoteComputerUri` is used as a placeholder for the actual URI of a remote computer.

```csharp
namespace Samples
{
  using System;
  using System.Collections.ObjectModel;
  using System.Management.Automation;            // PowerShell namespace.
  using System.Management.Automation.Runspaces;  // PowerShell namespace.

  /// <summary>
  /// This class contains the Main entry point for this host application.
  /// </summary>
  internal class RemoteRunspace02
  {
    /// <summary>
    /// This sample shows how to create a remote runspace that
    /// runs commands on the local computer.
    /// </summary>
    /// <param name="args">Parameter not used.</param>
    private static void Main(string[] args)
    {
      // Create a WSManConnectionInfo object using the default constructor
      // to connect to the "localHost". The WSManConnectionInfo object can
      // also be used to specify connections to remote computers.
      Uri RemoteComputerUri = new Uri("http://Server01:5985/WSMAN");
      WSManConnectionInfo connectionInfo = new WSManConnectionInfo(RemoteComputerUri);

      // Set the OperationTimeout property and OpenTimeout properties.
      // The OperationTimeout property is used to tell PowerShell
      // how long to wait (in milliseconds) before timing out for an
      // operation. The OpenTimeout property is used to tell Windows
      // PowerShell how long to wait (in milliseconds) before timing out
      // while establishing a remote connection.
      connectionInfo.OperationTimeout = 4 * 60 * 1000; // 4 minutes.
      connectionInfo.OpenTimeout = 1 * 60 * 1000; // 1 minute.

      // Create a remote runspace using the connection information.
      //using (Runspace remoteRunspace = RunspaceFactory.CreateRunspace())
      using (Runspace remoteRunspace = RunspaceFactory.CreateRunspace(connectionInfo))
      {
        // Establish the connection by calling the Open() method to open the runspace.
        // The OpenTimeout value set previously will be applied while establishing
        // the connection. Establishing a remote connection involves sending and
        // receiving some data, so the OperationTimeout will also play a role in this process.
          remoteRunspace.Open();

        // Create a PowerShell object to run commands in the remote runspace.
        using (PowerShell powershell = PowerShell.Create())
        {
          powershell.Runspace = remoteRunspace;
          powershell.AddCommand("get-process");
          powershell.Invoke();

          Collection<PSObject> results = powershell.Invoke();

          Console.WriteLine("Process              HandleCount");
          Console.WriteLine("--------------------------------");

          // Display the results.
          foreach (PSObject result in results)
          {
            Console.WriteLine(
                              "{0,-20} {1}",
                              result.Members["ProcessName"].Value,
                              result.Members["HandleCount"].Value);
          }
        }

        // Close the connection. Call the Close() method to close the remote
        // runspace. The Dispose() method (called by using primitive) will call
        // the Close() method if it is not already called.
        remoteRunspace.Close();
      }
    }
  }
}
```
