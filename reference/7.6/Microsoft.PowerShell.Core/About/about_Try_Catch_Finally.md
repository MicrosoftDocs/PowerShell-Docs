---
description: Describes how to use the `try`, `catch`, and `finally` blocks to handle terminating errors.
Locale: en-US
ms.date: 01/07/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Try_Catch_Finally
---
# about_Try_Catch_Finally

## Short description

Describes how to use the `try`, `catch`, and `finally` blocks to handle
terminating errors.

## Long description

Use `try`, `catch`, and `finally` blocks to respond to or handle terminating
errors in scripts. The `Trap` statement can also be used to handle terminating
errors in scripts. For more information, see [about_Trap][05].

A terminating error stops a statement from running. If PowerShell does not
handle a terminating error in some way, PowerShell also stops running the
function or script using the current pipeline. In other languages, such as C\#,
terminating errors are referred to as exceptions.

Use the `try` block to define a section of a script in which you want
PowerShell to monitor for errors. When an error occurs within the `try` block,
the error is first saved to the `$Error` automatic variable. PowerShell then
searches for a `catch` block to handle the error. If the `try` statement does
not have a matching `catch` block, PowerShell continues to search for an
appropriate `catch` block or `Trap` statement in the parent scopes. After a
`catch` block is completed or if no appropriate `catch` block or `Trap`
statement is found, the `finally` block is run. If the error cannot be handled,
the error is written to the error stream.

A `catch` block can include commands for tracking the error or for recovering
the expected flow of the script. A `catch` block can specify which error types
it catches. A `try` statement can include multiple `catch` blocks for different
kinds of errors.

A `finally` block can be used to free any resources that are no longer needed
by your script.

`try`, `catch`, and `finally` resemble the `try`, `catch`, and `finally`
keywords used in the C\# programming language.

## Syntax

A `try` statement contains a `try` block, zero or more `catch` blocks, and zero
or one `finally` block. A `try` statement must have at least one `catch` block
or one `finally` block.

The following shows the `try` block syntax:

```powershell
try {<statement list>}
```

The `try` keyword is followed by a statement list in braces. If a terminating
error occurs while the statements in the statement list are being run, the
script passes the error object from the `try` block to an appropriate `catch`
block.

The following shows the `catch` block syntax:

```powershell
catch [[<error type>][',' <error type>]*] {<statement list>}
```

Error types appear in brackets. The outermost brackets indicate the element is
optional.

The `catch` keyword is followed by an optional list of error type
specifications and a statement list. If a terminating error occurs in the `try`
block, PowerShell searches for an appropriate `catch` block. If one is found,
the statements in the `catch` block are executed.

The `catch` block can specify one or more error types. An error type is a
Microsoft .NET Framework exception or an exception that is derived from a .NET
Framework exception. A `catch` block handles errors of the specified .NET
Framework exception class or of any class that derives from the specified
class.

If a `catch` block specifies an error type, that `catch` block handles that
type of error. If a `catch` block does not specify an error type, that `catch`
block handles any error encountered in the `try` block. A `try` statement can
include multiple `catch` blocks for the different specified error types.

The following shows the `finally` block syntax:

```powershell
finally {<statement list>}
```

The `finally` keyword is followed by a statement list that runs every time the
script is run, even if the `try` statement ran without error or an error was
caught in a `catch` statement.

Note that pressing <kbd>CTRL</kbd>+<kbd>C</kbd> stops the pipeline. Objects
that are sent to the pipeline will not be displayed as output. Therefore, if
you include a statement to be displayed, such as "Finally block has run", it
will not be displayed after you press <kbd>CTRL</kbd>+<kbd>C</kbd>, even if the
`finally` block ran.

## Catching errors

The following sample script shows a `try` block with a `catch` block:

```powershell
try { NonsenseString }
catch { "An error occurred." }
```

The `catch` keyword must immediately follow the `try` block or another `catch`
block.

PowerShell does not recognize "NonsenseString" as a cmdlet or other item.
Running this script returns the following result:

```Output
An error occurred.
```

When the script encounters "NonsenseString", it causes a terminating error. The
`catch` block handles the error by running the statement list inside the block.

## Using multiple catch statements

A `try` statement can have any number of `catch` blocks. For example, the
following script has a `try` block that downloads `MyDoc.doc`, and it contains
two `catch` blocks:

```powershell
try {
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile("http://www.contoso.com/MyDoc.doc","c:\temp\MyDoc.doc")
} catch [System.Net.WebException],[System.IO.IOException] {
    "Unable to download MyDoc.doc from http://www.contoso.com."
} catch {
    "An error occurred that could not be resolved."
}
```

The first `catch` block handles errors of the **System.Net.WebException** and
**System.IO.IOException** types. The second `catch` block does not specify an
error type. The second `catch` block handles any other terminating errors that
occur.

PowerShell matches error types by inheritance. A `catch` block handles errors
of the specified .NET Framework exception class or of any class that derives
from the specified class. The following example contains a `catch` block that
catches a "Command Not Found" error:

```powershell
catch [System.Management.Automation.CommandNotFoundException] {
    "Inherited Exception"
}
```

The specified error type, **CommandNotFoundException**, inherits from the
**System.SystemException** type. The following example also catches a Command
Not Found error:

```powershell
catch [System.SystemException] {"Base Exception" }
```

This `catch` block handles the "Command Not Found" error and other errors that
inherit from the **SystemException** type.

If you specify an error class and one of its derived classes, place the `catch`
block for the derived class before the `catch` block for the general class.

> [!NOTE]
> PowerShell wraps all exceptions in a **RuntimeException** type. Therefore,
> specifying the error type **System.Management.Automation.RuntimeException**
> behaves the same as an unqualified catch block.

## Using Traps in a Try Catch

When a terminating error occurs in a `try` block with a `Trap` defined within
the `try` block, even if there is a matching `catch` block, the `Trap`
statement takes control.

If a `Trap` exists at a higher block than the `try`, and there is no matching
`catch` block within the current scope, the `Trap` will take control, even if
any parent scope has a matching `catch` block.

## Accessing exception information

Within a `catch` block, the current error can be accessed using `$_`, which is
also known as `$PSItem`. The object is of type **ErrorRecord**.

```powershell
try { NonsenseString }
catch {
    Write-Host "An error occurred:"
    Write-Host $_
}
```

Running this script returns the following result:

```Output
An Error occurred:
The term 'NonsenseString' is not recognized as the name of a cmdlet, function,
script file, or operable program. Check the spelling of the name, or if a path
was included, verify that the path is correct and try again.
```

There are additional properties that can be accessed, such as
**ScriptStackTrace**, **Exception**, and **ErrorDetails**. For example, if we
change the script to the following:

```powershell
try { NonsenseString }
catch {
    Write-Host "An error occurred:"
    Write-Host $_.ScriptStackTrace
}
```

The result will be similar to:

```Output
An Error occurred:
at <ScriptBlock>, <No file>: line 2
```

## Freeing resources using finally

To free resources used by a script, add a `finally` block after the `try` and
`catch` blocks. The `finally` block statements run regardless of whether the
`try` block encounters a terminating error. PowerShell runs the `finally` block
before the script terminates or before the current block goes out of scope.

A `finally` block runs even if you use <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the
script. A `finally` block also runs if an Exit keyword stops the script from
within a `catch` block.

In the following example, the `try` block attempts to download a file to the
`c:\temp` folder. The `catch` blocks handle errors that occur during the
download. The `finally` block disposes of the `WebClient` object and removes
the temporary file if it exists.

```powershell
try {
    $wc = New-Object System.Net.WebClient
    $tempFile = "c:\temp\MyDoc.doc"
    $wc.DownloadFile("http://www.contoso.com/MyDoc.doc",$tempFile)
} catch [System.Net.WebException],[System.IO.IOException] {
    "Unable to download MyDoc.doc from http://www.contoso.com."
} catch {
    "An error occurred that could not be resolved."
} finally {
    $wc.Dispose()
    if (Test-Path $tempPath) { Remove-item $tempFile }
}
```

## See also

- [about_Break][01]
- [about_Continue][02]
- [about_Scopes][03]
- [about_Throw][04]
- [about_Trap][05]

<!-- link references -->
[01]: about_Break.md
[02]: about_Continue.md
[03]: about_Scopes.md
[04]: about_Throw.md
[05]: about_Trap.md
