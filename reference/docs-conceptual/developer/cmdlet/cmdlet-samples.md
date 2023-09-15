---
description: Cmdlet Samples
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Samples
---
# Cmdlet Samples

This section describes sample code that is provided in the Windows PowerShell 2.0 SDK.

## In This Section

- **[GetProcessSample01 Sample](./getprocesssample01-sample.md):** This sample shows how to write a
  cmdlet that retrieves the processes on the local computer.

- **[GetProcessSample02 Sample](./getprocesssample02-sample.md):** This sample shows how to write a
  cmdlet that retrieves the processes on the local computer. It provides a Name parameter that can
  be used to specify the processes to be retrieved.

- **[GetProcessSample03 Sample](./getprocesssample03-sample.md):** This sample shows how to write a
  cmdlet that retrieves the processes on the local computer. It provides a Name parameter that can
  accept an object from the pipeline or a value from a property of an object whose property name is
  the same as the parameter name.

- **[GetProcessSample04 Sample](./getprocesssample04-sample.md):** This sample shows how to write a
  cmdlet that retrieves the processes on the local computer. It generates a non-terminating error if
  an error occurs while retrieving a process.

- **[GetProcessSample05 Sample](./getprocesssample05-sample.md):** This sample shows a complete
  version of the Get-Proc cmdlet.

- **[StopProcessSample01 Sample](./stopprocesssample01-sample.md):** This sample shows how to write
  a cmdlet that requests feedback from the user before it attempts to stop a process, and how to
  implement a `PassThru` parameter that indicates that the user wants the cmdlet to return an
  object.

- **[StopProcessSample02 Sample](./stopprocesssample02-sample.md):** This sample shows how to write
  a cmdlet that writes debug, verbose, and warning messages while stopping processes on the local
  computer.

- **[StopProcessSample03 Sample](./stopprocesssample03-sample.md):** This sample shows how to write
  a cmdlet whose parameters have aliases and that support wildcard characters.

- **[StopProcessSample04 Sample](./stopprocesssample04-sample.md):** This sample shows how to write
  a cmdlet that declares parameter sets, specifies the default parameter set, and can accept an
  input object.

- **[Events01 Sample](./events01-sample.md):** This sample shows how to create a cmdlet that allows
  the user to register for events raised by [System.IO.FileSystemWatcher][1]. With this cmdlet users
  can, for example, register an action to execute when a file is created under a specific directory.
  This sample derives from the [Microsoft.PowerShell.Commands.ObjectEventRegistrationBase][2] base
  class.

## See Also

- [Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[1]: /dotnet/api/System.IO.FileSystemWatcher
[2]: /dotnet/api/Microsoft.PowerShell.Commands.ObjectEventRegistrationBase
