---
ms.date:  4/3/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517140
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Save-Package
---

# Save-Package

## SYNOPSIS
Saves packages to the local computer without installing them.

## SYNTAX

### PackageBySearch

```
Save-Package [[-Name] <string[]>] [-RequiredVersion <string>] [-MinimumVersion <string>]
[-MaximumVersion <string>] [-Source <string[]>] [-Path <string>] [-LiteralPath <string>]
[-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
[-ProviderName <string[]>] [<CommonParameters>]
```

### PackageByInputObject

```
Save-Package -InputObject <SoftwareIdentity> [-Path <string>] [-LiteralPath <string>]
[-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PSModule:PackageByInputObject

```
Save-Package [-Path <string>] [-LiteralPath <string>] [-Credential <pscredential>] [-Force]
[-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <string>] [-Scope <string>]
[-PublishLocation <string>] [-AllVersions] [-Filter <string>] [-Tag <string[]>]
[-Includes <string[]>] [-DscResource <string[]>] [-Command <string[]>] [<CommonParameters>]
```

### PSModule

```
Save-Package [-Path <string>] [-LiteralPath <string>] [-Credential <pscredential>] [-Force]
[-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <string>] [-Scope <string>]
[-PublishLocation <string>] [-AllVersions] [-Filter <string>] [-Tag <string[]>]
[-Includes <string[]>] [-DscResource <string[]>] [-Command <string[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Save-Package` cmdlet saves packages to the local computer but doesn't install the packages.
This cmdlet saves the newest version of a package unless you specify a **RequiredVerion**. The
**Path** and **LiteralPath** parameters are mutually exclusive, and cannot be added to the same
command.

## EXAMPLES

### Example 1: Save a package to the local computer

This example saves the newest version of the package to a directory on the local computer. The
package's dependencies are download with the package.

```
PS> Save-Package -Name NuGet.Core -ProviderName NuGet -Path C:\LocalPkg
```

```Output
Name                    Version    Source    Summary
----                    -------    ------    -------
Microsoft.Web.Xdt       3.0.0      Nuget     Microsoft Xml Document Transformation (XDT) enables...
NuGet.Core              2.14.0     Nuget     NuGet.Core is the core framework assembly for NuGet...
```

`Save-Package` uses the **Name** parameter to specify the package. The package is downloaded from
the repository specified by the **ProviderName** parameter. The **Path** parameter determines where
the package is saved.

### Example 2: Save a specific package version

This example specifies the package version and saves it to a directory on the local computer.

```
PS> Save-Package -Name NuGet.Core -RequiredVersion 2.9.0 -ProviderName NuGet -Path C:\LocalPkg
```

```Output
Name                    Version    Source    Summary
----                    -------    ------    -------
Microsoft.Web.Xdt       3.0.0      Nuget     Microsoft Xml Document Transformation (XDT) enables...
NuGet.Core              2.9.0      Nuget     NuGet.Core is the core framework assembly for NuGet...
```

`Save-Package` uses the **Name** parameter to specify the package. **RequiredVersion** indicates a
specific package version. The package is downloaded from the repository specified by the
**ProviderName** parameter. The **Path** parameter determines where the package is saved.

### Example 3: Use Find-Package to save a package

This command uses `Find-Package` to locate the newest version of the package and sends the object to
`Save-Package`.

```
PS> Find-Package -Name NuGet.Core -ProviderName NuGet | Save-Package -Path C:\LocalPkg
```

`Find-Package` uses the **Name** parameter to specify the package. The package is downloaded from
the repository specified by the **ProviderName** parameter. The object is sent down the pipeline to
`Save-Package`. The **Path** parameter determines where the package is saved.

### Example 4: Save and install the package

The newest version of the package and its dependencies are downloaded and installed on the local
computer.

```
PS> Save-Package -Name NuGet.Core -ProviderName NuGet -Path C:\LocalPkg
PS> Install-Package C:\LocalPkg\NuGet.Core.2.14.0.nupkg
```

`Save-Package` downloads the package file and its dependencies to the local computer.
`Install-Package` installs the package and dependencies from the specified directory.

## PARAMETERS

### -AllVersions

Indicates that this cmdlet saves all available versions of the package.

```yaml
Type: SwitchParameter
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command

Specifies one or more commands included in the package.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageByInputObject, PSModule
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

### -Credential

Specifies a user account that has permission to save a package from a specified package provider or
source.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DscResource

Specifies one or more Desired State Configuration (DSC) resources for the package.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies a filter for the package.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule
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

Indicates that `Save-Package` forces **PackageManagement** to automatically install the package
provider for the specified package.

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

### -Includes

Indicates the resources that the package includes.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:
Accepted values: DscResource, Cmdlet, Function

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

A software ID object that represents the package that you want to save. Software IDs are part of the
results of the `Find-Package` cmdlet.

```yaml
Type: SoftwareIdentity
Parameter Sets: PackageByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the literal path to which you want to save the package. You cannot add both this parameter
and the **Path** parameter to the same command.

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

### -MaximumVersion

Specifies the maximum version of the package that you want to save.

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

Specifies the minimum version of the package that you want to find.

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

### -Name

Specifies one or more package names.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider

Specifies a package management provider.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the location on the local computer to store the package.

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

### -ProviderName

Specifies one or more provider names.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases: Provider
Accepted values: Bootstrap, chocolatey, msi, msu, nuget, Programs, PSModule

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PublishLocation

Specifies the publish location.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version of the package to save.

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

Specifies the scope of the package. The acceptable values for this parameter are: AllUsers and CurrentUser.

```yaml
Type: String
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies one or more package sources.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tag

Specifies a tag to search for within the package metadata.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageByInputObject, PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### `Save-Package` accepts objects from the pipeline.

## OUTPUTS

### This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-Package](Get-Package.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)