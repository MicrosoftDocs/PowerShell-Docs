---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517141
schema: 2.0.0
---

# Set-PackageSource
## SYNOPSIS
Replaces a package source for a specified package provider.

## SYNTAX

### SourceBySearch (Default)
```
Set-PackageSource [-Credential <PSCredential>] [[-Name] <String>] [-Location <String>] [-NewLocation <String>]
 [-NewName <String>] [-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-ProviderName <String>]
```

### SourceByInputObject
```
Set-PackageSource [-Credential <PSCredential>] [-NewLocation <String>] [-NewName <String>] [-Trusted]
 -InputObject <PackageSource> [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
```

### NuGet:SourceByInputObject
```
Set-PackageSource [-Credential <PSCredential>] [-NewLocation <String>] [-NewName <String>] [-Trusted] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-ConfigFile <String>] [-SkipValidate]
```

### NuGet:SourceBySearch
```
Set-PackageSource [-Credential <PSCredential>] [-NewLocation <String>] [-NewName <String>] [-Trusted] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-ConfigFile <String>] [-SkipValidate]
```

### PowerShellGet:SourceByInputObject
```
Set-PackageSource [-Credential <PSCredential>] [-NewLocation <String>] [-NewName <String>] [-Trusted] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <String>] [-Type <String>]
 [-PublishLocation <String>] [-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>]
```

### PowerShellGet:SourceBySearch
```
Set-PackageSource [-Credential <PSCredential>] [-NewLocation <String>] [-NewName <String>] [-Trusted] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <String>] [-Type <String>]
 [-PublishLocation <String>] [-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>]
```

## DESCRIPTION
The Set-PackageSource replaces a package source for a specified package provider.
Package sources are always managed by a package provider.

## EXAMPLES

### Example 1: Change a package source
```
PS C:\>Set-PackageSource -Name "psRep" -NewName "ps-Feature-Rep" -Trusted -ProviderName "PSModule"
```

This command changes the friendly name of a package source for the PSModule provider.
It also changes the package source to be trusted, so that users who install packages from this source are not prompted to verify that they trust the source.

## PARAMETERS

### -Credential
Specifies a user account that has permission to install package providers.

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
Indicates that this cmdlet forces Package Management to automatically install the package provider for the specified package source.

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

### -InputObject
Specifies a package source ID object that represents the package that you want to change.
Package source IDs are part of the results of the Get-PackageSource cmdlet.

```yaml
Type: PackageSource
Parameter Sets: SourceByInputObject
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location
Specifies the location to which a package source currently points.
The value of this parameter can be a URI, a file path, or any other destination format supported by the package provider.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the current friendly name of a package source.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: SourceName

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewLocation
Specifies the new location to which you want a package source to point.
The value of this parameter can be a URI, a file path, or any other destination format supported by the package provider.

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

### -NewName
Specifies the new friendly name that you want to assign to a package source.

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

### -PackageManagementProvider
Specifies the Package Management provider.

```yaml
Type: String
Parameter Sets: PowerShellGet:SourceByInputObject, PowerShellGet:SourceBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName
Specifies the provider name.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

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
Parameter Sets: PowerShellGet:SourceByInputObject, PowerShellGet:SourceBySearch
Aliases: 

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
Parameter Sets: PowerShellGet:SourceByInputObject, PowerShellGet:SourceBySearch
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
Parameter Sets: PowerShellGet:SourceByInputObject, PowerShellGet:SourceBySearch
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trusted
Indicates whether users trust packages from this source; that is, indicates whether users are prompted to verify that they trust the package source before they install a package from it.
If you add this parameter, users are not prompted.

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

### -Type
Specifies the type of package source.
The acceptable values for this parameter are:

-- Module
-- Script
-- All

```yaml
Type: String
Parameter Sets: PowerShellGet:SourceByInputObject, PowerShellGet:SourceBySearch
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

### -ConfigFile
{{Fill ConfigFile Description}}

```yaml
Type: String
Parameter Sets: NuGet:SourceByInputObject, NuGet:SourceBySearch
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
Parameter Sets: NuGet:SourceByInputObject, NuGet:SourceBySearch
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

[Get-PackageSource]()

[Register-PackageSource]()

[Unregister-PackageSource]()

