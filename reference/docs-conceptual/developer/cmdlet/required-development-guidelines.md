---
description: Required Development Guidelines
ms.date: 09/13/2016
title: Required Development Guidelines
---
# Required Development Guidelines

The following guidelines must be followed when you write your cmdlets. They're separated into
guidelines for designing cmdlets and guidelines for writing your cmdlet code. If you don't follow
these guidelines, your cmdlets could fail, and your users might have a poor experience when they use
your cmdlets.

## In this Topic

### Design Guidelines

- [Use only approved verbs (RD01)][14]
- [Cmdlet names: characters that can't be used (RD02)][02]
- [Parameter names that can't be used (RD03)][08]
- [Support confirmation requests (RD04)][11]
- [Support force parameter for interactive sessions (RD05)][12]
- [Document output objects (RD06)][04]

### Code Guidelines

- [Derive from the Cmdlet or PSCmdlet classes (RC01)][03]
- [Specify the Cmdlet attribute (RC02)][09]
- [Override an input processing method (RC03)][07]
- [Specify the OutputType attribute (RC04)][10]
- [Don't retain handles to output objects (RC05)][05]
- [Handle errors robustly (RC06)][06]
- [Use a Windows PowerShell module to deploy your cmdlets (RC07)][13]

## Design Guidelines

The following guidelines must be followed when designing cmdlets to ensure a consistent user
experience between using your cmdlets and other cmdlets. When you find a Design guideline that
applies to your situation, be sure to look at the Code guidelines for similar guidelines.

### Use Only Approved Verbs (RD01)

The verb specified in the Cmdlet attribute must come from the recognized set of verbs provided by
Windows PowerShell. It must not be one of the prohibited synonyms. Use the constant strings that are
defined by the following enumerations to specify cmdlet verbs:

- [System.Management.Automation.VerbsCommon][45]
- [System.Management.Automation.VerbsCommunications][46]
- [System.Management.Automation.VerbsData][47]
- [System.Management.Automation.VerbsDiagnostic][48]
- [System.Management.Automation.VerbsLifecycle][49]
- [System.Management.Automation.VerbsSecurity][51]
- [System.Management.Automation.VerbsOther][50]

For more information about the approved verb names, see [Cmdlet Verbs][16].

Users need a set of discoverable and expected cmdlet names. Use the appropriate verb so that the
user can make a quick assessment of what a cmdlet does and to easily discover the capabilities of
the system. For example, the following command-line command gets a list of all the commands on the
system whose names begin with "Start": `Get-Command Start-*`. Use the nouns in your cmdlets to
differentiate your cmdlets from other cmdlets. The noun indicates the resource on which the
operation will be performed. The operation itself is represented by the verb.

### Cmdlet Names: Characters that can't be Used (RD02)

When you name cmdlets, don't use any of the following special characters.

|      Character      |           Name           |
| :-----------------: | ------------------------ |
|         `#`         | number sign              |
|         `,`         | comma                    |
|        `( )`        | parentheses              |
|        `{ }`        | braces                   |
|        `[ ]`        | brackets                 |
|         `&`         | ampersand                |
|         `-`         | hyphen                   |
|         `/`         | slash mark               |
|         `\`         | backslash                |
|         `$`         | dollar sign              |
|         `^`         | caret                    |
|         `;`         | semicolon                |
|         `:`         | colon                    |
|         `"`         | double quotation mark    |
|         `'`         | single quotation mark    |
|        `< >`        | angle brackets           |
| <code>&#124;</code> | vertical bar             |
|         `?`         | question mark            |
|         `@`         | at sign                  |
|       `` ` ``       | back tick (grave accent) |
|         `*`         | asterisk                 |
|         `%`         | percent sign             |
|         `+`         | plus sign                |
|         `=`         | equals sign              |
|         `~`         | tilde                    |

### Parameter names that can't be used (RD03)

Windows PowerShell provides a common set of parameters to all cmdlets plus additional parameters
that are added in specific situations. When designing your own cmdlets you can't use the following
names: `Confirm`, `Debug`, `ErrorAction`, `ErrorVariable`, `OutBuffer`, `OutVariable`,
`WarningAction`, `WarningVariable`, `WhatIf`, `UseTransaction`, and `Verbose`. For more information
about these parameters, see [Common Parameter Names][19].

### Support confirmation requests (RD04)

For cmdlets that perform an operation that modifies the system, they should call the
[System.Management.Automation.Cmdlet.ShouldProcess*][32] method to request confirmation, and in
special cases call the [System.Management.Automation.Cmdlet.ShouldContinue*][31] method. (The
[System.Management.Automation.Cmdlet.ShouldContinue*][31] method should be called only after the
[System.Management.Automation.Cmdlet.ShouldProcess*][32] method is called.)

To make these calls the cmdlet must specify that it supports confirmation requests by setting the
`SupportsShouldProcess` keyword of the Cmdlet attribute. For more information about setting this
attribute, see [Cmdlet Attribute Declaration][17].

> [!NOTE]
> If the Cmdlet attribute of the cmdlet class indicates that the cmdlet supports calls to the
> [System.Management.Automation.Cmdlet.ShouldProcess*][32] method, and the cmdlet fails to make the
> call to the [System.Management.Automation.Cmdlet.ShouldProcess*][32] method, the user could modify
> the system unexpectedly.

Use the [System.Management.Automation.Cmdlet.ShouldProcess*][32] method for any system modification.
A user preference and the `WhatIf` parameter control the
[System.Management.Automation.Cmdlet.ShouldProcess*][32] method. In contrast, the
[System.Management.Automation.Cmdlet.ShouldContinue*][31] call performs an additional check for
potentially dangerous modifications. This method isn't controlled by any user preference or the
`WhatIf` parameter. If your cmdlet calls the
[System.Management.Automation.Cmdlet.ShouldContinue*][31] method, it should have a `Force` parameter
that bypasses the calls to these two methods and that proceeds with the operation. This is important
because it allows your cmdlet to be used in non-interactive scripts and hosts.

If your cmdlets support these calls, the user can determine whether the action should actually be
performed. For example, the [Stop-Process][25] cmdlet calls the
[System.Management.Automation.Cmdlet.ShouldContinue*][31] method before it stops a set of critical
processes, including the System, Winlogon, and Spoolsv processes.

For more information about supporting these methods, see [Requesting Confirmation][22].

### Support Force parameter for interactive sessions (RD05)

If your cmdlet is used interactively, always provide a Force parameter to override the interactive
actions, such as prompts or reading lines of input. This is important because it allows your cmdlet
to be used in non-interactive scripts and hosts. The following methods can be implemented by an
interactive host.

- [System.Management.Automation.Host.PSHostUserInterface.Prompt*][39]
- [System.Management.Automation.Host.PSHostUserInterface.PromptForChoice][40]
- [System.Management.Automation.Host.IHostUISupportsMultipleChoiceSelection.PromptForChoice][38]
- [System.Management.Automation.Host.PSHostUserInterface.PromptForCredential*][41]
- [System.Management.Automation.Host.PSHostUserInterface.ReadLine*][42]
- [System.Management.Automation.Host.PSHostUserInterface.ReadLineAsSecureString*][43]

### Document output objects (RD06)

Windows PowerShell uses the objects that are written to the pipeline. In order for users to take
advantage of the objects that are returned by each cmdlet, you must document the objects that are
returned, and you must document what the members of those returned objects are used for.

## Code guidelines

The following guidelines must be followed when writing cmdlet code. When you find a Code guideline
that applies to your situation, be sure to look at the Design guidelines for similar guidelines.

### Derive from the Cmdlet or PSCmdlet classes (RC01)

A cmdlet must derive from either the [System.Management.Automation.Cmdlet][27] or
[System.Management.Automation.PSCmdlet][44] base class. Cmdlets that derive from the
[System.Management.Automation.Cmdlet][27] class don't depend on the Windows PowerShell runtime. They
can be called directly from any Microsoft .NET Framework language. Cmdlets that derive from the
[System.Management.Automation.PSCmdlet][44] class depend on the Windows PowerShell runtime.
Therefore, they execute within a runspace.

All cmdlet classes that you implement must be public classes. For more information about these
cmdlet classes, see [Cmdlet Overview][18].

### Specify the Cmdlet attribute (RC02)

For a cmdlet to be recognized by Windows PowerShell, its .NET Framework class must be decorated with
the Cmdlet attribute. This attribute specifies the following features of the cmdlet.

- The verb-and-noun pair that identifies the cmdlet.

- The default parameter set that's used when multiple parameter sets are specified. The default
  parameter set is used when Windows PowerShell doesn't have enough information to determine which
  parameter set to use.

- Indicates if the cmdlet supports calls to the
  [System.Management.Automation.Cmdlet.ShouldProcess*][32] method. This method displays a
  confirmation message to the user before the cmdlet makes a change to the system. For more
  information about how confirmation requests are made, see [Requesting Confirmation][22].

- Indicate the impact level (or severity) of the action associated with the confirmation message. In
  most cases, the default value of Medium should be used. For more information about how the impact
  level affects the confirmation requests that are displayed to the user, see
  [Requesting Confirmation][22].

For more information about how to declare the cmdlet attribute, see [CmdletAttribute Declaration][17].

### Override an input processing method (RC03)

For the cmdlet to participate in the Windows PowerShell environment, it must override at least one
of the following _input processing methods_.

- [System.Management.Automation.Cmdlet.BeginProcessing][28] This method is called one time, and it
  is used to provide pre-processing functionality.
- [System.Management.Automation.Cmdlet.ProcessRecord][30] This method is called multiple times, and
  it's used to provide record-by-record functionality.
- [System.Management.Automation.Cmdlet.EndProcessing][29] This method is called one time, and it's
  used to provide post-processing functionality.

### Specify the OutputType attribute (RC04)

The OutputType attribute (introduced in Windows PowerShell 2.0) specifies the .NET Framework type
that your cmdlet returns to the pipeline. By specifying the output type of your cmdlets you make the
objects returned by your cmdlet more discoverable by other cmdlets. For more information about
decorating the cmdlet class with this attribute, see [OutputType Attribute Declaration][21].

### Don't retain handles to output objects (RC05)

Your cmdlet shouldn't retain any handles to the objects that are passed to the
[System.Management.Automation.Cmdlet.WriteObject*][35] method. These objects are passed to the next
cmdlet in the pipeline, or they're used by a script. If you retain the handles to the objects, two
entities will own each object, which causes errors.

### Handle errors robustly (RC06)

An administration environment inherently detects and makes important changes to the system that you
are administering. Therefore, it's vital that cmdlets handle errors correctly. For more information
about error records, see [Windows PowerShell Error Reporting][20].

- When an error prevents a cmdlet from continuing to process any more records, it's a terminating
  error. The cmdlet must call the [System.Management.Automation.Cmdlet.ThrowTerminatingError*][33]
  method that references an [System.Management.Automation.ErrorRecord][37] object. If an exception
  isn't caught by the cmdlet, the Windows PowerShell runtime itself throws a terminating error that
  contains less information.

- For a non-terminating error that doesn't stop operation on the next record that's coming from
  the pipeline (for example, a record produced by a different process), the cmdlet must call the
  [System.Management.Automation.Cmdlet.WriteError*][34] method that references an
  [System.Management.Automation.ErrorRecord][37] object. An example of a non-terminating error is
  the error that occurs if a particular process fails to stop. Calling the
  [System.Management.Automation.Cmdlet.WriteError*][34] method allows the user to consistently
  perform the actions requested and to retain the information for particular actions that fail. Your
  cmdlet should handle each record as independently as possible.

- The [System.Management.Automation.ErrorRecord][37] object that's referenced by the
  [System.Management.Automation.Cmdlet.ThrowTerminatingError*][33] and
  [System.Management.Automation.Cmdlet.WriteError*][34] methods requires an exception at its core.
  Follow the .NET Framework design guidelines when you determine the exception to use. If the error
  is semantically the same as an existing exception, use that exception or derive from that
  exception. Otherwise, derive a new exception or exception hierarchy directly from the
  [System.Exception][26] type.

An [System.Management.Automation.ErrorRecord][37] object also requires an error category that groups
errors for the user. The user can view errors based on the category by setting the value of the
`$ErrorView` shell variable to CategoryView. The possible categories are defined by the
[System.Management.Automation.ErrorCategory][36] enumeration.

- If a cmdlet creates a new thread, and if the code that's running in that thread throws an
  unhandled exception, Windows PowerShell can't catch the error and terminates the process.

- If an object has code in its destructor that causes an unhandled exception, Windows PowerShell
  can't catch the error and terminates the process. This also occurs if an object calls
  Dispose methods that cause an unhandled exception.

### Use a Windows PowerShell module to deploy your cmdlets (RC07)

Create a Windows PowerShell module to package and deploy your cmdlets. Support for modules is
introduced in Windows PowerShell 2.0. You can use the assemblies that contain your cmdlet classes
directly as binary module files (this is very useful when testing your cmdlets), or you can create a
module manifest that references the cmdlet assemblies. You can also add existing snap-in assemblies
when using modules. For more information about modules, see
[Writing a Windows PowerShell Module][01].

## See also

- [Strongly Encouraged Development Guidelines][23]
- [Advisory Development Guidelines][15]
- [Writing a Windows PowerShell Cmdlet][24]

<!-- link references -->
[01]: ../module/writing-a-windows-powershell-module.md
[02]: #cmdlet-names-characters-that-cant-be-used-rd02
[03]: #derive-from-the-cmdlet-or-pscmdlet-classes-rc01
[04]: #document-output-objects-rd06
[05]: #dont-retain-handles-to-output-objects-rc05
[06]: #handle-errors-robustly-rc06
[07]: #override-an-input-processing-method-rc03
[08]: #parameter-names-that-cant-be-used-rd03
[09]: #specify-the-cmdlet-attribute-rc02
[10]: #specify-the-outputtype-attribute-rc04
[11]: #support-confirmation-requests-rd04
[12]: #support-force-parameter-for-interactive-sessions-rd05
[13]: #use-a-windows-powershell-module-to-deploy-your-cmdlets-rc07
[14]: #use-only-approved-verbs-rd01
[15]: advisory-development-guidelines.md
[16]: approved-verbs-for-windows-powershell-commands.md
[17]: cmdlet-attribute-declaration.md
[18]: cmdlet-overview.md
[19]: common-parameter-names.md
[20]: error-reporting-concepts.md
[21]: outputtype-attribute-declaration.md
[22]: requesting-confirmation-from-cmdlets.md
[23]: strongly-encouraged-development-guidelines.md
[24]: writing-a-windows-powershell-cmdlet.md
[25]: xref:Microsoft.PowerShell.Management.Stop-Process
[26]: xref:System.Exception
[27]: xref:System.Management.Automation.Cmdlet
[28]: xref:System.Management.Automation.Cmdlet.BeginProcessing%2A
[29]: xref:System.Management.Automation.Cmdlet.EndProcessing%2A
[30]: xref:System.Management.Automation.Cmdlet.ProcessRecord%2A
[31]: xref:System.Management.Automation.Cmdlet.ShouldContinue%2A
[32]: xref:System.Management.Automation.Cmdlet.ShouldProcess%2A
[33]: xref:System.Management.Automation.Cmdlet.ThrowTerminatingError%2A
[34]: xref:System.Management.Automation.Cmdlet.WriteError%2A
[35]: xref:System.Management.Automation.Cmdlet.WriteObject%2A
[36]: xref:System.Management.Automation.ErrorCategory
[37]: xref:System.Management.Automation.ErrorRecord
[38]: xref:System.Management.Automation.Host.IHostUISupportsMultipleChoiceSelection.PromptForChoice%2A
[39]: xref:System.Management.Automation.Host.PSHostUserInterface.Prompt%2A
[40]: xref:System.Management.Automation.Host.PSHostUserInterface.PromptForChoice%2A
[41]: xref:System.Management.Automation.Host.PSHostUserInterface.PromptForCredential%2A
[42]: xref:System.Management.Automation.Host.PSHostUserInterface.ReadLine%2A
[43]: xref:System.Management.Automation.Host.PSHostUserInterface.ReadLineAsSecureString%2A
[44]: xref:System.Management.Automation.PSCmdlet
[45]: xref:System.Management.Automation.VerbsCommon
[46]: xref:System.Management.Automation.VerbsCommunications
[47]: xref:System.Management.Automation.VerbsData
[48]: xref:System.Management.Automation.VerbsDiagnostic
[49]: xref:System.Management.Automation.VerbsLifecycle
[50]: xref:System.Management.Automation.VerbsOther
[51]: xref:System.Management.Automation.VerbsSecurity
