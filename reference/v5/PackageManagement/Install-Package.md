---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517138
schema: 2.0.0
---

# Install-Package
## SYNOPSIS
Installs one or more software packages.

## SYNTAX

### PackageBySearch (Default)
```
Install-Package [[-Name] <String[]>] [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Source <String[]>] [-Credential <PSCredential>] [-AllVersions] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-ProviderName <String[]>]
```

### PackageByInputObject
```
Install-Package [-InputObject] <SoftwareIdentity[]> [-Credential <PSCredential>] [-AllVersions] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm]
```

### Programs:PackageBySearch
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-IncludeWindowsInstaller] [-IncludeSystemComponent]
```

### Programs:PackageByInputObject
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-IncludeWindowsInstaller] [-IncludeSystemComponent]
```

### msi:PackageBySearch
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <String[]>]
```

### msi:PackageByInputObject
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <String[]>]
```

### NuGet:PackageBySearch
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-ConfigFile <String>] [-SkipValidate] [-Headers <String[]>] [-FilterOnTag <String[]>] [-Contains <String>]
 [-AllowPrereleaseVersions] [-Destination <String>] [-ExcludeVersion] [-Scope <String>]
```

### NuGet:PackageByInputObject
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-ConfigFile <String>] [-SkipValidate] [-Headers <String[]>] [-FilterOnTag <String[]>] [-Contains <String>]
 [-AllowPrereleaseVersions] [-Destination <String>] [-ExcludeVersion] [-Scope <String>]
```

### PowerShellGet:PackageBySearch
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-Scope <String>] [-PackageManagementProvider <String>] [-Type <String>] [-PublishLocation <String>]
 [-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>] [-Filter <String>] [-Tag <String[]>]
 [-Includes <String[]>] [-DscResource <String[]>] [-Command <String[]>] [-InstallUpdate]
```

### PowerShellGet:PackageByInputObject
```
Install-Package [-Credential <PSCredential>] [-AllVersions] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-Scope <String>] [-PackageManagementProvider <String>] [-Type <String>] [-PublishLocation <String>]
 [-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>] [-Filter <String>] [-Tag <String[]>]
 [-Includes <String[]>] [-DscResource <String[]>] [-Command <String[]>] [-InstallUpdate]
```

## DESCRIPTION
The Install-Packages cmdlet installs one or more software packages on the local computer.

## EXAMPLES

### Example 1: Install a package by package name
```
PS C:\>Install-Package -Name "DSCAccelerator" -Credential "CONTOSO\TestUser"
```

This command installs a package named DSCAccelerator.
When you run this command, you are prompted to provide a password for the account that has rights to install the package.

### Example 2: Install a package that you find with Find-Package
```
PS C:\>Find-Package "zoomit" | Install-Package
```

This command installs a package named zoomit by piping the package from a Find-Package command.

### Example 3: Install packages by specifying a range of versions
```
PS C:\>Install-Package -Name "DSCAccel" -MinimumVersion 2.1.2 -MaximumVersion 2.2
```

This command installs any package that has a name matching the partial name "DSCAccel." The command installs the newest version of the package, within a range of versions that is specified by adding the MinimumVersion and MaximumVersion parameters.

## PARAMETERS

### -AdditionalArguments
Specifies one or more additional arguments for installation.

```yaml
Type: String[]
Parameter Sets: msi:PackageBySearch, msi:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions
Indicates that Install-Package installs all available versions of the package.
By default, Install -Package only installs the newest available version.

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
Specifies one or more commands for which Find-Package searches.

```yaml
Type: String[]
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has rights to install a package for a specified package provider or source.

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
Specifies one or more Desired State Configuration (DSC) resources for which Find-Package searches.

```yaml
Type: String[]
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies terms to search for within the Name and Description properties.

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Indicates that this cmdlet overrides restrictions that prevent the command from succeeding, as long as the changes do not compromise security.

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
Forces PackageManagement to automatically install the package provider for the specified package.

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
Specifies whether Find-Package should find all packages with DSC resources, cmdlets, functions, or workflows.
The acceptable values for this parameter are:

-- Cmdlet
-- DscResource
-- Function
-- Workflow

```yaml
Type: String[]
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 
Accepted values: DscResource, Cmdlet, Function, Workflow

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSystemComponent
Indicates that this cmdlet includes system components in the results.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageBySearch, Programs:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeWindowsInstaller
Indicates that this cmdlet includes the Windows installer in the results.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageBySearch, Programs:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a package by using the package's SoftwareIdentity type, which is shown in the results of the Find-Package cmdlet.

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
Indicates that this cmdlet installs updates.

```yaml
Type: SwitchParameter
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum allowed version of the package that you want to find.
If you do not specify this parameter, Install-Package installs the finds the highest-numbered available version of the package.

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
Specifies the minimum allowed version of the package that you want to find.
If you do not add this parameter, Install-Package finds the highest available version of the package that also satisfies any maximum specified version specified by the MaximumVersion parameter.

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
Multiple names must be separated by commas.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
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
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
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

### -PublishLocation
Specifies a location for publishing the package.

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact allowed version of the package that you want to install.
If you do not add this parameter, Install-Package installs the newest available version of the package that also satisfies any maximum version specified by the MaximumVersion parameter.

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
Specifies the scope to which to install the package.
The acceptable values for this parameter are:

-- CurrentUser
-- AllUsers

```yaml
Type: String
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject, PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptPublishLocation
Specifies the script publish location.

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptSourceLocation
Specifies the script source location.

```yaml
Type: String
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
Specifies one or more package sources.
Multiple package source names must be separated by commas.
You can get package source names by running the Get-PackageSource cmdlet.

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
Specifies one or more strings to search for in the package metadata.

```yaml
Type: String[]
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
Aliases: 

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
Parameter Sets: PowerShellGet:PackageBySearch, PowerShellGet:PackageByInputObject
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

### -AllowPrereleaseVersions
{{Fill AllowPrereleaseVersions Description}}

```yaml
Type: SwitchParameter
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigFile
{{Fill ConfigFile Description}}

```yaml
Type: String
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Contains
{{Fill Contains Description}}

```yaml
Type: String
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Destination
{{Fill Destination Description}}

```yaml
Type: String
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
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
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterOnTag
{{Fill FilterOnTag Description}}

```yaml
Type: String[]
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers
{{Fill Headers Description}}

```yaml
Type: String[]
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipValidate
{{Fill SkipValidate Description}}

```yaml
Type: SwitchParameter
Parameter Sets: NuGet:PackageBySearch, NuGet:PackageByInputObject
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### SoftwareIdentity[]

## NOTES

## RELATED LINKS

[about_PackageManagement]()

[Get-Package]()

[Find-Package]()

[Save-Package]()

[Uninstall-Package]()

