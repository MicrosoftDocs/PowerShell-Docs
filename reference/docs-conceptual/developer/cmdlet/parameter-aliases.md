---
ms.date: 09/13/2016
ms.topic: reference
title: Parameter Aliases
description: Parameter Aliases
---
# Parameter Aliases

Cmdlet parameters can also have aliases. You can use the aliases instead of the parameter names when you type or specify the parameter in a command.

## Benefits of Using Aliases

Adding aliases to parameters provides the following benefits.

- You can provide a shortcut so that the user does not have to use the complete parameter name when the cmdlet is called. For example, you could use the "CN" alias instead of the parameter name "ComputerName".

- You can define multiple aliases if you want to provide different names for the same parameter. You might want to define multiple aliases if you have to work with multiple user groups that refer to the same data in different ways.

- You can provide backwards compatibility for existing scripts if the name of a parameter changes.

- By using the Alias attribute along with the ValueFromPipelineByName attribute, you can define a parameter that allows your cmdlet to bind to different object types. For example, say you had two objects of different types and the first object had a writer property and the second object had an editor property. If your cmdlet had a parameter that had writer and editor aliases and the cmdlet accepted pipeline input based in property names, your cmdlet could bind to both objects using the two parameter aliases.

For more information about aliases that can be used with specific parameters, see [Common Parameter Names](./common-parameter-names.md).

## Defining Parameter Aliases

To define an alias for a parameter, declare the Alias attribute, as shown in the following parameter declaration. In this example, multiple aliases are defined for the same parameter. (For more information, see[How to Declare Cmdlet Parameters](./how-to-declare-cmdlet-parameters.md).)

```csharp
[Alias("UN","Writer","Editor")]
[Parameter()]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

## See Also

[Common Parameter Names](./common-parameter-names.md)

[How to Declare Cmdlet Parameters](./how-to-declare-cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
