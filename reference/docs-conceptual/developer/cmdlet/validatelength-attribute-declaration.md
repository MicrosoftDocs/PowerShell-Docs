---
ms.date: 09/13/2016
ms.topic: reference
title: ValidateLength Attribute Declaration
description: ValidateLength Attribute Declaration
---
# ValidateLength Attribute Declaration

The ValidateLength attribute specifies the minimum and maximum number of characters for a cmdlet parameter argument. This attribute can also be used by Windows PowerShell functions.

## Syntax

```csharp
[ValidateLength(int minLength, int maxlength)]
```

#### Parameters

`MinLength` ([System.Int32](/dotnet/api/System.Int32))
Required. Specifies the minimum number of characters allowed.

`MaxLength` ([System.Int32](/dotnet/api/System.Int32))
Required. Specifies the maximum number of characters allowed.

## Remarks

- For more information about how to declare this attribute, see [How to Declare Input Validation Rules](./how-to-validate-parameter-input.md).

- When this attribute is not used, the corresponding parameter argument can be of any length.

- The Windows PowerShell runtime throws an error under the following conditions:

  - When the value of the `MaxLength` attribute parameter is less than the value of the `MinLength` attribute parameter.

  - When the `MaxLength` attribute parameter is set to 0.

  - When the argument is not a string.

- The ValidateLength attribute is defined by the [System.Management.Automation.Validatelengthattribute](/dotnet/api/System.Management.Automation.ValidateLengthAttribute) class.

## See Also

[System.Management.Automation.Validatelengthattribute](/dotnet/api/System.Management.Automation.ValidateLengthAttribute)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
