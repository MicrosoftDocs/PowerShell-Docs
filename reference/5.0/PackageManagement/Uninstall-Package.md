---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517142
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Uninstall-Package
---
# Uninstall-Package

## SYNOPSIS

Uninstalls one or more software packages.

## SYNTAX

### PackageByInputObject

```
Uninstall-Package [-InputObject] <SoftwareIdentity[]> [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PackageBySearch

```
Uninstall-Package [-Name] <String[]> [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-ProviderName <String[]>]
 [<CommonParameters>]
```

### msi:PackageByInputObject

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-AdditionalArguments <String[]>]
 [<CommonParameters>]
```

### msi:PackageBySearch

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-AdditionalArguments <String[]>]
 [<CommonParameters>]
```

### Programs:PackageByInputObject

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-IncludeWindowsInstaller]
 [-IncludeSystemComponent] [<CommonParameters>]
```

### Programs:PackageBySearch

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-IncludeWindowsInstaller]
 [-IncludeSystemComponent] [<CommonParameters>]
```

### PSModule:PackageByInputObject

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <String>]
 [-Location <String>] [-InstallUpdate] [-InstallationPolicy <String>] [-DestinationPath <String>]
 [<CommonParameters>]
```

### PSModule:PackageBySearch

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <String>]
 [-Location <String>] [-InstallUpdate] [-InstallationPolicy <String>] [-DestinationPath <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The **Uninstall-Package** cmdlet uninstalls one or more software packages from the local computer.

## EXAMPLES

### Example 1: Uninstall a package

```
PS C:\> Uninstall-Package -Name "DSCAccelerator"
```

This command uninstalls a package named DSCAccelerator.

### Example 2: Uninstall a package by piping results of Get-Package

```
PS C:\> Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1.2" | Uninstall-Package -Force
```

This command uninstalls a package named DSCAccelerator by first locating the exact package with the **Get-Package** cmdlet, then piping the results of **Get-Package** to the **Uninstall-Package** cmdlet.
The *Force* parameter ensures that you are not prompted to confirm that you want to uninstall the package.

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

### -DestinationPath

Specifies a string of the path to the input object.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule:PackageBySearch
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

Indicates that this cmdlet uninstalls the package through Windows Installer.

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
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InstallUpdate

Indicates that this cmdlet uninstalls updates.

```yaml
Type: SwitchParameter
Parameter Sets: PSModule:PackageByInputObject, PSModule:PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallationPolicy

Specifies the installation policy. Valid values are: Trusted, UnTrusted.


```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule:PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Specifies a path to the input object. 

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule:PackageBySearch
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
If you do not add this parameter, **Uninstall-Package** uninstalls the newest available version of the package that also satisfies any maximum version specified by the *MaximumVersion* parameter.

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
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider

Specifies the Package Management provider.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule:PackageBySearch
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
Accepted values: msi, Programs, msu, Bootstrap, PSModule, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact allowed version of the package that you want to uninstall.
If you do not add this parameter, this cmdlet installs the newest available version of the package (subject to any maximum specified version, if you've added the *MaximumVersion* parameter).

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_packagemanagement.md)

[Find-Package](Find-Package.md)

[Get-Package](Get-Package.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)
