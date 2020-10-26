---
ms.date: 09/13/2016
ms.topic: reference
title: Alias Attribute Declaration
description: Alias Attribute Declaration
---
# Alias Attribute Declaration

The Alias attribute allows the user to specify different names for a cmdlet parameter. Aliases can be used to provide shortcuts for a parameter name, or they can provide different names that are appropriate for different scenarios.

## Syntax

```csharp
[Alias(aliasNames)]
```

#### Parameters

`aliasName` (String[])
Required. Specifies a set of comma-separated alias names for the cmdlet parameter.

## Remarks

- The Alias attribute is used with the Parameter attribute when you specify a cmdlet parameter. For more information about how to declare these attributes, see [How to Declare Cmdlet Parameters](./how-to-declare-cmdlet-parameters.md).

- Each alias name must be unique within a cmdlet. Windows PowerShell does not check for duplicate alias names.

- The Alias attribute is used once for each parameter in a cmdlet.

- The Alias attribute is defined by the [System.Management.Automation.Aliasattribute](/dotnet/api/System.Management.Automation.AliasAttribute) class.

## See Also

[Parameter Aliases](./parameter-aliases.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
