---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PackageManagement
ms.date: 3/29/2019
online version: http://go.microsoft.com/fwlink/?LinkID=517132
schema: 2.0.0
title: Find-Package
---

# Find-Package

## SYNOPSIS
Finds software packages in available package sources.

## SYNTAX

### NuGet

```
Find-Package [-IncludeDependencies] [-AllVersions] [-Source <String[]>] [-Credential <PSCredential>]
[-Proxy <Uri>] [-ProxyCredential <PSCredential>] [[-Name] <String[]>] [-RequiredVersion <String>]
[-MinimumVersion <String>] [-MaximumVersion <String>] [-Force] [-ForceBootstrap]
[-ProviderName <String[]>] [-ConfigFile <String>] [-SkipValidate] [-Headers <String[]>]
[-FilterOnTag <String[]>] [-Contains <String>] [-AllowPrereleaseVersions] [<CommonParameters>]
```

### PowerShellGet

```
Find-Package [-IncludeDependencies] [-AllVersions] [-Source <String[]>] [-Credential <PSCredential>]
[-Proxy <Uri>] [-ProxyCredential <PSCredential>] [[-Name] <String[]>] [-RequiredVersion <String>]
[-MinimumVersion <String>] [-MaximumVersion <String>] [-Force] [-ForceBootstrap]
[-ProviderName <String[]>] [-AllowPrereleaseVersions] [-PackageManagementProvider <String>]
[-PublishLocation <String>] [-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>]
[-Type <String>] [-Filter <String>] [-Tag <String[]>] [-Includes <String[]>]
[-DscResource <String[]>] [-RoleCapability <String[]>] [-Command <String[]>] [-AcceptLicense]
[<CommonParameters>]
```

## DESCRIPTION

`Find-Package` finds software packages that are available in package sources. `Get-PackageProvider`
and `Get-PackageSource` display details about your providers.

## EXAMPLES

### Example 1: Find all available packages from a package provider

This command finds all available PowerShell module packages in a registered gallery. Use
`Get-PackageProvider` to get the provider name.

```powershell
Find-Package -ProviderName PowerShellGet
```

```Output
Name                  Version   Source       Summary
----                  -------   ------       -------
SpeculationControl    1.0.12    PSGallery    This module provides the ability to query the...
AzureRM.profile       5.8.3     PSGallery    Microsoft Azure PowerShell - Profile credential...
Azure.Storage         4.6.1     PSGallery    Microsoft Azure PowerShell - Storage service cmdlets...
AzureRM.KeyVault      5.2.1     PSGallery    Microsoft Azure PowerShell - KeyVault service...
```

`Find-Package` uses the **Provider** parameter to specify the provider **PowerShellGet**.

### Example 2: Find a package from a package source

This command finds the newest version of a package from a specified package source. If a package
source isn't provided, `Find-Package` searches each installed package provider and its package
sources. Use `Get-PackageSource` to get the source name.

```powershell
Find-Package -Name StorageDSC -Source PSGallery
```

```Output
Name          Version  Source      Summary
----          -------  ------      -------
StorageDsc    4.5.0.0  PSGallery   This module contains all resources related to PowerShell Storage 
```

`Find-Package` uses the **Name** parameter to specify the package name **StorageDSC**. The
**Source** parameter specifies to search for the package in **PSGallery**.

### Example 3: Find all versions of a package

This command finds all available package versions from a specified provider.

```powershell
Find-Package -Name StorageDSC -ProviderName PowerShellGet -AllVersions
```

```Output
Name         Version    Source      Summary
----         -------    ------      -------
StorageDsc   4.5.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.4.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.3.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.2.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.1.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.0.0.0    PSGallery   This module contains resources related to the PowerShell Storage
```

`Find-Package` uses the **Name** parameter to specify the package **StorageDSC**. The
**ProviderName** parameter specifies to search for the package in **PowerShellGet**. **AllVersions**
specifies that all available versions are returned.

### Example 4: Find a package with a specific name and version

This command finds a specific package version from a specified provider.

```powershell
Find-Package -Name StorageDSC -ProviderName PowerShellGet -RequiredVersion 4.4.0.0
```

```Output
Name         Version    Source      Summary
----         -------    ------      -------
StorageDsc   4.4.0.0    PSGallery   This module contains resources related to the PowerShell Storage
```

`Find-Package` uses the **Name** parameter to specify the package name **StorageDSC**. The
**ProviderName** parameter specifies to search for the package in **PowerShellGet**.
**RequiredVersion** specifies that only version **4.4.0.0** is returned.

### Example 5: Find packages within a range of versions

This command finds a range of versions for a specified package.

```powershell
Find-Package -Name StorageDSC -MinimumVersion 4.1.0.0 -MaximumVersion 4.3.0.0 -AllVersions
```

```Output
StorageDsc   4.3.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.2.0.0    PSGallery   This module contains resources related to the PowerShell Storage
StorageDsc   4.1.0.0    PSGallery   This module contains resources related to the PowerShell Storage
```

`Find-Package` uses the **Name** parameter to specify the package name **StorageDSC**. The
**ProviderName** parameter specifies to search for the package in **PowerShellGet**.
**MinimumVersion** specifies the lowest version **4.1.0.0**. **MaximumVersion** specifies the
highest version **4.3.0.0**. **AllVersions** determines the range is returned as specified by the
minimum and maximum.

### Example 6: Find a package from a file system

This command finds packages with the file extension .`nupkg` that are stored on the local computer.
The files are packages downloaded from a gallery such as the PowerShell Gallery.

```
PS> Find-Package -Source C:\Temp
```

```Output
Name          Version Source                              Summary
----          ------- ------                              -------
PowerShellGet 2.1.2   C:\Temp\powershellget.2.1.2.nupkg   PowerShell module with commands for...
NetworkingDsc 7.0.0   C:\Temp\networkingdsc.7.0.0.nupkg   Module with DSC Resources for Networking
```

## PARAMETERS

### -AcceptLicense

Automatically accepts a license agreement if the package requires it.

```yaml
Type: SwitchParameter
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowPrereleaseVersions

Includes packages marked as a prerelease in the results.

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

### -AllVersions

Indicates that `Find-Package` returns all available versions of the package. By default,
`Find-Package` only returns the newest available version.

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

### -Command

Specifies an array of commands searched by `Find-Package`.

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigFile

Specifies a configuration file.

```yaml
Type: String
Parameter Sets: NuGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Contains

`Find-Package` gets objects if any item in the object's property values are an exact match for the
specified value.

```yaml
Type: String
Parameter Sets: NuGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to search for packages.

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

Specifies an array of Desired State Configuration (DSC) resources that this cmdlet searches.

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies terms to search for within the **Name** and **Description** properties.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterOnTag

Specifies the tag that filters the results. Results that don't contain the specified tag are
excluded.

```yaml
Type: String[]
Parameter Sets: NuGet
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

Indicates that `Find-Package` forces **PackageManagement** to automatically install the package
provider.

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

### -Headers

Specifies the headers for the package.

```yaml
Type: String[]
Parameter Sets: NuGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeDependencies

Indicates that this cmdlet includes package dependencies in the results.

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

Specifies whether `Find-Package` should find all packages within a category.

The accepted values are as follows:

- Cmdlet
- DscResource
- Function
- RoleCapability
- Workflow

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases:
Accepted values: Cmdlet, DscResource, Function, RoleCapability, Workflow

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum package version that you want to find.

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

### -MinimumVersion

Specifies the minimum package version that you want to find. If a higher version is available, that
version is returned.

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

### -Name

Specifies one or more package names, or package names with wildcard characters. Separate multiple
package names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -PackageManagementProvider

Specifies the name of a package management provider.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies one or more package provider names. Separate multiple package provider names with commas.
Use `Get-PackageProvider` to get a list of available package providers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: Bootstrap, NuGet, PowerShellGet

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Proxy

Specifies a proxy server for the request, rather than a direct connection to the internet resource.

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

### -ProxyCredential

Specifies a user account that has permission to use the proxy server that is specified by the
**Proxy** parameter.

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

### -PublishLocation

Specifies a location for publishing the package.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion

Specifies an exact package version that you want to find.

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

### -RoleCapability

Specifies an array of role capabilities.

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptPublishLocation

Specifies a script publishing location for the package.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptSourceLocation

Specifies a script source location.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipValidate

Switch that skips package credential validation.

```yaml
Type: SwitchParameter
Parameter Sets: NuGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies one or more package sources. Use `Get-PackageSource` to get a list of available package
sources. A file system directory can be used as a source for download packages.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tag

Specifies one or more strings to search for in the package metadata.

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Specifies whether to search for packages with a module, a script, or either.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:
Accepted values: Module, Script, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

`Find-Package` doesn't accept input from the pipeline.

## OUTPUTS

### SoftwareIdentify[]

`Find-Package` outputs a **SoftwareIdentity** object.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-Package](Get-Package.md)

[Get-PackageProvider](Get-PackageProvider.md)

[Get-PackageSource](Get-PackageSource.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)