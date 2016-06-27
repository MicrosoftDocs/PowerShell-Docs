---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Save-Script
## SYNOPSIS
Saves a script.

## SYNTAX

### NameAndPathParameterSet (Default)
```
Save-Script [-Name] <String[]> [-MinimumVersion <Version>] [-MaximumVersion <Version>]
 [-RequiredVersion <Version>] [-Repository <String[]>] -Path <String> [-Force] [-WhatIf] [-Confirm]
```

### NameAndLiteralPathParameterSet
```
Save-Script [-Name] <String[]> [-MinimumVersion <Version>] [-MaximumVersion <Version>]
 [-RequiredVersion <Version>] [-Repository <String[]>] -LiteralPath <String> [-Force] [-WhatIf] [-Confirm]
```

### InputOjectAndLiteralPathParameterSet
```
Save-Script -InputObject <PSObject[]> -LiteralPath <String> [-Force] [-WhatIf] [-Confirm]
```

### InputOjectAndPathParameterSet
```
Save-Script -InputObject <PSObject[]> -Path <String> [-Force] [-WhatIf] [-Confirm]
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
Parameter Sets: NameAndLiteralPathParameterSet, InputOjectAndLiteralPathParameterSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum, or newest version of the script to save.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of the script to find.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of scripts to save.

```yaml
Type: String[]
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (.).

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, InputOjectAndPathParameterSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

```yaml
Type: String[]
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version number of the script to save.

```yaml
Type: Version
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
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
Parameter Sets: InputOjectAndLiteralPathParameterSet, InputOjectAndPathParameterSet
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

[Uninstall-Script]()

[Update-Script]()

