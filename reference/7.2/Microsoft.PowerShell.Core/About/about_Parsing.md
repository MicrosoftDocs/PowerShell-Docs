---
description: Describes how PowerShell parses commands.
Locale: en-US
ms.date: 09/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parsing?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Parsing
---
# About Parsing

## SHORT DESCRIPTION
Describes how PowerShell parses commands.

## LONG DESCRIPTION

When you enter a command at the command prompt, PowerShell breaks the command
text into a series of segments called _tokens_ and then determines how to
interpret each token.

For example, if you type:

```powershell
Write-Host book
```

PowerShell breaks the command into two tokens, `Write-Host` and `book`, and
interprets each token independently using one of two major parsing modes:
expression mode and argument mode.

> [!NOTE]
> As PowerShell parses command input it tries to resolve the command names to
> cmdlets or native executables. If a command name does not have an exact
> match, PowerShell prepends `Get-` to the command as a default verb. For
> example, PowerShell parses `Process` as `Get-Process`. It's not
> recommended to use this feature for the following reasons:
>
> - It's inefficient. This causes PowerShell to search multiple times.
> - External programs with the same name are resolved first, so you may not
>   execute intended cmdlet.
> - `Get-Help` and `Get-Command` don't recognize verb-less names.

### Expression mode

Expression mode is intended for combining expressions, required for value
manipulation in a scripting language. Expressions are representations of values
in PowerShell syntax, and can be simple or composite, for example:

Literal expressions are direct representations of their values: 

```powershell
'hello', 32
```

Variable expressions carry the value of the variable they reference: 

```powershell
$x, $script:path
```
Operators combine other expressions for evaluation: 

```powershell
- 12, -not $Quiet, 3 + 7, $input.Length -gt 1
```

- _Character string literals_ must be contained in quotation marks.
- _Numbers_ are treated as numerical values rather than as a series of
  characters (unless escaped).
- _Operators_, including unary operators like `-` and `-not` and binary
  operators like `+` and `-gt`, are interpreted as operators and apply their
  respective operations on their arguments (operands).
- _Attribute and conversion expressions_ are parsed as expressions and applied
  to subordinate expressions, e.g. `[int] '7'`.
- _Variable references_ are evaluated to their values but _splatting_ (i.e.
  pasting prefilled parameter sets) is forbidden and causes a parser error.
- Anything else will be treated as a command to be invoked.

### Argument mode

When parsing, PowerShell first looks to interpret input as an expression. But
when a command invocation is encountered, parsing continues in argument mode.

Argument mode is designed for parsing arguments and parameters for commands in
a shell environment. All input is treated as an expandable string unless it
uses one of the following syntaxes:

- Dollar sign (`$`) begins a variable reference (only if it is followed by a
  valid variable name, otherwise it is interpreted as part of the expandable
  string).
- Quotation marks (`'` and `"`) begin string values
- Parentheses (`(` and `)`) demarcate new expressions.
- Subexpression operator (`$(`…`)`) demarcates embedded expressions.
- Braces (`{` and `}`) demarcate new script blocks.
- Initial at sign (`@`) begins expression syntaxes such as splatting (`@args`),
  arrays (`@(1,2,3)`) and hash tables (`@{a=1;b=2}`).
- Commas (`,`) introduce lists passed as arrays, except when the command to be
  called is a native application, in which case they are interpreted as part of
  the expandable string. Initial, consecutive or trailing commas are not
  supported.

<!--
01234567890123456789012345678901234567890123456789012345678901234567890123456789
-->
Values of embedded expressions are converted to strings.

The following table provides several examples of values processed in expression
mode and argument mode and the evaluation of those values. We assume that the
value of the variable `a` is `4`.

|       Example        |    Mode    |      Result       |
| -------------------- | ---------- | ----------------- |
| `2`                  | Expression | 2 (integer)       |
| `` `2``              | Expression | "2" (command)     |
| `echo 2`             | Expression | 2 (integer)       |
| `2+2`                | Expression | 4 (integer)       |
| `echo 2+2`           | Argument   | "2+2" (string)    |
| `echo(2+2)`          | Expression | 4 (integer)       |
| `$a`                 | Expression | 4 (integer)       |
| `echo $a`            | Expression | 4 (integer)       |
| `$a+2`               | Expression | 6 (integer)       |
| `echo $a+2`          | Argument   | 4+2 (string)      |
| `$-`                 | Argument   | "$-" (command)    |
| `echo $-`            | Argument   | "$-" (string)     |
| `a$a`                | Expression | "a$a" (command)   |
| `echo a$a`           | Argument   | "a4" (string)     |
| `a'$a'`              | Expression | "a$a" (command)   |
| `echo a'$a'`         | Argument   | "a$a" (string)    |
| `a"$a"`              | Expression | "a$a" (command)   |
| `echo a"$a"`         | Argument   | "a4" (string)     |
| `a$(2)`              | Expression | "a$(2)" (command) |
| `echo a$(2)`         | Argument   | "a2" (string)     |

Every token can be interpreted as some kind of object type, such as Boolean or
string. PowerShell attempts to determine the object type from the expression.
The object type depends on the type of parameter a command expects and on
whether PowerShell knows how to convert the argument to the correct type. The
following table shows several examples of the types assigned to values returned
by the expressions.

|       Example          |    Mode    |     Result      |
| ---------------------- | ---------- | --------------- |
| `Write-Output !1`      | argument   | "!1" (string)   |
| `Write-Output (!1)`    | expression | False (Boolean) |
| `Write-Output (2)`     | expression | 2 (integer)     |
| `Set-Variable AB A,B`  | argument   | 'A','B' (array) |
| `CMD /CECHO A,B`       | argument   | 'A,B' (string)  |
| `CMD /CECHO $AB`       | expression | 'A','B' (array) |
| `CMD /CECHO :$AB`      | argument   | ':A B' (string) |

The stop-parsing symbol (`--%`), introduced in PowerShell 3.0, directs
PowerShell to refrain from interpreting input as PowerShell commands or
expressions.

When calling an executable program in PowerShell, place the stop-parsing symbol
before the program arguments. This technique is much easier than using escape
characters to prevent misinterpretation.

When it encounters a stop-parsing symbol, PowerShell treats the remaining
characters in the line as a literal. The only interpretation it performs is to
substitute values for environment variables that use standard Windows notation,
such as `%USERPROFILE%`.

The stop-parsing symbol is effective only until the next newline or pipeline
character. You cannot use a continuation character (`` ` ``) to extend its
effect or use a command delimiter (`;`) to terminate its effect.

For example, the following command calls the **Icacls** program.

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

PowerShell sends the following command string to the **Icacls** program:

`X:\VMS /grant Dom\HVAdmin:(CI)(OI)F`

> [!NOTE]
> The stop-parsing symbol only intended for use on Windows platforms.

## SEE ALSO

[about_Command_Syntax](about_Command_Syntax.md)
