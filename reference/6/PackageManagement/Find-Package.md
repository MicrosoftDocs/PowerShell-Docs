---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517132
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Find-Package
---

# Find-Package

## SYNOPSIS
Finds software packages in available package sources.

## SYNTAX

### NuGet
```
Find-Package [-IncludeDependencies] [-AllVersions] [-Source <String[]>] [-Credential <PSCredential>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [[-Name] <String[]>] [-RequiredVersion <String>]
 [-MinimumVersion <String>] [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>]
 [-ConfigFile <String>] [-SkipValidate] [-Headers <String[]>] [-FilterOnTag <String[]>] [-Contains <String>]
 [-AllowPrereleaseVersions] [<CommonParameters>]
```

### PowerShellGet
```
Find-Package [-IncludeDependencies] [-AllVersions] [-Source <String[]>] [-Credential <PSCredential>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [[-Name] <String[]>] [-RequiredVersion <String>]
 [-MinimumVersion <String>] [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>]
 [-PackageManagementProvider <String>] [-PublishLocation <String>] [-ScriptSourceLocation <String>]
 [-ScriptPublishLocation <String>] [-Type <String>] [-Filter <String>] [-Tag <String[]>] [-Includes <String[]>]
 [-DscResource <String[]>] [-RoleCapability <String[]>] [-Command <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Find-Package** cmdlet finds matching software packages that are available in package sources.

## EXAMPLES

### Example 1: Find all available packages from a package provider
```
PS C:\> Find-Package -Provider "PSModule"
```

This command finds all available Windows PowerShell module packages from galleries that are registered with the PSModule provider.

### Example 2: Find a package from a provider that is not yet installed
```
PS C:\> Find-Package -Name "Git" -Provider "Chocolatey"
```

This command first automatically installs the Chocolatey provider on the local computer, then searches for the Git package within that provider.

### Example 3: Find a package from a package source
```
PS C:\> Find-Package -Name "Git" -Source "ChocolateyRepository"
```

This command finds a package from a specified package source.
This is a useful command if you know the name of the package source that you want to search, but are unsure about the package provider to which the source is registered.
Without specifying a package source, **Find-Package** searches through all installed package providers and their package sources for a specified package.
You can run Get-PackageSource -Location to get a package source name.

### Example 4: Find a package from a file system
```
PS C:\> Find-Package "C:\temp"
```

This command finds packages from all installed PackageManagement package providers that are stored in the C:\temp folder on the local computer.

### Example 5: Find a package with a specific name and version
```
PS C:\> Find-Package -Name "DSCAccel" -RequiredVersion "2.1.2"
```

This command finds version 2.1.2 of a package named DSCAccelerator.
Although only part of the package name has been specified, **Find-Package** should be able to find the DSCAccelerator package if there are no other packages with a name matching that pattern.

### Example 6: Find packages within a range of versions
```
PS C:\> Find-Package -Name "DSCAccelerator" -MinimumVersion "1.5.0" -MaximumVersion "2.1" -AllVersions
```

This command finds a matching range of versions of a package named DSCAccelerator, by adding the *MinimumVersion* and *MaximumVersion* parameters to specify a range, and the *AllVersions* parameter to specify that all matching results within that range are returned as results.

## PARAMETERS

### -AllVersions
Indicates that **Find-Package** returns all available versions of the package.
By default, **Find-Package** only returns the newest available version.

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
Specifies an array of commands for which this cmdlet searches.

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
Specifies an array of Desired State Configuration (DSC) resources for which this cmdlet searches.

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
Indicates that this cmdlet forces Package Management to automatically install the package provider.

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
Specifies whether **Find-Package** should find all packages with DSC resources, cmdlets, functions, or workflows.
The acceptable values for this parameter are:

- Cmdlet
- DscResource
- Function
- Workflow

```yaml
Type: String[]
Parameter Sets: PowerShellGet
Aliases: 
Accepted values: DscResource, Cmdlet, Function, Workflow

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum allowed version of the package that you want to find.
If you do not add this parameter, **Find-Package** finds the highest available version of the package.

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
Specifies the minimum allowed version of the package that you want to find.
If you do not add this parameter, **Find-Package** finds the highest available version of the package that also satisfies any maximum specified version specified by the *MaximumVersion* parameter.

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
Specifies one or more package names, or package names with wildcard characters.
Separate multiple package names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider
Specifies the name of the Package Management provider.

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
Specifies one or more package provider names.
Separate multiple package provider names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Specifies the exact allowed version of the package to find.
If you do not add this parameter, **Find-Package** finds the highest available version of the provider that also satisfies any maximum version specified by the *MaximumVersion* parameter.

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

### -Source
Specifies one or more package sources.
You can get a list of available package sources by using the Get-PackageSource cmdlet.

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

### -AllowPrereleaseVersions
{{Fill AllowPrereleaseVersions Description}}

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

### -ConfigFile
{{Fill ConfigFile Description}}

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
{{Fill Contains Description}}

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

### -FilterOnTag
{{Fill FilterOnTag Description}}

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

### -Headers
{{Fill Headers Description}}

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

### -Proxy
@{Text=}

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
@{Text=}

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

### -RoleCapability
@{Text=}

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

### -SkipValidate
{{Fill SkipValidate Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

###  
You cannot pipe input to this cmdlet

## OUTPUTS

### SoftwareIdentify[]
This cmdlet does not produce any output.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-Package](Get-Package.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)

