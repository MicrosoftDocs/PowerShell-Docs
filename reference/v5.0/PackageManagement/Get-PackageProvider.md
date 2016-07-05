---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517136
schema: 2.0.0
---

# Get-PackageProvider
## SYNOPSIS
Returns a list of package providers that are connected to Package Management.

## SYNTAX

```
Get-PackageProvider [[-Name] <String[]>] [-Force] [-ForceBootstrap] [-ListAvailable]
```

## DESCRIPTION
The Get-PackageProvider cmdlet returns a list of package providers that are connected to Package Management.
Examples of these providers include PSModule, NuGet, and Chocolatey.
You can filter the results based on all or part of one or more provider names.

## EXAMPLES

### Example 1: Get all currently loaded package providers
```
PS C:\>Get-PackageProvider
```

This command gets a list of all the package providers that are currently loaded on the local computer.

### Example 2: Get all available package providers
```
PS C:\>Get-PackageProvider -ListAvailable
```

This command gets a list of all package providers that are available on the local computer.

### Example 3: Dynamically get a package provider
```
PS C:\>Get-PackageProvider -Name "Chocolatey" -ForceBootstrap
```

This command automatically installs the Chocolatey provider if your computer does not have the Chocolatey provider installed.

## PARAMETERS

### -Force
Indicates that this cmdlet forces all other actions with this cmdlet that can be forced.
In Get-PackageProvider, this means the Force parameter acts the same as the ForceBootstrap parameter.

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

### -ListAvailable
Gets all installed providers.
Get-PackageProvider gets provider in paths listed in the PSModulePath environment variable as well as the package provider assembly folders:

$env:ProgramFiles\PackageManagement\ProviderAssemblies$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies

Without this parameter, Get-PackageProvider gets only the providers loaded in the current session.

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

### -Name
Specifies one or more provider names, or partial provider names.
Separate multiple provider names with commas.
Valid values for this parameter include names of providers that you have installed with packages; PackageManagement ships with a set of default providers, including the PSModule and MSI providers.

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

## INPUTS

## OUTPUTS

### PackageProvider[]

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Get-PackageSource](3fa76858-9e0b-4db6-b67d-f40702d41659)

[Register-PackageSource](02802b19-bd09-41b6-bd14-d310c0c732e1)

[Unregister-PackageSource](2e179dcb-d825-4329-b001-eb1579eceb67)

