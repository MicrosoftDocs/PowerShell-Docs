---
description: Advisory Development Guidelines
ms.date: 05/22/2025
title: Advisory Development Guidelines
---
# Advisory Development Guidelines

This section describes guidelines that you should consider to ensure good development and user
experiences. Sometimes they might apply, and sometimes they might not.

## Design Guidelines

The following guidelines should be considered when designing cmdlets. When you find a Design
guideline that applies to your situation, be sure to look at the Code guidelines for similar
guidelines.

### Support an InputObject Parameter (AD01)

Because Windows PowerShell works directly with Microsoft .NET Framework objects, a .NET Framework
object is often available that exactly matches the type the user needs to perform a particular
operation. `InputObject` is the standard name for a parameter that takes such an object as input.
For example, the sample `Stop-Proc` cmdlet in the [StopProc Tutorial][03] defines an `InputObject`
parameter of type Process that supports the input from the pipeline. The user can get a set of
process objects, manipulate them to select the exact objects to stop, and then pass them to the
`Stop-Proc` cmdlet directly.

### Support the Force Parameter (AD02)

Occasionally, a cmdlet needs to protect the user from performing a requested operation. Such a
cmdlet should support a **Force** parameter to allow the user to override that protection if the
user has permissions to perform the operation.

For example, the [Remove-Item][18] cmdlet doesn't normally remove a read-only file. However, this
cmdlet supports a **Force** parameter so a user can force removal of a read-only file. If the user
already has permission to modify the read-only attribute, and the user removes the file, use of the
**Force** parameter simplifies the operation. However, if the user doesn't have permission to remove
the file, the **Force** parameter has no effect.

### Handle Credentials Through Windows PowerShell (AD03)

A cmdlet should define a `Credential` parameter to represent credentials. This parameter must be of
type [System.Management.Automation.PSCredential][15] and must be defined using a Credential
attribute declaration. This support automatically prompts the user for the user name, for the
password, or for both when a full credential isn't supplied directly. For more information about the
Credential attribute, see [Credential Attribute Declaration][01].

### Support Encoding Parameters (AD04)

If your cmdlet reads or writes text to or from a binary form, such as writing to or reading from a
file in a filesystem, then your cmdlet has to have Encoding parameter that specifies how the text is
encoded in the binary form.

### Test Cmdlets Should Return a Boolean (AD05)

Cmdlets that perform tests against their resources should return a [System.Boolean][06] type to the
pipeline so that they can be used in conditional expressions.

## Code Guidelines

The following guidelines should be considered when writing cmdlet code. When you find a guideline
that applies to your situation, be sure to look at the Design guidelines for similar guidelines.

### Follow Cmdlet Class Naming Conventions (AC01)

By following standard naming conventions, you make your cmdlets more discoverable, and you help the
user understand exactly what the cmdlets do. This practice is particularly important for other
developers using Windows PowerShell because cmdlets are public types.

#### Define a Cmdlet in the Correct Namespace

You normally define the class for a cmdlet in a .NET Framework namespace that appends `.Commands` to
the namespace that represents the product in which the cmdlet runs. For example, cmdlets that are
included with Windows PowerShell are defined in the `Microsoft.PowerShell.Commands` namespace.

#### Name the Cmdlet Class to Match the Cmdlet Name

When you name the .NET Framework class that implements a cmdlet, name the class
`<Verb><Noun>Command`, where you replace the `<Verb>` and `<Noun>` placeholders with the verb and
noun used for the cmdlet name. For example, the [Get-Process][17] cmdlet is implemented by a class
called `GetProcessCommand`.

### If No Pipeline Input Override the BeginProcessing Method (AC02)

If your cmdlet doesn't accept input from the pipeline, processing should be implemented in the
[System.Management.Automation.Cmdlet.BeginProcessing][09] method. Use of this method allows Windows
PowerShell to maintain ordering between cmdlets. The first cmdlet in the pipeline always returns its
objects before the remaining cmdlets in the pipeline get a chance to start their processing.

### To Handle Stop Requests Override the StopProcessing Method (AC03)

Override the [System.Management.Automation.Cmdlet.StopProcessing][12] method so that your cmdlet can
handle stop signal. Some cmdlets take a long time to complete their operation, and they let a long
time pass between calls to the Windows PowerShell runtime, such as when the cmdlet blocks the thread
in long-running RPC calls. This includes cmdlets that make calls to the
[System.Management.Automation.Cmdlet.WriteObject][14] method, to the
[System.Management.Automation.Cmdlet.WriteError][13] method, and to other feedback mechanisms that
may take a long time to complete. For these cases the user might need to send a stop signal to these
cmdlets.

### Implement the IDisposable Interface (AC04)

If your cmdlet has objects that aren't disposed of (written to the pipeline) by the
[System.Management.Automation.Cmdlet.ProcessRecord][11] method, your cmdlet might require additional
object disposal. For example, if your cmdlet opens a file handle in its
[System.Management.Automation.Cmdlet.BeginProcessing][09] method and keeps the handle open for use
by the [System.Management.Automation.Cmdlet.ProcessRecord][11] method, this handle has to be closed
at the end of processing.

The Windows PowerShell runtime doesn't always call the
[System.Management.Automation.Cmdlet.EndProcessing][10] method. For example, the
[System.Management.Automation.Cmdlet.EndProcessing][10] method might not be called if the cmdlet is
canceled midway through its operation or if a terminating error occurs in any part of the cmdlet.
Therefore, the .NET Framework class for a cmdlet that requires object cleanup should implement the
complete [System.IDisposable][07] interface pattern, including the finalizer, so that the Windows
PowerShell runtime can call both the [System.Management.Automation.Cmdlet.EndProcessing][10] and
[System.IDisposable.Dispose*][08] methods at the end of processing.

### Use Serialization-friendly Parameter Types (AC05)

To support running your cmdlet on remote computers, use types that can be serialized on the client
computer and then rehydrated on the server computer. The follow types are serialization-friendly.

Primitive types:

- Byte, SByte, Decimal, Single, Double, Int16, Int32, Int64, Uint16, UInt32, and UInt64.
- Boolean, Guid, Byte[], TimeSpan, DateTime, Uri, and Version.
- Char, String, XmlDocument.

Built-in rehydratable types:

- PSPrimitiveDictionary
- SwitchParameter
- PSListModifier
- PSCredential
- IPAddress, MailAddress
- CultureInfo
- X509Certificate2, X500DistinguishedName
- DirectorySecurity, FileSecurity, RegistrySecurity

Other types:

- SecureString
- Containers (lists and dictionaries of the above type)

### Use SecureString for Sensitive Data (AC06)

When handling sensitive data always use the [System.Security.SecureString][16] data type. This could
include pipeline input to parameters, as well as returning sensitive data to the pipeline.

While .NET recommends against using **SecureString** for new development, PowerShell continues to
support the **SecureString** class for backward compatibility. Using a **SecureString** is still
more secure than using a plain text string. PowerShell still relies on the **SecureString** type to
avoid accidentally exposing the contents to the console or in logs. Use **SecureString** carefully,
because it can be easily converted to a plain text string. For a full discussion about using
**SecureString**, see the [System.Security.SecureString class][01] documentation.

## See Also

[Required Development Guidelines][02]

[Strongly Encouraged Development Guidelines][04]

[Writing a Windows PowerShell Cmdlet][05]

<!-- link references -->
[01]: ./credential-attribute-declaration.md
[02]: ./required-development-guidelines.md
[03]: ./stopproc-tutorial.md
[04]: ./strongly-encouraged-development-guidelines.md
[05]: ./writing-a-windows-powershell-cmdlet.md
[06]: xref:System.Boolean
[07]: xref:System.IDisposable
[08]: xref:System.IDisposable.Dispose
[09]: xref:System.Management.Automation.Cmdlet.BeginProcessing
[10]: xref:System.Management.Automation.Cmdlet.EndProcessing
[11]: xref:System.Management.Automation.Cmdlet.ProcessRecord
[12]: xref:System.Management.Automation.Cmdlet.StopProcessing
[13]: xref:System.Management.Automation.Cmdlet.WriteError%2A
[14]: xref:System.Management.Automation.Cmdlet.WriteObject%2A
[15]: xref:System.Management.Automation.PSCredential
[16]: xref:System.Security.SecureString
[17]: xref:Microsoft.PowerShell.Management.Get-Process
[18]: xref:Microsoft.PowerShell.Management.Remove-Item
