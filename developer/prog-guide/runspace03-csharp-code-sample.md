---
title: "RunSpace03 (C#) Code Sample | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 9ac8ab99-1856-4d6f-b30d-c0a18b8dd1fc
caps.latest.revision: 6
---
# RunSpace03 (C#) Code Sample
Here is the C# source code for the console application described in [Creating a Console Application That Runs a Specified Script &#91;ps&#93;](http://msdn.microsoft.com/en-us/a93e6006-36db-4bcc-b9da-c5bebf4ffd68). This sample uses the [System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke) class to execute a script that retrieves process information by using the list of process names passed into the script. It shows how to pass input objects to a script and how to retrieve error objects as well as the output objects.

> [!NOTE]
>  You can download the C# source file (runspace03.cs) for this sample using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>  You can download the C# source file (runspace03.cs) for this sample using the Microsoft Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime Components. For download instructions, see [How to Install Windows PowerShell and Download the Windows PowerShell SDK &#91;delete&#93;](http://msdn.microsoft.com/en-us/3ef7402e-fc80-432d-aaf7-c4a43fc09e68).
>
>  The downloaded source files are available in the **\<PowerShell Samples>** directory.

## Code Sample

```csharp
namespace Microsoft.Samples.PowerShell.Runspaces
{
    using System;
    using System.Collections;
    using System.Management.Automation;
    using System.Management.Automation.Runspaces;
    using PowerShell = System.Management.Automation.PowerShell;

    /// <summary>
    /// This class contains the Main entry point for this host application.
    /// </summary>
    internal class Runspace03
    {
        /// <summary>
        /// This sample uses the PowerShell class to execute
        /// a script that retrieves process information for the
        /// list of process names passed into the script.
        /// It shows how to pass input objects to a script and
        /// how to retrieve error objects as well as the output objects.
        /// </summary>
        /// <param name="args">Parameter not used.</param>
        /// <remarks>
        /// This sample demonstrates the following:
        /// 1. Creating an instance of the PowerSHell class.
        /// 2. Using this instance to execute a string as a PowerShell script.
        /// 3. Passing input objects to the script from the calling program.
        /// 4. Using PSObject to extract and display properties from the objects
        ///    returned by this command.
        /// 5. Retrieving and displaying error records that were generated
        ///    during the execution of that script.
        /// </remarks>
        private static void Main(string[] args)
        {
            // Define a list of processes to look for
            string[] processNames = new string[] 
            {
              "lsass", "nosuchprocess", "services", "nosuchprocess2" 
            };

            // The script to run to get these processes. Input passed
            // to the script will be available in the $input variable.
            string script = "$input | get-process -name {$_}";

            // Create an instance of the PowerShell class.
            using (PowerShell powershell = PowerShell.Create())
            {
                powershell.AddScript(script);

                Console.WriteLine("Process              HandleCount");
                Console.WriteLine("--------------------------------");

                // Now invoke the PowerShell and display the objects that are
                // returned...
                foreach (PSObject result in powershell.Invoke(processNames))
                {
                    Console.WriteLine(
                        "{0,-20} {1}",
                        result.Members["ProcessName"].Value,
                        result.Members["HandleCount"].Value);
                }

                // Now process any error records that were generated while running the script.
                Console.WriteLine("\nThe following non-terminating errors occurred:\n");
                PSDataCollection<ErrorRecord> errors = powershell.Streams.Error;
                if (errors != null && errors.Count > 0)
                {
                    foreach (ErrorRecord err in errors)
                    {
                        System.Console.WriteLine("    error: {0}", err.ToString());
                    }
                }
            }

            System.Console.WriteLine("\nHit any key to exit...");
            System.Console.ReadKey();
        }
    }
}
```

[!code-csharp[Runspace03.cs](../../powershell-sdk-samples/SDK-2.0/csharp/Runspace03/Runspace03.cs#L11-L88 "Runspace03.cs")]

## See Also
 [Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)
 [Windows PowerShell SDK](../windows-powershell-reference.md)
