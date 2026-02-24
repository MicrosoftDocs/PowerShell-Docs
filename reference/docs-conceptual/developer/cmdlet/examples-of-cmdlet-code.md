---
description: Examples of Cmdlet Code
ms.date: 09/13/2016
title: Examples of Cmdlet Code
---
# Examples of Cmdlet Code

This section contains examples of cmdlet code that you can use to start writing your own cmdlets.

> [!IMPORTANT]
> If you want step-by-step instructions for writing cmdlets, see [Tutorials for Writing Cmdlets][12].

## In This Section

- [How to Write a Simple Cmdlet][11] - This example shows the basic structure of cmdlet code.
- [How to Declare Cmdlet Parameters][01] - This example shows how to declare the different types of
  parameters.
- [How to Declare Parameter Sets][03] - This example shows how to declare sets of parameters that
  can change the action a cmdlet performs.
- [How to Validate Parameter Input][10] - These examples show how to validate parameter input.
- [How to Declare Dynamic Parameters][02] - This example shows how to declare a parameter that is
  added at runtime.
- [How to Invoke Scripts Within a Cmdlet][05] - This example shows how to invoke a script that is
  supplied to a cmdlet.
- [How To Override Input Processing Methods][06] - These examples show the basic structure used to
  override the BeginProcessing, ProcessRecord, and EndProcessing methods.
- [How to Support ShouldProcess Calls][07] - This example shows how the
  [System.Management.Automation.Cmdlet.ShouldProcess][15] and
  [System.Management.Automation.Cmdlet.ShouldContinue][14] methods should be called from within a
  cmdlet.
- [How to Support Transactions][09] - This example shows how to indicate that the cmdlet supports
  transactions and how to implement the action that is taken when the cmdlet is used within a
  transaction.
- [How to Support Transactions][09] - This example shows how to indicate that the cmdlet supports
  transactions and how to implement the action that is taken when the cmdlet is used within a
  transaction.
- [How to Support Jobs][08] - This example shows how to support jobs when you write cmdlets.
- [How to Invoke a Cmdlet From Within a Cmdlet][04] - This example shows how to invoke a cmdlet from
  within another cmdlet, which allows you to add the functionality of the invoked cmdlet to the
  cmdlet you are developing.

## See Also

[Writing a Windows PowerShell Cmdlet][13]

<!-- link references -->
[01]: ./how-to-declare-cmdlet-parameters.md
[02]: ./how-to-declare-dynamic-parameters.md
[03]: ./how-to-declare-parameter-sets.md
[04]: ./how-to-invoke-a-cmdlet-from-within-a-cmdlet.md
[05]: ./how-to-invoke-scripts-within-a-cmdlet.md
[06]: ./how-to-override-input-processing-methods.md
[07]: ./requesting-confirmation-from-cmdlets.md
[08]: ./how-to-support-jobs.md
[09]: ./how-to-support-transactions.md
[10]: ./how-to-validate-parameter-input.md
[11]: ./how-to-write-a-simple-cmdlet.md
[12]: ./tutorials-for-writing-cmdlets.md
[13]: ./writing-a-windows-powershell-cmdlet.md
[14]: /dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue
[15]: /dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess
