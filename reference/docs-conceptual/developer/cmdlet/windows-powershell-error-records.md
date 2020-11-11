---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Error Records
description: Windows PowerShell Error Records
---
# Windows PowerShell Error Records

Cmdlets must pass an
[System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)
object that identifies the error condition for terminating and non-terminating errors.

The
[System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)
object contains the following information:

- The exception that describes the error. Often, this is an exception that the cmdlet caught and
  converted into an error record. Every error record must contain an exception.

If the cmdlet did not catch an exception, it must create a new exception and choose the exception
class that best describes the error condition. However, you do not need to throw the exception
because it can be accessed through the
[System.Management.Automation.ErrorRecord.Exception](/dotnet/api/System.Management.Automation.ErrorRecord.Exception)
property of the
[System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)
object.

- An error identifier that provides a targeted designator that can be used for diagnostic purposes
  and by Windows PowerShell scripts to handle specific error conditions with specific error
  handlers. Every error record must contain an error identifier (see Error Identifier).

- An error category that provides a general designator that can be used for diagnostic purposes.
  Every error record must specify an error category (see Error Category).

- An optional replacement error message and a recommended action (see Replacement Error Message).

- Optional invocation information about the cmdlet that threw the error. This information is
  specified by Windows PowerShell (see Invocation Message).

- The target object that was being processed when the error occurred. This might be the input
  object, or it might be another object that your cmdlet was processing. For example, for the
  command `remove-item -recurse c:\somedirectory`, the error might be an instance of a FileInfo
  object for "c:\somedirectory\lockedfile". The target object information is optional.

## Error Identifier

When you create an error record, specify an identifier that designates the error condition within
your cmdlet. Windows PowerShell combines the targeted identifier with the name of your cmdlet to
create a fully qualified error identifier. The fully qualified error identifier can be accessed
through the
[System.Management.Automation.ErrorRecord.FullyQualifiedErrorId](/dotnet/api/System.Management.Automation.ErrorRecord.FullyQualifiedErrorId)
property of the
[System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)
object. The error identifier is not available by itself. It is available only as part of the fully
qualified error identifier.

Use the following guidelines to generate error identifiers when you create error records:

- Make error identifiers specific to an error condition. Target the error identifiers for diagnostic
  purposes and for scripts that handle specific error conditions with specific error handlers. A
  user should be able to use the error identifier to identify the error and its source. Error
  identifiers also enable reporting for specific error conditions from existing exceptions so that
  new exception subclasses are not required.

- In general, assign different error identifiers to different code paths. The end-user benefits from
  specific identifiers. Often, each code path that calls
  [System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)
  or
  [System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)
  has its own identifier. As a rule, define a new identifier when you define a new template string
  for the error message, and vice-versa. Do not use the error message as an identifier.

- When you publish code using a particular error identifier, you establish the semantics of errors
  with that identifier for your complete product support lifecycle. Do not reuse it in a context
  that is semantically different from the original context. If the semantics of this error change,
  create and then use a new identifier.

- You should generally use a particular error identifier only for exceptions of a particular CLR
  type. If the type of the exception or the type of the target object changes, create and then use a
  new identifier.

- Choose text for your error identifier that concisely corresponds to the error that you are
  reporting. Use standard .NET Framework naming and capitalization conventions. Do not use white
  space or punctuation. Do not localize error identifiers.

- Do not dynamically generate error identifiers in a non-reproducible way. For example, do not
  incorporate error information such as a process ID. Error identifiers are useful only if they
  correspond to the error identifiers seen by other users who are experiencing the same error
  condition.

## Error Category

When you create an error record, specify the category of the error using one of the constants
defined by the
[System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory)
enumeration. Windows PowerShell uses the error category to display error information when users set
the `$ErrorView` variable to `"CategoryView"`.

Avoid using the
[System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory)
**NotSpecified** constant. If you have any information about the error or about the operation that
caused the error, choose the category that best describes the error or the operation, even if the
category is not a perfect match.

The information displayed by Windows PowerShell is referred to as the category-view string and is
built from the properties of the
[System.Management.Automation.Errorcategoryinfo](/dotnet/api/System.Management.Automation.ErrorCategoryInfo)
class. (This class is accessed through the error
[System.Management.Automation.ErrorRecord.CategoryInfo](/dotnet/api/System.Management.Automation.ErrorRecord.CategoryInfo)
property.)

```
{Category}: ({TargetName}:{TargetType}):[{Activity}], {Reason}
```

The following list describes the information displayed:

- Category: A Windows PowerShell-defined
  [System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory)
  constant.

- TargetName: By default, the name of the object the cmdlet was processing when the error occurred.
  Or, another cmdlet-defined string.

- TargetType: By default, the type of the target object. Or, another cmdlet-defined string.

- Activity: By default, the name of the cmdlet that created the error record. Or, some other
  cmdlet-defined string.

- Reason: By default, the exception type. Or, another cmdlet-defined string.

## Replacement Error Message

When you develop an error record for a cmdlet, the default error message for the error comes from
the default message text in the [System.Exception.Message](/dotnet/api/System.Exception.Message)
property. This is a read-only property whose message text is intended only for debugging purposes
(according to the .NET Framework guidelines). We recommend that you create an error message that
replaces or augments the default message text. Make the message more user-friendly and more specific
to the cmdlet.

The replacement message is provided by an
[System.Management.Automation.ErrorDetails](/dotnet/api/System.Management.Automation.ErrorDetails)
object. Use one of the following constructors of this object because they provide additional
localization information that can be used by Windows PowerShell.

- [ErrorDetails(Cmdlet, String, String, Object[])](/dotnet/api/system.management.automation.errordetails.-ctor#System_Management_Automation_ErrorDetails__ctor_System_Management_Automation_Cmdlet_System_String_System_String_System_Object___):
  Use this constructor if your template string is a resource string in the same assembly in which
  the cmdlet is implemented or if you want to load the template string through an override of the
  [System.Management.Automation.Cmdlet.GetResourceString](/dotnet/api/System.Management.Automation.Cmdlet.GetResourceString)
  method.

- [ErrorDetails(Assembly, String, String, Object[])](/dotnet/api/system.management.automation.errordetails.-ctor#System_Management_Automation_ErrorDetails__ctor_System_Reflection_Assembly_System_String_System_String_System_Object___): Use this constructor if the template string is in another assembly and you do not load it through an override of [System.Management.Automation.Cmdlet.GetResourceString](/dotnet/api/System.Management.Automation.Cmdlet.GetResourceString).

The replacement message should conform to the .NET Framework design guidelines for writing exception
messages with a small difference. The guidelines state that exception messages should be written for
developers. These replacement messages should be written for the cmdlet user.

The replacement error message must be added before the
[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)
or
[System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)
methods are called. To add a replacement message, set the
[System.Management.Automation.ErrorRecord.ErrorDetails](/dotnet/api/System.Management.Automation.ErrorRecord.ErrorDetails)
property of the error record. When this property is set, Windows PowerShell displays the
[System.Management.Automation.ErrorDetails.Message*](/dotnet/api/System.Management.Automation.ErrorDetails.Message)
property instead of the default message text.

## Recommended Action Information

The
[System.Management.Automation.ErrorDetails](/dotnet/api/System.Management.Automation.ErrorDetails)
object can also provide information about what actions are recommended when the error occurs.

## Invocation information

When a cmdlet uses
[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)
or
[System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)
to report an error record, Windows PowerShell automatically adds information that describes the
command that was invoked when the error occurred. This information is provided by a
[System.Management.Automation.Invocationinfo](/dotnet/api/System.Management.Automation.InvocationInfo)
object that contains the name of the cmdlet that was invoked by the command, the command itself, and
information about the pipeline or script. This property is read-only.

## See Also

[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)

[System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)

[System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory)

[System.Management.Automation.Errorcategoryinfo](/dotnet/api/System.Management.Automation.ErrorCategoryInfo)

[System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord)

[System.Management.Automation.ErrorDetails](/dotnet/api/System.Management.Automation.ErrorDetails)

[System.Management.Automation.Invocationinfo](/dotnet/api/System.Management.Automation.InvocationInfo)

[Windows PowerShell Error Reporting](./error-reporting-concepts.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
