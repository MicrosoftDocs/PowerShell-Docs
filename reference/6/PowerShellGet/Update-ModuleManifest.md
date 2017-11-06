---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=822341
external help file:  PSModule-help.xml
title:  Update-ModuleManifest
---

# Update-ModuleManifest

## SYNOPSIS
Updates a module manifest file.

## SYNTAX

```powershell
Update-ModuleManifest [-Path] <String> [-NestedModules <Object[]>] [-Guid <Guid>] [-Author <String>]
 [-CompanyName <String>] [-Copyright <String>] [-RootModule <String>] [-ModuleVersion <Version>]
 [-Description <String>] [-ProcessorArchitecture <ProcessorArchitecture>] [-CompatiblePSEditions <String[]>]
 [-PowerShellVersion <Version>] [-ClrVersion <Version>] [-DotNetFrameworkVersion <Version>]
 [-PowerShellHostName <String>] [-PowerShellHostVersion <Version>] [-RequiredModules <Object[]>]
 [-TypesToProcess <String[]>] [-FormatsToProcess <String[]>] [-ScriptsToProcess <String[]>]
 [-RequiredAssemblies <String[]>] [-FileList <String[]>] [-ModuleList <Object[]>]
 [-FunctionsToExport <String[]>] [-AliasesToExport <String[]>] [-VariablesToExport <String[]>]
 [-CmdletsToExport <String[]>] [-DscResourcesToExport <String[]>] [-PrivateData <Hashtable>] [-Tags <String[]>]
 [-ProjectUri <Uri>] [-LicenseUri <Uri>] [-IconUri <Uri>] [-ReleaseNotes <String[]>] [-HelpInfoUri <Uri>]
 [-PassThru] [-DefaultCommandPrefix <String>] [-ExternalModuleDependencies <String[]>]
 [-PackageManagementProviders <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The `Update-ModuleManifest` cmdlet updates a module manifest (.psd1) file.

## EXAMPLES

### Example 1: Update a module manifest
```powershell
Update-ModuleManifest -Path "C:\temp\TestManifest.psd1" -Author "TestUser1" -CompanyName "Contoso Corporation" -Copyright "(c) 2015 Contoso Corporation. All rights reserved."
```

This command updates the module manifest TestManifest.psd1 with updated Author, CompanyName, and Copyright fields.

## PARAMETERS

### -AliasesToExport
Specifies the aliases that the module exports.
Wildcards are permitted.

You can use this parameter to restrict the aliases that are exported by the module.
It can remove aliases from the list of exported aliases, but it cannot add aliases to the list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Author
Specifies the module author.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClrVersion
Specifies the minimum version of the Common Language Runtime (CLR) of the Microsoft .NET Framework that the module requires.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CmdletsToExport
Specifies the cmdlets that the module exports.
Wildcards are permitted.

You can use this parameter to restrict the cmdlets that are exported by the module.
It can remove cmdlets from the list of exported cmdlets, but it cannot add cmdlets to the list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyName
Specifies the company or vendor who created the module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Copyright
Specifies a copyright statement for the module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultCommandPrefix
Specifies the default command prefix.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Specifies a description of the module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DotNetFrameworkVersion
Specifies the minimum version of the Microsoft .NET Framework that the module requires.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DscResourcesToExport
Specifies the DSC resources that the module exports.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalModuleDependencies
Specifies an array of external module dependencies.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileList
Specifies all items that are included in the module.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatsToProcess
Specifies the formatting files (.ps1xml) that run when the module is imported.

When you import a module, Windows PowerShell runs the `Update-FormatData` cmdlet with the specified files.
Because formatting files are not scoped, they affect all session states in the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FunctionsToExport
Specifies the functions that the module exports.
Wildcards are permitted.

You can use this parameter to restrict the functions that are exported by the module.
It can remove functions from the list of exported aliases, but it cannot add functions to the list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Guid
Specifies a unique identifier for the module.
The GUID can be used to distinguish among modules with the same name.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HelpInfoUri
Specifies the Internet address of the HelpInfo XML file for the module.
Enter a Uniform Resource Identifier (URI) that begins with http or https.

The HelpInfo XML file supports the Updatable Help feature that was introduced in Windows PowerShell version 3.0.
It contains information about the location of downloadable help files for the module and the version numbers of the newest help files for each supported locale.
For information about Updatable Help, see [about_Updatable_Help](../Microsoft.PowerShell.Core/About/about_Updatable_Help.md).
For information about the HelpInfo XML file, see [Supporting Updatable Help](https://msdn.microsoft.com/library/hh852754) in the MSDN library.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconUri
Specifies the URL of an icon for the module.
The specified icon is displayed on the gallery web page for the module.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenseUri
Specifies the URL of licensing terms for the module.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleList
Specifies an array of modules that are included in the module.

Enter each module name as a string or as a hash table with **ModuleName** and **ModuleVersion** keys.
The hash table can also have an optional **GUID** key.
You can combine strings and hash tables in the parameter value.

This key is designed to act as a module inventory.
The modules that are listed in the value of this key are not automatically processed.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleVersion
Specifies the version of the module.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NestedModules
Specifies script modules (.psm1) and binary modules (.dll) that are imported into the module's session state.
The files in the **NestedModules** key run in the order in which they are listed in the value.

Enter each module name as a string or as a hash table with **ModuleName** and **ModuleVersion** keys.
The hash table can also have an optional **GUID** key.
You can combine strings and hash tables in the parameter value.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProviders
Specifies an array of package management providers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path and file name of the module manifest.
Enter a path and file name with a .psd1 file name extension, such as $pshome\Modules\MyModule\MyModule.psd1.

If you specify the path to an existing file, `Update-ModuleManifest` replaces the file without warning unless the file has the read-only attribute.

The manifest should be located in the module's directory, and the manifest file name should be the same as the module directory name, but with a .psd1 extension.

Note: You cannot use variables, such as $pshome or $home, in response to a prompt for a **Path** parameter value.
To use a variable, include the **Path** parameter in the command.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PowerShellHostName
Specifies the name of the Windows PowerShell host program that the module requires.
Enter the name of the host program, such as Windows PowerShell ISE Host or ConsoleHost.
Wildcards are not permitted.

To find the name of a host program, in the program, type `$host.name`.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellHostVersion
Specifies the minimum version of the Windows PowerShell host program that works with the module.
Enter a version number, such as 1.1.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellVersion
Specifies the minimum version of Windows PowerShell that will work with this module.
For example, you can specify 3.0, 4.0, or 5.0 as the value of this parameter.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateData
Specifies data that is passed to the module when it is imported.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessorArchitecture
Specifies the processor architecture that the module requires.
The acceptable values for this parameter are:

- None (unknown or unspecified)
- MSIL
- X86
- IA64
- Amd64
- Arm

```yaml
Type: ProcessorArchitecture
Parameter Sets: (All)
Aliases: 
Accepted values: None, MSIL, X86, IA64, Amd64, Arm

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectUri
Specifies the URL of a web page about this project.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseNotes
Specifies a string array that contains release notes or comments that you want to be available to users of this version of the script.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredAssemblies
Specifies the assembly (.dll) files that the module requires.
Enter the assembly file names.
Windows PowerShell loads the specified assemblies before updating types or formats, importing nested modules, or importing the module file that is specified in the value of the **RootModule** key.

Use this parameter to specify all of the assemblies that the module requires, including assemblies that must be loaded to update any formatting or type files that are listed in the **FormatsToProcess** or **TypesToProcess** keys, even if those assemblies are also listed as binary modules in the **NestedModules** key.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredModules
Specifies modules that must be in the global session state.
If the required modules are not in the global session state, Windows PowerShell imports them.
If the required modules are not available, the `Import-Module` command fails.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootModule
Specifies the primary or root file of the module.
Enter the file name of a script (.ps1), a script module (.psm1), a module manifest (.psd1), an assembly (.dll), a cmdlet definition XML file (.cdxml), or a workflow (.xaml).
When the module is imported, the members that are exported from the root module file are imported into the caller's session state.

If a module has a manifest file and no root file has been designated in the **RootModule** key, the manifest becomes the primary file for the module, and the module becomes a manifest module (ModuleType = Manifest).

To export members from .psm1 or .dll files in a module that has a manifest, the names of those files must be specified in the values of the **RootModule** or **NestedModules** keys in the manifest.
Otherwise, their members are not exported.

Note: In Windows PowerShell 2.0, this key was called **ModuleToProcess**.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptsToProcess
Specifies script (.ps1) files that run in the caller's session state when the module is imported.
You can use these scripts to prepare an environment, just as you might use a login script.

To specify scripts that run in the module's session state, use the **NestedModules** key.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
Specifies an array of tags.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypesToProcess
Specifies the type files (.ps1xml) that run when the module is imported.

When you import the module, Windows PowerShell runs the `Update-TypeData` cmdlet with the specified files.
Because type files are not scoped, they affect all session states in the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VariablesToExport
Specifies the variables that the module exports.
Wildcards are permitted.

You can use this parameter to restrict the variables that are exported by the module.
It can remove variables from the list of exported variables, but it cannot add variables to the list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompatiblePSEditions
Specifies the compatible PSEditions of the module.
For information about PSEdition, see [Modules with compatible PowerShell Editions](https://docs.microsoft.com/powershell/gallery/psget/module/modulewithpseditionsupport).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: Desktop, Core

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

