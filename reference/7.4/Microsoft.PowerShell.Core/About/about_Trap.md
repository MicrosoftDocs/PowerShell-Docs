---
description: Describes a keyword that handles a terminating error.
Locale: en-US
ms.date: 07/05/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_trap?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Trap
---
# about_Trap

## Short description

Describes a keyword that handles a terminating error.

## Long description

A terminating error stops a statement from running. If PowerShell doesn't
handle a terminating error in some way, PowerShell also stops running the
function or script in the current pipeline. In other languages, such as C#,
terminating errors are known as exceptions.

The `trap` keyword specifies a list of statements to run when a terminating
error occurs. `trap` statements can handle the terminating errors in the
following ways:

- Display the error after processing the `trap` statement block and continuing
  execution of the script or function containing the `trap`. This behavior is
  the default.

  > [!NOTE]
  > When the terminating error occurs in a subordinate script block, such as
  > an `if` statement or `foreach` loop, the statements in the `trap` block are
  > run and execution continues at the next statement outside the subordinate
  > script block.

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

When a terminating error occurs that isn't handled in another way in a script
or command, PowerShell checks for a `trap` statement that handles the error. If
a `trap` statement is present, PowerShell continues running the script or
command in the `trap` statement.

The following example is a minimal `trap` statement:

```powershell
trap { 'Error found.' }
```

This `trap` statement traps any terminating error.

In the following example, the function includes a nonsense string that causes
a runtime error.

```powershell
function TrapTest {
    trap { 'Error found.' }
    nonsenseString
}

TrapTest
```

Running this function returns the following output:

```Output
Error found.
nonsenseString:
Line |
   3 |      nonsenseString
     |      ~~~~~~~~~~~~~~
     | The term 'nonsenseString' is not recognized as a name of a cmdlet,
function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the
path is correct and try again.
```

The following example includes a `trap` statement that displays the error by
using the `$_` automatic variable:

```powershell
function TrapTest {
    trap { "Error found: $_" }
    nonsenseString
}

TrapTest
```

Running this version of the function returns the following output:

```Output
Error found: The term 'nonsenseString' is not recognized as the name of a
cmdlet, function, script file, or operable program. Check the spelling of
the name, or if a path was included, verify that the path is correct and
try again.
nonsenseString:
Line |
   3 |      nonsenseString
     |      ~~~~~~~~~~~~~~
     | The term 'nonsenseString' is not recognized as a name of a cmdlet,
function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the
path is correct and try again.
```

> [!IMPORTANT]
> `trap` statements may be defined anywhere within a given script block, but
> always apply to all statements in that script block. At runtime, `trap`
> statements in a block are defined before any other statements are executed.
> In JavaScript, this is known as
> [hoisting](https://wikipedia.org/wiki/JavaScript_syntax#hoisting). This means
> that `trap` statements apply to all statements in that block even if
> execution hasn't advanced past the point at which they're defined. For
> example, defining a `trap` at the end of a script and throwing an error in
> the first statement still triggers that `trap`.

### Trapping specific errors

A script or command can have multiple `trap` statements. A `trap` can be
defined to handle specific errors.

The following example is a `trap` statement that traps the specific error
**CommandNotFoundException**:

```powershell
trap [System.Management.Automation.CommandNotFoundException] {
    'Command error trapped'
}
```

When a function or script encounters a string that doesn't match a known
command, this `trap` statement displays the `Command error trapped` string.
After running the `trap` statement list, PowerShell writes the error object to
the error stream and then continues the script.

PowerShell uses .NET exception types. The following example specifies the
**System.Exception** error type:

```powershell
trap [System.Exception] { 'An error trapped' }
```

The **CommandNotFoundException** error type inherits from the
**System.Exception** type. This statement traps any errors raised by unknown
commands. It also traps other error types.

You can find the exception type for an error by inspecting the error object.
The following example shows how to get the full name of the exception for the
last error in a session:

```powershell
nonsenseString
$Error[0].Exception.GetType().FullName
```

```Output
nonsenseString: The term 'nonsenseString' is not recognized as a name of a
cmdlet, function, script file, or executable program. Check the spelling
of the name, or if a path was included, verify that the path is correct
and try again.

System.Management.Automation.CommandNotFoundException
```

You can have more than one `trap` statement in a script. Only one `trap`
statement can trap each error type. When a terminating error occurs, PowerShell
searches for the `trap` with the most specific match, starting in the current
script block of execution.

The following script example contains an error. The script includes a general
`trap` statement that traps any terminating error and a specific `trap`
statement that specifies the **CommandNotFoundException** type.

```powershell
trap { 'Other terminating error trapped' }
trap [System.Management.Automation.CommandNotFoundException] {
  'Command error trapped'
}
nonsenseString
```

Running this script produces the following result:

```Output
Command error trapped
nonsenseString:
Line |
   5 |      nonsenseString
     |      ~~~~~~~~~~~~~~
     | The term 'nonsenseString' is not recognized as a name of a cmdlet,
function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the
path is correct and try again.
```

Because PowerShell doesn't recognize `nonsenseString` as a cmdlet or other
item, it returns a **CommandNotFoundException** error. The specific `trap`
statement traps this terminating error.

The following script example contains the same `trap` statements with a
different error:

```powershell
trap { 'Other terminating error trapped' }
trap [System.Management.Automation.CommandNotFoundException] {
    'Command error trapped'
}
1/$null
```

Running this script produces the following result:

```Output
Other terminating error trapped
RuntimeException:
Line |
   5 |  1/$null
     |  ~~~~~~~
     | Attempted to divide by zero.
```

The attempt to divide by zero doesn't create a **CommandNotFoundException**
error. The other `trap` statement, which traps any terminating error, traps the
divide by zero error.

### Trapping errors in a script block

By default, when a terminating error is thrown, execution transfers to the trap
statement. After the `trap` block is run, control returns to the next statement
block after the location of the error.

For example, when a terminating error occurs in an `foreach` statement, the
`trap` statement is run and execution continues at the next statement after the
`foreach` block, not within the `foreach` block.

```powershell
trap { 'An error occurred!'}
foreach ($x in 3..-1) {
       "1/$x = "
       "`t$(1/$x)"
}
'after loop'
```

```Output
1/3 =
        0.333333333333333
1/2 =
        0.5
1/1 =
        1
1/0 =
An error occurred!
RuntimeException:
Line |
   4 |         "`t$(1/$x)"
     |              ~~~~
     | Attempted to divide by zero.
after loop
```

In the output, you can see the loops continue until the last iteration. When
the script tries to divide 1 by 0, PowerShell throws a terminating error. The
script skips the rest of the `foreach` script block, runs the `try` statement,
and continues after the `foreach` script block.

### Trapping errors and scope

If a terminating error occurs in the same script block as the `trap` statement,
PowerShell runs the list of statements defined by the `trap`. Execution
continues at the statement after the error. If the `trap` statement is in a
different script block from the error, execution continues at the next
statement that's in the same script block as the `trap` statement.

For example, if an error occurs in a function, and the `trap` statement is in
the function, the script continues at the next statement. The following script
contains an error and a `trap` statement:

```powershell
function function1 {
    trap { 'An error: ' }
    NonsenseString
    'function1 was completed'
}

function1
```

Running this script produces the following result:

```Output
An error:
NonsenseString:
Line |
   3 |      NonsenseString
     |      ~~~~~~~~~~~~~~
     | The term 'NonsenseString' is not recognized as a name of a cmdlet,
function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the
path is correct and try again.
function1 was completed
```

The `trap` statement in the function traps the error. After displaying the
message, PowerShell resumes running the function. Notice that `Function1`
completed after the `trap` statement.

Compare this behavior with the following example, which has the same error and
`trap` statement. In this example, the `trap` statement occurs outside the
function:

```powershell
function function2 {
    NonsenseString
    'function2 was completed'
}

trap { 'An error:' }

function2
```

Running the `Function2` function produces the following result:

```Output
An error:
NonsenseString:
Line |
   2 |      NonsenseString
     |      ~~~~~~~~~~~~~~
     | The term 'NonsenseString' is not recognized as a name of a cmdlet,
function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the
path is correct and try again.
```

In this example, the `function2 was completed` command wasn't run. In both
examples, the terminating error occurs within the function. In this example,
however, the `trap` statement is outside the function. PowerShell doesn't go
back into the function after the `trap` statement runs.

> [!CAUTION]
> When multiple traps are defined for the same error condition, the first `trap`
> defined lexically (highest in the script block) is used.

In the following example, only the `trap` with `whoops 1` runs.

```powershell
Remove-Item -ErrorAction Stop ThisFileDoesNotExist
trap { 'whoops 1'; continue }
trap { 'whoops 2'; continue }
```

> [!IMPORTANT]
> A `trap` statement is scoped to where it compiles. If you have a `trap`
> statement inside a function or dot sourced script, when the function or dot
> sourced script exits, all `trap` statements inside are removed.

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
        'Error trapped'
        break
    }
    1/$null
    'Function completed.'
}

break_example
```

```Output
Error trapped
ParentContainsErrorRecordException:
Line |
   6 |      1/$null
     |      ~~~~~~~
     | Attempted to divide by zero.
```

Because the `trap` statement included the `break` keyword, the function doesn't
continue to run, and the `Function completed` line isn't run.

If you include a `continue` keyword in a `trap` statement, PowerShell resumes
after the statement that caused the error, just as it would without `break` or
`continue`. With the `continue` keyword, however, PowerShell doesn't write an
error to the error stream.

The following sample function uses the `continue` keyword in a `trap`
statement:

```powershell
function ContinueExample {
    trap {
        'Error trapped'
        continue
    }
    foreach ($x in 3..-1) {
       "1/$x = "
       "`t$(1/$x)"
    }
    'End of function'
}

ContinueExample
```

```Output
1/3 =
        0.333333333333333
1/2 =
        0.5
1/1 =
        1
1/0 =
Error trapped
End of function
```

The function resumes after the error is trapped, and the `End of function`
statement runs. No error is written to the error stream.

## Notes

`trap` statements provide a way to ensure all terminating errors within a
script block are handled. For more finer-grained error handling, use
`try`/`catch` blocks where traps are defined using `catch` statements. The
`catch` statements only apply to the code inside the associated `try`
statement. For more information, see
[about_Try_Catch_Finally](about_Try_Catch_Finally.md).

## See also

- [about_Break](about_Break.md)
- [about_Continue](about_Continue.md)
- [about_Scopes](about_Scopes.md)
- [about_Throw](about_Throw.md)
- [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
