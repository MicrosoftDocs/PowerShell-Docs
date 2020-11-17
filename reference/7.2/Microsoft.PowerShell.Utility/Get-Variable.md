---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-variable?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Variable
---
# Get-Variable

## SYNOPSIS
Gets the variables in the current console.

## SYNTAX

```
Get-Variable [[-Name] <String[]>] [-ValueOnly] [-Include <String[]>] [-Exclude <String[]>] [-Scope <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-Variable` cmdlet gets the PowerShell variables in the current console.
You can retrieve just the values of the variables by specifying the **ValueOnly** parameter, and you
can filter the variables returned by name.

## EXAMPLES

### Example 1: Get variables by letter

This command gets variables with names that begin with the letter m.
The command also gets the value of the variables.

```powershell
Get-Variable m*
```

### Example 2: Get variable values by letter

This command gets only the values of the variables that have names that begin with m.

```powershell
Get-Variable m* -ValueOnly
```

### Example 3: Get variables by two letters

This command gets information about the variables that begin with either the letter M or the letter
P.

```powershell
Get-Variable -Include M*,P*
```

### Example 4: Get variables by scope

The first command gets only the variables that are defined in the local scope.
It is equivalent to `Get-Variable -Scope Local` and can be abbreviated as `gv -s 0`.

The second command uses the `Compare-Object` cmdlet to find the variables that are defined in the
parent scope (Scope 1) but are visible only in the local scope (Scope 0).

```powershell
Get-Variable -Scope 0
Compare-Object (Get-Variable -Scope 0) (Get-Variable -Scope 1)
```

## PARAMETERS

### -Exclude

Specifies an array of items that this cmdlet excludes from the operation.
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

### -Include

Specifies an array of items upon which the cmdlet will act, excluding all others.
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

Specifies the name of the variable.
Wildcards are permitted.
You can also pipe a variable name to `Get-Variable`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Scope

Specifies the variables in the scope.The acceptable values for this parameter are:

- **Global**
- **Local**
- **Script**
- A number relative to the current scope (0 through the number of scopes, where 0 is the current
scope and 1 is its parent)

**Local** is the default.
For more information, see [about_Scopes](../Microsoft.PowerShell.Core/About/about_Scopes.md).

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

### -ValueOnly

Indicates that this cmdlet gets only the value of the variable.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string that contains the variable name to `Get-Variable`.

## OUTPUTS

### System.Management.Automation.PSVariable

This cmdlet returns a **System.Management.AutomationPSVariable** object for each variable that it
gets. The object type depends on the variable.

### System.Object[]

When you specify the **ValueOnly** parameter, if the specified variable's value is a collection,
`Get-Variable` returns a `[System.Object[]]`. This behavior prevents normal pipeline operation from
processing the variable's values one at a time. A workaround to force collection enumeration is to
enclose the `Get-Variable` command in parenthesis.

## NOTES

- This cmdlet does not manage environment variables. To manage environment variables, you can use
the environment variable provider.

## RELATED LINKS

[Clear-Variable](Clear-Variable.md)

[New-Variable](New-Variable.md)

[Remove-Variable](Remove-Variable.md)

[Set-Variable](Set-Variable.md)

