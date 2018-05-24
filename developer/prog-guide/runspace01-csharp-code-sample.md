---
title: "Runspace01 (C#) Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d59f8b7c-e800-4633-aa5b-74d4c57e2706
caps.latest.revision: 6
---
# Runspace01 (C#) Code Sample
Here are the code samples for the runspace described in [Creating a Console Application That Runs a Specified Command &#91;ps&#93;](http://msdn.microsoft.com/en-us/793a6570-a072-4799-840b-172f28ce620e). To do this, the application invokes a runspace, and then invokes a command. (Note that this application does not specify runspace configuration information, nor does it explicitly create a pipeline). The command that is invoked is the Get-Process cmdlet.
Here are the code samples for the runspace described in [Creating a Console Application That Runs a Specified Command &#91;ps&#93;](http://msdn.microsoft.com/en-us/793a6570-a072-4799-840b-172f28ce620e). To do this, the application invokes a runspace, and then invokes a command. (Note that this application does not specify runspace configuration information, nor does it explicitly create a pipeline). The command that is invoked is the Get-Process cmdlet.

> [!NOTE]
>  You can download the C# source file (runspace01.cs) for this runspace using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>  You can download the C# source file (runspace01.cs) for this runspace using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>
>  The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

```csharp
namespace Microsoft.Samples.PowerShell.Runspaces
{
  using System;
  using System.Management.Automation;
  using PowerShell = System.Management.Automation.PowerShell;
  
  /// <summary>
  /// This class contains the Main entry point for this host application.
  /// </summary>
  internal class Runspace01
  {
    /// <summary>
    /// This sample uses the PowerShell class to execute
    /// the get-process cmdlet synchronously. The name and
    /// handlecount are then extracted from the PSObjects
    /// returned and displayed.
    /// </summary>
    /// <param name="args">Parameter not used.</param>
    /// <remarks>
    /// This sample demonstrates the following:
    /// 1. Creating a PowerShell object to run a command.
    /// 2. Adding a command to the pipeline of the PowerShell object.
    /// 3. Running the command synchronously.
    /// 4. Using PSObject objects to extract properties from the objects
    ///    returned by the command.
    /// </remarks>
    private static void Main(string[] args)
    {
      // Create a PowerShell object. Creating this object  takes care of 
      // building all of the other data structures needed to run the command.
      using (PowerShell powershell = PowerShell.Create().AddCommand("get-process"))
      {
        Console.WriteLine("Process              HandleCount");
        Console.WriteLine("--------------------------------");
          
        // Invoke the command synchronously and display the  
        // ProcessName and HandleCount properties of the 
        // objects that are returned.
        foreach (PSObject result in powershell.Invoke())
        {
          Console.WriteLine(
                      "{0,-20} {1}",
                      result.Members["ProcessName"].Value,
                      result.Members["HandleCount"].Value);
        }
      }
      
      System.Console.WriteLine("Hit any key to exit...");
      System.Console.ReadKey();
    }
  }
}
```

[!code-csharp[Runspace01.cs](../../powershell-sdk-samples/SDK-2.0/csharp/Runspace01/Runspace01.cs#L11-L62 "Runspace01.cs")]

## See Also

 [Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
 [Windows PowerShell SDK](../windows-powershell-reference.md)
