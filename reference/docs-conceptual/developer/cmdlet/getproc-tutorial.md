---
description: GetProc Tutorial
ms.date: 09/13/2016
ms.topic: reference
title: GetProc Tutorial
---
# GetProc Tutorial

This section provides a tutorial for creating a Get-Proc cmdlet that is very similar to the
[Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet provided by
Windows PowerShell. This tutorial provides fragments of code that illustrate how cmdlets are
implemented, and an explanation of the code.

## Topics in this Tutorial

The topics in this tutorial are designed to be read sequentially, with each topic building on what
was discussed in the previous topic.

- **[Creating a Cmdlet without Parameters][1]:** This section describes how to create a cmdlet that
  retrieves information from the local computer without the use of parameters, and then writes the
  information to the pipeline.

- **[Adding Parameters that Process Command-Line Input][2]:** This section describes how to add a
  parameter to the Get-Proc cmdlet so that the cmdlet can process input based on explicit objects
  passed to the cmdlet. The implementation described here retrieves processes based on their name,
  and then writes the information to the pipeline.

- **[Adding Parameters that Process Pipeline Input][3]:** This section describes how to add a
  parameter to the Get-Proc cmdlet so that the cmdlet can process objects passed to it through the
  pipeline. The implementation cmdlet described here retrieves processes based on objects passed to
  the cmdlet, and then writes the information to the pipeline.

- **[Adding Non-terminating Error Reporting to Your Cmdlet][4]:** This section describes how to add
  non-terminating error reporting to a cmdlet. The implementation described here detects
  non-terminating errors that occur when processing input, and writes an error record to the error
  stream.

## See Also

- [Windows PowerShell SDK](../windows-powershell-reference.md)

[1]: ./creating-a-cmdlet-without-parameters.md
[2]: ./adding-parameters-that-process-command-line-input.md
[3]: ./adding-parameters-that-process-pipeline-input.md
[4]: ./adding-non-terminating-error-reporting-to-your-cmdlet.md
