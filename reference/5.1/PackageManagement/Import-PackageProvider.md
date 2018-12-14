---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PackageManagement
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822306
schema: 2.0.0
title: Import-PackageProvider
---

# Import-PackageProvider

## SYNOPSIS
Adds Package Management package providers to the current session.

## SYNTAX

```
Import-PackageProvider [-Name] <String[]> [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [<CommonParameters>]
```

## DESCRIPTION
The **Import-PackageProvider** cmdlet adds one or more package providers to the current session.
The provider that you import must be installed on the local computer.

To get a list of available providers, run `Get-PackageProvider -ListAvailable`.
Note that a package provider name can be different from its module name.

Due to security reasons, **PackageManagement** requires C#-based providers to contain a provider.manifest.
For more information on how to build a provider with provider.manifest injected, see the .csproj project files on https://github.com/oneget/onegethttps://oneget.org.

## EXAMPLES

### Example 1: Import a package provider from the local computer
```
PS C:\> Import-PackageProvider -Name "Nuget"
```

This command imports the Nuget provider after it has been installed on the local computer.

### Example 2: Import a specific version of a package provider
```
PS C:\> Find-PackageProvider -Name "Nuget" -AllVersions
Install-PackageProvider -Name "Nuget" -RequiredVersion "2.8.5.201" -Force
Get-PackageProvider -ListAvailable
Import-PackageProvider -Name "Nuget" -RequiredVersion "2.8.5.201" -Verbose
```

This command finds, installs, and imports a specific version of the Nuget package provider.

## PARAMETERS

### -Force
Forces the command to run without asking for user confirmation.
Re-imports a package provider.

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

### -MaximumVersion
Specifies the maximum allowed version of the package provider that you want to import.
If you do not add this parameter, **Import-PackageProvider** imports the highest available version of the provider.

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
Specifies the minimum allowed version of the package provider that you want to import.
If you do not add this parameter, **Import-PackageProvider** imports the highest available version of the package that also satisfies any maximum version that is specified using the *MaximumVersion* parameter.

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
Specifies one or more package provider names.
Wildcards are not permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version of the package provider that you want to import.
If you do not add this parameter, **Import-PackageProvider** imports the highest available version of the provider that also satisfies any maximum version specified using the *MaximumVersion* parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PackageManagement.Implementation.PackageProvider
You can pipe a **PackageProvider** object returned by **Get-PackageProvider** into **Import-PackageProvider**.

## OUTPUTS

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Unregister-PackageSource](Unregister-PackageSource.md)

[Get-PackageSource](Get-PackageSource.md)

[Register-PackageSource](Register-PackageSource.md)

[Get-PackageProvider](Get-PackageProvider.md)