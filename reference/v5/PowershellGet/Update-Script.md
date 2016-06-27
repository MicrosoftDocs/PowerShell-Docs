---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Update-Script
## SYNOPSIS
Updates a script.

## SYNTAX

```
Update-Script [[-Name] <String[]>] [-RequiredVersion <Version>] [-MaximumVersion <Version>] [-Force] [-WhatIf]
 [-Confirm]
```

## DESCRIPTION
The Update-Script cmdlet updates the specified script from the repository from which it was previously installed.

## EXAMPLES

### Example 1: Update the specified script
```
PS C:\>Update-Script -Name "Fabrikam-Script" -RequiredVersion 1.5
PS C:\> Get-InstalledScript -Name "Fabrikam-Script"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.5        Fabrikam-Script                     Script     local1               Description for the Fabrkiam-Script script
```

The first command updates the script Fabrikam-Script to version 1.5.

The second command gets Fabrikam-Script and displays the results.

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
Specifies the maximum, or newest, version of the script to update.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of scripts to update.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version number of the script to update.
The MinimumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Find-Script]()

[Install-Script]()

[Publish-Script]()

[Save-Script]()

[Uninstall-Script]()

