---
ms.date: 09/13/2016
ms.topic: reference
title: GetProcessSample01 Sample
description: GetProcessSample01 Sample
---
# GetProcessSample01 Sample

This sample shows how to implement a cmdlet that retrieves the processes on the local computer. This cmdlet is a simplified version of the `Get-Process` cmdlet that is provided by Windows PowerShell 2.0.

## How to build the sample by using Visual Studio.

1. With the Windows PowerShell 2.0 SDK installed, navigate to the GetProcessSample01 folder. The default location is C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0\Samples\sysmgmt\WindowsPowerShell\csharp\GetProcessSample01.

2. Double-click the icon for the solution (.sln) file. This opens the sample project in Microsoft Visual Studio.

3. In the **Build** menu, select **Build Solution**.

  The library for the sample will be built in the default \bin or \bin\debug folders.

### How to run the sample

1. Open a Command Prompt window.

2. Navigate to the directory containing the sample .dll file.

3. Run installutil "GetProcessSample01.dll".

4. Start Windows PowerShell.

5. Run the following command to add the snap-in to the shell.

   `Add-PSSnapin GetProcPSSnapIn01`

6. Enter the following command to run the cmdlet. `get-proc`

   `get-proc`

   This is a sample output that results from following these steps.

   ```output
   Id              Name            State      HasMoreData     Location             Command
   --              ----            -----      -----------     --------             -------
   1               26932870-d3b... NotStarted False                                 Write-Host "A f...

   ```

   ```powershell
   Set-Content $env:temp\test.txt "This is a test file"
   ```

   ```output
   A file was created in the TEMP directory
   ```

## Requirements

This sample requires Windows PowerShell 1.0 or later.

## Demonstrates

This sample demonstrates the following.

- Creating a basic sample cmdlet.

- Defining a cmdlet class by using the Cmdlet attribute.

- Creating a snap-in that works with both Windows PowerShell 1.0 and Windows PowerShell 2.0. Subsequent samples use modules instead of snap-ins so they require Windows PowerShell 2.0.

## Example

This sample shows how to create a simple cmdlet and its snap-in.

```csharp
using System;
using System.Diagnostics;
using System.Management.Automation;             //Windows PowerShell namespace
using System.ComponentModel;

namespace Microsoft.Samples.PowerShell.Commands
{

   #region GetProcCommand

   /// <summary>
   /// This class implements the Get-Proc cmdlet.
   /// </summary>
   [Cmdlet(VerbsCommon.Get, "Proc")]
   public class GetProcCommand : Cmdlet
   {
      #region Cmdlet Overrides

      /// <summary>
      /// The ProcessRecord method calls the Process.GetProcesses
      /// method to retrieve the processes of the local computer.
      /// Then, the WriteObject method writes the associated processes
      /// to the pipeline.
      /// </summary>
      protected override void ProcessRecord()
      {
         // Retrieve the current processes.
         Process[] processes = Process.GetProcesses();

         // Write the processes to the pipeline to make them available
         // to the next cmdlet. The second argument (true) tells Windows
         // PowerShell to enumerate the array and to send one process
         // object at a time to the pipeline.
         WriteObject(processes, true);
      }

      #endregion Overrides

   } //GetProcCommand

   #endregion GetProcCommand

   #region PowerShell snap-in

   /// <summary>
   /// Create this sample as an PowerShell snap-in
   /// </summary>
   [RunInstaller(true)]
   public class GetProcPSSnapIn01 : PSSnapIn
   {
       /// <summary>
       /// Create an instance of the GetProcPSSnapIn01
       /// </summary>
       public GetProcPSSnapIn01()
           : base()
       {
       }

       /// <summary>
       /// Get a name for this PowerShell snap-in. This name will be used in registering
       /// this PowerShell snap-in.
       /// </summary>
       public override string Name
       {
           get
           {
               return "GetProcPSSnapIn01";
           }
       }

       /// <summary>
       /// Vendor information for this PowerShell snap-in.
       /// </summary>
       public override string Vendor
       {
           get
           {
               return "Microsoft";
           }
       }

       /// <summary>
       /// Gets resource information for vendor. This is a string of format:
       /// resourceBaseName,resourceName.
       /// </summary>
       public override string VendorResource
       {
           get
           {
               return "GetProcPSSnapIn01,Microsoft";
           }
       }

       /// <summary>
       /// Description of this PowerShell snap-in.
       /// </summary>
       public override string Description
       {
           get
           {
               return "This is a PowerShell snap-in that includes the get-proc cmdlet.";
           }
       }
   }

   #endregion PowerShell snap-in
}
```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
