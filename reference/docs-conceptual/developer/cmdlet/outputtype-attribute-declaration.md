---
ms.date: 09/13/2016
ms.topic: reference
title: OutputType Attribute Declaration
description: OutputType Attribute Declaration
---
# OutputType Attribute Declaration

The `OutputType` attribute identifies the .NET Framework types returned by a cmdlet, function, or script.

## Syntax

```csharp
[OutputType(params string[] type)]
[OutputType(params Type[] type)]
[OutputType(params string[] type, Named Parameters...)]
[OutputType(params Type[] type, Named Parameters...)]
```

#### Parameters

Type (`string[]` or `Type[]`)
Required. Specifies the types returned by the cmdlet function, or script.

ParameterSetName (string[])
Optional. Specifies the parameter sets that return the types specified in the `type` parameter.

providerCmdlet
Optional. Specifies the provider cmdlet that returns the types specified in the `type` parameter.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
