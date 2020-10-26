---
ms.date: 09/13/2016
ms.topic: reference
title: Declaring Properties as Parameters
description: Declaring Properties as Parameters
---
# Declaring Properties as Parameters

This topic provides basic information you must understand before you declare the parameters of a cmdlet.

To declare the parameters of a cmdlet within your cmdlet class, define the public properties that represent each parameter, and then add one or more Parameter attributes to each property. The Windows PowerShell runtime uses the Parameter attributes to identify the property as a cmdlet parameter. The basic syntax for declaring the Parameter attribute is `[Parameter()]`.

Here is an example of a property defined as a required parameter.

```csharp
[Parameter(Position = 0, Mandatory = true)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

Here are some things to remember about parameters.

- A parameter must be explicitly marked as public. Parameters that are not marked as public default to internal and will not be found by the Windows PowerShell runtime.

- Parameters should be defined as Microsoft .NET Framework types to provide better parameter validation. For example, parameters that are restricted to one value out of a set of values should be defined as an enumeration type. Parameters that take a Uniform Resource Identifier (URI) value should be of type [System.Uri](/dotnet/api/System.Uri).

- Avoid basic string parameters for all but free-form text properties.

- You can add a parameter to any number of parameter sets. For more information about parameter sets, see [Cmdlet Parameter Sets](./cmdlet-parameter-sets.md).

Windows PowerShell also provides a set of common parameters that are automatically available to every cmdlet. For more information about these parameters and their aliases, see [Cmdlet Common Parameters](./common-parameter-names.md).

## See Also

[Cmdlet Common Parameters](./common-parameter-names.md)

[Types of Cmdlet Parameter](./types-of-cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
