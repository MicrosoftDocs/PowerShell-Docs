---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Parsing
---

# About Parsing

## SHORT DESCRIPTION

Describes how PowerShell parses commands.

## LONG DESCRIPTION

When you enter a command at the command prompt, PowerShell breaks the command
text into a series of segments called "tokens" and then determines how to
interpret each "token."

For example, if you type:

Write-Host book

PowerShell breaks the following command into two tokens, "Write-Host" and
"book", and interprets each token independently.

When processing a command, the PowerShell parser operates in expression mode
or in argument mode:

- In expression mode, character string values must be contained in
  quotation marks. Numbers not enclosed in quotation marks are treated as
  numerical values (rather than as a series of characters).

- In argument mode, each value is treated as an expandable string unless it
  begins with one of the following special characters: dollar sign (\$), at
  sign (@), single quotation mark (\'), double quotation mark (\"), or an
  opening parenthesis (\().

If preceded by one of these characters, the value is treated as a value
expression.

The following table provides several examples of commands processed in
expression mode and argument mode and the results produced by those
commands.

|Example            |Mode        | Result           |
|------------------ |----------  | ---------------- |
|2+2                |Expression  | 4 (integer)      |
|Write-Output 2+2   |Argument    | "2+2" (string)   |
|Write-Output (2+2) |Expression  | 4 (integer)      |
|\$a = 2+2          |Expression  | \$a = 4 (integer)|
|Write-Output $a    |Expression  | 4 (integer)      |
|Write-Output $a/H  |Argument    | "4/H" (string)   |

Every token can be interpreted as some kind of object type, such as Boolean
or string. PowerShell attempts to determine the object type from the
expression. The object type depends on the type of parameter a command
expects and on whether PowerShell knows how to convert the argument to the
correct type. The following table shows several examples of the types
assigned to values returned by the expressions.

|Example            |Mode        | Result         |
|------------------ |----------  | ---------------|
|Write-Output !1    |argument    | "!1" (string)  |
|Write-Output (!1)  |expression  | False (Boolean)|
|Write-Output (2)   |expression  | 2 (integer)    |

The stop-parsing symbol (--%), introduced in PowerShell 3.0, directs
PowerShell to refrain from interpreting input as PowerShell commands or
expressions.

When calling an executable program in PowerShell, place the stop-parsing
symbol before the program arguments. This technique is much easier than
using escape characters to prevent misinterpretation.

When it encounters a stop-parsing symbol, PowerShell treats the remaining
characters in the line as a literal. The only interpretation it performs is
to substitute values for environment variables that use standard Windows
notation, such as %USERPROFILE%.

The stop-parsing symbol is effective only until the next newline or
pipeline character. You cannot use a continuation character (`) to extend
its effect or use a command delimiter (;) to terminate its effect.

For example, the following command calls the Icacls program.

```powershell
icacls X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

To run this command in PowerShell 2.0, you must use escape characters to
prevent PowerShell from misinterpreting the parentheses.

```powershell
icacls X:\VMS /grant Dom\HVAdmin:`(CI`)`(OI`)F
```

Beginning in PowerShell 3.0, you can use the stop-parsing symbol.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

PowerShell sends the following command string to the Icacls program:

X:\VMS /grant Dom\HVAdmin:(CI)(OI)F

## SEE ALSO

[about_Command_Syntax](about_Command_Syntax.md)
