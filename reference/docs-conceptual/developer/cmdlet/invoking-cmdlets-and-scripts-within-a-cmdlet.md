---
ms.date: 09/13/2016
ms.topic: reference
title: Invoking Cmdlets and Scripts Within a Cmdlet
description: Invoking Cmdlets and Scripts Within a Cmdlet
---
# Invoking Cmdlets and Scripts Within a Cmdlet

A cmdlet can invoke other cmdlets and scripts from within the input processing method of the cmdlet. This allows you to add the functionality of existing cmdlets and scripts to your cmdlet without having to rewrite the code.

## The Invoke Method

All cmdlets can invoke an existing cmdlet by calling the [System.Management.Automation.Cmdlet.Invoke](/dotnet/api/System.Management.Automation.Cmdlet.Invoke) method from within an input processing method, such as [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing), that is overridden by the cmdlet. However, you can invoke only those cmdlets that derive directly from the [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) class. You cannot invoke a cmdlet that derives from the [System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet) class.

The [System.Management.Automation.Cmdlet.Invoke*](/dotnet/api/System.Management.Automation.Cmdlet.Invoke) method has the following variants.

[System.Management.Automation.Cmdlet.Invoke](/dotnet/api/System.Management.Automation.Cmdlet.Invoke)
This variant invokes the cmdlet object and returns a collection of "T" type objects.

[System.Management.Automation.Cmdlet.Invoke](/dotnet/api/System.Management.Automation.Cmdlet.Invoke)
This variant invokes the cmdlet object and returns a strongly typed emumerator. This variant allows the user to use the objects in the collection to perform custom operations.

## Examples

|Example|Description|
|-------------|-----------------|
|[Invoking Cmdlets Within a Cmdlet](./how-to-invoke-a-cmdlet-from-within-a-cmdlet.md)|This example shows how to invoke a cmdlet from within another cmdlet.|
|[Invoking Scripts Within a Cmdlet](./how-to-invoke-scripts-within-a-cmdlet.md)|This example shows how to invoke a script that is supplied to the cmdlet from within another cmdlet.|

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
