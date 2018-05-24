---
title: "RunSpace05 Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 9688cd69-07ea-4ea0-8822-0a4850bcf86c
caps.latest.revision: 7
---
# RunSpace05 Code Sample
Here is the source code for the Runspace05 sample that is described in [Configuring a Runspace Using RunspaceConfiguration &#91;ps&#93;](http://msdn.microsoft.com/en-us/42681d19-2d05-4975-befd-afb1990e79b2). This sample shows how to create the runspace configuration information, create a runspace, create a pipeline with a single command, and then execute the pipeline. The command that is executed is the Get-Process cmdlet.

> [!NOTE]
>  You can download the C# source file (runspace05.cs) by using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>  You can download the C# source file (runspace05.cs) by using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>
>  The downloaded source files are available in the **\<PowerShell Samples>** directory.

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
  internal class Runspace05
  {
    /// <summary>
    /// This sample uses an initial session state to create a runspace. The sample
    /// invokes a command from a PowerShell snap-in present in the console file.
    /// </summary>
    /// <param name="args">Parameter not used.</param>
    /// <remarks>
    /// This sample assumes that user has the GetProcessSample01.dll that is produced 
    /// by the GetProcessSample01 sample copied to the current directory. 
    /// This sample demonstrates the following:
    /// 1. Creating a default initial session state.
    /// 2. Creating a runspace using the default initial session state.
    /// 3. Creating a PowerShell object that uses the runspace.
    /// 4. Adding the get-proc cmdlet to the PowerShell object from a 
    ///    snap-in.
    /// 5. Using PSObject objects to extract and display properties from 
    ///    the objects returned by the cmdlet.
    /// </remarks>
    private static void Main(string[] args)
    {
      // Create the default initial session state. The default initial 
      // session state contains all the elements provided by Windows PowerShell.
      InitialSessionState iss = InitialSessionState.CreateDefault();
      PSSnapInException warning;
      iss.ImportPSSnapIn("GetProcPSSnapIn01", out warning);
           
      // Create a runspace. Notice that no PSHost object is supplied to the 
      // CreateRunspace method so the default host is used. See the Host 
      // samples for more information on creating your own custom host.
      using (Runspace myRunSpace = RunspaceFactory.CreateRunspace(iss))
      {
        myRunSpace.Open();
         
        // Create a PowerShell object. 
        using (PowerShell powershell = PowerShell.Create())
        {
          // Add the Cmdlet and specify the runspace.
          powershell.AddCommand("GetProcPSSnapIn01\\get-proc");
          powershell.Runspace = myRunSpace;
         
          // Run the cmdlet synchronously.
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

## Code Sample

[!code-csharp[Runspace05.cs](../../powershell-sdk-samples/SDK-2.0/csharp/Runspace05/Runspace05.cs#L11-L86 "Runspace05.cs")]

## See Also

 [Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
 [Windows PowerShell SDK](../windows-powershell-reference.md)
