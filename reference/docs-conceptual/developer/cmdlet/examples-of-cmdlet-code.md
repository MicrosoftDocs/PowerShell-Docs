---
ms.date: 09/13/2016
ms.topic: reference
title: Examples of Cmdlet Code
description: Examples of Cmdlet Code
---
# Examples of Cmdlet Code

This section contains examples of cmdlet code that you can use to start writing your own cmdlets.

> [!IMPORTANT]
> If you want step-by-step instructions for writing cmdlets, see [Tutorials for Writing Cmdlets](./tutorials-for-writing-cmdlets.md).

## In This Section

[How to Write a Simple Cmdlet](./how-to-write-a-simple-cmdlet.md)
This example shows the basic structure of cmdlet code.

[How to Declare Cmdlet Parameters](./how-to-declare-cmdlet-parameters.md)
This example shows how to declare the different types of parameters.

[How to Declare Parameter Sets](./how-to-declare-parameter-sets.md)
This example shows how to declare sets of parameters that can change the action a cmdlet performs.

[How to Validate Parameter Input](./how-to-validate-parameter-input.md)
These examples show how to validate parameter input.

[How to Declare Dynamic Parameters](./how-to-declare-dynamic-parameters.md)
This example shows how to declare a parameter that is added at runtime.

[How to Invoke Scripts Within a Cmdlet](./how-to-invoke-scripts-within-a-cmdlet.md)
This example shows how to invoke a script that is supplied to a cmdlet.

[How To Override Input Processing Methods](./how-to-override-input-processing-methods.md)
These examples show the basic structure used to override the BeginProcessing, ProcessRecord, and EndProcessing methods.

[How to Support ShouldProcess Calls](./how-to-request-confirmations.md)
This example shows how the [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) and [System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue) methods should be called from within a cmdlet.

[How to Support Transactions](./how-to-support-transactions.md)
This example shows how to indicate that the cmdlet supports transactions and how to implement the action that is taken when the cmdlet is used within a transaction.

[How to Support Jobs](./how-to-support-jobs.md)
This example shows how to support jobs when you write cmdlets.

[How to Invoke a Cmdlet From Within a Cmdlet](./how-to-invoke-a-cmdlet-from-within-a-cmdlet.md)
This example shows how to invoke a cmdlet from within another cmdlet, which allows you to add the functionality of the invoked cmdlet to the cmdlet you are developing.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
