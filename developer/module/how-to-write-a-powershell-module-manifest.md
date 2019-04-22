---
title: "How to Write a PowerShell Module Manifest | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: e082c2e3-12ce-4032-9caf-bf6b2e0dcf81
caps.latest.revision: 23
---
# How to Write a PowerShell Module Manifest

Once you have written your Windows PowerShell module, you can optionally add a module manifest. A module manifest is a PowerShell script file you can use to include information about the module. For example, you can describe the author, specify files in the module (such as nested modules), run scripts to customize the user's environment, load type and formatting files, define system requirements, and limit the members that the module exports.

## Creating a Module Manifest

A *module manifest* is a Windows PowerShell data file (.psd1) that describes the contents of a module and determines how a module is processed. The manifest file itself is a text file that contains a hash table of keys and values. You link a manifest file to a module by naming it the same as the module, and placing it in the root of the module directory.

For simple modules that contain only a single .psm1 or binary assembly, a module manifest is optional. However, it is recommended that you use a module manifest whenever possible, as they are useful to help you organize your code and to maintain versioning information. In addition, a module manifest is required to export an assembly that is installed in the global assembly cache. A module manifest is also required for modules that support the Updatable Help feature. That is, Updatable Help uses the **HelpInfoUri** key in the module manifest to find the Help information (HelpInfo XML) file that contains the location of the updated help files for the module. For more information about Updatable Help, see [Supporting Updatable Help](./supporting-updatable-help.md).

### To create and use a module manifest

1. To create a module manifest, you have several options:

   1. Directly create the hash table with the minimal information required, and save it to a .psd1 file that has the same name as your module. Once you have done this, you can open the file and add in the appropriate values manually.

      `'@{ModuleVersion="1.0"}' > myModuleName.psd1`

   2. Or, call the [New-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/New-ModuleManifest) cmdlet, with one or more of the default values passed in as parameters. (Note that the only the name of the file is required to generate a manifest, however.) This will create a module manifest with all the manifest values you supplied explicitly stated, and with the rest containing the appropriate default value.

      `New-ModuleManifest myModuleName.psd1 -ModuleVersion "2.0" -Author "YourNameHere"`

   3. Finally, you can also create an empty .psd1 file, and copy the template at the bottom of this topic into the file, and fill in the relevant values. The only real requirement in this case would be to ensure that the file was named the same as the module.

2. Add in any additional elements to the manifest that you want to have in the file.

   Generally speaking, this will probably be done in whatever text editor you prefer, such as Notepad. However this technically is a script file that contains code, so you may wish to edit it in an actual scripting or development environment, such as the PowerShell ISE. Again, note that all elements of a manifest file are optional, except for the ModuleVersion number.

   For descriptions of the keys and values you can have in a module manifest, see the **Module Manifest Elements** below. For additional information, see the parameter descriptions in the  [New-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/New-ModuleManifest) cmdlet.

3. Optionally, you can choose to add additional code to your module manifest, to address any scenarios that would not be covered by the base module manifest elements.

   Due to security concerns, PowerShell will run only a small subset of the available operations in a module manifest file. Generally, you can use the **if** statement, arithmetic and comparison operators, and the basic PowerShell data types.

4. Once you have created your module manifest, you can test it (to confirm that any paths described in the manifest are correct) with a call to [Test-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/Test-ModuleManifest).

   `Test-ModuleManifest myModuleName.psd1`

5. Be sure that your module manifest is located in the top level of the directory that contains your module.

   When you copy your module onto a system and import it, PowerShell will use the module manifest to import your module.

6. Optionally, you can directly test your module manifest with a call to [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) by dot-sourcing the manifest itself.

   `Import-Module .\myModuleName.psd1`

## Module Manifest Elements

The following table describes the elements you can have in a module manifest

|Element|Default|Description|
|-------------|-------------|-----------------|
|RootModule<br /><br /> Type: string|' '|Script module or binary module file associated with this manifest. Previous versions of PowerShell called this element the ModuleToProcess.<br /><br /> Possible types for the root module can be empty (which will make this a **Manifest** module), the name of a script module (.psm1, which makes this a **Script** module), or the name of a binary module (.exe or .dll, which makes this a **Binary** module). Placing the name of a module manifest (.psd1) or a script file (.ps1) in this element will cause an error to occur.|
|ModuleVersion<br /><br /> Type: string|1.0|Version number of this module. The string must be able to convert to [System.Version]. That is, '#.#.#.#.#'. `Import-Module` will load the first module it finds on the **$psModulePath** that matches the name, and has at least as high a ModuleVersion, as the `-MinimumVersion` parameter. To import a specific version, use the`-RequiredVersion` parameter, instead.<br /><br /> Example: `ModuleVersion = '1.0'`|
|GUID<br /><br /> Type: string|Autogenerated GUID|ID used to uniquely identify this module. Note that you cannot currently import a module by GUID.<br /><br /> Example: `GUID = 'cfc45206-1e49-459d-a8ad-5b571ef94857'`|
|Author<br /><br /> Type: string|None|Author of this module.<br /><br /> Example: `Author = 'AuthorNameHere'`|
|CompanyName<br /><br /> Type: string|Unknown|Company or vendor of this module.<br /><br /> Example: `CompanyName = 'Fabrikam'`|
|Copyright<br /><br /> Type: string|(c) [currentYear] [Author]. All rights reserved.|Copyright statement for this module.<br /><br /> Example: `Copyright = '2016 AuthorName. All rights reserved.'`|
|Description<br /><br /> Type: string|' '|Description of the functionality provided by this module.<br /><br /> Example: `Description = 'This is a description of a module.'`|
|PowerShellVersion<br /><br /> Type: string|' '|Minimum version of the Windows PowerShell engine required by this module. Current valid values are 1.0, 2.0, 3.0, 4.0, and 5.0.<br /><br /> Example: `PowerShellVersion = '5.0'`|
|PowerShellHostName<br /><br /> Type: string|' '|Specifies the name of the Windows PowerShell host that is required by the module. This name is provided by Windows PowerShell. To find the name of a host program, in the program, type: `$host.name` .<br /><br /> Example: `PowerShellHostName = 'Windows PowerShell ISE Host'`|
|PowerShellHostVersion<br /><br /> Type: string|' '|Minimum version of the Windows PowerShell host required by this module.<br /><br /> Example: `PowerShellHostVersion = '2.0'`|
|DotNetFrameworkVersion<br /><br /> Type: string|' '|Minimum version of Microsoft .NET Framework required by this module.<br /><br /> Example: `DotNetFrameworkVersion = '3.5'`|
|CLRVersion<br /><br /> Type: string|' '|Minimum version of the common language runtime (CLR) required by this module.<br /><br /> Example: `CLRVersion = '3.5'`|
|ProcessorArchitecture<br /><br /> Type: string|' '|Processor architecture (None, X86, Amd64) required by this module. Valid values are x86, AMD64, IA64, and None (unknown or unspecified).<br /><br /> Example: `ProcessorArchitecture = 'x86'`|
|RequiredModules<br /><br /> Type: [string[]]|@()|Modules that must be imported into the global environment prior to importing this module. This will load any modules listed unless they have already been loaded. (For example, some modules may already be loaded by a different module.). It is also possible to specify a specific version to load using `RequiredVersion` rather than `ModuleVersion`. When using `ModuleVersion` it will load the newest version available with a minimum of the version specified.<br /><br /> Example: `RequiredModules = @(@{ModuleName="myDependentModule"; ModuleVersion="2.0"; Guid="cfc45206-1e49-459d-a8ad-5b571ef94857"})`<br /><br /> Example: `RequiredModules = @(@{ModuleName="myDependentModule"; RequiredVersion="1.5"; Guid="cfc45206-1e49-459d-a8ad-5b571ef94857"})`|
|RequiredAssemblies<br /><br /> Type: [string[]]|@()|Assemblies that must be loaded prior to importing this module.<br /><br /> Note that unlike RequiredModules, PowerShell will load the RequiredAssemblies if they are not already loaded.|
|ScriptsToProcess<br /><br /> Type: [string[]]|@()|Script (.ps1) files that are run in the caller's session state when the module is imported. This could be the global session state or, for nested modules, the session state of another module. You can use these scripts to prepare an environment just as you might use a login script.<br /><br /> These scripts are run before any of the modules listed in the manifest are loaded.|
|TypesToProcess<br /><br /> Type: [Object[]]|@()|Type files (.ps1xml) to be loaded when importing this module.|
|FormatsToProcess<br /><br /> Type: [Object[]]|@()|Format files (.ps1xml) to be loaded when importing this module.|
|NestedModules<br /><br /> Type: [Object[]]|@()|Modules to import as nested modules of the module specified in RootModule/ModuleToProcess.<br /><br /> Adding a module name to this element is similar to calling `Import-Module` from within your script or assembly code. The main difference is that it's easier to see what you are loading here in the manifest file. Also, if a module fails to load here, you will not yet have loaded your actual module.<br /><br /> In addition to other modules, you may also load script (.ps1) files here. These files will execute in the context of the root module. (This is equivalent to dot sourcing the script in your root module.)|
|FunctionsToExport<br /><br /> Type: String|'*'|Specifies the functions that the module exports (wildcard characters are permitted) to the caller's session state. By default, all functions are exported. You can use this key to restrict the functions that are exported by the module.<br /><br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When chaining nested modules, all functions that are exported by a nested module will be exported to the global session state unless a module in the chain restricts the function by using the FunctionsToExport key.<br /><br /> If the manifest also exports aliases for the functions, this key can remove functions whose aliases are listed in the AliasesToExport key, but this key cannot add function aliases to the list.|
|CmdletsToExport<br /><br /> Type: String|'*'|Specifies the cmdlets that the module exports (wildcard characters are permitted). By default, all cmdlets are exported. You can use this key to restrict the cmdlets that are exported by the module.<br /><br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When you are chaining nested modules, all cmdlets that are exported by a nested module will be ultimately exported to the global session state unless a module in the chain restricts the cmdlet by using the CmdletsToExport key.<br /><br /> If the manifest also exports aliases for the cmdlets, this key can remove cmdlets whose aliases are listed in the AliasesToExport key, but this key cannot add cmdlet aliases to the list.|
|VariablesToExport<br /><br /> Type: String|'*'|Specifies the variables that the module exports (wildcard characters are permitted) to the caller's session state. By default, all variables are exported. You can use this key to restrict the variables that are exported by the module.<br /><br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When you are chaining nested modules, all variables that are exported by a nested module will be exported to the global session state unless a module in the chain restricts the variable by using the VariablesToExport key.<br /><br /> If the manifest also exports aliases for the variables, this key can remove variables whose aliases are listed in the AliasesToExport key, but this key cannot add variable aliases to the list.|
|AliasesToExport<br /><br /> Type: String|'*'|Specifies the aliases that the module exports (wildcard characters are permitted) to the caller's session state. By default, all aliases are exported. You can use this key to restrict the aliases that are exported by the module.<br /><br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When you are chaining nested modules, all aliases that are exported by a nested module will be ultimately exported to the global session state unless a module in the chain restricts the alias by using the AliasesToExport key.|
|ModuleList<br /><br /> Type: [string[]]|@()|Specifies all the modules that are packaged with this module. These modules can be entered by name (a comma-separated string) or as a hash table with ModuleName and GUID keys. The hash table can also have an optional ModuleVersion key. The ModuleList key is designed to act as a module inventory. These modules are not automatically processed.|
|FileList<br /><br /> Type: [string[]]|@()|List of all files packaged with this module. As with ModuleList, FileList is to assist you as an inventory list, and is not otherwise processed.|
|PrivateData<br /><br /> Type: [object]|' '|Specifies any private data that needs to be passed to the root module specified by the RootModule/ModuleToProcess key.|
|HelpInfoURI<br /><br /> Type: string|' '|HelpInfo URI of this module.|
|DefaultCommandPrefix<br /><br /> Type: string|' '|Default prefix for commands exported from this module. Override the default prefix using `Import-Module` -Prefix.|

## Sample Module Manifest

The following sample module manifest shows the keys and default values in a module manifest. This example was created by using the `New-ModuleManifest` cmdlet in Windows PowerShell 3.0. When creating multiple modules, you can use this cmdlet to create a manifest template that can then be modified for different modules.

```powershell
#
# Module manifest for module 'myManifest'
#
# Generated by: User01
#
# Generated on: 1/24/2012
#

@{

# Script module or binary module file associated with this manifest
#RootModule = ''

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = 'd0a9150d-b6a4-4b17-a325-e3a24fed0aa9'

# Author of this module
Author = 'User01'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2012 User01. All rights reserved.'

# Description of the functionality provided by this module
# Description = ''

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

```

## See Also

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
