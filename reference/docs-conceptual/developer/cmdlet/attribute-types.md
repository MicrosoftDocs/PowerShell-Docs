---
ms.date: 09/13/2016
ms.topic: reference
title: Attribute Types
description: Attribute Types
---
# Attribute Types

Cmdlet attributes can be grouped by functionality.
The following sections describe the available attributes and describe what the runtime does when the attribute is invoked.

## Cmdlet Attributes

### Cmdlet

Identifies a .NET Framework class as a cmdlet.
This is the required base attribute.
For more information, see [Cmdlet Attribute Declaration](./cmdlet-attribute-declaration.md).

## Parameter Attributes

### Parameter

Identifies a public property in the cmdlet class as a cmdlet parameter.
For more information, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

### Alias

Specifies one or more aliases for a parameter.
For more information, see [Alias Attribute Declaration](./alias-attribute-declaration.md).

## Argument Validation Attributes

### ValidateCount

Specifies the minimum and maximum number of arguments that are allowed for a cmdlet parameter.
For more information, see [ValidateCount Attribute Declaration](./validatecount-attribute-declaration.md).

### ValidateLength

Specifies a minimum and maximum number of characters for a cmdlet parameter argument.
For more information, see [ValidateLength Attribute Declaration](./validatelength-attribute-declaration.md).

### ValidatePattern

Specifies a regular expression pattern that the cmdlet parameter argument must match.
For more information, see [ValidatePattern Attribute Declaration](./validatepattern-attribute-declaration.md).

### ValidateRange

Specifies the minimum and maximum values for a cmdlet parameter argument.
For more information, see [ValidateRange Attribute Declaration](./validaterange-attribute-declaration.md).

### ValidateSet

Specifies a set of valid values for the cmdlet parameter argument.
For more information, see [ValidateSet Attribute Declaration](./validateset-attribute-declaration.md).

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)
