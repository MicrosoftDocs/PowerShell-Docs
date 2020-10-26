---
ms.date: 10/16/2019
ms.topic: reference
title: How to Write a PowerShell Module Manifest
description: How to Write a PowerShell Module Manifest
---

# How to write a PowerShell module manifest

After you've written your PowerShell module, you can add an optional module manifest that includes
information about the module. For example, you can describe the author, specify files in the module
(such as nested modules), run scripts to customize the user's environment, load type and formatting
files, define system requirements, and limit the members that the module exports.

## Creating a module manifest

A **module manifest** is a PowerShell data file (`.psd1`) that describes the contents of a module
and determines how a module is processed. The manifest file is a text file that contains a hash
table of keys and values. You link a manifest file to a module by naming the manifest the same as
the module, and storing the manifest in the module's root directory.

For simple modules that contain only a single `.psm1` or binary assembly, a module manifest is
optional. But, the recommendation is to use a module manifest whenever possible, as they're useful
to help you organize your code and maintain versioning information. And, a module manifest is
required to export an assembly that is installed in the
[Global Assembly Cache](/dotnet/framework/app-domains/gac). A module manifest is also required for
modules that support the Updatable Help feature. Updatable Help uses the **HelpInfoUri** key in the
module manifest to find the Help information (HelpInfo XML) file that contains the location of the
updated help files for the module. For more information about Updatable Help, see
[Supporting Updatable Help](./supporting-updatable-help.md).

### To create and use a module manifest

1. The best practice to create a module manifest is to use the
   [New-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/New-ModuleManifest) cmdlet. You
   can use parameters to specify one or more of the manifest's default keys and values. The only
   requirement is to name the file. `New-ModuleManifest` creates a module manifest with your
   specified values, and includes the remaining keys and their default values. If you need to create
   multiple modules, use `New-ModuleManifest` to create a module manifest template that can be
   modified for your different modules. For an example of a default module manifest, see the
   [Sample module manifest](#sample-module-manifest).

   `New-ModuleManifest -Path C:\myModuleName.psd1 -ModuleVersion "2.0" -Author "YourNameHere"`

   An alternative is to manually create the module manifest's hash table using the minimal
   information required, the **ModuleVersion**. You save the file with the same name as your module
   and use the `.psd1` file extension. You can then edit the file and add the appropriate keys and
   values.

1. Add any additional elements that you want in the manifest file.

   To edit the manifest file, use any text editor you prefer. But, the manifest file is a script
   file that contains code, so you may wish to edit it in a scripting or development environment,
   such as Visual Studio Code. All elements of a manifest file are optional, except for the
   **ModuleVersion** number.

   For descriptions of the keys and values you can include in a module manifest, see the
   [Module manifest elements](#module-manifest-elements) table. For more information, see the
   parameter descriptions in the
   [New-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/New-ModuleManifest) cmdlet.

1. To address any scenarios that might not be covered by the base module manifest elements, you have
   the option to add additional code to your module manifest.

   For security concerns, PowerShell only runs a small subset of the available operations in a
   module manifest file. Generally, you can use the `if` statement, arithmetic and comparison
   operators, and the basic PowerShell data types.

1. After you've created your module manifest, you can test it to confirm that any paths described in
   the manifest are correct. To test your module manifest, use
   [Test-ModuleManifest](/powershell/module/Microsoft.PowerShell.Core/Test-ModuleManifest).

   `Test-ModuleManifest myModuleName.psd1`

1. Be sure that your module manifest is located in the top level of the directory that contains your
   module.

   When you copy your module onto a system and import it, PowerShell uses the module manifest to
   import your module.

1. Optionally, you can directly test your module manifest with a call to
   [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) by dot-sourcing the
   manifest itself.

   `Import-Module .\myModuleName.psd1`

## Module manifest elements

The following table describes the elements you can include in a module manifest.

|Element|Default|Description|
|-------------|-------------|-----------------|
|**RootModule**<br /> Type: `String`|`<empty string>`|Script module or binary module file associated with this manifest. Previous versions of PowerShell called this element the **ModuleToProcess**.<br /> Possible types for the root module can be empty, which creates a **Manifest** module, the name of a script module (`.psm1`), or the name of a binary module (`.exe` or `.dll`). Placing the name of a module manifest (`.psd1`) or a script file (`.ps1`) in this element causes an error. <br /> Example: `RootModule = 'ScriptModule.psm1'`|
|**ModuleVersion**<br /> Type: `Version`|`'0.0.1'`|Version number of this module. If a value isn't specified, `New-ModuleManifest`   uses the default. The string must be able to convert to the type `Version` for example `#.#.#.#.#`. `Import-Module` loads the first module it finds on the **$PSModulePath** that matches the name, and has at least as high a **ModuleVersion**, as the **MinimumVersion** parameter. To import a specific version, use the `Import-Module` cmdlet's **RequiredVersion** parameter.<br /> Example: `ModuleVersion = '1.0'`|
|**GUID**<br /> Type: `GUID`|`'<GUID>'`|ID used to uniquely identify this module. If a value isn't specified, `New-ModuleManifest` autogenerates the value. You can't currently import a module by **GUID**. <br /> Example: `GUID = 'cfc45206-1e49-459d-a8ad-5b571ef94857'`|
|**Author**<br /> Type: `String`|`'<Current user>'`|Author of this module. If a value isn't specified, `New-ModuleManifest` uses the current user. <br /> Example: `Author = 'AuthorNameHere'`|
|**CompanyName**<br /> Type: `String`|`'Unknown'`|Company or vendor of this module. If a value isn't specified, `New-ModuleManifest` uses the default.<br /> Example: `CompanyName = 'Fabrikam'`|
|**Copyright**<br /> Type: `String`|`'(c) <Author>. All rights reserved.'`| Copyright statement for this module. If a value isn't specified, `New-ModuleManifest` uses the default with the current user as the `<Author>`. To specify an author, use the **Author** parameter. <br /> Example: `Copyright = '2019 AuthorName. All rights reserved.'`|
|**Description**<br /> Type: `String`|`<empty string>`|Description of the functionality provided by this module.<br /> Example: `Description = 'This is the module's description.'`|
|**PowerShellVersion**<br /> Type: `Version`|`<empty string>`|Minimum version of the PowerShell engine required by this module. Valid values are 1.0, 2.0, 3.0, 4.0, 5.0, 5.1, 6, and 7.<br /> Example: `PowerShellVersion = '5.0'`|
|**PowerShellHostName**<br /> Type: `String`|`<empty string>`|Name of the PowerShell host required by this module. This name is provided by PowerShell. To find the name of a host program, in the program, type: `$host.name`.<br /> Example: `PowerShellHostName = 'ConsoleHost'`|
|**PowerShellHostVersion**<br /> Type: `Version`|`<empty string>`|Minimum version of the PowerShell host required by this module.<br /> Example: `PowerShellHostVersion = '2.0'`|
|**DotNetFrameworkVersion**<br /> Type: `Version`|`<empty string>`|Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only, such as PowerShell 5.1.<br /> Example: `DotNetFrameworkVersion = '3.5'`|
|**CLRVersion**<br /> Type: `Version`|`<empty string>`|Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only, such as PowerShell 5.1.<br /> Example: `CLRVersion = '3.5'`|
|**ProcessorArchitecture**<br /> Type: `ProcessorArchitecture`|`<empty string>`|Processor architecture (None, X86, Amd64) required by this module. Valid values are x86, AMD64, Arm, IA64, MSIL, and None (unknown or unspecified).<br /> Example: `ProcessorArchitecture = 'x86'`|
|**RequiredModules**<br /> Type: `Object[]`|`@()`|Modules that must be imported into the global environment prior to importing this module. This loads any modules listed unless they've already been loaded. For example, some modules may already be loaded by a different module. It's possible to specify a specific version to load using `RequiredVersion` rather than `ModuleVersion`. When `ModuleVersion` is used it will load the newest version available with a minimum of the version specified. You can combine strings and hash tables in the parameter value.<br /> Example: `RequiredModules = @("MyModule", @{ModuleName="MyDependentModule"; ModuleVersion="2.0"; GUID="cfc45206-1e49-459d-a8ad-5b571ef94857"})`<br /> Example: `RequiredModules = @("MyModule", @{ModuleName="MyDependentModule"; RequiredVersion="1.5"; GUID="cfc45206-1e49-459d-a8ad-5b571ef94857"})`|
|**RequiredAssemblies**<br /> Type: `String[]`|`@()`|Assemblies that must be loaded prior to importing this module. Specifies the assembly (`.dll`) file names that the module requires.<br /> PowerShell loads the specified assemblies before updating types or formats, importing nested modules, or importing the module file that is specified in the value of the RootModule key. Use this parameter to list all the assemblies that the module requires.<br /> Example: `RequiredAssemblies = @("assembly1.dll", "assembly2.dll", "assembly3.dll")`|
|**ScriptsToProcess**<br /> Type: `String[]`|`@()`|Script (`.ps1`) files that are run in the caller's session state when the module is imported. This could be the global session state or, for nested modules, the session state of another module. You can use these scripts to prepare an environment just as you might use a log in script.<br /> These scripts are run before any of the modules listed in the manifest are loaded. <br /> Example: `ScriptsToProcess = @("script1.ps1", "script2.ps1", "script3.ps1")`|
|**TypesToProcess**<br /> Type: `String[]`|`@()`|Type files (`.ps1xml`) to be loaded when importing this module. <br /> Example: `TypesToProcess = @("type1.ps1xml", "type2.ps1xml", "type3.ps1xml")`|
|**FormatsToProcess**<br /> Type: `String[]`|`@()`|Format files (`.ps1xml`) to be loaded when importing this module. <br /> Example: `FormatsToProcess = @("format1.ps1xml", "format2.ps1xml", "format3.ps1xml")`|
|**NestedModules**<br /> Type: `Object[]`|`@()`|Modules to import as nested modules of the module specified in **RootModule** (alias:**ModuleToProcess**).<br /> Adding a module name to this element is similar to calling `Import-Module` from within your script or assembly code. The main difference by using a manifest file is that it's easier to see what you're loading. And, if a module fails to load, you will not yet have loaded your actual module.<br /> In addition to other modules, you may also load script (`.ps1`) files here. These files will execute in the context of the root module. This is equivalent to dot sourcing the script in your root module. <br /> Example: `NestedModules = @("script.ps1", @{ModuleName="MyModule"; ModuleVersion="1.0.0.0"; GUID="50cdb55f-5ab7-489f-9e94-4ec21ff51e59"})`|
|**FunctionsToExport**<br /> Type: `String[]`|`@()`|Specifies the functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export. By default, no functions are exported. You can use this key to list the functions that are exported by the module.<br /> The module exports the functions to the caller's session state. The caller's session state can be the global session state or, for nested modules, the session state of another module. When chaining nested modules, all functions that are exported by a nested module will be exported to the global session state unless a module in the chain restricts the function by using the **FunctionsToExport** key.<br /> If the manifest exports aliases for the functions, this key can remove functions whose aliases are listed in the **AliasesToExport** key, but this key cannot add function aliases to the list. <br /> Example: `FunctionsToExport = @("function1", "function2", "function3")`|
|**CmdletsToExport**<br /> Type: `String[]`|`@()`|Specifies the cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export. By default, no cmdlets are exported. You can use this key to list the cmdlets that are exported by the module.<br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When you're chaining nested modules, all cmdlets that are exported by a nested module will be exported to the global session state unless a module in the chain restricts the cmdlet by using the **CmdletsToExport** key.<br /> If the manifest exports aliases for the cmdlets, this key can remove cmdlets whose aliases are listed in the **AliasesToExport** key, but this key cannot add cmdlet aliases to the list. <br /> Example: `CmdletsToExport = @("Get-MyCmdlet", "Set-MyCmdlet", "Test-MyCmdlet")`|
|**VariablesToExport**<br /> Type: `String[]`|`'*'`|Specifies the variables that the module exports to the caller's session state. Wildcard characters are permitted. By default, all variables (`'*'`) are exported. You can use this key to restrict the variables that are exported by the module.<br /> The caller's session state can be the global session state or, for nested modules, the session state of another module. When you are chaining nested modules, all variables that are exported by a nested module will be exported to the global session state unless a module in the chain restricts the variable by using the **VariablesToExport** key.<br /> If the manifest also exports aliases for the variables, this key can remove variables whose aliases are listed in the **AliasesToExport** key, but this key cannot add variable aliases to the list. <br /> Example: `VariablesToExport = @('$MyVariable1', '$MyVariable2', '$MyVariable3')`|
|**AliasesToExport**<br /> Type: `String[]`|`@()`|Specifies the aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export. By default, no aliases are exported. You can use this key to list the aliases that are exported by the module.<br /> The module exports the aliases to caller's session state. The caller's session state can be the global session state or, for nested modules, the session state of another module. When you are chaining nested modules, all aliases that are exported by a nested module will be ultimately exported to the global session state unless a module in the chain restricts the alias by using the **AliasesToExport** key. <br /> Example: `AliasesToExport = @("MyAlias1", "MyAlias2", "MyAlias3")`|
|**DscResourcesToExport**<br /> Type: `String[]`|`@()`|Specifies DSC resources to export from this module. Wildcards are permitted. <br /> Example: `DscResourcesToExport = @("DscResource1", "DscResource2", "DscResource3")`|
|**ModuleList**<br /> Type: `Object[]`|`@()`|Specifies all the modules that are packaged with this module. These modules can be entered by name, using a comma-separated string, or as a hash table with **ModuleName** and **GUID** keys. The hash table can also have an optional **ModuleVersion** key. The **ModuleList** key is designed to act as a module inventory. These modules are not automatically processed. <br /> Example: `ModuleList = @("SampleModule", "MyModule", @{ModuleName="MyModule"; ModuleVersion="1.0.0.0"; GUID="50cdb55f-5ab7-489f-9e94-4ec21ff51e59"})`|
|**FileList**<br /> Type: `String[]`|`@()`|List of all files packaged with this module. As with **ModuleList**, **FileList** is an inventory list, and isn't otherwise processed. <br /> Example: `FileList = @("File1", "File2", "File3")`|
|**PrivateData**<br /> Type: `Object`|`@{...}`|Specifies any private data that needs to be passed to the root module specified by the **RootModule** (alias: **ModuleToProcess**) key. **PrivateData** is a hash table that comprises several elements: **Tags**, **LicenseUri**, **ProjectURI**, **IconUri**, **ReleaseNotes**, **Prerelease**, **RequireLicenseAcceptance**, and **ExternalModuleDependencies**. |
|**Tags** <br /> Type: `String[]` |`@()`| Tags help with module discovery in online galleries. <br /> Example: `Tags = "PackageManagement", "PowerShell", "Manifest"`|
|**LicenseUri**<br /> Type: `Uri` |`<empty string>`| A URL to the license for this module. <br /> Example: `LicenseUri = 'https://www.contoso.com/license'`|
|**ProjectUri**<br /> Type: `Uri` |`<empty string>`| A URL to the main website for this project. <br /> Example: `ProjectUri = 'https://www.contoso.com/project'`|
|**IconUri**<br /> Type: `Uri` |`<empty string>`| A URL to an icon representing this module. <br /> Example: `IconUri = 'https://www.contoso.com/icons/icon.png'`|
|**ReleaseNotes**<br /> Type: `String` |`<empty string>`| Specifies the module's release notes. <br /> Example: `ReleaseNotes = 'The release notes provide information about the module.`|
|**PreRelease**<br /> Type: `String` |`<empty string>`| This parameter was added in PowerShellGet 1.6.6. A **PreRelease** string that identifies the module as a prerelease version in online galleries. <br /> Example: `PreRelease = 'This module is a prerelease version.`|
|**RequireLicenseAcceptance**<br /> Type: `Boolean`|`$true`| This parameter was added in PowerShellGet 1.5. Flag to indicate whether the module requires explicit user acceptance for install, update, or save. <br /> Example: `RequireLicenseAcceptance = $false`|
|**ExternalModuleDependencies**<br /> Type: `String[]` |`@()`| This parameter was added in PowerShellGet v2. A list of external modules that this module is dependent upon. <br /> Example: `ExternalModuleDependencies =  @("ExtModule1", "ExtModule2", "ExtModule3")`|
|**HelpInfoURI**<br /> Type: `String`|`<empty string>`|HelpInfo URI of this module. <br /> Example: `HelpInfoURI = 'https://www.contoso.com/help'`|
|**DefaultCommandPrefix**<br /> Type: `String`|`<empty string>`|Default prefix for commands exported from this module. Override the default prefix using `Import-Module -Prefix`. <br /> Example: `DefaultCommandPrefix = 'My'`|

## Sample module manifest

The following sample module manifest was created with `New-ModuleManifest` in PowerShell 7 and
contains the default keys and values.

```powershell
#
# Module manifest for module 'SampleModuleManifest'
#
# Generated by: User01
#
# Generated on: 10/15/2019
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '0.0.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'b632e90c-df3d-4340-9f6c-3b832646bf87'

# Author of this module
Author = 'User01'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) User01. All rights reserved.'

# Description of the functionality provided by this module
# Description = ''

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $true

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
```

## See also

[about_Comparison_Operators](/powershell/module/microsoft.powershell.core/about/about_comparison_operators)

[about_If](/powershell/module/microsoft.powershell.core/about/about_if)

[Global Assembly Cache](/dotnet/framework/app-domains/gac)

[Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)

[New-ModuleManifest](/powershell/module/microsoft.powershell.core/new-modulemanifest)

[Test-ModuleManifest](/powershell/module/microsoft.powershell.core/test-modulemanifest)

[Update-ModuleManifest](/powershell/module/powershellget/update-modulemanifest)

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
