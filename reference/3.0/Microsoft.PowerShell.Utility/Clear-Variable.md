---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=113285
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Clear-Variable
---
# Clear-Variable

## SYNOPSIS

Deletes the value of a variable.

## SYNTAX

```
Clear-Variable [-Name] <String[]> [-Include <String[]>] [-Exclude <String[]>] [-Force] [-PassThru]
 [-Scope <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The Clear-Variable cmdlet deletes the data stored in a variable, but it does not delete the variable.
As a result, the value of the variable is NULL (empty).
If the variable has a specified data or object type, Clear-Variable preserves the type of the object stored in the variable.

## EXAMPLES

### Example 1

```powershell
Clear-Variable my* -Scope Global
```

This command deletes the value of global variables that have names that begin with "my".

### Example 2

```
PS> $a=3
PS> &{ Clear-Variable a }
PS> $a
3
```

These commands demonstrate that clearing a variable in a child scope does not clear the value in the parent scope.
The first command sets the value of the variable $a to "3".
The second command uses the invoke operator (&) to run a Clear-Variable command in a new scope.
The variable is cleared in the child scope (although it did not exist), but it is not cleared in the local scope.
The third command, which gets the value of $a, shows that the value "3" is unaffected.

### Example 3

```powershell
Clear-Variable -Name Processes
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
Accept wildcard characters: True
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
Default value: False
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
Accept wildcard characters: True
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
Accept wildcard characters: True
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
Default value: False
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
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to Clear-Variable.

## OUTPUTS

### None or System.Management.Automation.PSVariable

When you use the PassThru parameter, Clear-Variable generates a System.Management.Automation.PSVariable object representing the cleared variable.
Otherwise, this cmdlet does not generate any output.

## NOTES

- To delete a variable, along with its value, use Remove-Variable or Remove-Item.

  Clear-Variable will not delete the values of variables that are set as constants or owned by the system, even if you use the -Force parameter.

  If the variable that you are clearing does not exist, the cmdlet has no effect.
It does not create a variable with a null value.

  You can also refer to Clear-Variable by its built-in alias, "clv".
For more information, see about_Aliases.

## RELATED LINKS

[Get-Variable](Get-Variable.md)

[New-Variable](New-Variable.md)

[Remove-Variable](Remove-Variable.md)

[Set-Variable](Set-Variable.md)
