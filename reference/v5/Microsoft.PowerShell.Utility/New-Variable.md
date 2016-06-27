---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293995
schema: 2.0.0
---

# New-Variable
## SYNOPSIS
Creates a new variable.

## SYNTAX

```
New-Variable [-Name] <String> [[-Value] <Object>] [-Description <String>] [-Option <ScopedItemOptions>]
 [-Visibility <SessionStateEntryVisibility>] [-Force] [-PassThru] [-Scope <String>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The New-Variable cmdlet creates a new variable in Windows PowerShell.
You can assign a value to the variable while creating it or assign or change the value after it is created.

You can use the parameters of New-Variable to set the properties of the variable (such as those that create read-only or constant variables), set the scope of a variable, and determine whether variables are public or private.

Typically, you create a new variable by typing the variable name and its value, such as "$var = 3", but you can use the New-Variable cmdlet to use its parameters.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>new-variable days
```

This command creates a new variable named "days".
It has no value immediately following the command.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>new-variable zipcode -value 98033
```

This command creates a variable named "zipcode" and assigns it the value "98033".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>new-variable -name max -value 256 -option readonly
PS C:\>new-variable -name max -value 1024

New-Variable : A variable with name 'max' already exists.
At line:1 char:13
+ new-variable <<<<  -name max -value 1024

PS C:\>new-variable -name max -value 1024 -force
```

This example shows how to use the ReadOnly option of New-Variable to protect a variable from being overwritten.

The first command creates a new variable named Max and sets its value to "256".
It uses the Option parameter with a value of ReadOnly.

The second command tries to create a second variable with the same name.
This command returns an error, because the read-only option is set on the variable.

The third command uses the Force parameter to override the read-only protection on the variable.
In this case, the command to create a new variable with the same name succeeds.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>new-variable -name counter -visibility private

#Effect of private variable in a module.

PS C:\>get-variable c*

Name                           Value
----                           -----
Culture                        en-US
ConsoleFileName
ConfirmPreference              High
CommandLineParameters          {}

PS C:\>$counter

"Cannot access the variable '$counter' because it is a private variable"

PS C:\>Get-Counter

Name         Value
----         -----
Counter1     3.1415
...
```

This command demonstrates the behavior of a private variable in a module.
The module contains the Get-Counter cmdlet, which has a private variable named "Counter".
The command uses the Visibility parameter with a value of "Private" to create the variable.

The sample output shows the behavior of a private variable.
The user who has loaded the module cannot view or change the value of the Counter variable, but the Counter variable can be read and changed by the commands in the module.

## PARAMETERS

### -Description
Specifies a description of the variable.

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

### -Force
Allows you to create a new variable with the same name as an existing read-only variable.

By default, you can overwrite a variable unless the variable has an option value of ReadOnly or Constant.
For more information, see the Option parameter.

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
Specifies a name for the new variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option
Sets the value of the Options property of the variable.

Valid values are:

-- None: Sets no options. ("None" is the default.)
-- ReadOnly: Can be deleted. Cannot be not changed, except by using the Force parameter.
-- Constant: Cannot be deleted or changed. "Constant" is valid only when you are creating a variable. You cannot change the options of an existing variable to "Constant".
-- Private: The variable is available only in the current scope.
-- AllScope: The variable is copied to any new scopes that are created.

To see the Options property of all variables in the session, type "get-variable | format-table -property name, options -autosize".

```yaml
Type: ScopedItemOptions
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
Returns an object representing the new variable.
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
Determines the scope of the new variable.
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

### -Value
Specifies the initial value of the variable.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Visibility
Determines whether the variable is visible outside of the session in which it was created.
This parameter is designed for  use in scripts and commands that will be delivered to other users.

Valid values are:

-- Public:  The variable is visible. ("Public" is the default.)
-- Private: The variable is not visible.

When a variable is private, it does not appear in lists of variables, such as those returned by Get-Variable, or in displays of the Variable: drive.
Commands to read or change the value of a private variable return an error.
However, the user can run commands that use a private variable if the commands were written in the session in which the variable was defined.

```yaml
Type: SessionStateEntryVisibility
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

### System.Object
You can pipe a value to New-Variable.

## OUTPUTS

### None or System.Management.Automation.PSVariable
When you use the PassThru parameter, New-Variable generates a System.Management.Automation.PSVariable object representing the new variable.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Clear-Variable]()

[Get-Variable]()

[Remove-Variable]()

[Set-Variable]()

