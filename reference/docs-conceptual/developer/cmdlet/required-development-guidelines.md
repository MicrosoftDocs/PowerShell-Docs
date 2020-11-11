---
ms.date: 09/13/2016
ms.topic: reference
title: Required Development Guidelines
description: Required Development Guidelines
---
# Required Development Guidelines

The following guidelines must be followed when you write your cmdlets. They are separated into guidelines for designing cmdlets and guidelines for writing your cmdlet code. If you do not follow these guidelines, your cmdlets could fail, and your users might have a poor experience when they use your cmdlets.

## In this Topic

### Design Guidelines

- [Use Only Approved Verbs (RD01)](./required-development-guidelines.md#use-only-approved-verbs-rd01)

- [Cmdlet Names: Characters that cannot be Used (RD02)](./required-development-guidelines.md#cmdlet-names-characters-that-cannot-be-used-rd02)

- [Parameters Names that cannot be Used (RD03)](./required-development-guidelines.md#parameters-names-that-cannot-be-used-rd03)

- [Support Confirmation Requests (RD04)](./required-development-guidelines.md#support-confirmation-requests-rd04)

- [Support Force Parameter for Interactive Sessions (RD05)](./required-development-guidelines.md#support-force-parameter-for-interactive-sessions-rd05)

- [Document Output Objects (RD06)](./required-development-guidelines.md#document-output-objects-rd06)

### Code Guidelines

- [Derive from the Cmdlet or PSCmdlet Classes (RC01)](./required-development-guidelines.md#derive-from-the-cmdlet-or-pscmdlet-classes-rc01)

- [Specify the Cmdlet Attribute (RC02)](./required-development-guidelines.md#specify-the-cmdlet-attribute-rc02)

- [Override an Input Processing Method (RC03)](./required-development-guidelines.md#override-an-input-processing-method-rc03)

- [Specify the OutputType Attribute (RC04)](./required-development-guidelines.md#specify-the-outputtype-attribute-rc04)

- [Do Not Retain Handles to Output Objects (RC05)](./required-development-guidelines.md#do-not-retain-handles-to-output-objects-rc05)

- [Handle Errors Robustly (RC06)](./required-development-guidelines.md#handle-errors-robustly-rc06)

- [Use a Windows PowerShell Module to Deploy your Cmdlets (RC07)](./required-development-guidelines.md#use-a-windows-powershell-module-to-deploy-your-cmdlets-rc07)

## Design Guidelines

The following guidelines must be followed when designing cmdlets to ensure a consistent user experience between using your cmdlets and other cmdlets. When you find a Design guideline that applies to your situation, be sure to look at the Code guidelines for similar guidelines.

### Use Only Approved Verbs (RD01)

The verb specified in the Cmdlet attribute must come from the recognized set of verbs provided by Windows PowerShell. It must not be one of the prohibited synonyms. Use the constant strings that are defined by the following enumerations to specify cmdlet verbs:

- [System.Management.Automation.VerbsCommon](/dotnet/api/System.Management.Automation.VerbsCommon)

- [System.Management.Automation.VerbsCommunications](/dotnet/api/System.Management.Automation.VerbsCommunications)

- [System.Management.Automation.VerbsData](/dotnet/api/System.Management.Automation.VerbsData)

- [System.Management.Automation.VerbsDiagnostic](/dotnet/api/System.Management.Automation.VerbsDiagnostic)

- [System.Management.Automation.VerbsLifeCycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle)

- [System.Management.Automation.VerbsSecurity](/dotnet/api/System.Management.Automation.VerbsSecurity)

- [System.Management.Automation.VerbsOther](/dotnet/api/System.Management.Automation.VerbsOther)

For more information about the approved verb names, see [Cmdlet Verbs](./approved-verbs-for-windows-powershell-commands.md).

Users need a set of discoverable and expected cmdlet names. Use the appropriate verb so that the user can make a quick assessment of what a cmdlet does and to easily discover the capabilities of the system. For example, the following command-line command gets a list of all the commands on the system whose names begin with "start": `get-command start-*`. Use the nouns in your cmdlets to differentiate your cmdlets from other cmdlets. The noun indicates the resource on which the operation will be performed. The operation itself is represented by the verb.

### Cmdlet Names: Characters that cannot be Used (RD02)

When you name cmdlets, do not use any of the following special characters.

|Character|Name|
|---------------|----------|
|#|number sign|
|,|comma|
|()|parentheses|
|{}|braces|
|[]|brackets|
|&|ampersand|
|-|hyphen **Note:**  The hyphen can be used to separate the verb from the noun, but it cannot be used within the noun or within the verb.|
|/|slash mark|
|\\|backslash|
|$|dollar sign|
|^|caret|
|;|semicolon|
|:|colon|
|"|double quotation mark|
|'|single quotation mark|
|<>|angle brackets|
|&#124;|vertical bar|
|?|question mark|
|@|at sign|
|`|back tick (grave accent)|
|*|asterisk|
|%|percent sign|
|+|plus sign|
|=|equals sign|
|~|tilde|

### Parameters Names that cannot be Used (RD03)

Windows PowerShell provides a common set a parameters to all cmdlets plus additional parameters that are added in specific situations. When designing your own cmdlets you cannot use the following names: Confirm, Debug, ErrorAction, ErrorVariable, OutBuffer, OutVariable, WarningAction, WarningVariable, WhatIf, UseTransaction, and Verbose. For more information about these parameters, see [Common Parameter Names](./common-parameter-names.md).

### Support Confirmation Requests (RD04)

For cmdlets that perform an operation that modifies the system, they should call the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method to request confirmation, and in special cases call the [System.Management.Automation.Cmdlet.ShouldContinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) method. (The [System.Management.Automation.Cmdlet.ShouldContinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) method should be called only after the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method is called.)

To make these calls the cmdlet must specify that it supports confirmation requests by setting the `SupportsShouldProcess` keyword of the Cmdlet attribute. For more information about setting this attribute, see [Cmdlet Attribute Declaration](./cmdlet-attribute-declaration.md).

> [!NOTE]
> If the Cmdlet attribute of the cmdlet class indicates that the cmdlet supports calls to the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method, and the cmdlet fails to make the call to the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method, the user could modify the system unexpectedly.

Use the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method for any system modification. A user preference and the `WhatIf` parameter control the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method. In contrast, the [System.Management.Automation.Cmdlet.ShouldContinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) call performs an additional check for potentially dangerous modifications. This method is not controlled by any user preference or the `WhatIf` parameter. If your cmdlet calls the [System.Management.Automation.Cmdlet.ShouldContinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) method, it should have a `Force` parameter that bypasses the calls to these two methods and that proceeds with the operation. This is important because it allows your cmdlet to be used in non-interactive scripts and hosts.

If your cmdlets support these calls, the user can determine whether the action should actually be performed. For example, the [Stop-Process](/powershell/module/microsoft.powershell.management/stop-process) cmdlet calls the [System.Management.Automation.Cmdlet.ShouldContinue*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) method before it stops a set of critical processes, including the System, Winlogon, and Spoolsv processes.

For more information about supporting these methods, see [Requesting Confirmation](./requesting-confirmation-from-cmdlets.md).

### Support Force Parameter for Interactive Sessions (RD05)

If your cmdlet is used interactively, always provide a Force parameter to override the interactive actions, such as prompts or reading lines of input). This is important because it allows your cmdlet to be used in non-interactive scripts and hosts. The following methods can be implemented by an interactive host.

- [System.Management.Automation.Host.PSHostUserInterface.Prompt*](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.Prompt)

- [System.Management.Automation.Host.Pshostuserinterface.PromptForChoice](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.PromptForChoice)

- [System.Management.Automation.Host.Ihostuisupportsmultiplechoiceselection.PromptForChoice](/dotnet/api/System.Management.Automation.Host.IHostUISupportsMultipleChoiceSelection.PromptForChoice)

- [System.Management.Automation.Host.Pshostuserinterface.PromptForCredential*](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.PromptForCredential)

- [System.Management.Automation.Host.Pshostuserinterface.ReadLine*](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.ReadLine)

- [System.Management.Automation.Host.Pshostuserinterface.ReadLineAsSecureString*](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface.ReadLineAsSecureString)

### Document Output Objects (RD06)

Windows PowerShell uses the objects that are written to the pipeline. In order for users to take advantage of the objects that are returned by each cmdlet, you must document the objects that are returned, and you must document what the members of those returned objects are used for.

## Code Guidelines

The following guidelines must be followed when writing cmdlet code. When you find a Code guideline that applies to your situation, be sure to look at the Design guidelines for similar guidelines.

### Derive from the Cmdlet or PSCmdlet Classes (RC01)

A cmdlet must derive from either the [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) or [System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet) base class. Cmdlets that derive from the [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) class do not depend on the Windows PowerShell runtime. They can be called directly from any Microsoft .NET Framework language. Cmdlets that derive from the [System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet) class depend on the Windows PowerShell runtime. Therefore, they execute within a runspace.

All cmdlet classes that you implement must be public classes. For more information about these cmdlet classes, see [Cmdlet Overview](./cmdlet-overview.md).

### Specify the Cmdlet Attribute (RC02)

For a cmdlet to be recognized by Windows PowerShell, its .NET Framework class must be decorated with the Cmdlet attribute. This attribute specifies the following features of the cmdlet.

- The verb-and-noun pair that identifies the cmdlet.

- The default parameter set that is used when multiple parameter sets are specified. The default parameter set is used when Windows PowerShell does not have enough information to determine which parameter set to use.

- Indicates if the cmdlet supports calls to the [System.Management.Automation.Cmdlet.ShouldProcess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method. This method displays a confirmation message to the user before the cmdlet makes a change to the system. For more information about how confirmation requests are made, see [Requesting Confirmation](./requesting-confirmation-from-cmdlets.md).

- Indicate the impact level (or severity) of the action associated with the confirmation message. In most cases, the default value of Medium should be used. For more information about how the impact level affects the confirmation requests that are displayed to the user, see [Requesting Confirmation](./requesting-confirmation-from-cmdlets.md).

For more information about how to declare the cmdlet attribute, see [CmdletAttribute Declaration](./cmdlet-attribute-declaration.md).

### Override an Input Processing Method (RC03)

For the cmdlet to participate in the Windows PowerShell environment, it must override at least one of the following *input processing methods*.

[System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing)
This method is called one time, and it is used to provide pre-processing functionality.

[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
This method is called multiple times, and it is used to provide record-by-record functionality.

[System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing)
This method is called one time, and it is used to provide post-processing functionality.

### Specify the OutputType Attribute (RC04)

The OutputType attribute (introduced in Windows PowerShell 2.0) specifies the .NET Framework type that your cmdlet returns to the pipeline. By specifying the output type of your cmdlets you make the objects returned by your cmdlet more discoverable by other cmdlets. For more information about decorating the cmdlet class with this attribute, see [OutputType Attribute Declaration](./outputtype-attribute-declaration.md).

### Do Not Retain Handles to Output Objects (RC05)

Your cmdlet should not retain any handles to the objects that are passed to the [System.Management.Automation.Cmdlet.WriteObject*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) method. These objects are passed to the next cmdlet in the pipeline, or they are used by a script. If you retain the handles to the objects, two entities will own each object, which causes errors.

### Handle Errors Robustly (RC06)

An administration environment inherently detects and makes important changes to the system that you are administering. Therefore, it is vital that cmdlets handle errors correctly. For more information about error records, see [Windows PowerShell Error Reporting](./error-reporting-concepts.md).

- When an error prevents a cmdlet from continuing to process any more records, it is a terminating error. The cmdlet must call the [System.Management.Automation.Cmdlet.ThrowTerminatingError*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError) method that references an [System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord) object. If an exception is not caught by the cmdlet, the Windows PowerShell runtime itself throws a terminating error that contains less information.

- For a non-terminating error that does not stop operation on the next record that is coming from the pipeline (for example, a record produced by a different process), the cmdlet must call the [System.Management.Automation.Cmdlet.WriteError*](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) method that references an [System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord) object. An example of a non-terminating error is the error that occurs if a particular process fails to stop. Calling the [System.Management.Automation.Cmdlet.WriteError*](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) method allows the user to consistently perform the actions requested and to retain the information for particular actions that fail. Your cmdlet should handle each record as independently as possible.

- The [System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord) object that is referenced by the [System.Management.Automation.Cmdlet.ThrowTerminatingError*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError) and [System.Management.Automation.Cmdlet.WriteError*](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) methods requires an exception at its core. Follow the .NET Framework design guidelines when you determine the exception to use. If the error is semantically the same as an existing exception, use that exception or derive from that exception. Otherwise, derive a new exception or exception hierarchy directly from the [System.Exception](/dotnet/api/System.Exception) type.

An [System.Management.Automation.ErrorRecord](/dotnet/api/System.Management.Automation.ErrorRecord) object also requires an error category that groups errors for the user. The user can view errors based on the category by setting the value of the `$ErrorView` shell variable to CategoryView. The possible categories are defined by the [System.Management.Automation.ErrorCategory](/dotnet/api/System.Management.Automation.ErrorCategory) enumeration.

- If a cmdlet creates a new thread, and if the code that is running in that thread throws an unhandled exception, Windows PowerShell will not catch the error and will terminate the process.

- If an object has code in its destructor that causes an unhandled exception, Windows PowerShell will not catch the error and will terminate the process. This also occurs if an object calls Dispose methods that cause an unhandled exception.

### Use a Windows PowerShell Module to Deploy your Cmdlets (RC07)

Create a Windows PowerShell module to package and deploy your cmdlets. Support for modules is introduced in Windows PowerShell 2.0. You can use the assemblies that contain your cmdlet classes directly as binary module files (this is very useful when testing your cmdlets), or you can create a module manifest that references the cmdlet assemblies. (You can also add existing snap-in assemblies when using modules.) For more information about modules, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

## See Also

[Strongly Encouraged Development Guidelines](./strongly-encouraged-development-guidelines.md)

[Advisory Development Guidelines](./advisory-development-guidelines.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
