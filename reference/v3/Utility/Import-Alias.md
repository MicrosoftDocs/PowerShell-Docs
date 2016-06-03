---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Import-Alias
## SYNOPSIS
Imports an alias list from a file.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Import-Alias [-Path] <String> [-Force] [-PassThru] [-Scope <String>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Import-Alias [-Force] [-PassThru] [-Scope <String>] -LiteralPath <String> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Import-Alias cmdlet imports an alias list from a file.

Beginning in Windows PowerShell 3.0, as a security feature, Import-Alias does not overwrite existing aliases by default.
To overwrite an existing alias, after assuring that the contents of the alias file is safe, use the Force parameter.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>import-alias test.txt
```

This command imports alias information from a file named test.txt.

## PARAMETERS

### -Force
Allows the cmdlet to import an alias that is already defined or is read only.
You can use the following command to display information about the currently-defined aliases:

get-alias | select-object name,Options

If the corresponding alias is read-only, it will be displayed in the value of the Options property.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -PassThru
Returns an object that represents the alias.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: No output
Accept pipeline input: false
Accept wildcard characters: False
```

### -Path
Specifies the path to a file that includes exported alias information.
Wildcards are allowed but they must resolve to a single name.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: True
```

### -Scope
Specifies the scope into which the aliases are imported.
Valid values are "Global", "Local", or "Script", or a number relative to the current scope \(0 through the number of scopes, where 0 is the current scope and 1 is its parent\).
"Local" is the default.
For more information, see about_Scopes.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Local
Accept pipeline input: false
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to a file that includes exported alias information.
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: true (ByValue, ByPropertyName)
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
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains a path to Import-Alias.

## OUTPUTS

### None or System.Management.Automation.AliasInfo
When you use the Passthru parameter, Import-Alias returns a System.Management.Automation.AliasInfo object that represents the alias.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113339)

[Export-Alias](f2ebfdac-0af9-4bf1-bef9-2b612381f3e6)

[Get-Alias](c5703118-f617-4535-afc3-e6e64f333856)

[New-Alias](e77672bd-900b-4267-a07d-dab0d7957208)

[Set-Alias](b77236fb-e34f-4ac9-b8f7-9682dcb08593)


