---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Return
---

# About Return

## SHORT DESCRIPTION

Exits the current scope, which can be a function, script, or script block.

## LONG DESCRIPTION

 The Return keyword exits a function, script, or script block. It can be used
 to exit a scope at a specific point, to return a value, or to indicate that
 the end of the scope has been reached.

Users who are familiar with languages like C or C\# might want to use the
Return keyword to make the logic of leaving a scope explicit.

In PowerShell, the results of each statement are returned as output,
even without a statement that contains the Return keyword. Languages like C or
C\# return only the value or values that are specified by the Return keyword.

### SYNTAX

The syntax for the Return keyword is as follows:

```
return [<expression>]
```

The Return keyword can appear alone, or it can be followed by a value or
expression, as follows:

```
return
return $a
return (2 + $a)
```


### EXAMPLES

The following example uses the Return keyword to exit a function at a specific
point if a conditional is met:

```
function ScreenPassword($instance)
{
    if (!($instance.screensaversecure)) {return $instance.name}
    <additional statements>
}

foreach ($a in @(get-wmiobject win32_desktop)) { ScreenPassword($a) }
```

This script checks each user account. The ScreenPassword function returns the
name of any user account that does not have a password-protected screen saver.
If the screen saver is password protected, the function completes any other
statements to be run, and PowerShell does not return any value.

In PowerShell, values can be returned even if the Return keyword is not used.
The results of each statement are returned. For example, the following
statements return the value of the \$a variable:

```
$a
return
```

The following statement also returns the value of $a:

```
return $a
```

The following example includes a statement intended to let the user know that
the function is performing a calculation:

```powershell
function calculation {
    param ($value)

    "Please wait. Working on calculation..."
    $value += 73
    return $value
}
```

Running this function and assigning the result to a variable has the following
effect:

```powershell
$a = calculation 14
```

The "Please wait. Working on calculation..." string is not displayed. Instead,
it is assigned to the $a variable, as in the following example:

```output
C:\PS> $a
Please wait. Working on calculation...
87
```

Both the informational string and the result of the calculation are returned
by the function and assigned to the \$a variable.

## SEE ALSO

[about_Language_Keywords](about_Language_Keywords.md)

[about_Functions](about_Functions.md)

[about_Scopes](about_Scopes.md)

[about_Script_Blocks](about_Script_Blocks.md)