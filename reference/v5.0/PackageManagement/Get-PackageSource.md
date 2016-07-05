---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517137
schema: 2.0.0
---

# Get-PackageSource
## SYNOPSIS
Gets a list of package sources that are registered for a package provider.

## SYNTAX

```
Get-PackageSource [[-Name] <String>] [-Force] [-ForceBootstrap] [-Location <String>]
 [-PackageManagementProvider <String>] [-ProviderName] [-PublishLocation <String>]
 [-ScriptPublishLocation <String>] [-ScriptSourceLocation <String>] [-Type]
```

## DESCRIPTION
The Get-PackageSource gets a list of package sources that are registered with Package Management on the local computer.
If you specify a package provider, Get-PackageSource gets only those sources that are associated with the specified provider.
Otherwise, the command returns all package sources that are registered with Package Management.

## EXAMPLES

### Example 1: Get all package sources
```
PS C:\>Get-PackageSource
```

This command gets all package sources that are registered with Package Management on the local computer.

### Example 2: Get all package sources for a specific provider
```
PS C:\>Get-PackageSource -ProviderName "PSModule"
```

This command gets all package sources that are registered for the PSModule provider.

### Example 3: Get all package sources for a specific provider
```
PS C:\>Get-PackageProvider "PSModule" | Get-PackageSource
```

This command gets all package sources for the PSModule provider by piping the results of the Get-PackageProvider cmdlet to Get-PackageSource.

## PARAMETERS

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

### -Location
Specifies the location of the Package Management source or repository.

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
Specifies the name of the Package Management source.

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
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName
Specifies the provider name.
The acceptable values for this parameter are:

- msi
- msu
- PowerShellGet
- nuget
- chocolatey

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -PublishLocation
Specifies the publish location for the package source.

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
Specifies the script publish location.

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

### -ScriptSourceLocation
Specifies the script source location.

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

### -Type
Specifies whether to search for packages with a module, a script, or either.
The acceptable values for this parameter are:

- Module
- Script
- All

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Accepted values: Module, Script, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### PackageSource[]
Specifies one or more package sources.

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Register-PackageSource](02802b19-bd09-41b6-bd14-d310c0c732e1)

[Set-PackageSource](be1d9f0d-6c92-4554-8ed1-f4509e1b12af)

[Unregister-PackageSource](2e179dcb-d825-4329-b001-eb1579eceb67)

