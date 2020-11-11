---
ms.date: 09/13/2016
ms.topic: reference
title: ValidatePattern Attribute Declaration
description: ValidatePattern Attribute Declaration
---
# ValidatePattern Attribute Declaration

The ValidatePattern attribute specifies a regular expression pattern that validates the argument of a cmdlet parameter. This attribute can also be used by Windows PowerShell functions.

When ValidatePattern is invoked within a cmdlet, the Windows PowerShell runtime converts the argument of the cmdlet parameter to a string and then compares that string to the pattern supplied by the ValidatePattern attribute. The cmdlet is run only if the converted string representation of the argument and the supplied pattern match. If they do not match, an error is thrown by the Windows PowerShell runtime.

## Syntax

```csharp
[ValidatePattern(string regexString)]
[ValidatePattern(string regexString, Named Parameters)]
```

#### Parameters

`RegexString` ([System.String](/dotnet/api/System.String))
Required. Specifies a regular expression that validates the parameter argument.

Options ([System.Text.Regularexpressions.Regexoptions](/dotnet/api/System.Text.RegularExpressions.RegexOptions))
Optional named parameter. Specifies a bitwise combination of [System.Text.Regularexpressions.Regexoptions](/dotnet/api/System.Text.RegularExpressions.RegexOptions) flags that specify regular expression options.

## Remarks

- This attribute can be used only once per parameter.

- You can use the `Option` parameter of the attribute to further define the pattern. For example, you can make the pattern case sensitive.

- If this attribute is applied to a collection, each element in the collection must match the pattern.

- The ValidatePattern attribute is defined by the [System.Management.Automation.Validatepatternattribute](/dotnet/api/System.Management.Automation.ValidatePatternAttribute) class.

## See Also

[System.Management.Automation.Validatepatternattribute](/dotnet/api/System.Management.Automation.ValidatePatternAttribute)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
