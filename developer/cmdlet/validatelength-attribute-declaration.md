---
title: "ValidateLength Attribute Declaration | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
helpviewer_keywords:
  - "ValidateLength attribute, described"
  - "attributes, ValidateLength"
  - "ValidateLength attribute"
ms.assetid: 82fe3a35-a94b-4bc1-ad9e-dfc5f1e788b3
caps.latest.revision: 13
---
# ValidateLength Attribute Declaration

The ValidateLength attribute specifies the minimum and maximum number of characters for a cmdlet parameter argument. This attribute can also be used by Windows PowerShell functions.

## Syntax

```csharp
[ValidateLength(int minLength, int maxlength)]
```

#### Parameters

`MinLength` ([System.Integer](/dotnet/api/System.Integer))
Required. Specifies the minimum number of characters allowed.

`MaxLength` ([System.Integer](/dotnet/api/System.Integer))
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
