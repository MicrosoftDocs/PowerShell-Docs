---
title: "Cmdlet Attribute Declaration | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
helpviewer_keywords:
  - "Cmdlet attribute, described"
  - "attributes, Cmdlet"
  - "Cmdlet attribute"
ms.assetid: 1d323332-f773-4c0e-8a69-2aada765afb2
caps.latest.revision: 12
---
# Cmdlet Attribute Declaration

The Cmdlet attribute identifies a Microsoft .NET Framework class as a cmdlet and specifies the verb and noun used to invoke the cmdlet.

## Syntax

```csharp
[Cmdlet("verbName", "nounName")]
[Cmdlet("verbName", "nounName", Named Parameters...)]
```

#### Parameters

`VerbName` ([System.String](/dotnet/api/System.String))
Required. Specifies the cmdlet verb. This verb specifies the action taken by the cmdlet. For more information about approved cmdlet verbs, see [Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md) and [Required Development Guidelines](./required-development-guidelines.md).

`NounName` ([System.String](/dotnet/api/System.String))
Required. Specifies the cmdlet noun. This noun specifies the resource that the cmdlet acts upon. For more information about cmdlet nouns, see [Cmdlet Declaration](./cmdlet-class-declaration.md) and [Strongly Encouraged Development Guidelines](./strongly-encouraged-development-guidelines.md).

`SupportsShouldProcess` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates that the cmdlet supports calls to the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method, which provides the cmdlet with a way to prompt the user before an action that changes the system is performed. `False`, the default value, indicates that the cmdlet does not support calls to the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method. For more information about confirmation requests, see [Requesting Confirmation](./requesting-confirmation-from-cmdlets.md).

`ConfirmImpact` ([System.Management.Automation.Confirmimpact](/dotnet/api/System.Management.Automation.ConfirmImpact))
Optional named parameter. Specifies when the action of the cmdlet should be confirmed by a call to the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method. [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) will only be called when the ConfirmImpact value of the cmdlet (by default, Medium) is equal to or greater than the value of the `$ConfirmPreference` variable. This parameter should be specified only when the `SupportsShouldProcess` parameter is specified.

`DefaultParameterSetName` ([System.String](/dotnet/api/System.String))
Optional named parameter. Specifies the default parameter set that the Windows PowerShell runtime attempts to use when it cannot determine which parameter set to use. Notice that this situation can be eliminated by making the unique parameter of each parameter set a mandatory parameter.

There is one case where Windows PowerShell cannot use the default parameter set even if a default parameter set name is specified. The Windows PowerShell runtime cannot distinguish between parameter sets based solely on object type. For example, if you have one parameter set that takes a string as the file path, and another set that takes a **FileInfo** object directly, Windows PowerShell cannot determine which parameter set to use based on the values passed to the cmdlet, nor does it use the default parameter set. In this case, even if you specify a default parameter set name, Windows PowerShell throws an ambiguous parameter set error message.

`SupportsTransactions` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates that the cmdlet can be used within a transaction. When `True` is specified, the Windows PowerShell runtime adds the `UseTransaction` parameter to the parameter list of the cmdlet. `False`, the default value, indicates that the cmdlet cannot be used within a transaction.

## Remarks

- Together, the verb and noun are used to identify your registered cmdlet and to invoke your cmdlet within a script.

- When the cmdlet is invoked from the Windows PowerShell console, the command resembles the following command:

**VerbName-NounName**

- All cmdlets that change resources outside of Windows PowerShell should include the `SupportsShouldProcess` keyword when the Cmdlet attribute is declared, which allows the cmdlet to call the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method before the cmdlet performs its action. If the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) call returns `false`, the action should not be taken. For more information about the confirmation requests generated by the [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) call, see [Requesting Confirmation](./requesting-confirmation-from-cmdlets.md).

The `Confirm` and `WhatIf` cmdlet parameters are available only for cmdlets that support [System.Management.Automation.Cmdlet.Shouldprocess*](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) calls.

## Example

The following class definition uses the Cmdlet attribute to identify the .NET Framework class for a **Get-Proc** cmdlet that retrieves information about the processes running on the local computer.

```csharp
[Cmdlet(VerbsCommon.Get, "Proc")]
public class GetProcCommand : Cmdlet
```

For more information about the **Get-Proc** cmdlet, see [GetProc Tutorial](./getproc-tutorial.md).

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
