---
description: ValidateScript Attribute Declaration
ms.date: 09/16/2021
ms.topic: reference
title: ValidateScript Attribute Declaration
---
# ValidateScript Attribute Declaration

The `ValidateScript` attribute specifies a script that is used to validate a parameter or variable
value. PowerShell pipes the value to the script, and generates an error if the script returns
`$false` or if the script throws an exception.

When you use the `ValidateScript` attribute, the value that's being validated is mapped to the `$_`
variable. You can use the `$_` variable to refer to the value in the script.

## Syntax

```csharp
[ValidateScriptAttribute(ScriptBlock scriptBlock)]
```

### Parameters

- `scriptBlock` -
  ([System.Management.Automation.ScriptBlock](/dotnet/api/System.Management.Automation.ScriptBlock))
  Required. The script block used to validate the input.
- `ErrorMessage` - Optional - The item being validated and the validating scriptblock are passed as
  the first and second formatting arguments.

## Remarks

- This attribute can be used only once per parameter.
- If this attribute is applied to a collection, each element in the collection must match the
  pattern.
- The ValidateScript attribute is defined by the
  [System.Management.Automation.ValidateScriptAttribute](/dotnet/api/System.Management.Automation.ValidateScriptAttribute)
  class.

## See Also

[System.Management.Automation.ValidateScriptAttribute](/dotnet/api/System.Management.Automation.ValidateScriptAttribute)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
