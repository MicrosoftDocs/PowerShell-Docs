---
external help file: Microsoft.PowerShell.PackageManagement.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PackageManagement
ms.date: 3/29/2019
online version: http://go.microsoft.com/fwlink/?LinkID=517137
schema: 2.0.0
title: Get-PackageSource
---
# Get-PackageSource

## SYNOPSIS
Gets a list of package sources that are registered for a package provider.

## SYNTAX

### NuGet

```
Get-PackageSource [[-Name] <String>] [-Location <String>] [-Force] [-ForceBootstrap]
[-ProviderName <String[]>] [-ConfigFile <String>] [-SkipValidate] [<CommonParameters>]
```

### PowerShellGet

```
Get-PackageSource [[-Name] <String>] [-Location <String>] [-Force] [-ForceBootstrap]
[-ProviderName <String[]>] [-PackageManagementProvider <String>] [-PublishLocation <String>]
[-ScriptSourceLocation <String>] [-ScriptPublishLocation <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-PackageSource` cmdlet gets a list of package sources that are registered with
**PackageManagement** on the local computer. If you specify a package provider, `Get-PackageSource`
gets only those sources that are associated with the specified provider. Otherwise, the command
returns all package sources that are registered with **PackageManagement**.

## EXAMPLES

### Example 1: Get all package sources

The `Get-PackageSource` cmdlet gets all package sources that are registered with
**PackageManagement** on the local computer.

```powershell
Get-PackageSource
```

```Output
Name                 ProviderName     IsTrusted  Location
----                 ------------     ---------  --------
LocalPackages        NuGet            False      C:\LocalPkg\
MyNuget              NuGet            False      https://www.nuget.org/api/v2
PSGallery            PowerShellGet    False      https://www.powershellgallery.com/api/v2
```

### Example 2: Get all package sources for a specific provider

This command gets package sources that are registered for a specific provider.

```powershell
Get-PackageSource -ProviderName NuGet
```

```Output
Name                 ProviderName     IsTrusted  Location
----                 ------------     ---------  --------
LocalPackages        NuGet            False      C:\LocalPkg\
MyNuget              NuGet            False      https://www.nuget.org/api/v2
```

`Get-PackageSource` uses the **ProviderName** parameter to get package sources that are registered
for the **NuGet** provider.

### Example 3: Get sources from a package provider

This command uses a package provider to get package sources.

```powershell
Get-PackageProvider -Name NuGet | Get-PackageSource
```

```Output
Name                 ProviderName     IsTrusted  Location
----                 ------------     ---------  --------
LocalPackages        NuGet            False      C:\LocalPkg\
MyNuget              NuGet            False      https://www.nuget.org/api/v2
```

`Get-PackageProvider` uses the **Name** parameter specify the provider name, **NuGet**. The object
is sent down the pipeline to `Get-PackageSource`.

## PARAMETERS

### -ConfigFile

Specifies a configuration file.

```yaml
Type: String
Parameter Sets: NuGet
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

Indicates that this cmdlet forces **PackageManagement** to automatically install a package provider.

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

Specifies the location of a package management source or repository.

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

Specifies the name of a package management source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider

Specifies a package management provider.

```yaml
Type: String
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies one or more package provider names. Separate multiple package provider names with commas.
Use `Get-PackageProvider` to get a list of available package providers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: Bootstrap, NuGet, PowerShellGet

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PublishLocation

Specifies the publish location for the package source.

```yaml
Type: String
Parameter Sets: PowerShellGet
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
Parameter Sets: PowerShellGet
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
Parameter Sets: PowerShellGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipValidate

Switch that skips validating the credentials of a package source.

```yaml
Type: SwitchParameter
Parameter Sets: NuGet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PackageSource[]

Specifies one or more package sources.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Find-Package](Find-Package.md)

[Get-Package](Get-Package.md)

[Get-PackageProvider](Get-PackageProvider.md)

[Register-PackageSource](Register-PackageSource.md)

[Set-PackageSource](Set-PackageSource.md)

[Unregister-PackageSource](Unregister-PackageSource.md)