---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 07/08/2019
online version: https://docs.microsoft.com/powershell/module/powershellget/update-modulemanifest?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Update-ModuleManifest
---

# Update-ModuleManifest

## SYNOPSIS
Updates a module manifest file.

## SYNTAX

### All

```
Update-ModuleManifest [-Path] <String> [-NestedModules <Object[]>] [-Guid <Guid>] [-Author <String>]
 [-CompanyName <String>] [-Copyright <String>] [-RootModule <String>] [-ModuleVersion <Version>]
 [-Description <String>] [-ProcessorArchitecture <ProcessorArchitecture>]
 [-CompatiblePSEditions <String[]>] [-PowerShellVersion <Version>] [-ClrVersion <Version>]
 [-DotNetFrameworkVersion <Version>] [-PowerShellHostName <String>]
 [-PowerShellHostVersion <Version>] [-RequiredModules <Object[]>] [-TypesToProcess <String[]>]
 [-FormatsToProcess <String[]>] [-ScriptsToProcess <String[]>] [-RequiredAssemblies <String[]>]
 [-FileList <String[]>] [-ModuleList <Object[]>] [-FunctionsToExport <String[]>]
 [-AliasesToExport <String[]>] [-VariablesToExport <String[]>] [-CmdletsToExport <String[]>]
 [-DscResourcesToExport <String[]>] [-PrivateData <Hashtable>] [-Tags <String[]>]
 [-ProjectUri <Uri>] [-LicenseUri <Uri>] [-IconUri <Uri>] [-ReleaseNotes <String[]>]
 [-Prerelease <String>] [-HelpInfoUri <Uri>] [-PassThru] [-DefaultCommandPrefix <String>]
 [-ExternalModuleDependencies <String[]>] [-PackageManagementProviders <String[]>]
 [-RequireLicenseAcceptance] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Update-ModuleManifest` cmdlet updates a module manifest (`.psd1`) file.

## EXAMPLES

### Example 1: Update a module manifest

This example updates an existing module manifest file. Splatting is used to pass parameter values to
`Update-ModuleManifest`. For more information, see [about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

```powershell
$Parms = @{
  Path = "C:\Test\TestManifest.psd1"
  Author = "TestUser1"
  CompanyName = "Contoso Corporation"
  Copyright = "(c) 2019 Contoso Corporation. All rights reserved."
}

Update-ModuleManifest @Parms
```

`$Parms` is a splat that stores the parameter values for **Path**, **Author**, **CompanyName**, and
**Copyright**. `Update-ModuleManifest` gets the parameter values from `@Parms` and updates the
module manifest, **TestManifest.psd1**.

## PARAMETERS

### -AliasesToExport

Specifies the aliases that the module exports. Wildcards are permitted.

Use this parameter to restrict the aliases that are exported by the module. **AliasesToExport** can
remove aliases from the list of exported aliases, but it can't add aliases to the list.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Author

Specifies the module author.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClrVersion

Specifies the minimum version of the Common Language Runtime (CLR) of the Microsoft .NET Framework
that the module requires.

```yaml
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CmdletsToExport

Specifies the cmdlets that the module exports. Wildcards are permitted.

Use this parameter to restrict the cmdlets that are exported by the module. **CmdletsToExport** can
remove cmdlets from the list of exported cmdlets, but it can't add cmdlets to the list.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -CompanyName

Specifies the company or vendor who created the module.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompatiblePSEditions

Specifies the compatible **PSEditions** of the module. For information about **PSEdition**, see
[Modules with compatible PowerShell Editions](/powershell/scripting/gallery/concepts/module-psedition-support).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:
Accepted values: Desktop, Core

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running `Update-ModuleManifest`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Copyright

Specifies a copyright statement for the module.

```yaml
Type: System.String
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
Type: System.String
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
Type: System.String
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
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DscResourcesToExport

Specifies the Desired State Configuration (DSC) resources that the module exports. Wildcards are
permitted.

```yaml
Type: System.String[]
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
Type: System.String[]
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
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatsToProcess

Specifies the formatting files (`.ps1xml`) that run when the module is imported.

When you import a module, PowerShell runs the `Update-FormatData` cmdlet with the specified files.
Because formatting files aren't scoped, they affect all session states in the session.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FunctionsToExport

Specifies the functions that the module exports. Wildcards are permitted.

Use this parameter to restrict the functions that are exported by the module. **FunctionsToExport**
can remove functions from the list of exported aliases, but it can't add functions to the list.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Guid

Specifies a unique identifier for the module. The GUID can be used to distinguish among modules with
the same name.

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HelpInfoUri

Specifies the internet address of the module's **HelpInfo XML** file. Enter a Uniform Resource
Identifier (URI) that begins with **http** or **https**.

The **HelpInfo XML** file supports the Updatable Help feature that was introduced in PowerShell
version 3.0. It contains information about the location of the module's downloadable help files and
the version numbers of the newest help files for each supported locale.

For information about Updatable Help, see [about_Updatable_Help](../Microsoft.PowerShell.Core/About/about_Updatable_Help.md).
For information about the **HelpInfo XML** file, see [Supporting Updatable Help](/powershell/scripting/developer/module/supporting-updatable-help).

```yaml
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconUri

Specifies the URL of an icon for the module. The specified icon is displayed on the gallery web page
for the module.

```yaml
Type: System.Uri
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
Type: System.Uri
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

Enter each module name as a string or as a hash table with **ModuleName** and **ModuleVersion**
keys. The hash table can also have an optional **GUID** key. You can combine strings and hash tables
in the parameter value.

This key is designed to act as a module inventory. The modules that are listed in the value of this
key aren't automatically processed.

```yaml
Type: System.Object[]
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
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NestedModules

Specifies script modules (`.psm1`) and binary modules (`.dll`) that are imported into the module's
session state. The files in the **NestedModules** key run in the order in which they're listed in
the value.

Enter each module name as a string or as a hash table with **ModuleName** and **ModuleVersion**
keys. The hash table can also have an optional **GUID** key. You can combine strings and hash tables
in the parameter value.

```yaml
Type: System.Object[]
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
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you're working. By default,
`Update-ModuleManifest` doesn't generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path and file name of the module manifest. Enter a path and file name with a `.psd1`
file name extension, such as `$PSHOME\Modules\MyModule\MyModule.psd1`.

If you specify the path to an existing file, `Update-ModuleManifest` replaces the file without
warning unless the file has the read-only attribute.

The manifest should be located in the module's directory, and the manifest file name should be the
same as the module directory name, but with a `.psd1` extension.

You can't use variables, such as `$PSHOME` or `$HOME`, in response to a prompt for a **Path**
parameter value. To use a variable, include the **Path** parameter in the command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PowerShellHostName

Specifies the name of the PowerShell host program that the module requires. Enter the name of the
host program, such as PowerShell ISE Host or ConsoleHost. Wildcards aren't permitted.

To find the name of a host program, in the program, type `$Host.Name`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellHostVersion

Specifies the minimum version of the PowerShell host program that works with the module. Enter a
version number, such as 1.1.

```yaml
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellVersion

Specifies the minimum version of PowerShell that will work with this module. For example, you can
specify 3.0, 4.0, or 5.0 as the value of this parameter.

```yaml
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prerelease

Indicates the module is prerelease.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateData

Specifies data that is passed to the module when it's imported.

```yaml
Type: System.Collections.Hashtable
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

- Amd64
- Arm
- IA64
- MSIL
- None (unknown or unspecified)
- X86

```yaml
Type: System.Reflection.ProcessorArchitecture
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
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseNotes

Specifies a string array that contains release notes or comments that you want available for this
version of the script.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireLicenseAcceptance

Specifies that a license acceptance is required for the module.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredAssemblies

Specifies the assembly (`.dll`) files that the module requires. Enter the assembly file names.
PowerShell loads the specified assemblies before updating types or formats, importing nested
modules, or importing the module file that is specified in the value of the **RootModule** key.

Use this parameter to specify all the assemblies that the module requires, including assemblies that
must be loaded to update any formatting or type files that are listed in the **FormatsToProcess** or
**TypesToProcess** keys, even if those assemblies are also listed as binary modules in the
**NestedModules** key.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredModules

Specifies modules that must be in the global session state. If the required modules aren't in the
global session state, PowerShell imports them. If the required modules aren't available, the
`Import-Module` command fails.

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootModule

Specifies the primary or root file of the module. Enter the file name of a script (`.ps1`), a script
module (`.psm1`), a module manifest (`.psd1`), an assembly (`.dll`), a cmdlet definition XML file
(`.cdxml`), or a workflow (`.xaml`). When the module is imported, the members that are exported from
the root module file are imported into the caller's session state.

If a module has a manifest file and no root file has been specified in the **RootModule** key, the
manifest becomes the primary file for the module. And, the module becomes a manifest module
(ModuleType = Manifest).

To export members from `.psm1` or `.dll` files in a module that has a manifest, the names of those
files must be specified in the values of the **RootModule** or **NestedModules** keys in the
manifest. Otherwise, their members aren't exported.

In PowerShell 2.0, this key was called **ModuleToProcess**.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptsToProcess

Specifies script (`.ps1`) files that run in the caller's session state when the module is imported.
You can use these scripts to prepare an environment, just as you might use a login script.

To specify scripts that run in the module's session state, use the **NestedModules** key.

```yaml
Type: System.String[]
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
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypesToProcess

Specifies the type files (`.ps1xml`) that run when the module is imported.

When you import the module, PowerShell runs the `Update-TypeData` cmdlet with the specified files.
Because type files aren't scoped, they affect all session states in the session.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VariablesToExport

Specifies the variables that the module exports. Wildcards are permitted.

Use this parameter to restrict the variables that are exported by the module. **VariablesToExport**
can remove variables from the list of exported variables, but it can't add variables to the list.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -WhatIf

Shows what would happen if `Update-ModuleManifest` runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

> [!IMPORTANT]
> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS)
> versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when
> trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS
> 1.2:
>
> `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
>
> For more information, see the
> [announcement](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/) in the
> PowerShell blog.

## RELATED LINKS
