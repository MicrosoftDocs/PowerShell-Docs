---
ms.date: 4/3/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517141
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Set-PackageSource
---

# Set-PackageSource

## SYNOPSIS
Replaces a package source for a specified package provider.

## SYNTAX

### SourceBySearch (Default)

```
Set-PackageSource [[-Name] <string>] [-Credential <pscredential>] [-Location <string>]
[-NewLocation <string>] [-NewName <string>] [-Trusted] [-Force] [-ForceBootstrap] [-WhatIf]
[-Confirm] [-ProviderName <string>] [<CommonParameters>]
```

### SourceByInputObject

```
Set-PackageSource -InputObject <PackageSource> [-Credential <pscredential>] [-NewLocation <string>]
[-NewName <string>] [-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PSModule:SourceByInputObject

```
Set-PackageSource [-Credential <pscredential>] [-NewLocation <string>] [-NewName <string>]
[-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <string>]
[-Scope <string>] [-PublishLocation <string>] [<CommonParameters>]
```

### PSModule:SourceBySearch

```
Set-PackageSource [-Credential <pscredential>] [-NewLocation <string>] [-NewName <string>]
[-Trusted] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm] [-PackageManagementProvider <string>]
[-Scope <string>] [-PublishLocation <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Set-PackageSource` replaces a package source for a specified package provider. Package sources
are always managed by a package provider.

## EXAMPLES

### Example 1: Change a package source

This command changes the existing name of a package source. The source is set to **Trusted**, which
eliminates prompts to verify the source when packages are installed.

```
PS C:\> Set-PackageSource -Name MyNuget -NewName NewNuGet -Trusted -ProviderName NuGet
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

Indicates that `Set-PackageSource` forces **PackageManagement** to automatically install the package
provider.

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

### -InputObject

Specifies a package source ID object that represents the package that you want to change. Package
source IDs are part of the results of the `Get-PackageSource` cmdlet.

```yaml
Type: PackageSource
Parameter Sets: SourceByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Location

Specifies the current package source location. The value can be a URI, a file path, or any other
destination format supported by the package provider.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies a package source's name.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: SourceName

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewLocation

Specifies the new location for a package source. The value can be a URI, a file path, or any other
destination format supported by the package provider.

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

### -NewName

Specifies the new name you assign to a package source.

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

### -PackageManagementProvider

Specifies a package management provider.

```yaml
Type: String
Parameter Sets: PSModule:SourceByInputObject, PSModule:SourceBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies a provider name.

```yaml
Type: String
Parameter Sets: SourceBySearch
Aliases: Provider
Accepted values: Bootstrap, chocolatey, msi, msu, nuget, Programs, PSModule

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
Parameter Sets: PSModule:SourceByInputObject, PSModule:SourceBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

Specifies the scope of the Package Source. The acceptable values for this parameter are: AllUsers and CurrentUser.

```yaml
Type: String
Parameter Sets: PSModule:SourceByInputObject, PSModule:SourceBySearch
Aliases:
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Trusted

Indicates that the source is a trusted package provider. Trusted sources don't prompt for
verification to install packages.

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

### `Set-PackageSource` doesn't accept pipeline input.

## OUTPUTS

### This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Get-PackageSource](Get-PackageSource.md)

[Register-PackageSource](Register-PackageSource.md)

[Unregister-PackageSource](Unregister-PackageSource.md)