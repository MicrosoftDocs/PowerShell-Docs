---
ms.date: 09/13/2016
ms.topic: reference
title: Credential Attribute Declaration
description: Credential Attribute Declaration
---
# Credential Attribute Declaration

The Credential attribute is an optional attribute that can be used with credential parameters of type [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) so that a string can also be passed as an argument to the parameter. When this attribute is added to a parameter declaration, Windows PowerShell converts the string input into a [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) object. For example, the [Get-Credential](/powershell/module/Microsoft.PowerShell.Security/Get-Credential) cmdlet uses this attribute to have Windows PowerShell generate the [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) object that is returned by the cmdlet.

## Syntax

```csharp
[Credential]
```

## Remarks

- Typically this attribute is used by parameters of type [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) so that a string can also be passed as an argument to the parameter. When a [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) object is passed to the parameter, Windows PowerShell does nothing.

- When creating the [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential) object, Windows PowerShell uses the current Host to display the appropriate prompts to the user. For example, the default Host displays a prompt for a user name and password when this attribute is used. However, if a custom host is being used that defines a different prompt then that prompt would be displayed.

- This attribute is used with the Parameter attribute. For more information about that attribute, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

- The credential attribute is defined by the [System.Management.Automation.Credentialattribute](/dotnet/api/System.Management.Automation.CredentialAttribute) class.

## See Also

[Parameter Aliases](./parameter-aliases.md)

[Parameter Attribute Declaration](./parameter-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
