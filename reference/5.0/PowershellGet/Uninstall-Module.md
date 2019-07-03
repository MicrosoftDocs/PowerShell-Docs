---
ms.date: 7/2/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=821673
external help file:  PSGet-help.xml
title:  Uninstall-Module
---

# Uninstall-Module

## SYNOPSIS
Uninstalls a module.

## SYNTAX

### NameParameterSet (Default)

```
Uninstall-Module [-Name] <String[]> [-MinimumVersion <Version>] [-RequiredVersion <Version>]
 [-MaximumVersion <Version>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject

```
Uninstall-Module [-InputObject] <PSObject[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Uninstall-Module` cmdlet uninstalls a specified module from the local computer. You can't
uninstall a module if it has other modules as dependencies.

## EXAMPLES

### Example 1: Uninstall a module

In this example, an installed module's version is displayed and the module is uninstalled.

```powershell
Get-InstalledModule -Name SpeculationControl
Uninstall-Module -Name SpeculationControl
```

```Output
Version  Name                Repository   Description
-------  ----                ----------   -----------
1.0.14   SpeculationControl  PSGallery    This module provides the ability to query...
```

`Get-InstalledModule` uses the **Name** parameter to display the installed module,
**SpeculationControl**. `Uninstall-Module` uses the **Name** parameter to specify the module to
uninstall.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the `Uninstall-Module`.

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

### -Force

Forces `Uninstall-Module` to run without asking for user confirmation.

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

Accepts a **PSRepositoryItemInfo** object. For example, output `Get-InstalledModule` to a variable
and use that variable as the **InputObject** argument.

```yaml
Type: PSObject[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum, or newest, version of the module to uninstall. The **MaximumVersion** and
**RequiredVersion** parameters can't be used in the same command.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion

Specifies the minimum version of the script to uninstall. The **MinimumVersion** and
**RequiredVersion** parameters can't be used in the same command.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies an array of module names to uninstall.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version number of the module to uninstall.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if `Uninstall-Module` runs. The cmdlet isn't run.

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

[Find-Module](Find-Module.md)

[Get-InstalledModule](Get-InstalledModule.md)

[Publish-Module](Publish-Module.md)

[Save-Module](Save-Module.md)

[Update-Module](Update-Module.md)
