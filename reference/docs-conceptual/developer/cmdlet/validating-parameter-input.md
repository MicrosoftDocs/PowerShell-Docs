---
ms.date: 09/13/2016
ms.topic: reference
title: Validating Parameter Input
description: Validating Parameter Input
---
# Validating Parameter Input

PowerShell can validate the arguments passed to cmdlet parameters in several ways.
PowerShell can validate the length, the range, and the pattern of the characters of the argument.
It can validate the number of arguments available (the count).
These validation rules are defined by validation attributes that are declared with the Parameter attribute on public properties of the cmdlet class.

To validate a parameter argument, the PowerShell runtime uses the information provided by the validation attributes to confirm the value of the parameter before the cmdlet is run.
If the parameter input is not valid, the user receives an error message.
Each validation parameter defines a validation rule that is enforced by PowerShell.

PowerShell enforces the validation rules based on the following attributes.

### ValidateCount

Specifies the minimum and maximum number of arguments that a parameter can accept.
For more information, see [ValidateCount Attribute Declaration](./validatecount-attribute-declaration.md).

### ValidateLength

Specifies the minimum and maximum number of characters in the parameter argument.
For more information, see [ValidateLength Attribute Declaration](./validatelength-attribute-declaration.md).

### ValidatePattern

Specifies a regular expression that validates the parameter argument.
For more information, see [ValidatePattern Attribute Declaration](./validatepattern-attribute-declaration.md).

### ValidateRange

Specifies the minimum and maximum values of the parameter argument.
For more information, see [ValidateRange Attribute Declaration](./validaterange-attribute-declaration.md).

### ValidateSet

Specifies the valid values for the parameter argument.
For more information, see [ValidateSet Attribute Declaration](./validateset-attribute-declaration.md).

## See Also

[How to Validate Parameter Input](./how-to-validate-parameter-input.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
