---
description:  Describes a keyword that handles a terminating error. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_trap?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Trap
---
# About Trap

## Short description

Describes a keyword that handles a terminating error.

## Long description

A terminating error stops a statement from running. If PowerShell does not
handle a terminating error in some way, PowerShell also stops running the
function or script in the current pipeline. In other languages, such as C#,
terminating errors are known as exceptions.

The `trap` keyword specifies a list of statements to run when a terminating
error occurs. `trap` statements handle the terminating errors in the following
ways:

- Display the error after processing the `trap` statement block and continuing
  execution of the script or function containing the `trap`. This is the
  default behavior.

- Display the error and abort execution of the script or function containing
  the `trap` using `break` in the `trap` statement.

- Silence the error, but continue execution of the script or function
  containing the `trap` by using `continue` in the `trap` statement.

The statement list of the `trap` can include multiple conditions or function
calls. A `trap` can write logs, test conditions, or even run another program.

### Syntax

The `trap` statement has the following syntax:

```powershell
trap [[<error type>]] {<statement list>}
```

The `trap` statement includes a list of statements to run when a terminating
error occurs. A `trap` statement consists of the `trap` keyword, optionally
followed by a type expression, and the statement block containing the list of
statements to run when an error is trapped. The type expression refines the
types of errors the `trap` catches.

A script or command can have multiple `trap` statements. `trap` statements can
appear anywhere in the script or command.

### Trapping all terminating errors

When a terminating error occurs that is not handled in another way in a script
or command, PowerShell checks for a `trap` statement that handles the error. If
a `trap` statement is present, PowerShell continues running the script or
command in the `trap` statement.

The following example is a very simple `trap` statement:

```powershell
trap {"Error found."}
```

This `trap` statement traps any terminating error.

In the following example, the function includes a nonsense string that causes
a runtime error.

```powershell
function TrapTest {
    trap {"Error found."}
    nonsenseString
}

TrapTest
```

Running this function returns the following:

```Output
Error found.
nonsenseString : The term 'nonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At line:3 char:5
+     nonsenseString
+     ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (nonsenseString:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

The following example includes a `trap` statement that displays the error by
using the `$_` automatic variable:

```powershell
function TrapTest {
    trap {"Error found: $_"}
    nonsenseString
}

TrapTest
```

Running this version of the function returns the following:

```Output
Error found: The term 'nonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
nonsenseString : The term 'nonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At line:3 char:5
+     nonsenseString
+     ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (nonsenseString:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

> [!IMPORTANT]
> `trap` statements may be defined anywhere within a given scope, but always
> apply to all statements in that scope. At runtime, `trap` statements in a
> block are defined before any other statements are executed. In JavaScript,
> this is known as
> [hoisting](https://wikipedia.org/wiki/JavaScript_syntax#hoisting). This means
> that `trap` statements apply to all statements in that block even if
> execution has not advanced past the point at which they are defined. For
> example, defining a `trap` at the end of a script and throwing an error in
> the first statement still triggers that `trap`.

### Trapping specific errors

A script or command can have multiple `trap` statements. A `trap` can be
defined to handle specific errors.

The following example is a `trap` statement that traps the specific error
**CommandNotFoundException**:

```powershell
trap [System.Management.Automation.CommandNotFoundException]
    {"Command error trapped"}
```

When a function or script encounters a string that does not match a known
command, this `trap` statement displays the "Command error trapped" string.
After running the `trap` statement list, PowerShell writes the error object to
the error stream and then continues the script.

PowerShell uses .NET exception types. The following example specifies the
**System.Exception** error type:

```powershell
trap [System.Exception] {"An error trapped"}
```

The **CommandNotFoundException** error type inherits from the
**System.Exception** type. This statement traps an error that is created by an
unknown command. It also traps other error types.

You can have more than one `trap` statement in a script. Each error type can be
trapped by only one `trap` statement. When a terminating error occurs,
PowerShell searches for the `trap` with the most specific match, starting in
the current scope of execution.

The following script example contains an error. The script includes a general
`trap` statement that traps any terminating error and a specific `trap`
statement that specifies the **CommandNotFoundException** type.

```powershell
trap {"Other terminating error trapped" }
trap [System.Management.Automation.CommandNotFoundException] {
  "Command error trapped"
}
nonsenseString
```

Running this script produces the following result:

```Output
Command error trapped
nonsenseString : The term 'nonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At C:\Temp\traptest.ps1:5 char:1
+ nonsenseString
+ ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (nonsenseString:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

Because PowerShell does not recognize "nonsenseString" as a cmdlet or other
item, it returns a **CommandNotFoundException** error. This terminating error
is trapped by the specific `trap` statement.

The following script example contains the same `trap` statements with a
different error:

```powershell
trap {"Other terminating error trapped" }
trap [System.Management.Automation.CommandNotFoundException]
    {"Command error trapped"}
1/$null
```

Running this script produces the following result:

```Output
Attempted to divide by zero.
At C:\temp\traptest.ps1:4 char:1
+ 1/$null
+ ~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], RuntimeException
    + FullyQualifiedErrorId : RuntimeException
```

The attempt to divide by zero does not create a **CommandNotFoundException**
error. Instead, that error is trapped by the other `trap` statement, which traps
any terminating error.

### Trapping errors and scope

If a terminating error occurs in the same scope as the `trap` statement,
PowerShell runs the list of statements defined by the `trap`. Execution
continues at the statement after the error. If the `trap` statement is in a
different scope from the error, execution continues at the next statement that
is in the same scope as the `trap` statement.

For example, if an error occurs in a function, and the `trap` statement is in
the function, the script continues at the next statement. The following script
contains an error and a `trap` statement:

```powershell
function function1 {
    trap { "An error: " }
    NonsenseString
    "function1 was completed"
}

function1
```

Running this script produces the following result:

```Output
An error:
NonsenseString : The term 'NonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At line:3 char:5
+     NonsenseString
+     ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (NonsenseString:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

function1 was completed
```

The `trap` statement in the function traps the error. After displaying the
message, PowerShell resumes running the function. Note that `Function1` was
completed.

Compare this with the following example, which has the same error and `trap`
statement. In this example, the `trap` statement occurs outside the function:

```powershell
function function2 {
    NonsenseString
    "function2 was completed"
}

trap { "An error: " }

function2
```

Running the `Function2` function produces the following result:

```Output
An error:
NonsenseString : The term 'NonsenseString' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was
included, verify that the path is correct and try again.
At C:\temp\traptest.ps1:2 char:5
+     NonsenseString
+     ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (NonsenseString:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

In this example, the "function2 was completed" command was not run. In both
examples, the terminating error occurs within the function. In this example,
however, the `trap` statement is outside the function. PowerShell does not go
back into the function after the `trap` statement runs.

> [!CAUTION]
> When multiple traps are defined for the same error condition, the first `trap`
> defined lexically (highest in the scope) is used.

In the following example, only the `trap` with "whoops 1" is run.

```powershell
Remove-Item -ErrorAction Stop ThisFileDoesNotExist
trap { "whoops 1"; continue }
trap { "whoops 2"; continue }
```

> [!IMPORTANT]
> A Trap statement is scoped to where it compiles. If you have a
> `trap` statement inside a function or dot sourced script, when the function
> or dot sourced script exits, all `trap` statements inside are removed.

### Using the break and continue keywords

You can use the `break` and `continue` keywords in a `trap` statement to
determine whether a script or command continues to run after a terminating
error.

If you include a `break` statement in a `trap` statement list, PowerShell stops
the function or script. The following sample function uses the `break` keyword
in a `trap` statement:

```powershell
function break_example {
    trap {
        "Error trapped"
        break
    }
    1/$null
    "Function completed."
}

break_example
```

```Output
Error trapped
Attempted to divide by zero.
At line:6 char:5
+     1/$null
+     ~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : RuntimeException
```

Because the `trap` statement included the `break` keyword, the function does
not continue to run, and the "Function completed" line is not run.

If you include a `continue` keyword in a `trap` statement, PowerShell resumes
after the statement that caused the error, just as it would without `break` or
`continue`. With the `continue` keyword, however, PowerShell does not write an
error to the error stream.

The following sample function uses the `continue` keyword in a `trap`
statement:

```powershell
function continue_example {
    trap {
        "Error trapped"
        continue
    }
    1/$null
    "Function completed."
}

continue_example
```

```Output
Error trapped
Function completed.
```

The function resumes after the error is trapped, and the "Function completed"
statement runs. No error is written to the error stream.

## Notes

`trap` statements provide a simple way to broadly ensure all terminating errors
within a scope are handled. For more finer-grained error handling, use
`try`/`catch` blocks where traps are defined using `catch` statements. The
`catch` statements only apply to the code inside the associated `try`
statement. For more information, see [about_Try_Catch_Finally](about_Try_Catch_Finally.md).

## See also

[about_Break](about_Break.md)

[about_Continue](about_Continue.md)

[about_Scopes](about_Scopes.md)

[about_Throw](about_Throw.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)
