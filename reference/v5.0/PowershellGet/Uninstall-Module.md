---
external help file: PSITPro5_PSGet.xml
online version: d70909ca-b3bd-4859-81f4-5b68731c8feb
schema: 2.0.0
---

# Uninstall-Module
## SYNOPSIS
Uninstalls a module.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Uninstall-Module [-Name] <String[]> [-AllVersions] [-Force] [-MaximumVersion <Version>]
 [-MinimumVersion <Version>] [-RequiredVersion <Version>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Uninstall-Module [-Force] [-Confirm] [-WhatIf]
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of the script to uninstall.
The MinimumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of modules to uninstall.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version number of the module to uninstall.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Find-Module](d70909ca-b3bd-4859-81f4-5b68731c8feb)

[Get-InstalledModule](3ae41c50-7025-4d55-a3b2-d8e6278b9e45)

[Publish-Module](074815a6-779e-4e5f-a291-6677550c6f45)

[Save-Module](5e9256cc-0654-40c5-93b8-3206d25b8c7c)

[Update-Module](7557593d-d028-4e42-8e65-6180f88d7fb9)

