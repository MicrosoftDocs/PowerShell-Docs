---
ms.date: 09/13/2016
ms.topic: reference
title: ValidateSet Attribute Declaration
description: ValidateSet Attribute Declaration
---
# ValidateSet Attribute Declaration

The ValidateSetAttribute attribute specifies a set of possible values for a cmdlet parameter argument. This attribute can also be used by Windows PowerShell functions.

When this attribute is specified, the Windows PowerShell runtime determines whether the supplied argument for the cmdlet parameter matches an element in the supplied element set. The cmdlet is run only if the parameter argument matches an element in the set. If no match is found, an error is thrown by the Windows PowerShell runtime.

## Syntax

```csharp
[ValidateSetAttribute(params string[] validValues)]
[ValidateSetAttribute(params string[] validValues, Named Parameters)]
```

#### Parameters

`ValidValues` ([System.String](/dotnet/api/System.String))
Required. Specifies the valid parameter element values. The following sample shows how to specify one element or multiple elements.

```csharp
[ValidateSetAttribute("Steve")]
[ValidateSetAttribute("Steve","Mary")]
```

`IgnoreCase` ([System.Boolean](/dotnet/api/System.Boolean))
Optional named parameter. The default value of `true` indicates that case is ignored. A value of `false` makes the cmdlet case-sensitive.

## Remarks

- This attribute can be used only once per parameter.

- If the parameter value is an array, every element of the array must match an element of the attribute set.

- The ValidateSetAttribute attribute is defined by the [System.Management.Automation.Validatesetattribute](/dotnet/api/System.Management.Automation.ValidateSetAttribute) class.

## See Also

[System.Management.Automation.Validatesetattribute](/dotnet/api/System.Management.Automation.ValidateSetAttribute)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
