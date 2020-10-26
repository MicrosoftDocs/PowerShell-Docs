---
ms.date: 09/13/2016
ms.topic: reference
title: Parameter Attribute Declaration
description: Parameter Attribute Declaration
---
# Parameter Attribute Declaration

The Parameter attribute identifies a public property of the cmdlet class as a cmdlet parameter.

## Syntax

```csharp
[Parameter()]
[Parameter(Named Parameters...)]
```

#### Parameters

`Mandatory` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates the cmdlet parameter is required. If a required parameter is not provided when the cmdlet is invoked, Windows PowerShell prompts the user for a parameter value. The default is `false`.

`ParameterSetName` ([System.String](/dotnet/api/System.String))
Optional named parameter. Specifies the parameter set that this cmdlet parameter belongs to. If no parameter set is specified, the parameter belongs to all parameter sets.

`Position` ([System.Int32](/dotnet/api/System.Int32))
Optional named parameter. Specifies the position of the parameter within a Windows PowerShell command.

`ValueFromPipeline` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates that the cmdlet parameter takes its value from a pipeline object. Specify this keyword if the cmdlet accesses the complete object, not just a property of the object. The default is `false`.

`ValueFromPipelineByPropertyName` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates that the cmdlet parameter takes its value from a property of a pipeline object that has either the same name or the same alias as this parameter. For example, if the cmdlet has a `Name` parameter and the pipeline object also has a `Name` property, the value of the `Name` property is assigned to the `Name` parameter of the cmdlet. The default is `false`.

`ValueFromRemainingArguments` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. `True` indicates that the cmdlet parameter accepts all remaining arguments that are passed to the cmdlet. The default is `false`.

`HelpMessage`
Optional named parameter. Specifies a short description of the parameter. Windows PowerShell displays this message when a cmdlet is run and a mandatory parameter is not specified.

`HelpMessageBaseName`
Optional named parameter.Specifies the location where resource identifiers reside. For example, this parameter could specify a resource assembly that contains Help messages that you want to localize.

`HelpMessageResourceId`
Optional named parameter.Specifies the resource identifier for a Help message.

## Remarks

- For more information about how to declare this attribute, see [How to Declare Cmdlet Parameters](./how-to-declare-cmdlet-parameters.md).

- A cmdlet can have any number of parameters. However, for a better user experience, limit the number of parameters.

- Parameters must be declared on public non-static fields or properties. Parameters should be declared on properties. The property must have a public set accessor, and if the `ValueFromPipeline` or `ValueFromPipelineByPropertyName` keyword is specified, the property must have a public get accessor.

- When you specify positional parameters,  limit the number of positional parameters in a parameter set to less than five. And, positional parameters do not have to be contiguous. Positions 5, 100, and 250 work the same as positions 0, 1, and 2.

- When the `Position` keyword is not specified, the cmdlet parameter must be referenced by its name.

- When you use parameter sets, note the following:

  - Each parameter set must have at least one unique parameter. Good cmdlet design indicates this unique parameter should also be mandatory if possible. If your cmdlet is designed to be run without parameters, the unique parameter cannot be mandatory.

  - No parameter set should contain more than one positional parameter with the same position.

  - Only one parameter in a parameter set should declare `ValueFromPipeline = true`. Multiple parameters can define `ValueFromPipelineByPropertyName = true`.

  - Multiple parameters can define `ValueFromPipelineByPropertyName = true`.

- For more information about the guidelines for parameter names, see [Cmdlet Parameter Names](standard-cmdlet-parameter-names-and-types.md).

- The parameter attribute is defined by the [System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute) class.

## See Also

[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)

[Cmdlet Parameter Names](standard-cmdlet-parameter-names-and-types.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
