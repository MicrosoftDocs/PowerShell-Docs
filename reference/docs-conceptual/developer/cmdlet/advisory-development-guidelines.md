---
ms.date: 09/13/2016
ms.topic: reference
title: Advisory Development Guidelines
description: Advisory Development Guidelines
---
# Advisory Development Guidelines

This section describes guidelines that you should consider to ensure good development and user experiences. Sometimes they might apply, and sometimes they might not.

## Design Guidelines

The following guidelines should be considered when designing cmdlets. When you find a Design guideline that applies to your situation, be sure to look at the Code guidelines for similar guidelines.

### Support an InputObject Parameter (AD01)

Because Windows PowerShell works directly with Microsoft .NET Framework objects, a .NET Framework object is often available that exactly matches the type the user needs to perform a particular operation. `InputObject` is the standard name for a parameter that takes such an object as input. For example, the sample **Stop-Proc** cmdlet in the [StopProc Tutorial](./stopproc-tutorial.md) defines an `InputObject` parameter of type Process that supports the input from the pipeline. The user can get a set of process objects, manipulate them to select the exact objects to stop, and then pass them to the **Stop-Proc** cmdlet directly.

### Support the Force Parameter (AD02)

Occasionally, a cmdlet needs to protect the user from performing a requested operation. Such a cmdlet should support a `Force` parameter to allow the user to override that protection if the user has permissions to perform the operation.

For example, the [Remove-Item](/powershell/module/microsoft.powershell.management/remove-item) cmdlet does not normally remove a read-only file. However, this cmdlet supports a `Force` parameter so a user can force removal of a read-only file. If the user already has permission to modify the read-only attribute, and the user removes the file, use of the `Force` parameter simplifies the operation. However, if the user does not have permission to remove the file, the `Force` parameter has no effect.

### Handle Credentials Through Windows PowerShell (AD03)

A cmdlet should define a `Credential` parameter to represent credentials. This parameter must be of type [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) and must be defined using a Credential attribute declaration. This support automatically prompts the user for the user name, for the password, or for both when a full credential is not supplied directly. For more information about the Credential attribute, see [Credential Attribute Declaration](./credential-attribute-declaration.md).

### Support Encoding Parameters (AD04)

If your cmdlet reads or writes text to or from a binary form, such as writing to or reading from a file in a filesystem, then your cmdlet has to have Encoding parameter that specifies how the text is encoded in the binary form.

### Test Cmdlets Should Return a Boolean (AD05)

Cmdlets that perform tests against their resources should return a [System.Boolean](/dotnet/api/System.Boolean) type to the pipeline so that they can be used in conditional expressions.

## Code Guidelines

The following guidelines should be considered when writing cmdlet code. When you find a guideline that applies to your situation, be sure to look at the Design guidelines for similar guidelines.

### Follow Cmdlet Class Naming Conventions (AC01)

By following standard naming conventions, you make your cmdlets more discoverable, and you help the user understand exactly what the cmdlets do. This practice is particularly important for other developers using Windows PowerShell because cmdlets are public types.

#### Define a Cmdlet in the Correct Namespace

You normally define the class for a cmdlet in a .NET Framework namespace that appends ".Commands" to the namespace that represents the product in which the cmdlet runs. For example, cmdlets that are included with Windows PowerShell are defined in the `Microsoft.PowerShell.Commands` namespace.

#### Name the Cmdlet Class to Match the Cmdlet Name

When you name the .NET Framework class that implements a cmdlet, name the class "*\<Verb>**\<Noun>**\<Command>*", where you replace the *\<Verb>* and *\<Noun>* placeholders with the verb and noun used for the cmdlet name. For example, the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet is implemented by a class called `GetProcessCommand`.

### If No Pipeline Input Override the BeginProcessing Method (AC02)

If your cmdlet does not accept input from the pipeline, processing should be implemented in the [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) method. Use of this method allows Windows PowerShell to maintain ordering between cmdlets. The first cmdlet in the pipeline always returns its objects before the remaining cmdlets in the pipeline get a chance to start their processing.

### To Handle Stop Requests Override the StopProcessing Method (AC03)

Override the [System.Management.Automation.Cmdlet.StopProcessing](/dotnet/api/System.Management.Automation.Cmdlet.StopProcessing) method so that your cmdlet can handle stop signal. Some cmdlets take a long time to complete their operation, and they let a long time pass between calls to the Windows PowerShell runtime, such as when the cmdlet blocks the thread in long-running RPC calls. This includes cmdlets that make calls to the [System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) method, to the [System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) method, and to other feedback mechanisms that may take a long time to complete. For these cases the user might need to send a stop signal to these cmdlets.

### Implement the IDisposable Interface (AC04)

If your cmdlet has objects that are not disposed of (written to the pipeline) by the [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method, your cmdlet might require additional object disposal. For example, if your cmdlet opens a file handle in its [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) method and keeps the handle open for use by the [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method, this handle has to be closed at the end of processing.

The Windows PowerShell runtime does not always call the  [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) method. For example, the [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) method might not be called if the cmdlet is canceled midway through its operation or if a terminating error occurs in any part of the cmdlet. Therefore, the .NET Framework class for a cmdlet that requires object cleanup should implement the complete  [System.IDisposable](/dotnet/api/System.IDisposable) interface pattern, including the finalizer, so that the Windows PowerShell runtime can call both the [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) and [System.IDisposable.Dispose*](/dotnet/api/System.IDisposable.Dispose) methods at the end of processing.

### Use Serialization-friendly Parameter Types (AC05)

To support running your cmdlet on remote computers, use types that can be easily serialized on the client computer and then rehydrated on the server computer. The follow types are serialization-friendly.

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

When handling sensitive data always use the [System.Security.Securestring](/dotnet/api/System.Security.SecureString) data type. This could include pipeline input to parameters, as well as returning sensitive data to the pipeline.

## See Also

[Required Development Guidelines](./required-development-guidelines.md)

[Strongly Encouraged Development Guidelines](./strongly-encouraged-development-guidelines.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
