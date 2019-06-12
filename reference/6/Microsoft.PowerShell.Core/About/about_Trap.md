---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Trap
---
# About Trap

## SHORT DESCRIPTION
Describes a keyword that handles a terminating error.

## LONG DESCRIPTION

A terminating error stops a statement from running. If PowerShell
does not handle a terminating error in some way, PowerShell also
stops running the function or script in the current pipeline. In other
languages, such as C\#, terminating errors are referred to as exceptions.

The Trap keyword specifies a list of statements to run when a terminating
error occurs. Trap statements handle the terminating errors and allow
execution of the script or function to continue instead of stopping.

### SYNTAX

The Trap statement has the following syntax:

```powershell
trap [[<error type>]] {<statement list>}
```

The Trap statement includes a list of statements to run when a terminating
error occurs. The Trap keyword can optionally specify an error type. An
error type requires brackets.

A script or command can have multiple Trap statements. Trap statements can
appear anywhere in the script or command.

### TRAPPING ALL TERMINATING ERRORS

When a terminating error occurs that is not handled in another way in a
script or command, PowerShell checks for a Trap statement that
handles the error. If a Trap statement is present, PowerShell
continues running the script or command in the Trap statement.

The following example is a very simple Trap statement:

```powershell
trap {"Error found."}
```

This Trap statement traps any terminating error. The following example is a
function that contains this Trap statement:

```powershell
function TrapTest {
    trap {"Error found."}
    nonsenseString
    }
```

This function includes a nonsense string that causes an error. Running this
function returns the following:

```powershell
C:\PS> TrapTest
Error found.
```

The following example includes a Trap statement that displays the error by
using the `$_` automatic variable:

```powershell
function TrapTest {
    trap {"Error found: $_"}
    nonsenseString
}
```

Running this version of the function returns the following:

```powershell
C:\PS> TrapTest
Error found: The term 'nonsenseString' is not recognized as the name
of a cmdlet, function, script file, or operable program. Check the
spelling of the name, or if a path was included verify that the path
is correct, and then try again.
```

Trap statements can also be more complex. A Trap statement can include
multiple conditions or function calls. It can log, test, or even run
another program.

### TRAPPING SPECIFIED TERMINATING ERRORS

The following example is a Trap statement that traps the
CommandNotFoundException error type:

```powershell
trap [System.Management.Automation.CommandNotFoundException]
    {"Command error trapped"}
```

When a function or script encounters a string that does not match a known
command, this Trap statement displays the "Command error trapped" string.
After running any statements in the Trap statement list, PowerShell
writes the error object to the error stream and then continues the script.

PowerShell uses the Microsoft .NET Framework exception types. The
following example specifies the System.Exception error type:

```powershell
trap [System.Exception] {"An error trapped"}
```

The CommandNotFoundException error type inherits from the System.Exception
type. This statement traps an error that is created by an unknown command.
It also traps other error types.

You can have more than one Trap statement in a script. Each error can be
trapped by only one Trap statement. If an error occurs, and more than one
Trap statement is available, PowerShell uses the Trap statement
with the most specific error type that matches the error.

The following script example contains an error. The script includes a
general Trap statement that traps any terminating error and a specific Trap
statement that specifies the CommandNotFoundException type.

```powershell
trap {"Other terminating error trapped" }
trap [System.Management.Automation.CommandNotFoundException] {
  "Command error trapped"
}
nonsenseString
```

Running this script produces the following result:

```powershell
Command error trapped
The term 'nonsenseString' is not recognized as the name of a cmdlet,
function, script file, or operable program. Check the spelling of
the name, or if a path was included verify that the path is correct,
and then try again.
At C:\PS>testScript1.ps1:3 char:19
+     nonsenseString <<<<
```

Because PowerShell does not recognize "nonsenseString" as a cmdlet
or other item, it returns a CommandNotFoundException error. This
terminating error is trapped by the specific Trap statement.

The following script example contains the same Trap statements with a
different error:

```powershell
trap {"Other terminating error trapped" }
trap [System.Management.Automation.CommandNotFoundException]
    {"Command error trapped"}
1/$null
```

Running this script produces the following result:

```powershell
Other terminating error trapped
Attempted to divide by zero.
At C:PS> errorX.ps1:3 char:7
+     1/ <<<< $null
```

The attempt to divide by zero does not create a CommandNotFoundException
error. Instead, that error is trapped by the other Trap statement, which
traps any terminating error.

### TRAPPING ERRORS AND SCOPE

If a terminating error occurs in the same scope as the Trap statement,
after running the Trap statements, PowerShell continues at the
statement after the error. If the Trap statement is in a different scope
from the error, execution continues at the next statement that is in the
same scope as the Trap statement.

For instance, if an error occurs in a function, and the Trap statement is
in the function, the script continues at the next statement. For example,
the following script contains an error and a Trap statement:

```powershell
function function1 {
    trap { "An error: " }
    NonsenseString
    "function1 was completed"
    }
```

Later in the script, running the Function1 function produces the following
result:

```powershell
function1
An error:
The term 'NonsenseString' is not recognized as the name of a cmdlet,
function, script file, or operable program. Check the spelling of the
name, or if a path was included verify that the path is correct, and
then try again.
At C:\PS>TestScript1.ps1:3 char:19
+     NonsenseString <<<<

function1 was completed
```

The Trap statement in the function traps the error. After displaying the
message, PowerShell resumes running the function. Note that
Function1 was completed.

Compare this with the following example, which has the same error and Trap
statement. In this example, the Trap statement occurs outside the function:

```powershell
function function2 {
    NonsenseString
    "function2 was completed"
    }

trap { "An error: " }
    . . .
function2
```

Later in the script, running the Function2 function produces the following
result:

```powershell
An error:
The term 'NonsenseString' is not recognized as the name of a cmdlet,
function, script file, or operable program. Check the spelling of the
name, or if a path was included verify that the path is correct, and
then try again.
At C:\PS>TestScript2.ps1:4 char:19
+     NonsenseString <<<<
```

In this example, the "function2 was completed" command was not run.
Although both terminating errors occur within a function, if the Trap
statement is outside the function, PowerShell does not go back into
the function after the Trap statement runs.

### USING THE BREAK AND CONTINUE KEYWORDS

You can use the Break and Continue keywords in a Trap statement to
determine whether a script or command continues to run after a terminating
error.

If you include a Break statement in a Trap statement list, Windows
PowerShell stops the function or script. The following sample function uses
the Break keyword in a Trap statement:

```powershell
C:\PS> function break_example {
    trap {"Error trapped"; break;}
    1/$null
    "Function completed."
    }

C:\PS> break_example
Error trapped
Attempted to divide by zero.
At line:4 char:7
```

Because the Trap statement included the Break keyword, the function does
not continue to run, and the "Function completed" line is not run.

If you include a Continue statement in a Trap statement, PowerShell
resumes after the statement that caused the error, just as it would without
Break or Continue. With the Continue keyword, however, PowerShell
does not write an error to the error stream.

The following sample function uses the Continue keyword in a Trap
statement:

```powershell
C:\PS> function continue_example {
    trap {"Error trapped"; continue;}
    1/$null
    "Function completed."}

C:\PS> continue_example
Error trapped
Function completed.
```

The function resumes after the error is trapped, and the "Function
completed" statement runs. No error is written to the error stream.

## SEE ALSO

[about_Break](about_Break.md)

[about_Continue](about_Continue.md)

[about_Scopes](about_Scopes.md)

[about_Throw](about_Throw.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)