---
description: StopProc Tutorial
ms.date: 09/13/2016
ms.topic: reference
title: StopProc Tutorial
---
# StopProc Tutorial

This section provides a tutorial for creating the Stop-Proc cmdlet, which is very similar to the
[Stop-Process][1] cmdlet provided by Windows PowerShell. This tutorial provides fragments of code
that illustrate how cmdlets are implemented, and an explanation of the code.

## Topics in this Tutorial

The topics in this tutorial are designed to be read sequentially, with each topic building on what
was discussed in the previous topic.

- **[Creating a Cmdlet that Modifies the System][2]:** This section describes how to create a cmdlet
  that supports system modifications, such as stopping a process running on the computer.

- **[Adding User Messages to Your Cmdlet][3]:** This section describes how to add the ability to
  write user messages, debug messages, warning messages, and progress information to your cmdlet.

- **[Adding Aliases, Wildcard Expansion, and Help to Cmdlet Parameters][4]:** This section describes
  how to create a cmdlet that supports parameter aliases, Help, and wildcard expansion.

- **[Adding Parameter Sets to Cmdlets][5]:** This section describes how to add parameter sets to a
  cmdlet. Parameter sets allow the cmdlet to operate differently based on what parameters are
  specified by the user.

## See Also

- [Windows PowerShell SDK](../windows-powershell-reference.md)

[1]: /powershell/module/Microsoft.PowerShell.Management/Stop-Process
[2]: ./creating-a-cmdlet-that-modifies-the-system.md
[3]: ./adding-user-messages-to-your-cmdlet.md
[4]: ./adding-aliases-wildcard-expansion-and-help-to-cmdlet-parameters.md
[5]: ./adding-parameter-sets-to-a-cmdlet.md
