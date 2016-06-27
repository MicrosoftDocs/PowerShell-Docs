---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293944
schema: 2.0.0
---

# Clear-Variable
## SYNOPSIS
Deletes the value of a variable.

## SYNTAX

```
Clear-Variable [-Name] <String[]> [-Include <String[]>] [-Exclude <String[]>] [-Force] [-PassThru]
 [-Scope <String>] [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Clear-Variable cmdlet deletes the data stored in a variable, but it does not delete the variable.
As a result, the value of the variable is NULL (empty).
If the variable has a specified data or object type, Clear-Variable preserves the type of the object stored in the variable.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Clear-Variable my* -Scope Global
```

This command deletes the value of global variables that have names that begin with "my".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$a=3
PS C:\>&{ Clear-Variable a }
PS C:\>$a
3
```

These commands demonstrate that clearing a variable in a child scope does not clear the value in the parent scope.
The first command sets the value of the variable $a to "3".
The second command uses the invoke operator (&) to run a Clear-Variable command in a new scope.
The variable is cleared in the child scope (although it did not exist), but it is not cleared in the local scope.
The third command, which gets the value of $a, shows that the value "3" is unaffected.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Clear-variable -Name Processes
```

This command deletes the value of the $processes variable.
The $processes variable still exists, but the value is null.

## PARAMETERS

### -Exclude
Omits the specified items.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Allows the cmdlet to clear a variable even if it is read-only.
Even using the Force parameter, the cmdlet cannot clear constants.

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

### -Include
Clears only the specified items.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

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
@{Text=}

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

### -Name
Specifies the name of the variable to be cleared.
Wildcards are permitted.
This parameter is required, but the parameter name ("Name") is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the cleared variable.
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

### -Scope
Specifies the scope in which this alias is valid.
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

### None
You cannot pipe objects to Clear-Variable.

## OUTPUTS

### None or System.Management.Automation.PSVariable
When you use the PassThru parameter, Clear-Variable generates a System.Management.Automation.PSVariable object representing the cleared variable.
Otherwise, this cmdlet does not generate any output.

## NOTES
To delete a variable, along with its value, use Remove-Variable or Remove-Item.

Clear-Variable will not delete the values of variables that are set as constants or owned by the system, even if you use the -Force parameter.

If the variable that you are clearing does not exist, the cmdlet has no effect.
It does not create a variable with a null value.

You can also refer to Clear-Variable by its built-in alias, "clv".
For more information, see about_Aliases.

## RELATED LINKS

[Get-Variable]()

[New-Variable]()

[Remove-Variable]()

[Set-Variable]()

