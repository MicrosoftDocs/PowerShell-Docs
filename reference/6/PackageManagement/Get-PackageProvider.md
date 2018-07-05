---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PackageManagement
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkID=517136
schema: 2.0.0
title: Get-PackageProvider
---

# Get-PackageProvider

## SYNOPSIS
Returns a list of package providers that are connected to Package Management.

## SYNTAX

```
Get-PackageProvider [[-Name] <String[]>] [-ListAvailable] [-Force] [-ForceBootstrap] [<CommonParameters>]
```

## DESCRIPTION
The **Get-PackageProvider** cmdlet returns a list of package providers that are connected to Package Management.
Examples of these providers include PSModule, NuGet, and Chocolatey.
You can filter the results based on all or part of one or more provider names.

## EXAMPLES

### Example 1: Get all currently loaded package providers
```
PS C:\> Get-PackageProvider
```

This command gets a list of all the package providers that are currently loaded on the local computer.

### Example 2: Get all available package providers
```
PS C:\> Get-PackageProvider -ListAvailable
```

This command gets a list of all package providers that are available on the local computer.

### Example 3: Dynamically get a package provider
```
PS C:\> Get-PackageProvider -Name "Chocolatey" -ForceBootstrap
```

This command automatically installs the Chocolatey provider if your computer does not have the Chocolatey provider installed.

## PARAMETERS

### -Force
Indicates that this cmdlet forces all other actions with this cmdlet that can be forced.
In **Get-PackageProvider**, this means the *Force* parameter acts the same as the *ForceBootstrap* parameter.

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
**Get-PackageProvider** gets provider in paths listed in the **PSModulePath** environment variable as well as the package provider assembly folders:

**$env:ProgramFiles\PackageManagement\ProviderAssemblies****$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies**

Without this parameter, **Get-PackageProvider** gets only the providers loaded in the current session.

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
Valid values for this parameter include names of providers that you have installed with packages; PackageManagement ships with a set of default providers, including the **PSModule** and **MSI** providers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PackageProvider[]

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-PackageSource](Get-PackageSource.md)

[Register-PackageSource](Register-PackageSource.md)

[Unregister-PackageSource](Unregister-PackageSource.md)