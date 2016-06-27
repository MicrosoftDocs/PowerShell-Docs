---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Uninstall-Module
## SYNOPSIS
Uninstalls a module.

## SYNTAX

### NameParameterSet (Default)
```
Uninstall-Module [-Name] <String[]> [-MinimumVersion <Version>] [-RequiredVersion <Version>]
 [-MaximumVersion <Version>] [-AllVersions] [-Force] [-WhatIf] [-Confirm]
```

### InputObject
```
Uninstall-Module -InputObject <PSObject[]> [-Force] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Uninstall-Module cmdlet uninstalls the specified module from the local computer.
You cannot uninstall a module if it has other modules as dependencies.

## EXAMPLES

### Example 1: Get a module and uninstall it
```
PS C:\>Get-InstalledModule -Name "xPSDesiredStateConfiguration" -RequiredVersion 3.6.0.0 | Uninstall-Module
```

This command gets version 3.6.0.0 of the module named xPSDesiredStateConfiguration, and then uses the pipeline operator to pass it to the Uninstall-Module cmdlet, which uninstalls it.

## PARAMETERS

### -AllVersions
Specifies that you want to include all available versions of a module.
You cannot use the AllVersions parameter with the MinimumVersion, MaximumVersion, or RequiredVersion parameters.

```yaml
Type: SwitchParameter
Parameter Sets: NameParameterSet
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

### -MaximumVersion
Specifies the maximum, or newest, version of the module to uninstall.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies the minimum version of the script to uninstall.
The MinimumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies an array of names of modules to uninstall.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases: 

Required: True
Position: 1
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

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### -InputObject
{{Fill InputObject Description}}

```yaml
Type: PSObject[]
Parameter Sets: InputObject
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Find-Module]()

[Get-InstalledModule]()

[Publish-Module]()

[Save-Module]()

[Update-Module]()

