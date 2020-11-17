---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 07/21/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/remove-variable?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Variable
---
# Remove-Variable

## SYNOPSIS
Deletes a variable and its value.

## SYNTAX

```
Remove-Variable [-Name] <String[]> [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Scope <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Variable` cmdlet deletes a variable and its value from the scope in which it is defined,
such as the current session. You cannot use this cmdlet to delete variables that are set as
constants or those that are owned by the system.

## EXAMPLES

### Example 1: Remove a variable

```powershell
Remove-Variable Smp
```

This command deletes the `$Smp` variable.

## PARAMETERS

### -Exclude

Specifies an array of items that this cmdlet omits from the operation. The value of this parameter
qualifies the **Name** parameter. Enter a name element or pattern, such as "s*". Wildcards are
permitted.

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

Indicates that the cmdlet removes a variable even if it is read-only. Even using the **Force**
parameter, the cmdlet cannot remove a constant.

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

Specifies an array of items that this cmdlet deletes in the operation. The value of this parameter
qualifies the **Name** parameter. Enter a name element or pattern, such as s*. Wildcards are
permitted.

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

Specifies the name of the variable to be removed. The parameter name (**Name**) is optional.
Wildcards are permitted

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

### -Scope

Gets only the variables in the specified scope. The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current
  scope and 1 is its parent)

Local is the default. For more information, see [about_Scopes](../Microsoft.PowerShell.Core/About/about_Scopes.md).

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSVariable

You can pipe a variable object to `Remove-Variable`.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

- Changes affect only the current scope, such as a session. To delete a variable from all sessions,
  add a `Remove-Variable` command to your PowerShell profile.

- You can also refer to `Remove-Variable` by its built-in alias, `rv`. For more information, see
  [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

## RELATED LINKS

[Clear-Variable](Clear-Variable.md)

[Get-Variable](Get-Variable.md)

[New-Variable](New-Variable.md)

[Set-Variable](Set-Variable.md)
