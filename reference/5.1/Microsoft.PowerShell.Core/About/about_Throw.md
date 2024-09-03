---
description: Describes the Throw keyword, which generates a terminating error.
Locale: en-US
ms.date: 08/24/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Throw
---
# about_Throw

## Short description
Describes the `throw` keyword that generates a terminating error.

## Long description

The `throw` keyword causes a terminating error. You can use the `throw` keyword
to stop the processing of a command, function, or script.

For example, you can use the `throw` keyword in the script block of an `if`
statement to respond to a condition or in the `catch` block of a
`try`-`catch`-`finally` statement.

The `throw` keyword can throw any object, such as a user message string or the
object that caused the error.

## Syntax

The syntax of the `throw` keyword is as follows:

```powershell
throw [<expression>]
```

The expression in the `throw` syntax is optional. When the `throw` statement
doesn't appear in a `catch` block, and it doesn't include an expression, it
generates a **ScriptHalted** error.

```powershell
throw
```

```Output
ScriptHalted
At line:1 char:6
+ throw <<<<
+ CategoryInfo          : OperationStopped: (:) [], RuntimeException
+ FullyQualifiedErrorId : ScriptHalted
```

If the `throw` keyword is used in a `catch` block without an expression, it
throws the current RuntimeException again. For more information, see
[about_Try_Catch_Finally](about_Try_Catch_Finally.md).

## Throwing a string

The optional expression in a `throw` statement can be a string, as shown in the
following example:

```powershell
throw "This is an error."
```

```Output
This is an error.
At line:1 char:6
+ throw <<<<  "This is an error."
+ CategoryInfo          : OperationStopped: (This is an error.:String) [], R
untimeException
+ FullyQualifiedErrorId : This is an error.
```

## Throwing other objects

The expression can also be an object that throws the object that represents the
PowerShell process, as shown in the following example:

```powershell
throw (Get-Process pwsh)
```

```Output
At line:1 char:6
+ throw <<<<  (get-process PowerShell)
+ CategoryInfo          : OperationStopped: (System.Diagnostics.Process (Pow
erShell):Process) [],
RuntimeException
+ FullyQualifiedErrorId : System.Diagnostics.Process (PowerShell)
```

You can use the **TargetObject** property of the **ErrorRecord** object in the
`$Error` automatic variable to examine the error.

```powershell
$Error[0].TargetObject
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
319      26    61016      70864   568     3.28   5548 PowerShell
```

You can also `throw` an **ErrorRecord** object or a .NET exception. The
following example uses the `throw` keyword to throw a
**System.FormatException** object.

```powershell
$formatError = New-Object System.FormatException
throw $formatError
```

```Output
One of the identified items was in an invalid format.
At line:1 char:6
+ throw <<<<  $formatError
+ CategoryInfo          : OperationStopped: (:) [], FormatException
+ FullyQualifiedErrorId : One of the identified items was in an invalid
format.
```

## The resulting error

The `throw` keyword can generate an **ErrorRecord** object. The **Exception**
property of the **ErrorRecord** object contains a **RuntimeException** object.
The remainder of the **ErrorRecord** object and the **RuntimeException** object
varies depending on the object thrown.

The `throw` object is wrapped in an **ErrorRecord** object, and the ErrorRecord
object is automatically saved in the `$Error` automatic variable.

## Using `throw` to create a mandatory parameter

Unlike past versions of PowerShell, don't use the `throw` keyword for parameter
validation. See
[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)
for the correct way.

## See also

- [about_Break](about_Break.md)
- [about_Continue](about_Continue.md)
- [about_Scopes](about_Scopes.md)
- [about_Trap](about_Trap.md)
- [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
