---
ms.date: 09/13/2016
ms.topic: reference
title: GetProc Tutorial
description: GetProc Tutorial
---
# GetProc Tutorial

This section provides a tutorial for creating a Get-Proc cmdlet that is very similar to the [Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet provided by Windows PowerShell. This tutorial provides fragments of code that illustrate how cmdlets are implemented, and an explanation of the code.

## Topics in this Tutorial

The topics in this tutorial are designed to be read sequentially, with each topic building on what was discussed in the previous topic.

[Creating a Cmdlet without Parameters](./creating-a-cmdlet-without-parameters.md)
This section describes how to create a cmdlet that retrieves information from the local computer without the use of parameters, and then writes the information to the pipeline.

[Adding Parameters that Process Command-Line Input](./adding-parameters-that-process-command-line-input.md)
This section describes how to add a parameter to the Get-Proc cmdlet so that the cmdlet can process input based on explicit objects passed to the cmdlet. The implementation described here retrieves processes based on their name, and then writes the information to the pipeline.

[Adding Parameters that Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md)
This section describes how to add a parameter to the Get-Proc cmdlet so that the cmdlet can process objects passed to it through the pipeline. The implementation cmdlet described here retrieves processes based on objects passed to the cmdlet, and then writes the information to the pipeline.

[Adding Nonterminating Error Reporting to Your Cmdlet](./adding-non-terminating-error-reporting-to-your-cmdlet.md)
This section describes how to add nonterminating error reporting to a cmdlet. The implementation described here detects nonterminating errors that occur when processing input, and writes an error record to the error stream.

## See Also

[Creating a Cmdlet without Parameters](./creating-a-cmdlet-without-parameters.md)

[Adding Parameters that Process Command-Line Input](./adding-parameters-that-process-command-line-input.md)

[Adding Parameters that Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md)

[Adding Nonterminating Error Reporting to Your Cmdlet](./adding-non-terminating-error-reporting-to-your-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
