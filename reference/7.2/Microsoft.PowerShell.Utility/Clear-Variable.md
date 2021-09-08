---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/clear-variable?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Clear-Variable
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

The **Clear-Variable** cmdlet deletes the data stored in a variable, but it does not delete the variable.
As a result, the value of the variable is NULL (empty).
If the variable has a specified data or object type, this cmdlet preserves the type of the object stored in the variable.

## EXAMPLES

### Example 1: Remove the value of global variables that begin with a search string

```
PS C:\> Clear-Variable my* -Scope Global
```

This command removes the value of global variables that have names that begin with my.

### Example 2: Clear a variable in a child scope but not the parent scope

```
PS C:\> $a=3
PS C:\> &{ Clear-Variable a }
PS C:\> $a
3
```

These commands demonstrate that clearing a variable in a child scope does not clear the value in the parent scope.
The first command sets the value of the variable $A to 3.
The second command uses the invoke operator (&) to run the **Clear-Variable** command in a new scope.
The variable is cleared in the child scope (although it did not exist), but it is not cleared in the local scope.
The third command, which gets the value of $A, shows that the value 3 is unaffected.

### Example 3: Delete the value of the specified variable

```
PS C:\> Clear-Variable -Name "Processes"
```

This command deletes the value of the variable named Processes.
After the cmdlet completes the operation, the variable named Processes still exists, but the value is null.

## PARAMETERS

### -Exclude

Specifies an array of items that this cmdlet omits in the operation.
The value of this parameter qualifies the *Name* parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: System.String[]
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies an array of items that this cmdlet includes in the operation.
The value of this parameter qualifies the *Name* parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: System.String[]
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
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -PassThru

Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
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

The acceptable values for this parameter are:

- Global
- Local
- Script

You can also use a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
Local is the default.
For more information, see about_Scopes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.PSVariable

When you use the *PassThru* parameter, this cmdlet generates a **System.Management.Automation.PSVariable** object representing the cleared variable.
Otherwise, this cmdlet does not generate any output.

## NOTES

* To delete a variable, along with its value, use Remove-Variable or Remove-Item.

  This cmdlet does not delete the values of variables that are set as constants or owned by the system, even if you use the *Force* parameter.

  If the variable that you are clearing does not exist, the cmdlet has no effect.
It does not create a variable with a null value.

  You can also refer to **Clear-Variable** by its built-in alias, clv.
For more information, see about_Aliases.

*

## RELATED LINKS

[Get-Variable](Get-Variable.md)

[New-Variable](New-Variable.md)

[Remove-Variable](Remove-Variable.md)

[Set-Variable](Set-Variable.md)

