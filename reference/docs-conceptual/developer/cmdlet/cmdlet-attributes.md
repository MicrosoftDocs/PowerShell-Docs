---
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Attributes
description: Cmdlet Attributes
---
# Cmdlet Attributes

Windows PowerShell defines several attributes that you can use to add common functionality to your cmdlets without implementing that functionality within your own code. This includes the Cmdlet attribute that identifies a Microsoft .NET Framework class as a cmdlet class, the OutputType attribute that specifies the .NET Framework types returned by the cmdlet, the Parameter attribute that identifies public properties as cmdlet parameters, and more.

## In This Section

[Attributes in Cmdlet Code](./attributes-in-cmdlet-code.md)
Describes the benefit of using attributes in cmdlet code.

[Attribute Types](./attribute-types.md)
Describes the different attributes that can decorate a cmdlet class.

[Alias Attribute Declaration](./alias-attribute-declaration.md)
Describes how to define aliases for a cmdlet parameter name.

[Cmdlet Attribute Declaration](./cmdlet-attribute-declaration.md)
Describes how to define a .NET Framework class as a cmdlet.

[Credential Attribute Declaration](./credential-attribute-declaration.md)
Describes how to add support for converting string input into a [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) object.

[OutputType attribute Declaration](./outputtype-attribute-declaration.md)
Describes how to specify the .NET Framework types returned by the cmdlet.

[Parameter Attribute Declaration](./parameter-attribute-declaration.md)
Describes how to define the parameters of a cmdlet.

[ValidateCount Attribute Declaration](./validatecount-attribute-declaration.md)
Describes how to define how many arguments are allowed for a parameter.

[ValidateLength Attribute Declaration](./validatelength-attribute-declaration.md)
Describes how to define the length (in characters) of a parameter argument.

[ValidatePattern Attribute Declaration](./validatepattern-attribute-declaration.md)
Describes how to define the valid patterns for a parameter argument.

[ValidateRange Attribute Declaration](./validaterange-attribute-declaration.md)
Describes how to define the valid range for a parameter argument.

[ValidateSet Attribute Declaration](./validateset-attribute-declaration.md)
Describes how to define the possible values for a parameter argument.

## Reference

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
