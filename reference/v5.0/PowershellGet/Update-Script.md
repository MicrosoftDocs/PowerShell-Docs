---
external help file: PSITPro5_PSGet.xml
online version: ba918f1e-1606-4cfd-b0ff-2c2eb821f586
schema: 2.0.0
---

# Update-Script
## SYNOPSIS
Updates a script.

## SYNTAX

```
Update-Script [[-Name] <String[]>] [-Force] [-MaximumVersion <Version>] [-RequiredVersion <Version>] [-Confirm]
 [-WhatIf]
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
Accept pipeline input: True(ByPropertyName)
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
Accept pipeline input: True(ByPropertyName)
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

[Uninstall-Script](22014a04-4bf6-4d13-98cd-7717567da987)

