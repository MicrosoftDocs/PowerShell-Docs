---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Parsing
---

# About Parsing

## Short Description

Describes how Windows PowerShell parses commands.

## Long Description

When you enter a command at the command prompt, Windows PowerShell
breaks the command text into a series of segments called "tokens"
and then determines how to interpret each "token."

For example, if you type `Write-Host book`, Windows PowerShell breaks
the command into two tokens, "Write-Host" and "book", and interprets
each token independently.

### Expression Mode and Argument Mode
When processing a command, the Windows PowerShell parser operates
in expression mode or in argument mode:

* Expression mode

  Character string values must be contained in quotation marks.
  Numbers not enclosed in quotation marks are treated as numerical values
  (rather than as a series of characters).

* Argument mode

  Each value is treated as an expandable string unless it begins with
  one of the following special characters:
  - dollar sign (`$`)
  - at sign (`@`)
  - single quotation mark (`'`)
  - double quotation mark (`"`)
  - opening parenthesis (`(`)

If preceded by one of these characters, the value is treated as a value
expression.

The following table provides several examples of commands processed in
expression mode and argument mode and the results produced by those
commands.

| Example            | Mode       | Result           |
| ------------------ | ---------- | ---------------- |
| 2+2                | Expression | 4 (integer)      |
| Write-Output 2+2   | Argument   | "2+2" (string)   |
| Write-Output (2+2) | Expression | 4 (integer)      |
| $a = 2+2           | Expression | $a = 4 (integer) |
| Write-Output $a    | Expression | 4 (integer)      |
| Write-Output $a/H  | Argument   | "4/H" (string)   |

Every token can be interpreted as some kind of object type, such
as Boolean or string. Windows PowerShell attempts to determine the
object type from the expression. The object type depends on the
type of parameter a command expects and on whether Windows PowerShell
knows how to convert the argument to the correct type. The
following table shows several examples of the types assigned to
values returned by the expressions.

| Example            | Mode       | Result          |
| ------------------ | ---------- | --------------- |
| Write-Output !1    | Argument   | "!1" (string)   |
| Write-Output (!1)  | Expression | False (Boolean) |
| Write-Output (2)   | Expression | 2 (integer)     |

### STOP PARSING: --%
The stop-parsing symbol (`--%`), introduced in Windows PowerShell 3.0,
directs Windows PowerShell to refrain from interpreting input as
Windows PowerShell commands or expressions.

When calling an executable program in Windows PowerShell, place the
stop-parsing symbol before the program arguments. This technique is
much easier than using escape characters to prevent misinterpretation.

When it encounters a stop-parsing symbol, Windows PowerShell treats
the remaining characters in the line as a literal. The only
interpretation it performs is to substitute values for environment
variables that use standard Windows notation, such as %USERPROFILE%.

The stop-parsing symbol is effective only until the next newline or
pipeline character. You cannot use a continuation character (`) to
extend its effect or use a command delimiter (;) to terminate its effect.

For example, the following command calls the Icacls program.

```
icacls X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

To run this command in Windows PowerShell 2.0, you must use escape characters
to prevent Windows PowerShell from misinterpreting the parentheses.

```powershell
icacls X:\VMS /grant Dom\HVAdmin:`(CI`)`(OI`)F
```

Beginning in Windows PowerShell 3.0, you can use the stop-parsing
symbol.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

Windows PowerShell sends the following command string to the
Icacls program:

```
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

## See Also

[about_Command_Syntax](about_Command_Syntax.md)
