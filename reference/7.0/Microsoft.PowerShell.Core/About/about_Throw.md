---
description: Describes the Throw keyword, which generates a terminating error.
Locale: en-US
ms.date: 12/01/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Throw
---
# About Throw

## Short description
Describes the Throw keyword, which generates a terminating error.

## Long description

The Throw keyword causes a terminating error. You can use the Throw keyword to
stop the processing of a command, function, or script.

For example, you can use the Throw keyword in the script block of an If
statement to respond to a condition or in the Catch block of a
Try-Catch-Finally statement. You can also use the Throw keyword in a parameter
declaration to make a function parameter mandatory.

The Throw keyword can throw any object, such as a user message string or the
object that caused the error.

## Syntax

The syntax of the Throw keyword is as follows:

```powershell
throw [<expression>]
```

The expression in the Throw syntax is optional. When the Throw statement does
not appear in a Catch block, and it does not include an expression, it
generates a ScriptHalted error.

```powershell
C:\PS> throw

Exception: ScriptHalted
```

If the Throw keyword is used in a Catch block without an expression, it throws
the current RuntimeException again. For more information, see
about_Try_Catch_Finally.

## Throwing a string

The optional expression in a Throw statement can be a string, as shown in the
following example:

```powershell
C:\PS> throw "This is an error."

Exception: This is an error.
```

## Throwing other objects

The expression can also be an object that throws the object that represents
the PowerShell process, as shown in the following example:

```powershell
C:\PS> throw (get-process Pwsh)

Exception: System.Diagnostics.Process (pwsh) System.Diagnostics.Process (pwsh) System.Diagnostics.Process (pwsh)
```

You can use the TargetObject property of the ErrorRecord object in the
$error automatic variable to examine the error.

```powershell
C:\PS> $error[0].targetobject

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
    125   174.44     229.57      23.61    1548   2 pwsh
     63    44.07      81.95       1.75    1732   2 pwsh
     63    43.32      77.65       1.48    9092   2 pwsh
```

You can also throw an ErrorRecord object or a .NET
exception. The following example uses the Throw keyword to throw a
System.FormatException object.

```powershell
C:\PS> $formatError = new-object system.formatexception

C:\PS> throw $formatError

OperationStopped: One of the identified items was in an invalid format.
```

## The resulting error

The Throw keyword can generate an ErrorRecord object. The Exception property
of the ErrorRecord object contains a RuntimeException object. The remainder of
the ErrorRecord object and the RuntimeException object vary with the object
that the Throw keyword throws.

The RunTimeException object is wrapped in an ErrorRecord object, and the
ErrorRecord object is automatically saved in the $Error automatic variable.

## Using Throw to create a mandatory parameter

Unlike past versions of PowerShell, do not use the Throw keyword for parameter validation. See [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md) for the correct way.

## See also

- [about_Break](about_Break.md)
- [about_Continue](about_Continue.md)
- [about_Scopes](about_Scopes.md)
- [about_Trap](about_Trap.md)
- [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
