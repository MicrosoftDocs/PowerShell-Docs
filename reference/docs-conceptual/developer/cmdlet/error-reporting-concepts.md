---
ms.date: 09/13/2016
ms.topic: reference
title: Error Reporting Concepts
description: Error Reporting Concepts
---
# Error Reporting Concepts

Windows PowerShell provides two mechanisms for reporting errors: one mechanism for *terminating errors* and another mechanism for *non-terminating errors*. It is important for your cmdlet to report errors correctly so that the host application that is running your cmdlets can react in an appropriate manner.

Your cmdlet should call the [System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError) method when an error occurs that does not or should not allow the cmdlet to continue to process its input objects. Your cmdlet should call the [System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError) method to report non-terminating errors when the cmdlet can continue processing the input objects. Both methods provide an error record that the host application can use to investigate the cause of the error.

Use the following guidelines to determine whether an error is a terminating or non-terminating error.

- An error is a terminating error if it prevents your cmdlet from continuing to process the current object or from successfully processing any further input objects, regardless of their content.

- An error is a terminating error if you do not want your cmdlet to continue processing the current object or any further input objects, regardless of their content.

- An error is a terminating error if it occurs in a cmdlet that does not accept or return an object or if it occurs in a cmdlet that accepts or returns only one object.

- An error is a non-terminating error if you want your cmdlet to continue processing the current object and any further input objects.

- An error is a non-terminating error if it is related to a specific input object or subset of input objects.

## See Also

[System.Management.Automation.Cmdlet.Throwterminatingerror*](/dotnet/api/System.Management.Automation.Cmdlet.ThrowTerminatingError)

[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/System.Management.Automation.Cmdlet.WriteError)

[Windows PowerShell Error Records](./windows-powershell-error-records.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
