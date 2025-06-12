---
description: How to Write a PowerShell Binary Module
ms.date: 06/12/2025
title: How to Write a PowerShell Binary Module
---
# How to Write a PowerShell Binary Module

A binary module can be any assembly (`.dll`) that contains cmdlet classes. By default, all the
cmdlets in the assembly are imported when the binary module is imported. However, you can restrict
the cmdlets that are imported by creating a module manifest whose root module is the assembly. (For
example, the **CmdletsToExport** key of the manifest can be used to export only those cmdlets that
are needed.) In addition, a binary module can contain additional files, a directory structure, and
other pieces of useful management information that a single cmdlet cannot.

The following procedure describes how to create and install a PowerShell binary module.

## How to create and install a PowerShell binary module

1. Create a binary PowerShell solution (such as a cmdlet written in C#), with the capabilities you
   need, and ensure that it runs properly.

   From a code perspective, the core of a binary module is a cmdlet assembly. In fact, PowerShell
   treats a single cmdlet assembly as a module for loading and unloading, with no additional effort
   on the part of the developer. For more information about writing a cmdlet, see
   [Writing a Windows PowerShell Cmdlet][01].

1. If necessary, create the rest of your solution: (additional cmdlets, XML files, and so on) and
   describe them with a module manifest.

   In addition to describing the cmdlet assemblies in your solution, a module manifest can describe
   how you want your module exported and imported, what cmdlets will be exposed, and what additional
   files will go into the module. As stated previously however, PowerShell can treat a binary cmdlet
   like a module with no additional effort. As such, a module manifest is useful mainly for
   combining multiple files into a single package, or for explicitly controlling publication for a
   given assembly. For more information, see [How to Write a PowerShell Module Manifest][03].

   The following code is a simplified C# example that contains three cmdlets in the same file that
   can be used as a module.

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

1. Package your solution, and save the package to somewhere in the PowerShell module path.

   The `$env:PSModulePath` global environment variable describes the default paths that PowerShell
   uses to locate your module. For example, a common path to save a module on a system would be
   `%SystemRoot%\Users\<user>\Documents\WindowsPowerShell\Modules\<moduleName>`. If you don't use
   the default paths, you need to explicitly state the location of your module during installation.
   Be sure to create a folder to save your module in, as you may need the folder to store multiple
   assemblies and files for your solution.

   Technically, you don't need to install your module anywhere on the `$env:PSModulePath` - those
   are simply the default locations that PowerShell will look for your module. However, it's
   considered best practice to do so, unless you have a good reason for storing your module
   somewhere else. For more information, see [Installing a PowerShell Module][05] and
   [about_PSModulePath][02].

1. Import your module into PowerShell with a call to [Import-Module][07].

   Calling to [Import-Module][07] loads your module into active memory. If you are using PowerShell
   3.0 and later, invoking a command from your module in code also imports it. For more information,
   see [Importing a PowerShell Module][04].

## Module initialization and cleanup code

If your module needs to do something upon import or removal such as a discovery task or
initialization, you can implement the [`IModuleAssemblyInitializer`][09] and
[`IModuleAssemblyCleanup`][08] interfaces.

> [!NOTE]
> This pattern is discouraged unless absolutely necessary. To keep PowerShell performant, you should
> lazily load things at the point your commands are called rather than on import.

## Importing snap-in assemblies as modules

Cmdlets and providers that exist in snap-in assemblies can be loaded as binary modules. When the
snap-in assemblies are loaded as binary modules, the cmdlets and providers in the snap-in are
available to the user, but the snap-in class in the assembly is ignored, and the snap-in isn't
registered. As a result, the snap-in cmdlets provided by Windows PowerShell can't detect the
snap-in even though the cmdlets and providers are available to the session.

In addition, any formatting or types files that are referenced by the snap-in can't be imported as
part of a binary module. To import the formatting and types files you must create a module manifest.
See, [How to Write a PowerShell Module Manifest][03].

## See Also

- [Writing a Windows PowerShell Module][06]

<!-- link references -->
[01]: ../cmdlet/writing-a-windows-powershell-cmdlet.md
[02]: /powershell/module/microsoft.powershell.core/about/about_psmodulepath
[03]: how-to-write-a-powershell-module-manifest.md
[04]: importing-a-powershell-module.md
[05]: installing-a-powershell-module.md
[06]: writing-a-windows-powershell-module.md
[07]: xref:Microsoft.PowerShell.Core.Import-Module
[08]: xref:System.Management.Automation.IModuleAssemblyCleanup
[09]: xref:System.Management.Automation.IModuleAssemblyInitializer
