---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-variable?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Variable
---

# New-Variable

## SYNOPSIS
Creates a new variable.

## SYNTAX

```
New-Variable [-Name] <String> [[-Value] <Object>] [-Description <String>] [-Option <ScopedItemOptions>]
 [-Visibility <SessionStateEntryVisibility>] [-Force] [-PassThru] [-Scope <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-Variable** cmdlet creates a new variable in PowerShell.
You can assign a value to the variable while creating it or assign or change the value after it is created.

You can use the parameters of **New-Variable** to set the properties of the variable, set the scope of a variable, and determine whether variables are public or private.

Typically, you create a new variable by typing the variable name and its value, such as `$Var = 3`, but you can use the **New-Variable** cmdlet to use its parameters.

## EXAMPLES

### Example 1: Create a variable

```
PS C:\> New-Variable days
```

This command creates a new variable named days.
You are not required to type the *Name* parameter.

### Example 2: Create a variable and assign it a value

```
PS C:\> New-Variable -Name "zipcode" -Value 98033
```

This command creates a variable named zipcode and assigns it the value 98033.

### Example 3: Create a variable with the ReadOnly option

```
PS C:\> New-Variable -Name Max -Value 256 -Option ReadOnly
PS C:\> New-Variable -Name max -Value 1024

New-Variable : A variable with name 'max' already exists.
At line:1 char:1
+ New-Variable -Name max -Value 1024
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ResourceExists: (max:String) [New-Variable], SessionStateException
    + FullyQualifiedErrorId : VariableAlreadyExists,Microsoft.PowerShell.Commands.NewVariableCommand

PS C:\> New-Variable -Name max -Value 1024 -Force
```

This example shows how to use the ReadOnly option of **New-Variable** to protect a variable from being overwritten.

The first command creates a new variable named Max and sets its value to 256.
It uses the *Option* parameter with a value of ReadOnly.

The second command tries to create a second variable with the same name.
This command returns an error, because the read-only option is set on the variable.

The third command uses the *Force* parameter to override the read-only protection on the variable.
In this case, the command to create a new variable with the same name succeeds.

### Example 4: Create a private variable

```
PS C:\> New-Variable -Name counter -Visibility Private

#Effect of private variable in a module.

PS C:\> Get-Variable c*

Name                           Value
----                           -----
Culture                        en-US
ConsoleFileName
ConfirmPreference              High
CommandLineParameters          {}

PS C:\> $counter
"Cannot access the variable '$counter' because it is a private variable"
At line:1 char:1
+ $counter
+ ~~~~~~~~
    + CategoryInfo          : PermissionDenied: (counter:String) [], SessionStateException
    + FullyQualifiedErrorId : VariableIsPrivate

PS C:\> Get-Counter
Name         Value
----         -----
Counter1     3.1415
...
```

This command demonstrates the behavior of a private variable in a module.
The module contains the Get-Counter cmdlet, which has a private variable named Counter.
The command uses the *Visibility* parameter with a value of Private to create the variable.

The sample output shows the behavior of a private variable.
The user who has loaded the module cannot view or change the value of the Counter variable, but the Counter variable can be read and changed by the commands in the module.

### Example 5: Create a variable with a space

```
PS C:\> New-Variable -Name 'with space' -Value 'abc123xyz'

PS C:\> Get-Variable -Name 'with space'

Name                           Value
----                           -----
with space                     abc123xyz

PS C:\> ${with space}
abc123xyz
```

This command demonstrates that variables with spaces can be created.
The variables can be accessed using the **Get-Variable** cmdlet or directly by delimiting a variable with braces.

## PARAMETERS

### -Description
Specifies a description of the variable.

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

### -Force
Indicates that the cmdlet creates a variable with the same name as an existing read-only variable.

By default, you can overwrite a variable unless the variable has an option value of ReadOnly or Constant.
For more information, see the *Option* parameter.

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

### -Name
Specifies a name for the new variable.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option
Specifies the value of the **Options** property of the variable.The acceptable values for this parameter are:

- None.
Sets no options.
(None is the default.)
- ReadOnly.
Can be deleted.
Cannot be changed, except by using the *Force* parameter.
- Private.
The variable is available only in the current scope.
- AllScope.
The variable is copied to any new scopes that are created.
- Constant.
Cannot be deleted or changed.
Constant is valid only when you are creating a variable.
You cannot change the options of an existing variable to Constant.

To see the **Options** property of all variables in the session, type `Get-Variable | Format-Table -Property name, options -autosize`.

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
Specifies the scope of the new variable.
The acceptable values for this parameter are:

- Global.
Variables created in the global scope are accessible everywhere in a PowerShell process.
- Local.
The local scope refers to the current scope, this can be any scope depending on the context.
- Script.
Variables created in the script scope are accessible only within the script file or module they are created in.
- Private.
Variables created in the private scope cannot be accessed outside the scope they exist in.
You can use private scope to create a private version of an item with the same name in another scope.
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope, 1 is its parent, 2 the parent of the parent scope, and so on).
Negative numbers cannot be used.

Local is the default scope when the scope parameter is not specified.

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

### -Value
Specifies the initial value of the variable.

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
Determines whether the variable is visible outside of the session in which it was created.
This parameter is designed for  use in scripts and commands that will be delivered to other users.
The acceptable values for this parameter are:

- Public.
The variable is visible.
(Public is the default.)
- Private.
The variable is not visible.

When a variable is private, it does not appear in lists of variables, such as those returned by Get-Variable, or in displays of the Variable: drive.
Commands to read or change the value of a private variable return an error.
However, the user can run commands that use a private variable if the commands were written in the session in which the variable was defined.

```yaml
Type: System.Management.Automation.SessionStateEntryVisibility
Parameter Sets: (All)
Aliases:
Accepted values: Public, Private

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

### System.Object
You can pipe a value to **New-Variable**.

## OUTPUTS

### None or System.Management.Automation.PSVariable
When you use the *PassThru* parameter, **New-Variable** generates a **System.Management.Automation.PSVariable** object representing the new variable.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Clear-Variable](Clear-Variable.md)

[Get-Variable](Get-Variable.md)

[Remove-Variable](Remove-Variable.md)

[Set-Variable](Set-Variable.md)

