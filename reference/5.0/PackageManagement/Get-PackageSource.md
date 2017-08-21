---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517137
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Get-PackageSource
---

# Get-PackageSource

## SYNOPSIS
Gets a list of package sources that are registered for a package provider.

## SYNTAX

```
Get-PackageSource [[-Name] <String>] [-Location <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>]
 [-PackageManagementProvider <String>] [-Scope <String>] [-PublishLocation <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-PackageSource** gets a list of package sources that are registered with Package Management on the local computer.
If you specify a package provider, **Get-PackageSource** gets only those sources that are associated with the specified provider.
Otherwise, the command returns all package sources that are registered with Package Management.

## EXAMPLES

### Example 1: Get all package sources
```
PS C:\> Get-PackageSource
```

This command gets all package sources that are registered with Package Management on the local computer.

### Example 2: Get all package sources for a specific provider
```
PS C:\> Get-PackageSource -ProviderName "PSModule"
```

This command gets all package sources that are registered for the PSModule provider.

### Example 3: Get all package sources for a specific provider
```
PS C:\> Get-PackageProvider "PSModule" | Get-PackageSource
```

This command gets all package sources for the PSModule provider by piping the results of the **Get-PackageProvider** cmdlet to **Get-PackageSource**.

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
Position: 0
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
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: msi, Programs, msu, Bootstrap, PSModule, nuget, chocolatey

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
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
{{Fill Scope Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PackageSource[]
Specifies one or more package sources.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_packagemanagement.md)

[Register-PackageSource](Register-PackageSource.md)

[Set-PackageSource](Set-PackageSource.md)

[Unregister-PackageSource](Unregister-PackageSource.md)

