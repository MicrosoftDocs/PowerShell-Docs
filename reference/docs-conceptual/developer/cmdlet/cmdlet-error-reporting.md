---
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Error Reporting
description: Cmdlet Error Reporting
---

# Cmdlet error reporting

Cmdlets should report errors differently depending on whether the errors are terminating errors or
nonterminating errors. Terminating errors are errors that cause the pipeline to be terminated
immediately, or errors that occur when there's no reason to continue processing. Nonterminating
errors are those errors that report a current error condition, but the cmdlet can continue to
process input objects. With nonterminating errors, the user is typically notified of the problem,
but the cmdlet continues to process the next input object.

## Terminating and nonterminating errors

The following guidelines can be used to determine if an error condition is a terminating error or a
nonterminating error.

- Does the error condition prevent your cmdlet from successfully processing any further input
  objects? If so, this is a terminating error.

- Is the error condition related to a specific input object or a subset of input objects? If so,
  this is a nonterminating error.

- Does the cmdlet accept multiple input objects, such that processing may succeed on another input
  object? If so, this is a nonterminating error.

- Cmdlets that can accept multiple input objects should decide between what are terminating and
  nonterminating errors, even when a particular situation applies to only a single input object.

- Cmdlets can receive any number of input objects and send any number of success or error objects
  before throwing a terminating exception. There's no relationship between the number of input
  objects received and the number of success and error objects sent.

- Cmdlets that can accept only 0-1 input objects and generate only 0-1 output objects should treat
  errors as terminating errors and generate terminating exceptions.

## Reporting nonterminating errors

The reporting of a nonterminating error should always be done within the cmdlet's implementation of
the
[System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing)
method, the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method, or the
[System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing)
method. These types of errors are reported by calling the
[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)
method that in turn sends an error record to the error stream.

## Reporting terminating errors

Terminating errors are reported by throwing exceptions or by calling the
[System.Management.Automation.Cmdlet.ThrowTerminatingError](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)
method. Be aware that cmdlets can also catch and rethrow exceptions such as **OutOfMemory**,
however, they aren't required to rethrow exceptions as the PowerShell runtime will catch them as
well.

You can also define your own exceptions for issues specific to your situation, or add additional
information to an existing exception using its error record.

## Error records

PowerShell describes a nonterminating error condition with [System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)
objects. Each object provides error category information, an optional target object, and details
about the error condition.

### Error identifiers

The error identifier is a simple string that identifies the error condition within the cmdlet.
PowerShell combines this identifier with a cmdlet identifier to create a fully qualified error
identifier that can be used later when filtering error streams or logging errors, when responding to
specific errors, or with other user-specific activities.

The following guidelines should be followed when specifying error identifiers:

- Assign different, highly specific, error identifiers to different code paths. Each code path that
  calls
  [System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)
  or
  [System.Management.Automation.Cmdlet.ThrowTerminatingError](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)
  should have its own error identifier.

- Error identifiers should be unique to Common Language Runtime (CLR) exception types for both
  terminating and nonterminating errors.

- Don't change the semantics of an error identifier between versions of your cmdlet or PowerShell
  provider. After the semantics of an error identifier is established, it should remain constant
  throughout the lifecycle of your cmdlet.

- For terminating errors, use a unique error identifier for a particular CLR exception type. If the
  exception type changes, use a new error identifier.

- For nonterminating errors, use a specific error identifier for a specific input object.

- Choose text for the identifier that tersely corresponds to the error being reported. Don't use
  white space or punctuation.

- Don't generate error identifiers that aren't reproducible. For example, don't generate identifiers
  that include a process identifier. Error identifiers are useful only when they correspond to
  identifiers that are seen by other users who are experiencing the same problem.

### Error categories

Error categories are used to group errors for the user. PowerShell defines these categories and
cmdlets and PowerShell providers must choose between them when generating the error record.

For a description of the error categories that are available, see the [System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory)
enumeration. In general, you should avoid using **NoError**, **UndefinedError**, and
**GenericError** whenever possible.

Users can view errors based on category when they set `$ErrorView` to **CategoryView**.

## See also

[Cmdlet Overview](./cmdlet-overview.md)

[Types of Cmdlet Output](./types-of-cmdlet-output.md)

[Windows PowerShell Reference](../windows-powershell-reference.md)
