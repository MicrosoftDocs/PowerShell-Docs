---
ms.date: 09/13/2016
ms.topic: reference
title: How to Write a PowerShell Binary Module
description: How to Write a PowerShell Binary Module
---
# How to Write a PowerShell Binary Module

A binary module can be any assembly (.dll) that contains cmdlet classes. By default, all the cmdlets in the assembly are imported when the binary module is imported. However, you can restrict the cmdlets that are imported by creating a module manifest whose root module is the assembly. (For example, the CmdletsToExport key of the manifest can be used to export only those cmdlets that are needed.) In addition, a binary module can contain additional files, a directory structure, and other pieces of useful management information that a single cmdlet cannot.

The following procedure describes how to create and install a PowerShell binary module.

#### How to create and install a PowerShell binary module

1. Create a binary PowerShell solution (such as a cmdlet written in C#), with the capabilities you need, and ensure that it runs properly.

   From a code perspective, the core of a binary module is simply a cmdlet assembly. In fact, PowerShell will treat a single cmdlet assembly as a module, in terms of loading and unloading, with no additional effort on the part of the developer. For more information about writing a cmdlet, see [Writing a Windows PowerShell Cmdlet](../cmdlet/writing-a-windows-powershell-cmdlet.md).

2. If necessary, create the rest of your solution: (additional cmdlets, XML files, and so on) and describe them with a module manifest.

   In addition to describing the cmdlet assemblies in your solution, a module manifest can describe how you want your module exported and imported, what cmdlets will be exposed, and what additional files will go into the module.
   As stated previously however, PowerShell can treat a binary cmdlet like a module with no additional effort.
   As such, a module manifest is useful mainly for combining multiple files into a single package, or for explicitly controlling publication for a given assembly.
   For more information, see [How to Write a PowerShell Module Manifest](how-to-write-a-powershell-module-manifest.md).

   The following code is an extremely simple C# code block that contains three cmdlets in the same file that can be used as a module.

   ```csharp
   using System.Management.Automation;           // Windows PowerShell namespace.

   namespace ModuleCmdlets
   {
     [Cmdlet(VerbsDiagnostic.Test,"BinaryModuleCmdlet1")]
     public class TestBinaryModuleCmdlet1Command : Cmdlet
     {
       protected override void BeginProcessing()
       {
         WriteObject("BinaryModuleCmdlet1 exported by the ModuleCmdlets module.");
       }
     }

     [Cmdlet(VerbsDiagnostic.Test, "BinaryModuleCmdlet2")]
     public class TestBinaryModuleCmdlet2Command : Cmdlet
     {
         protected override void BeginProcessing()
         {
             WriteObject("BinaryModuleCmdlet2 exported by the ModuleCmdlets module.");
         }
     }

     [Cmdlet(VerbsDiagnostic.Test, "BinaryModuleCmdlet3")]
     public class TestBinaryModuleCmdlet3Command : Cmdlet
     {
         protected override void BeginProcessing()
         {
             WriteObject("BinaryModuleCmdlet3 exported by the ModuleCmdlets module.");
         }
     }

   }
   ```

3. Package your solution, and save the package to somewhere in the PowerShell module path.

   The `PSModulePath` global environment variable describes the default paths that PowerShell will use to locate your module. For example, a common path to save a module on a system would be `%SystemRoot%\users\<user>\Documents\WindowsPowerShell\Modules\<moduleName>`. If you do not use the default paths, you will need to explicitly state the location of your module during installation. Be sure to create a folder to save your module in, as you may need the folder to store multiple assemblies and files for your solution.

   Note that technically you do not need to install your module anywhere on the `PSModulePath` - those are simply the default locations that PowerShell will look for your module. However, it is considered best practice to do so, unless you have a good reason for storing your module somewhere else. For more information, see [Installing a PowerShell Module](./installing-a-powershell-module.md) and [Modifying the PowerShell Module Installation Path](./modifying-the-psmodulepath-installation-path.md).

4. Import your module into PowerShell with a call to [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module).

   Calling to [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) will load your module into active memory. If you are using PowerShell 3.0 and later, simply calling the name of your module in code will also import it; for more information, see [Importing a PowerShell Module](./importing-a-powershell-module.md).

## Importing Snap-in Assemblies as Modules

Cmdlets and providers that exist in snap-in assemblies can be loaded as binary modules. When the snap-in assemblies are loaded as binary modules, the cmdlets and providers in the snap-in are available to the user, but the snap-in class in the assembly is ignored, and the snap-in is not registered. As a result, the snap-in cmdlets provided by Windows PowerShell cannot detect the snap-in even though the cmdlets and providers are available to the session.

In addition, any formatting or types files that are referenced by the snap-in cannot be imported as part of a binary module.
To import the formatting and types files you must create a module manifest.
See, [How to Write a PowerShell Module Manifest](how-to-write-a-powershell-module-manifest.md).

## See Also

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
