---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821517
schema: 2.0.0
title: Set-StrictMode
---

# Set-StrictMode

## SYNOPSIS
Establishes and enforces coding rules in expressions, scripts, and script blocks.

## SYNTAX

### Version (Default)
```
Set-StrictMode -Version <Version> [<CommonParameters>]
```

### Off
```
Set-StrictMode [-Off] [<CommonParameters>]
```

## DESCRIPTION
The **Set-StrictMode** cmdlet configures strict mode for the current scope and all child scopes, and turns it on and off.
When strict mode is on, Windows PowerShell generates a terminating error when the content of an expression, script, or script block violates basic best-practice coding rules.

Use the *Version* parameter to determine which coding rules are enforced.

Unlike the Set-PSDebug cmdlet, **Set-StrictMode** affects only the current scope and its child scopes.
Therefore, you can use it in a script or function without affecting the global scope.

When **Set-StrictMode** is off, uninitialized variables (Version 1) are assumed to have a value of 0 (zero) or $Null, depending on type.
References to non-existent properties return $Null, and the results of function syntax that is not valid vary with the error.
Unnamed variables are not permitted.

## EXAMPLES

### Example 1: Turn on strict mode as version 1.0
```
PS C:\> Set-StrictMode -Version 1.0
PS C:\> $a -gt 5
False

The variable $a cannot be retrieved because it has not been set yet.

At line:1 char:3

+ $a <<<<  -gt 5

+ CategoryInfo          : InvalidOperation: (a:Token) [], RuntimeException

+ FullyQualifiedErrorId : VariableIsUndefined
```

This command turns strict mode on and sets it to version 1.0.
As a result, attempts to reference variables that are not initialized fail.

The sample output shows the effect of version 1.0 strict mode.

### Example 2: Turn on strict mode as version 2.0
```
PS C:\> # Set-StrictMode -Version 2.0
# Strict mode is off by default.

PS C:\> function add ($a, $b) {$a + $b}
PS C:\> add 3 4
7
PS C:\> add(3,4)
3
4
PS C:\> Set-StrictMode -Version 2.0
PS C:\> add(3,4)

The function or command was called like a method. Parameters should be separated by spaces, as described in 'Get-Help about_Parameter.'
At line:1 char:4
+ add <<<< (3,4)
+ CategoryInfo          : InvalidOperation: (:) [], RuntimeException
+ FullyQualifiedErrorId : StrictModeFunctionCallWithParens

PS C:\> Set-StrictMode -Off
PS C:\> $string = "This is a string."
PS C:\> $string.Month
PS C:\>
PS C:\> Set-StrictMode -Version 2.0
PS C:\> $string = "This is a string."
PS C:\> $string.Month

Property 'month' cannot be found on this object; make sure it exists.
At line:1 char:9
+ $string. <<<< month
+ CategoryInfo          : InvalidOperation: (.:OperatorToken) [], RuntimeException
+ FullyQualifiedErrorId : PropertyNotFoundStrict
```

This command turns strict mode on and sets it to version 2.0.
As a result, Windows PowerShell returns an error if you use method syntax, which uses parentheses and commas, for a function call or reference uninitialized variables or non-existent properties.

The sample output shows the effect of version 2.0 strict mode.

Without version 2.0 strict mode, the "(3,4)" value is interpreted as a single array object to which nothing is added.
By using version 2.0 strict mode, it is correctly interpreted as faulty syntax for submitting two values.

Without version 2.0, the reference to the non-existent **Month** property of a string returns only $Null.
By using version 2.0, it is interpreted correctly as a reference error.

## PARAMETERS

### -Off
Indicates that this cmdlet turns strict mode off.
This parameter also turns off `Set-PSDebug -Strict`.

```yaml
Type: SwitchParameter
Parameter Sets: Off
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Specifies the conditions that cause an error in strict mode.

The acceptable values for this parameter are:

- 1.0

---- Prohibits references to uninitialized variables, except for uninitialized variables in strings.
- 2.0

---- Prohibits references to uninitialized variables. This includes uninitialized variables in strings.
---- Prohibits references to non-existent properties of an object.
---- Prohibits function calls that use the syntax for calling methods.
---- Prohibits a variable without a name (${}).

Latest

---- Selects the latest version available.
The latest version is the most strict.
Use this value to make sure that scripts use the strictest available version, even when new versions are added to Windows PowerShell.

```yaml
Type: Version
Parameter Sets: Version
Aliases: v

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* **Set-StrictMode** is like the *Strict* parameter of **Set-PSDebug**. `Set-StrictMode -Version 1` is equivalent to `Set-PSDebug -Strict`, except that **Set-PSDebug** is effective in all scopes. **Set-StrictMode** is effective only in the scope in which it is set and in its child scopes. For more information about scopes in Windows PowerShell, see about_Scopes.

*

## RELATED LINKS

[Set-PSDebug](Set-PSDebug.md)