---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517142
schema: 2.0.0
---

# Uninstall-Package
## SYNOPSIS
Uninstalls one or more software packages.

## SYNTAX

### PackageByInputObject
```
Uninstall-Package [-InputObject] <SoftwareIdentity[]> [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf]
 [-Confirm]
```

### PackageBySearch
```
Uninstall-Package [-Name] <String[]> [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-ProviderName <String[]>]
```

### Programs:PackageByInputObject
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-IncludeWindowsInstaller]
 [-IncludeSystemComponent]
```

### Programs:PackageBySearch
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-IncludeWindowsInstaller]
 [-IncludeSystemComponent]
```

### msi:PackageByInputObject
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <String[]>]
```

### msi:PackageBySearch
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <String[]>]
```

### NuGet:PackageByInputObject
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-Destination <String>]
 [-ExcludeVersion] [-Scope <String>]
```

### NuGet:PackageBySearch
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-Destination <String>]
 [-ExcludeVersion] [-Scope <String>]
```

### PowerShellGet:PackageByInputObject
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-Scope <String>]
 [-PackageManagementProvider <String>] [-Type <String>] [-InstallUpdate]
```

### PowerShellGet:PackageBySearch
```
Uninstall-Package [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-Scope <String>]
 [-PackageManagementProvider <String>] [-Type <String>] [-InstallUpdate]
```

## DESCRIPTION
The Uninstall-Package cmdlet uninstalls one or more software packages from the local computer.

## EXAMPLES

### Example 1: Uninstall a package
```
PS C:\>Uninstall-Package -Name "DSCAccelerator"
```

This command uninstalls a package named DSCAccelerator.

### Example 2: Uninstall a package by piping results of Get-Package
```
PS C:\>Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1.2" | Uninstall-Package -Force
```

This command uninstalls a package named DSCAccelerator by first locating the exact package with the Get-Package cmdlet, then piping the results of Get-Package to the Uninstall-Package cmdlet.
The Force parameter ensures that you are not prompted to confirm that you want to uninstall the package.

## PARAMETERS

### -AdditionalArguments
Specifies additional arguments.

```yaml
Type: String[]
Parameter Sets: msi:PackageByInputObject, msi:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions
Indicates that this cmdlet uninstalls all versions of the package.

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

### -Force
Forces the command to run without asking for user confirmation.

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

### -ForceBootstrap
Forces Package Management to automatically install the package provider for the specified package.

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

### -IncludeSystemComponent
Specifies that this cmdlet uninstalls system components.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageByInputObject, Programs:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeWindowsInstaller
Indicates that this cmdlet uninstalls the Windows installer.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageByInputObject, Programs:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a package by using the package's SoftwareIdentity type, which is shown in the results of the Get-Package cmdlet.

```yaml
Type: SoftwareIdentity[]
Parameter Sets: PackageByInputObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InstallUpdate
Indicates that this cmdlet uninstalls updates.

```yaml
Type: SwitchParameter
Parameter Sets: PowerShellGet:PackageByInputObject, PowerShellGet:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum allowed version of the package that you want to uninstall.
If you do not specify this parameter, this cmdlet uninstalls the highest-numbered available version of the package on the computer.

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum allowed version of the package that you want to uninstall.
If you do not add this parameter, Uninstall-Package uninstalls the newest available version of the package that also satisfies any maximum version specified by the MaximumVersion parameter.

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies one or more package names.
Multiple names must be separated by commas.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider
Specifies the Package Management provider.

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageByInputObject, PowerShellGet:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName
Specifies one or more package provider names to which to scope your package search.
You can get package provider names by running the Get-PackageProvider cmdlet.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact allowed version of the package that you want to uninstall.
If you do not add this parameter, Uninstall-Package installs the newest available version of the package (subject to any maximum specified version, if you've added the MaximumVersion parameter).

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Specifies the scope at which to uninstall the package.
The acceptable values for this parameter are:

-- CurrentUser
-- AllUsers

```yaml
Type: String
Parameter Sets: NuGet:PackageByInputObject, NuGet:PackageBySearch, PowerShellGet:PackageByInputObject, PowerShellGet:PackageBySearch
Aliases: 
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies whether to search for packages with a module, a script, or either.
The acceptable values for this parameter are:

-- Module
-- Script
-- All

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageByInputObject, PowerShellGet:PackageBySearch
Aliases: 
Accepted values: Module, Script, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

### -Destination
{{Fill Destination Description}}

```yaml
Type: String
Parameter Sets: NuGet:PackageByInputObject, NuGet:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeVersion
{{Fill ExcludeVersion Description}}

```yaml
Type: SwitchParameter
Parameter Sets: NuGet:PackageByInputObject, NuGet:PackageBySearch
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[about_PackageManagement]()

[Find-Package]()

[Get-Package]()

[Install-Package]()

[Save-Package]()

