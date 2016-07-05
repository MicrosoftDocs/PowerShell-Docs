---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517138
schema: 2.0.0
---

# Install-Package
## SYNOPSIS
Installs one or more software packages.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Install-Package [[-Name] <String[]>] [-AllVersions] [-Credential <PSCredential>] [-Force] [-ForceBootstrap]
 [-MaximumVersion <String>] [-MinimumVersion <String>] [-ProviderName] [-RequiredVersion <String>]
 [-Source <String[]>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Install-Package [-AdditionalArguments <String[]>] [-AllVersions] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Install-Package [-AdditionalArguments <String[]>] [-AllVersions] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Install-Package [-InputObject] <SoftwareIdentity[]> [-AllVersions] [-Credential <PSCredential>] [-Force]
 [-ForceBootstrap] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Install-Package [-AllVersions] [-IncludeSystemComponent] [-IncludeWindowsInstaller] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_6
```
Install-Package [-AllVersions] [-IncludeSystemComponent] [-IncludeWindowsInstaller] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_7
```
Install-Package [-AllVersions] [-Command <String[]>] [-DscResource <String[]>] [-Filter <String>] [-Includes]
 [-InstallUpdate] [-PackageManagementProvider <String>] [-PublishLocation <String>] [-Scope]
 [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Tag <String[]>] [-Type] [-Confirm]
 [-WhatIf]
```

### UNNAMED_PARAMETER_SET_8
```
Install-Package [-AllVersions] [-Command <String[]>] [-DscResource <String[]>] [-Filter <String>] [-Includes]
 [-InstallUpdate] [-PackageManagementProvider <String>] [-PublishLocation <String>] [-Scope]
 [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Tag <String[]>] [-Type] [-Confirm]
 [-WhatIf]
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

This command installs any package that has a name matching the partial name DSCAccel.
The command installs the newest version of the package, within a range of versions that is specified by adding the MinimumVersion and MaximumVersion parameters.

## PARAMETERS

### -AdditionalArguments
Specifies one or more additional arguments for installation.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions
Indicates that this cmdlet installs all available versions of the package.
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
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

- Cmdlet
- DscResource
- Function
- Workflow

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
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
Parameter Sets: UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
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
Parameter Sets: UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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

- CurrentUser
- AllUsers

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies whether to search for packages with a module, a script, or both.
The acceptable values for this parameter are:

- Module
- Script
- All

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_7, UNNAMED_PARAMETER_SET_8
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
Aliases: 

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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### SoftwareIdentity[]

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Get-Package](02b961ff-a850-469b-b562-06d03e7577c3)

[Find-Package](7e47fec3-2b59-4724-989e-e594ce4869d6)

[Save-Package](f8a24112-8d22-49d5-820b-b0095f1a30ec)

[Uninstall-Package](0290e116-7753-4990-a29e-48f8166ef72d)

