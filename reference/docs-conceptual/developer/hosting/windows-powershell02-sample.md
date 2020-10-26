---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell02 Sample
description: Windows PowerShell02 Sample
---
# Windows PowerShell02 Sample

This sample shows how to run commands asynchronously using the runspaces of a runspace pool. The
sample generates a list of commands, and then runs those commands while the Windows PowerShell
engine opens a runspace from the pool when it is needed.

## Requirements

- This sample requires Windows PowerShell 2.0.

## Demonstrates

This sample demonstrates the following:

- Creating a RunspacePool object with a minimum and maximum number of runspaces allowed to be open
  at the same time.
- Creating a list of commands.
- Running the commands asynchronously.
- Calling the [System.Management.Automation.Runspaces.Runspacepool.Getavailablerunspaces*](/dotnet/api/System.Management.Automation.Runspaces.RunspacePool.GetAvailableRunspaces)
  method to see how many runspaces are free.
- Capturing the command output with the [System.Management.Automation.Powershell.Endinvoke*](/dotnet/api/System.Management.Automation.PowerShell.EndInvoke)
  method.

## Example

This sample shows how to open the runspaces of a runspace pool, and how to asynchronously run
commands in those runspaces.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/PowerShell02/PowerShell02.cs" range="11-96":::

## See Also

[Writing a Windows PowerShell Host Application](./writing-a-windows-powershell-host-application.md)
