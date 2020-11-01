---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Variable
---
# Set-Variable

## SYNOPSIS
Sets the value of a variable. Creates the variable if one with the requested name does not exist.

## SYNTAX

```
Set-Variable [-Name] <String[]> [[-Value] <Object>] [-Include <String[]>] [-Exclude <String[]>]
 [-Description <String>] [-Option <ScopedItemOptions>] [-Force] [-Visibility <SessionStateEntryVisibility>]
 [-PassThru] [-Scope <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Variable` cmdlet assigns a value to a specified variable or changes the current value. If
the variable does not exist, the cmdlet creates it.

## EXAMPLES

### Example 1: Set a variable and get its value

These commands set the value of the `$desc` variable to `A description`, and then gets the value of
the variable.

```powershell
Set-Variable -Name "desc" -Value "A description"
Get-Variable -Name "desc"
```

```Output
Name                           Value
----                           -----
desc                           A description
```

### Example 2: Set a global, read-only variable

This example creates a global, read-only variable that contains all processes on the system, and
then it displays all properties of the variable.

```powershell
Set-Variable -Name "processes" -Value (Get-Process) -Option constant -Scope global -Description "All processes" -PassThru |
    Format-List -Property *
```

The command uses the `Set-Variable` cmdlet to create the variable. It uses the **PassThru**
parameter to create an object representing the new variable, and it uses the pipeline operator (`|`)
to pass the object to the `Format-List` cmdlet. It uses the **Property** parameter of `Format-List`
with a value of all (`*`) to display all properties of the newly created variable.

The value, `(Get-Process)`, is enclosed in parentheses to ensure that it is executed before being
stored in the variable. Otherwise, the variable contains the words "**Get-Process**".

### Example 3: Understand public vs. private variables

This example shows how to change the visibility of a variable to `Private`. This variable can be
read and changed by scripts with the required permissions, but it is not visible to the user.

```
PS C:\> New-Variable -Name "counter" -Visibility Public -Value 26
PS C:\> $Counter
26

PS C:\> Get-Variable c*

Name                  Value
----                  -----
Culture               en-US
ConsoleFileName
ConfirmPreference     High
CommandLineParameters {}
Counter               26

PS C:\> Set-Variable -Name "counter" -Visibility Private
PS C:\> Get-Variable c*

Name                  Value
----                  -----
Culture               en-US
ConsoleFileName
ConfirmPreference     High
CommandLineParameters {}

PS C:\> $counter
"Cannot access the variable '$counter' because it is a private variable"

PS C:\> .\use-counter.ps1
#Commands completed successfully.
```

This command shows how to change the visibility of a variable to Private. This variable
can be read and changed by scripts with the required permissions, but it is not visible
to the user.

## PARAMETERS

### -Description

Specifies the description of the variable.

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

### -Exclude

Specifies an array of items that this cmdlet excludes from the operation. The value of this
parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `*.txt`.
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

Allows you to create a variable with the same name as an existing read-only variable, or to change
the value of a read-only variable.

By default, you can overwrite a variable, unless the variable has an option value of `ReadOnly` or
`Constant`. For more information, see the **Option** parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies an array of items that this cmdlet includes in the operation. The value of this parameter
qualifies the **Name** parameter. Enter a name or name pattern, such as `c*`. Wildcards are
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

Specifies the variable name.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option

Specifies the value of the **Options** property of the variable.

Valid values are:

- `None`: Sets no options. ("None" is the default.)
- `ReadOnly`: Can be deleted. Cannot be changed, except by using the Force parameter.
- `Constant`: Cannot be deleted or changed. `Constant` is valid only when you are creating a
  variable. You cannot change the options of an existing variable to `Constant`.
- `Private`: The variable is available only in the current scope.
- `AllScope`: The variable is copied to any new scopes that are created.

```yaml
Type: System.Management.Automation.ScopedItemOptions
Parameter Sets: (All)
Aliases:
Accepted values: None, ReadOnly, Constant, Private, AllScope, Unspecified

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the new variable. By default, this cmdlet does not generate any
output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

Specifies the scope of the variable.The acceptable values for this parameter are:

- Global
- Local
- Script
- Private
- A number relative to the current scope (0 through the number of scopes, where 0 is the current
  scope and 1 is its parent).

Local is the default.

For more information, see [about_Scopes](../Microsoft.PowerShell.Core/About/about_scopes.md).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

Specifies the value of the variable.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Visibility

Determines whether the variable is visible outside of the session in which it was created. This
parameter is designed for use in scripts and commands that will be delivered to other users.

Valid values are:

- Public:  The variable is visible. ("Public" is the default.)
- Private: The variable is not visible.

When a variable is private, it does not appear in lists of variables, such as those returned by
`Get-Variable`, or in displays of the **Variable:** drive. Commands to read or change the value of a
private variable return an error. However, the user can run commands that use a private variable if
the commands were written in the session in which the variable was defined.

```yaml
Type: System.Management.Automation.SessionStateEntryVisibility
Parameter Sets: (All)
Aliases:
Accepted values: Public, Private

Required: False
Position: Named
Default value: Public
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe an object that represents the value of the variable to `Set-Variable`.

## OUTPUTS

### None or System.Management.Automation.PSVariable

When you use the **PassThru** parameter, `Set-Variable` generates a
**System.Management.Automation.PSVariable** object representing the new or changed variable.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Clear-Variable](Clear-Variable.md)

[Get-Variable](Get-Variable.md)

[New-Variable](New-Variable.md)

[Remove-Variable](Remove-Variable.md)
