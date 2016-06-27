---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Uninstall-Script
## SYNOPSIS
Uninstalls a script file.

## SYNTAX

### NameParameterSet (Default)
```
Uninstall-Script [-Name] <String[]> [-MinimumVersion <Version>] [-RequiredVersion <Version>]
 [-MaximumVersion <Version>] [-Force] [-WhatIf] [-Confirm]
```

### InputObject
```
Uninstall-Script -InputObject <PSObject[]> [-Force] [-WhatIf] [-Confirm]
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
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command

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
Specifies an array of names of scripts to uninstall.

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
Specifies the exact version number of the script to uninstall.

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

[Find-Script]()

[Install-Script]()

[Publish-Script]()

[Save-Script]()

[Update-Script]()

