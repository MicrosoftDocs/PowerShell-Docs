---
external help file: PSITPro5_PSGet.xml
online version: ba918f1e-1606-4cfd-b0ff-2c2eb821f586
schema: 2.0.0
---

# Uninstall-Script
## SYNOPSIS
Uninstalls a script file.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Uninstall-Script [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-RequiredVersion <Version>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Uninstall-Script [-Force] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Uninstall-Script cmdlet uninstalls the specified script files from the online gallery.

## EXAMPLES

### Example 1: Uninstall a script file
```
PS C:\>Uninstall-Script -Name "MyScript" -RequiredVersion 2.5
```

This command uninstalls version 2.5 of the script file named MyScript.

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

### -MaximumVersion
Specifies the maximum, or newest, version of the script to uninstall.
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
Specifies an array of names of scripts to uninstall.

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
Specifies the exact version number of the script to uninstall.

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

[Find-Script](ba918f1e-1606-4cfd-b0ff-2c2eb821f586)

[Install-Script](ad041750-9866-43b1-af85-077f2b2efae0)

[Publish-Script](e8bdc076-6514-4e00-b16d-23e7d5fd4d13)

[Save-Script](e4f6f4ae-94fd-4ac2-adab-d3465dafb562)

[Update-Script](aa68486d-6ad6-495f-a1bb-67752ca8ed79)

