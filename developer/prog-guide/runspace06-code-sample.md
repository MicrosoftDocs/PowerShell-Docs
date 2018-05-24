---
title: "RunSpace06 Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d71f86d5-eb62-4b16-aa95-5fd3f314ffd3
caps.latest.revision: 6
---
# RunSpace06 Code Sample
Here is the source code for the Runspace06 sample described in [Configuring a Runspace Using a Windows PowerShell Snap-in &#91;ps&#93;](http://msdn.microsoft.com/en-us/a7289ee8-9732-49ee-91c7-d533e9538b83). This sample application creates a runspace based on a Windows PowerShell snap-in, which is then used to run a pipeline with a single command. To do this, the application creates the runspace configuration information, creates a runspace, creates a pipeline with a single command, and then executes the pipeline.

> [!NOTE]
>  You can download the C# source file (runspace06.cs) by using the Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>  You can download the C# source file (runspace06.cs) by using the Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>
>  The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

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
  internal class Runspace06
  {
    /// <summary>
    /// This sample uses an initial session state to create a runspace. 
    /// The sample invokes a command from binary module that is loaded by the 
    /// initial session state.
    /// </summary>
    /// <param name="args">Parameter not used.</param>
    /// <remarks>
    /// This sample assumes that user has the GetProcessSample02.dll that is 
    /// produced by the GetProcessSample02 sample copied to the current directory. 
    /// This sample demonstrates the following:
    /// 1. Creating a default initial session state.
    /// 2. Creating a runspace using the initial session state.
    /// 3. Creating a PowerShell object that uses the runspace.
    /// 4. Adding the get-proc cmdlet to the PowerShell object from a 
    ///    module.
    /// 5. Using PSObject objects to extract and display properties from 
    ///    the objects returned by the cmdlet.
    /// </remarks>
    private static void Main(string[] args)
    {
      // Create an initial session state.
      InitialSessionState iss = InitialSessionState.CreateDefault();
      iss.ImportPSModule(new string[] { @".\GetProcessSample02.dll" });

      // Create a runspace. Notice that no PSHost object is supplied to the 
      // CreateRunspace method so the default host is used. See the Host 
      // samples for more information on creating your own custom host.
      using (Runspace myRunSpace = RunspaceFactory.CreateRunspace(iss))
      {
        myRunSpace.Open();

        // Create a PowerShell object. 
        using (PowerShell powershell = PowerShell.Create())
        {
          // Add the cmdlet and specify the runspace.
          powershell.AddCommand(@"GetProcessSample02\get-proc");
          powershell.Runspace = myRunSpace;

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
        
        // Close the runspace to release any resources.
        myRunSpace.Close();
      }

      System.Console.WriteLine("Hit any key to exit...");
      System.Console.ReadKey();
    }
  }
}
```

[!code-csharp[Runspace06.cs](../../powershell-sdk-samples/SDK-2.0/csharp/Runspace06/Runspace06.cs#L11-L85 "Runspace06.cs")]

## See Also

 [Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
 [Windows PowerShell SDK](../windows-powershell-reference.md)
