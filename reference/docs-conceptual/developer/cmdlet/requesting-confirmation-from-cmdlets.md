---
description: Requesting Confirmation from Cmdlets
ms.date: 09/13/2016
title: Requesting Confirmation from Cmdlets
---
# Requesting Confirmation from Cmdlets

Cmdlets should request confirmation when they make a change to the system that's outside of the
Windows PowerShell environment. For example, if a cmdlet is about to add a user account or stop a
process, the cmdlet should require confirmation from the user before it proceeds. In contrast, if a
cmdlet is about to change a Windows PowerShell variable, the cmdlet doesn't need to require
confirmation.

In order to make a confirmation request, the cmdlet must indicate that it supports confirmation
requests, and it must call the [System.Management.Automation.Cmdlet.ShouldProcess][03] and
[System.Management.Automation.Cmdlet.ShouldContinue][02] (optional) methods to display a
confirmation request message.

## Supporting Confirmation Requests

To support confirmation requests, the cmdlet must set the `SupportsShouldProcess` parameter of the
Cmdlet attribute to `true`. This enables the `Confirm` and `WhatIf` cmdlet parameters that are
provided by Windows PowerShell. The `Confirm` parameter allows the user to control whether the
confirmation request is displayed. The `WhatIf` parameter allows the user to determine whether the
cmdlet should display a message or perform its action. Don't manually add the `Confirm` and
`WhatIf` parameters to a cmdlet.

The following example shows a Cmdlet attribute declaration that supports confirmation requests.

```csharp
[Cmdlet(VerbsDiagnostic.Test, "RequestConfirmationTemplate1",
        SupportsShouldProcess = true)]
```

## Calling the Confirmation request methods

In the cmdlet code, call the [System.Management.Automation.Cmdlet.ShouldProcess][03] method before
the operation that changes the system is performed. Design the cmdlet so that if the call returns a
value of `false`, the operation isn't performed, and the cmdlet processes the next operation.

## Calling the ShouldContinue Method

Most cmdlets request confirmation using only the
[System.Management.Automation.Cmdlet.ShouldProcess][03] method. However, some cases might require
additional confirmation. For these cases, supplement the
[System.Management.Automation.Cmdlet.ShouldProcess][03] call with a call to the
[System.Management.Automation.Cmdlet.ShouldContinue][02] method. This allows the cmdlet or provider
to more finely control the scope of the **Yes to all** response to the confirmation prompt.

If a cmdlet calls the [System.Management.Automation.Cmdlet.ShouldContinue][02] method, the cmdlet
must also provide a `Force` switch parameter. If the user specifies `Force` when the user invokes
the cmdlet, the cmdlet should still call [System.Management.Automation.Cmdlet.ShouldProcess][03],
but it should bypass the call to [System.Management.Automation.Cmdlet.ShouldContinue][02].

[System.Management.Automation.Cmdlet.ShouldContinue][02] will throw an exception when it's called
from a non-interactive environment where the user can't be prompted. Adding a `Force` parameter
ensures that the command can still be performed when it's invoked in a non-interactive environment.

The following example shows how to call [System.Management.Automation.Cmdlet.ShouldProcess][03] and
[System.Management.Automation.Cmdlet.ShouldContinue][02].

```csharp
if (ShouldProcess (...) )
{
  if (Force || ShouldContinue(...))
  {
     // Add code that performs the operation.
  }
}
```

The behavior of a [System.Management.Automation.Cmdlet.ShouldProcess][03] call can vary depending on
the environment in which the cmdlet is invoked. Using the previous guidelines will help ensure that
the cmdlet behaves consistently with other cmdlets, regardless of the host environment.

## Specify the Impact Level

When you create the cmdlet, specify the impact level (the severity) of the change. To do this, set
the value of the `ConfirmImpact` parameter of the Cmdlet attribute to High, Medium, or Low. You can
specify a value for `ConfirmImpact` only when you also specify the `SupportsShouldProcess` parameter
for the cmdlet.

For most cmdlets, you don't have to explicitly specify `ConfirmImpact`. Instead, use the default
setting of the parameter, which is Medium. If you set `ConfirmImpact` to High, the operation will be
confirmed by default. Reserve this setting for highly disruptive actions, such as reformatting a
hard-disk volume.

## Calling Non-Confirmation Methods

If the cmdlet or provider must send a message but not request confirmation, it can call the
following three methods. Avoid using the [System.Management.Automation.Cmdlet.WriteObject][05]
method to send messages of these types because [System.Management.Automation.Cmdlet.WriteObject][05]
output is intermingled with the normal output of your cmdlet or provider, which makes script writing
difficult.

- To caution the user and continue with the operation, the cmdlet or provider can call the
  [System.Management.Automation.Cmdlet.WriteWarning][07] method.

- To provide additional information that the user can retrieve using the `Verbose` parameter, the
  cmdlet or provider can call the [System.Management.Automation.Cmdlet.WriteVerbose][06] method.

- To provide debugging-level detail for other developers or for product support, the cmdlet or
  provider can call the [System.Management.Automation.Cmdlet.WriteDebug][04] method. The user can
  retrieve this information using the `Debug` parameter.

Cmdlets and providers first call the following methods to request confirmation before they attempt
to perform an operation that changes a system outside of Windows PowerShell:

- [System.Management.Automation.Cmdlet.ShouldProcess][03]

- [System.Management.Automation.Provider.CmdletProvider.ShouldProcess][08]

They do so by calling the [System.Management.Automation.Cmdlet.ShouldProcess][03] method, which
prompts the user to confirm the operation based on how the user invoked the command.

## See Also

[Writing a Windows PowerShell Cmdlet][01]

<!-- link references -->
[01]: ./writing-a-windows-powershell-cmdlet.md
[02]: xref:System.Management.Automation.Cmdlet.ShouldContinue%2A
[03]: xref:System.Management.Automation.Cmdlet.ShouldProcess%2A
[04]: xref:System.Management.Automation.Cmdlet.WriteDebug%2A
[05]: xref:System.Management.Automation.Cmdlet.WriteObject%2A
[06]: xref:System.Management.Automation.Cmdlet.WriteVerbose%2A
[07]: xref:System.Management.Automation.Cmdlet.WriteWarning%2A
[08]: xref:System.Management.Automation.Provider.CmdletProvider.ShouldProcess%2A
