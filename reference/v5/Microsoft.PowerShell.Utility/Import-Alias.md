---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293981
schema: 2.0.0
---

# Import-Alias
## SYNOPSIS
Imports an alias list from a file.

## SYNTAX

### ByPath (Default)
```
Import-Alias [-Path] <String> [-Scope <String>] [-PassThru] [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### ByLiteralPath
```
Import-Alias -LiteralPath <String> [-Scope <String>] [-PassThru] [-Force]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
get-alias | select-object name,Options

If the corresponding alias is read-only, it will be displayed in the value of the Options property.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
get-alias | select-object name,Options

If the corresponding alias is read-only, it will be displayed in the value of the Options property.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to a file that includes exported alias information.
Wildcards are allowed but they must resolve to a single name.

```yaml
Type: String
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope
Specifies the scope into which the aliases are imported.
Valid values are "Global", "Local", or "Script", or a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
"Local" is the default.
For more information, see about_Scopes.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### System.String
You can pipe a string that contains a path to Import-Alias.

## OUTPUTS

### None or System.Management.Automation.AliasInfo
When you use the Passthru parameter, Import-Alias returns a System.Management.Automation.AliasInfo object that represents the alias.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Export-Alias]()

[Get-Alias]()

[New-Alias]()

[Set-Alias]()

