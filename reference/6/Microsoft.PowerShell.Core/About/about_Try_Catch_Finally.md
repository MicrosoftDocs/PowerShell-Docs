---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Try_Catch_Finally
---

# About Try Catch Finally

## SHORT DESCRIPTION

Describes how to use the Try, Catch, and Finally blocks to handle
terminating errors.

## LONG DESCRIPTION

Use Try, Catch, and Finally blocks to respond to or handle terminating
errors in scripts. The Trap statement can also be used to handle
terminating errors in scripts. For more information, see about_Trap.

A terminating error stops a statement from running. If PowerShell
does not handle a terminating error in some way, PowerShell also
stops running the function or script using the current pipeline. In other
languages, such as C\#, terminating errors are referred to as exceptions.
For more information about errors, see about_Errors.

Use the Try block to define a section of a script in which you want Windows
PowerShell to monitor for errors. When an error occurs within the Try
block, the error is first saved to the $Error automatic variable. Windows
PowerShell then searches for a Catch block to handle the error. If the Try
statement does not have a matching Catch block, PowerShell
continues to search for an appropriate Catch block or Trap statement in the
parent scopes. After a Catch block is completed or if no appropriate Catch
block or Trap statement is found, the Finally block is run. If the error
cannot be handled, the error is written to the error stream.

A Catch block can include commands for tracking the failure or for
recovering the expected flow of the script. A Catch block can specify which
error types it catches. A Try statement can include multiple Catch blocks
for different kinds of errors.

A Finally block can be used to free any resources that are no longer needed
by your script.

Try, Catch, and Finally resemble the Try, Catch, and Finally keywords used
in the C\# programming language.

### SYNTAX

A Try statement contains a Try block, zero or more Catch blocks, and zero
or one Finally block. A Try statement must have at least one Catch block or
one Finally block.

The following shows the Try block syntax:

```powershell
try {<statement list>}
```

The Try keyword is followed by a statement list in braces. If a terminating
error occurs while the statements in the statement list are being run, the
script passes the error object from the Try block to an appropriate Catch
block.

The following shows the Catch block syntax:

```powershell
catch [[<error type>][',' <error type>]*] {<statement list>}
```

Error types appear in brackets. The outermost brackets indicate the element
is optional.

The Catch keyword is followed by an optional list of error type
specifications and a statement list. If a terminating error occurs in the
Try block, PowerShell searches for an appropriate Catch block. If
one is found, the statements in the Catch block are executed.

The Catch block can specify one or more error types. An error type is a
Microsoft .NET Framework exception or an exception that is derived from a
.NET Framework exception. A Catch block handles errors of the specified
.NET Framework exception class or of any class that derives from the
specified class.

If a Catch block specifies an error type, that Catch block handles that
type of error. If a Catch block does not specify an error type, that Catch
block handles any error encountered in the Try block. A Try statement can
include multiple Catch blocks for the different specified error types.

The following shows the Finally block syntax:

```powershell
finally {<statement list>}
```

The Finally keyword is followed by a statement list that runs every time
the script is run, even if the Try statement ran without error or an error
was caught in a Catch statement.

Note that pressing CTRL\+C stops the pipeline. Objects that are sent to the
pipeline will not be displayed as output. Therefore, if you include a
statement to be displayed, such as "Finally block has run", it will not be
displayed after you press CTRL\+C, even if the Finally block ran.

### CATCHING ERRORS

The following sample script shows a Try block with a Catch block:

```powershell
try { NonsenseString }
catch { "An error occurred." }
```

The Catch keyword must immediately follow the Try block or another Catch
block.

PowerShell does not recognize "NonsenseString" as a cmdlet or other
item. Running this script returns the following result:

```powershell
An error occurred.
```

When the script encounters "NonsenseString", it causes a terminating error.
The Catch block handles the error by running the statement list inside the
block.

### USING MULTIPLE CATCH STATEMENTS

A Try statement can have any number of Catch blocks. For example, the
following script has a Try block that downloads MyDoc.doc, and it contains
two Catch blocks:

```powershell
try
{
   $wc = new-object System.Net.WebClient
   $wc.DownloadFile("http://www.contoso.com/MyDoc.doc")
}
catch [System.Net.WebException],[System.IO.IOException]
{
    "Unable to download MyDoc.doc from http://www.contoso.com."
}
catch
{
    "An error occurred that could not be resolved."
}
```

The first Catch block handles errors of the System.Net.WebException and
System.IO.IOException types. The second Catch block does not specify an
error type. The second Catch block handles any other terminating errors
that occur.

PowerShell matches error types by inheritance. A Catch block
handles errors of the specified .NET Framework exception class or of any
class that derives from the specified class. The following example contains
a Catch block that catches a "Command Not Found" error:

```powershell
catch [System.Management.Automation.CommandNotFoundException]
{"Inherited Exception" }
```

The specified error type, CommandNotFoundException, inherits from the
System.SystemException type. The following example also catches a Command
Not Found error:

```powershell
catch [System.SystemException] {"Base Exception" }
```

This Catch block handles the "Command Not Found" error and other errors
that inherit from the SystemException type.

If you specify an error class and one of its derived classes, place the
Catch block for the derived class before the Catch block for the general
class.

### FREEING RESOURCES BY USING FINALLY

To free resources used by a script, add a Finally block after the Try and
Catch blocks. The Finally block statements run regardless of whether the
Try block encounters a terminating error. PowerShell runs the
Finally block before the script terminates or before the current block goes
out of scope.

A Finally block runs even if you use CTRL\+C to stop the script. A Finally
block also runs if an Exit keyword stops the script from within a Catch
block.

### SEE ALSO

[about_Break](about_Break.md)

[about_Continue](about_Continue.md)

[about_Scopes](about_Scopes.md)

[about_Throw](about_Throw.md)

[about_Trap](about_Trap.md)