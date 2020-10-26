---
ms.date: 09/13/2016
ms.topic: reference
title: Input Filter Parameters
description: Input Filter Parameters
---
# Input Filter Parameters

A cmdlet can define `Filter`, `Include`, and `Exclude` parameters that filter the set of input objects that the cmdlet affects.

Typically, the set of input objects is specified by an `InputObject`, `Path`, or `Name` parameter. For example, a cmdlet can have a `Path` parameter that accepts multiple paths by using wildcard characters, and each path points to an input object. Used together, the `Filter`, `Include`, and `Exclude` parameters further qualify the paths the cmdlet works on each time it is invoked.

## Include and Exclude Parameters

The `Include` and `Exclude` parameters identify the objects that are included or excluded from the set of input objects passed to the cmdlet. Use these parameters when the filter can be expressed in the standard wildcard language. (For more information about wildcard characters, see [Supporting Wildcards in Cmdlet Parameters](./supporting-wildcard-characters-in-cmdlet-parameters.md).) The `Include` parameter includes all the objects whose names match the inclusion filter. The `Exclude` parameter excludes all the objects whose names match the filter.

## Filter Parameter

The `Filter` parameter specifies a filter that is not expressed in the standard wildcard language. For example, Active Directory Service Interfaces (ADSI) or SQL filters might be passed to the cmdlet through its `Filter` parameter. In the cmdlets provided by Windows PowerShell, these filters are specified by the Windows PowerShell providers that use the cmdlet to access a data store. Each provider typically defines its own filter.

## Filtering If No Set of Input Objects Is Specified

If no set of input objects is specified, this typically means to filter against all objects. For more information, see[Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process).

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
