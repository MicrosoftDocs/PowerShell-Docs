---
external help file: PSITPro5_OneGet.xml
online version: 
schema: 2.0.0
---

# Find-PackageProvider
## SYNOPSIS
Returns a list of Package Management package providers available for installation.

## SYNTAX

```
Find-PackageProvider [[-Name] <String[]>] [-AllVersions] [-Credential <PSCredential>] [-Force]
 [-ForceBootstrap] [-IncludeDependencies] [-MaximumVersion <String>] [-MinimumVersion <String>]
 [-RequiredVersion <String>] [-Source <String[]>]
```

## DESCRIPTION
The Find-PackageProvider cmdlet finds matching PackageManagement providers that are available in package sources registered with PowerShellGet.
These are package providers available for installation with the Install-PackageProvider cmdlet.
By default, this includes modules available in the Windows PowerShell Gallery with the PackageManagement and Provider tags.

Find-PackageProvider also finds matching Package Management providers that are available in the Package Management Azure Blob store.
Use the bootstrapper provider to find and install them.

## EXAMPLES

### Example 1: Find all available package providers
```
PS C:\>Find-PackageProvider
```

This command gets a list of all package providers that are available on the repositories supported by Package Management.
By default, those package providers are available on the PowerShell Gallery and by using the Package Management bootstrapping application.

### Example 2: Find all versions of a provider
```
PS C:\>Find-PackageProvider -Name "Nuget" -AllVersions
```

This command finds all versions of the package provider named Nuget.

### Example 3: Find a provider from a specified source
```
PS C:\>Find-PackageProvider -Name "Gistprovider" -Source "PSGallery"
```

This command finds a package provider available by using a specified package source.

## PARAMETERS

### -AllVersions
Indicates that this cmdlet returns all available versions of the package provider.
By default, Find-PackageProvider only returns the newest available version.

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

### -Credential
Specifies a user account that has permission to search for package providers.

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
Currently, this is equivalent to the ForceBootstrap parameter.

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
Indicates that this cmdlet includes dependencies.

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

### -MaximumVersion
Specifies the maximum allowed version of the package provider that you want to find.
If you do not add this parameter, Find-PackageProvider finds the highest available version of the provider.

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
Specifies the minimum allowed version of the package provider that you want to find.
If you do not add this parameter, Find-PackageProvider finds the highest available version of the package that also satisfies any maximum specified version specified by the MaximumVersion parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies one or more package provider module names, or provider names with wildcard characters.
Separate multiple package names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact allowed version of the package provider that you want to find.
If you do not add this parameter, Find-PackageProvider finds the highest available version of the provider that also satisfies any maximum version specified by the MaximumVersion parameter.

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
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.PackageManagement.Packaging.SoftwareIdentity
This cmdlet returns a SoftwareIdentity object.
A SoftwareIdentity object can be piped into Install-PackageProvider to install the results of Find-PackageProvider.

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Get-PackageProvider](2e179dcb-d825-4329-b001-eb1579eceb67)

[Get-PackageSource](3fa76858-9e0b-4db6-b67d-f40702d41659)

[Register-PackageSource](02802b19-bd09-41b6-bd14-d310c0c732e1)

[Install-PackageProvider](53f20878-a180-4c7c-b3e7-ee74aae1bf9b)

