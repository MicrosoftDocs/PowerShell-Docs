---
description: How to validate an argument using a script
ms.date: 06/11/2024
ms.topic: reference
title: How to validate an argument using a script
---
# How to validate an argument using a script

This example shows how to specify a validation rule that uses a script to check the parameter
argument before the cmdlet is run. The value of the parameter is piped to the script. The script
must return `$true` for every value piped to it.

> [!NOTE]
> For more information about the class that defines this attribute, see
> [System.Management.Automation.ValidateScriptAttribute](/dotnet/api/System.Management.Automation.ValidateScriptAttribute).

## To validate an argument using a script

- Add the ValidateScript attribute as shown in the following code. This example specifies a script
  to validate that the input value is an odd number.

   ```csharp
   [ValidateScript("$_ % 2", ErrorMessage = "The item '{0}' did not pass validation of script '{1}'")]
   [Parameter(Position = 0, Mandatory = true)]
   public int32 OddNumber
   {
     get { return oddNumber; }
     set { oddNumber = value; }
   }

   private int32 oddNumber;
   ```

For more information about how to declare this attribute, see
[ValidateScript Attribute Declaration](./ValidateScript-attribute-declaration.md).

## See Also

[System.Management.Automation.ValidateScriptAttribute](/dotnet/api/System.Management.Automation.ValidateScriptAttribute)

[ValidateScript Attribute Declaration](./ValidateScript-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
