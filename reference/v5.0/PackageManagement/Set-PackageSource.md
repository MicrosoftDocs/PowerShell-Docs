---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517141
schema: 2.0.0
---

# Set-PackageSource
## SYNOPSIS
Replaces a package source for a specified package provider.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-PackageSource [[-Name] <String>] [-Credential <PSCredential>] [-Force] [-ForceBootstrap]
 [-Location <String>] [-NewLocation <String>] [-NewName <String>] [-ProviderName] [-Trusted] [-Confirm]
 [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Set-PackageSource [-Credential <PSCredential>] [-Force] [-ForceBootstrap] [-NewLocation <String>]
 [-NewName <String>] [-Trusted] -InputObject <PackageSource> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Set-PackageSource [-Credential <PSCredential>] [-PackageManagementProvider <String>]
 [-PublishLocation <String>] [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Type]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Set-PackageSource [-Credential <PSCredential>] [-PackageManagementProvider <String>]
 [-PublishLocation <String>] [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Type]
 [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Set-PackageSource replaces a package source for a specified package provider.
Package sources are always managed by a package provider.

## EXAMPLES

### Example 1: Change a package source
```
PS C:\>Set-PackageSource -Name "PsRep" -NewName "PS-Feature-Rep" -Trusted -ProviderName "PSModule"
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
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
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -PublishLocation
Specifies the publish location.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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

- Module
- Script
- All

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
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

### You cannot pipe input to this cmdlet.
This cmdlet does not generate any output.

## OUTPUTS

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Get-PackageSource](3fa76858-9e0b-4db6-b67d-f40702d41659)

[Register-PackageSource](02802b19-bd09-41b6-bd14-d310c0c732e1)

[Unregister-PackageSource](2e179dcb-d825-4329-b001-eb1579eceb67)

