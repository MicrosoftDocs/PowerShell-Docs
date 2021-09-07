---
description: Describes how PowerShell parses commands.
Locale: en-US
ms.date: 09/07/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parsing?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Parsing
---
# about_Parsing

## Short description

Describes how PowerShell parses commands.

## Long description

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

## Expression mode

Expression mode is intended for combining expressions, required for value
manipulation in a scripting language. Expressions are representations of values
in PowerShell syntax, and can be simple or composite, for example:

Literal expressions are direct representations of their values:

```powershell
'hello'
32
```

Variable expressions carry the value of the variable they reference:

```powershell
$x
$script:path
```

Operators combine other expressions for evaluation:

```powershell
-12
-not $Quiet
3 + 7
$input.Length -gt 1
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

## Argument mode

When parsing, PowerShell first looks to interpret input as an expression. But
when a command invocation is encountered, parsing continues in argument mode.
If you have arguments that contain spaces, such as paths, then you must
enclose those argument values in quotes.

Argument mode is designed for parsing arguments and parameters for commands in
a shell environment. All input is treated as an expandable string unless it
uses one of the following syntaxes:

- Dollar sign (`$`) followed by a variable name begins a variable reference,
  otherwise it is interpreted as part of the expandable string. The variable
  reference can include member access or indexing.
  - Additional characters following simple variable references, such as
    `$HOME`, are considered part of the same argument. Enclose the variable
    name in braces (`{}`) to separate it from subsequent characters. For
    example, `${HOME}`.
  - When the variable reference include member access, the first of any
    additional characters is considered the start of a new argument. For
    example `$HOME.Length-more` results in two arguments: the value of
    `$HOME.Length` and string literal `-more`.

- Quotation marks (`'` and `"`) begin strings

- Braces (`{}`) begin a new script blocks

- Commas (`,`) introduce lists passed as arrays, except when the command to be
  called is a native application, in which case they are interpreted as part of
  the expandable string. Initial, consecutive or trailing commas are not
  supported.

- Parentheses (`()`) begin a new expression
- Subexpression operator (`$()`) begins an embedded expression
- Initial at sign (`@`) begins expression syntaxes such as splatting (`@args`),
  arrays (`@(1,2,3)`), and hash table literals (`@{a=1;b=2}`).
- `()`, `$()`, and `@()` at the start of a token create a new parsing context
  that can contain expressions or nested commands.
  - When followed by additional characters, the first additional character is
    considered the start of a new, separate argument.
  - When preceded by an unquoted literal `$()` works like an expandable string,
    `()` starts a new argument that is an expression, and `@()` is taken as
    literal `@` with `()` starting a new argument that is an expression.

- Everything else is treated as an expandable string, except
  metacharacters that still need escaping.
  - The argument-mode metacharacters (characters with special syntactic
    meaning) are: ``<space> ' " ` , ; ( ) { } | & < > @ #``. Of these, `< > @ #`
    are only special at the start of a token.

- The stop-parsing token (`--%`) changes the interpretation of all remaining
  arguments. For more information, see the
  [stop-parsing token](#the-stop-parsing-token) section below.

### Examples

The following table provides several examples of tokens processed in expression
mode and argument mode and the evaluation of those tokens. For these examples,
the value of the variable `$a` is `4`.

|       Example        |    Mode    |      Result       |
| -------------------- | ---------- | ----------------- |
| `2`                  | Expression | 2 (integer)       |
| `` `2``              | Expression | "2" (command)     |
| `Write-Output 2`     | Expression | 2 (integer)       |
| `2+2`                | Expression | 4 (integer)       |
| `Write-Output 2+2`   | Argument   | "2+2" (string)    |
| `Write-Output(2+2)`  | Expression | 4 (integer)       |
| `$a`                 | Expression | 4 (integer)       |
| `Write-Output $a`    | Expression | 4 (integer)       |
| `$a+2`               | Expression | 6 (integer)       |
| `Write-Output $a+2`  | Argument   | "4+2" (string)    |
| `$-`                 | Argument   | "$-" (command)    |
| `Write-Output $-`    | Argument   | "$-" (string)     |
| `a$a`                | Expression | "a$a" (command)   |
| `Write-Output a$a`   | Argument   | "a4" (string)     |
| `a'$a'`              | Expression | "a$a" (command)   |
| `Write-Output a'$a'` | Argument   | "a$a" (string)    |
| `a"$a"`              | Expression | "a$a" (command)   |
| `Write-Output a"$a"` | Argument   | "a4" (string)     |
| `a$(2)`              | Expression | "a$(2)" (command) |
| `Write-Output a$(2)` | Argument   | "a2" (string)     |

Every token can be interpreted as some kind of object type, such as **Boolean**
or **String**. PowerShell attempts to determine the object type from the
expression. The object type depends on the type of parameter a command expects
and on whether PowerShell knows how to convert the argument to the correct
type. The following table shows several examples of the types assigned to
values returned by the expressions.

|        Example        |    Mode    |     Result      |
| --------------------- | ---------- | --------------- |
| `Write-Output !1`     | argument   | "!1" (string)   |
| `Write-Output (!1)`   | expression | False (Boolean) |
| `Write-Output (2)`    | expression | 2 (integer)     |
| `Set-Variable AB A,B` | argument   | 'A','B' (array) |
| `CMD /CECHO A,B`      | argument   | 'A,B' (string)  |
| `CMD /CECHO $AB`      | expression | 'A B' (array)   |
| `CMD /CECHO :$AB`     | argument   | ':A B' (string) |

## Passing arguments to native commands

When running native commands from PowerShell, the arguments are first parsed
by PowerShell. The parsed arguments are then joined into a single string with
each parameter separated by a space.

For example, the following command calls the `icacls.exe` program.

```powershell
icacls X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

To run this command in PowerShell 2.0, you must use escape characters to
prevent PowerShell from misinterpreting the parentheses.

```powershell
icacls X:\VMS /grant Dom\HVAdmin:`(CI`)`(OI`)F
```

### The stop-parsing token

Beginning in PowerShell 3.0, you can use the stop-parsing token (`--%`) to
stop PowerShell from interpreting input asPowerShell commands or expressions.

> [!NOTE]
> The stop-parsing token is only intended for use on Windows platforms.

When calling a native command, place the stop-parsing token before the program
arguments. This technique is much easier than using escape characters to
prevent misinterpretation.

When it encounters a stop-parsing token, PowerShell treats the remaining
characters in the line as a literal. The only interpretation it performs is to
substitute values for environment variables that use standard Windows notation,
such as `%USERPROFILE%`.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

PowerShell sends the following command string to the `icacls.exe` program:

`X:\VMS /grant Dom\HVAdmin:(CI)(OI)F`

The stop-parsing token is effective only until the next newline or pipeline
character. You cannot use a continuation character (`` ` ``) to extend its
effect or use a command delimiter (`;`) to terminate its effect.

Other than `%variable%` environment-variable references, you cannot embed any
other dynamic elements in the command. Escaping a `%` character as `%%`, the
way you can do inside batch files, is not supported. `%<name>%` tokens are
invariably expanded. If `<name>` does not refer to a defined environment
variable the token is passed through as-is.

You cannot use stream redirection (like `>file.txt`) because they are passed
verbatim as arguments to the target command.

### Passing arguments that contain quote characters

Some native commands expect arguments that contain quote characters. Normally,
PowerShell's command line parsing removes the quote character you provided. The
parsed arguments are then joined into a single string with each parameter
separated by a space. This string is then assigned to the **Arguments**
property of a `ProcessStartInfo` object. Quotes within the string must be
escaped using extra quotes or backslash (`\`) characters.

> [!NOTE]
> The backslash (`\`) character is not recognized as an escape character by
> PowerShell. It is the escape character used by the underlying API for
> `ProcessStartInfo.Arguments`.

For more information about the escape requirements, see the documentation for
[ProcessStartInfo.Arguments](/dotnet/api/system.diagnostics.processstartinfo.arguments).

The following examples using the `TestExe.exe` tool. This tool is used by the
Pester tests in the PowerShell source repo. The goal of these examples is to
pass the directory path `"C:\Program Files (x86)\Microsoft\"` to a native
command so that it received the path as a quoted string.

The **echoargs** parameter of `TestExe` displays the values received as
arguments to the executable. You can use this tool to verify that you have
properly escaped the characters in your arguments.

```powershell
TestExe -echoargs """""${env:ProgramFiles(x86)}\Microsoft\\"""""
TestExe -echoargs """""C:\Program Files (x86)\Microsoft\\"""""
TestExe -echoargs "\""C:\Program Files (x86)\Microsoft\\"""
TestExe -echoargs --% "\"C:\Program Files (x86)\Microsoft\\"
TestExe -echoargs --% """C:\Program Files (x86)\Microsoft\\""
TestExe -echoargs --% """%ProgramFiles(x86)%\Microsoft\\""
```

The output is the same for all examples:

```Output
Arg 0 is <"C:\Program Files (x86)\Microsoft\">
```

You can build `TestExe` from the source code. See
[TestExe](https://github.com/PowerShell/PowerShell/blob/master/test/tools/TestExe/TestExe.cs).

## Experimental feature

Powershell 7.2 includes the **PSNativeCommandArgumentPassing** experimental
feature. When this experimental feature is enabled PowerShell uses the
**ArgumentList** property of the `StartProcessInfo` object rather than our
current mechanism of reconstructing a string when invoking a native executable.

For more information, see
[PSNativeCommandArgumentPassing](/powershell/scripting/learn/experimental-features#psnativecommandargumentpassing).

## See also

[about_Command_Syntax](about_Command_Syntax.md)
