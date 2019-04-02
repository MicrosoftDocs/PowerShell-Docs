---
ms.date:  4/1/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517139
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Register-PackageSource
---

# Register-PackageSource

## SYNOPSIS
Adds a package source for a specified package provider.

## SYNTAX

### SourceBySearch

```
Register-PackageSource [[-Name] <string>] [[-Location] <string>] [-Credential <pscredential>]
[-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-ProviderName <string>]
[<CommonParameters>]
```

### PSModule

```
Register-PackageSource [[-Name] <string>] [[-Location] <string>] [-Credential <pscredential>]
[-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <string>]
[-Scope <string>] [-PublishLocation <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Register-PackageSource` cmdlet adds a package source for a specified package provider. Package
sources are always managed by a package provider. If the package provider cannot add or replace a
package source, the provider generates an error message.

## EXAMPLES

### Example 1: Register a package source for the NuGet provider

This command registers a package source, a web-based location for the **NuGet** provider. By
default, sources aren't trusted. You are prompted to confirm the source is trusted before packages
are installed. To override the default, use the `-Trusted` parameter.

```powershell
Register-PackageSource -Name MyNuGet -Location https://www.nuget.org/api/v2 -ProviderName NuGet
```

```Output
Name          ProviderName     IsTrusted  Location
----          ------------     ---------  --------
MyNuGet       NuGet            False      https://www.nuget.org/api/v2
```

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

### -Credential

Specifies a user account that has permission to access the authenticated location.

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
Position: 1
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
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider

Specifies the Package Management provider.

```yaml
Type: String
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies the package provider's name.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: Provider
Accepted values: Bootstrap, chocolatey, msi, msu, NuGet, Programs, PSModule

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
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

Specifies the scope of the Package Source. The acceptable values for this parameter are: AllUsers
and CurrentUser.

```yaml
Type: String
Parameter Sets: PSModule
Aliases:
Accepted values: CurrentUser, AllUsers

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

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-PackageSource](Get-PackageSource.md)

[Set-PackageSource](Set-PackageSource.md)

[Unregister-PackageSource](Unregister-PackageSource.md)