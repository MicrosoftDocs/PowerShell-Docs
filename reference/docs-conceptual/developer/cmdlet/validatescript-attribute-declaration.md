---
description: ValidateScript Attribute Declaration
ms.date: 09/30/2022
ms.topic: reference
title: ValidateScript Attribute Declaration
---
# ValidateScript Attribute Declaration

The `ValidateScript` attribute specifies a script that's used to validate a parameter or variable
value. PowerShell pipes the value to the script, and generates an error if the script returns
`$false` or if the script throws an exception.

When you use the `ValidateScript` attribute, the value that's being validated is mapped to the `$_`
variable. You can use the `$_` variable to refer to the value in the script.

## Syntax

```csharp
[ValidateScriptAttribute(ScriptBlock scriptBlock)]
[ValidateScriptAttribute(ScriptBlock scriptBlock, Named Parameters)]
```

### Parameters

- `scriptBlock` - ([System.Management.Automation.ScriptBlock][01]) Required. The script block used
  to validate the input.
- `ErrorMessage` - Optional named parameter - The item being validated and the validating
  scriptblock are passed as the first and second formatting arguments.

> [!NOTE]
> The `ErrorMessage` argument was added in PowerShell 6.

## Remarks

- This attribute can be used only once per parameter.
- If this attribute is applied to a collection, each element in the collection must match the
  pattern.
- The ValidateScript attribute is defined by the
  [System.Management.Automation.ValidateScriptAttribute][02] class.

## See Also

[System.Management.Automation.ValidateScriptAttribute][02]

[Writing a Windows PowerShell Cmdlet][03]

<!-- Reference links -->
[01]: /dotnet/api/System.Management.Automation.ScriptBlock
[02]: /dotnet/api/System.Management.Automation.ValidateScriptAttribute
[03]: ./writing-a-windows-powershell-cmdlet.md
