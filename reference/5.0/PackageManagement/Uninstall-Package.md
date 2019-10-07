---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
ms.date: 05/24/2019
online version: https://docs.microsoft.com/powershell/module/packagemanagement/uninstall-package?view=powershell-5.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Uninstall-Package
---

# Uninstall-Package

## SYNOPSIS
Uninstalls one or more software packages.

## SYNTAX

### PackageByInputObject

```
Uninstall-Package [-InputObject] <SoftwareIdentity[]> [-Force] [-ForceBootstrap] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### PackageBySearch

```
Uninstall-Package [-Name] <string[]> [-RequiredVersion <string>] [-MinimumVersion <string>]
 [-MaximumVersion <string>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-ProviderName <string[]>] [<CommonParameters>]
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

### msi:PackageByInputObject

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-AdditionalArguments <string[]>]
 [<CommonParameters>]
```

### msi:PackageBySearch

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-AdditionalArguments <string[]>]
 [<CommonParameters>]
```

### PSModule:PackageByInputObject

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-PackageManagementProvider <string>] [-Location <string>] [-InstallUpdate]
 [-InstallationPolicy <string>] [-DestinationPath <string>] [<CommonParameters>]
```

### PSModule:PackageBySearch

```
Uninstall-Package [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-PackageManagementProvider <string>] [-Location <string>] [-InstallUpdate]
 [-InstallationPolicy <string>] [-DestinationPath <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Uninstall-Package` cmdlet uninstalls one or more software packages from the local computer. To
find installed packages, use the `Get-Package` cmdlet.

## EXAMPLES

### Example 1: Uninstall a package

The `Uninstall-Package` cmdlet uninstalls packages. The **Name** parameter specifies the package to
uninstall. If multiple versions of a package are installed, the newest version is uninstalled.

```
PS> Uninstall-Package -Name NuGet.Core
```

### Example 2: Use the pipeline to uninstall a package

`Get-Package` locates a specific package and sends the **SoftwareIdentity** object down the pipeline
to the `Uninsall-Package` cmdlet.

```
PS> Get-Package -Name NuGet.Core -RequiredVersion 2.14.0 | Uninstall-Package
```

The `Get-Package` cmdlet uses the **Name** and **RequiredVersion** parameters to specify a package.
A **SoftwareIdentity** object is sent down the pipeline. The `Uninstall-Package` cmdlet receives the
object as an **InputObject** and removes the package.

As an alternative, the `Uninstall-Package` cmdlet can specify a value for the **InputObject**
parameter:

`Uninstall-Package -InputObject ( Get-Package -Name NuGet.Core -RequiredVersion 2.14.0 )`

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

Forces **PackageManagement** to automatically install the package provider for the specified
package.

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

Accepts pipeline input that specifies the package's **SoftwareIdentity** object from the
`Get-Package` cmdlet. **InputObject** accepts the **SoftwareIdentity** object as a `Get-Package`
value or a variable that contains the object.

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

Indicates that `Uninstall-Package` uninstalls updates.

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

Specifies the maximum allowed package version that you want to uninstall. If you don't specify this
parameter, `Uninstall-Package` uninstalls the package's newest version.

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

Specifies the minimum allowed package version that you want to uninstall. If you don't add this
parameter, `Uninstall-Package` uninstalls the package's newest version that satisfies any version
specified by the **MaximumVersion** parameter.

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

Specifies one or more package names. Multiple package names must be separated by commas.

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

Specifies the **PackageManagement** provider.

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

Specifies one or more package provider names to search for packages. You can get package provider
names by running the `Get-PackageProvider` cmdlet.

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

Specifies the exact allowed version of the package that you want to uninstall. If you don't add this
parameter, `Uninstall-Package` uninstalls the package's newest version that satisfies any version
specified by the **MaximumVersion** parameter.

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

Shows what would happen if `Uninstall-Package` cmdlet is run. The cmdlet isn't run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### `Uninstall-Package` accepts **SoftwareIdentity** objects from the pipeline as input.

## OUTPUTS

### `Uninstall-Package` doesn't generate any output.

## NOTES

Including a package provider in a command can make dynamic parameters available to a cmdlet. Dynamic
parameters are specific to a package provider. The `Get-Help` cmdlet lists a cmdlet's parameter sets
and includes the provider's parameter set.

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Find-Package](Find-Package.md)

[Get-Package](Get-Package.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)
