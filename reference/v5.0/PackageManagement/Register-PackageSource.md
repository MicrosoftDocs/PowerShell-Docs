---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517139
schema: 2.0.0
---

# Register-PackageSource
## SYNOPSIS
Adds a package source for a specified package provider.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Register-PackageSource [[-Name] <String>] [[-Location] <String>] [-Credential <PSCredential>] [-Force]
 [-ForceBootstrap] [-ProviderName] [-Trusted] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Register-PackageSource [[-Name] <String>] [[-Location] <String>] [-Credential <PSCredential>] [-Force]
 [-ForceBootstrap] [-PackageManagementProvider <String>] [-PublishLocation <String>]
 [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Trusted] [-Type] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Register-PackageSource cmdlet adds a package source for a specified package provider.
Package sources are always managed by a package provider.
If the package provider cannot add or replace a package source, the provider generates an error message.

## EXAMPLES

### Example 1: Register a package source for the NuGet provider
```
PS C:\>Register-PackageSource -Name "MyRep" -Location "http://contoso/psmodule/Features/api/v3" -ProviderName "PsModule"
```

This command registers a package source, a web-based location for the PSModule provider.
If you do not add the Trusted parameter, by default, the package is not trusted, and users are prompted to confirm that they trust the source before installing packages from the source.

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
Indicates that this cmdlet automatically installs the package provider.

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

### -Location
Specifies the package source location.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the package source to register.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider
Specifies the Package Management provider.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trusted
Indicates that the package source is trusted.

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

- Module
- Script
- All

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
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

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Get-PackageSource](3fa76858-9e0b-4db6-b67d-f40702d41659)

[Set-PackageSource](be1d9f0d-6c92-4554-8ed1-f4509e1b12af)

[Unregister-PackageSource](2e179dcb-d825-4329-b001-eb1579eceb67)

