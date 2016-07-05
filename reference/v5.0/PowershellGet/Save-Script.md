---
external help file: PSITPro5_PSGet.xml
online version: ba918f1e-1606-4cfd-b0ff-2c2eb821f586
schema: 2.0.0
---

# Save-Script
## SYNOPSIS
Saves a script.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Save-Script [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-Repository <String[]>] [-RequiredVersion <Version>] -Path <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Save-Script [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-Repository <String[]>] [-RequiredVersion <Version>] -LiteralPath <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Save-Script [-Force] -LiteralPath <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Save-Script [-Force] -Path <String> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Save-Script cmdlet saves the specified script.

## EXAMPLES

### Example 1: Save a script and validate it
```
PS C:\>Save-Script -Name "Fabrikam-ClientScript" -Repository "Local01" -Path "D:\ScriptSharingDemo"
PS C:\> Test-ScriptFileInfo -Path "D:\ScriptSharingDemo\Fabrikam-ClientScript.ps1"
Version    Name                      Author               Description
-------    ----                      ------               -----------
2.5        Fabrikam-ClientScript     pattif               Description for the Fabrikam-ClientScript script
```

The first command saves the script Fabrikam-ClientScript from the Local01 repository to the local folder D:\ScriptSharingDemo.

The second command uses the Test-ScriptFileInfo cmdlet to validate the script.

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

### -LiteralPath
Specifies a path to one or more locations.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum, or newest version of the script to save.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of the script to find.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of scripts to save.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (.).

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version number of the script to save.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
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

[Uninstall-Script](22014a04-4bf6-4d13-98cd-7717567da987)

[Update-Script](aa68486d-6ad6-495f-a1bb-67752ca8ed79)

