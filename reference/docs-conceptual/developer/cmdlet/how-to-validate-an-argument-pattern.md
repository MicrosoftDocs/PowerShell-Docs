---
ms.date: 09/13/2016
ms.topic: reference
title: How to Validate an Argument Pattern
description: How to Validate an Argument Pattern
---
# How to Validate an Argument Pattern

This example shows how to specify a validation rule that the Windows PowerShell runtime can use to check the character pattern of the parameter argument before the cmdlet is run. You set this validation rule by declaring the ValidatePattern attribute.

> [!NOTE]
> For more information about the class that defines this attribute, see [System.Management.Automation.Validatepatternattribute](/dotnet/api/System.Management.Automation.ValidatePatternAttribute).

## To validate an argument pattern

- Add the Validate attribute as shown in the following code. This example specifies a pattern of four digits, where each digit has a value of 0 through 9.

    ```csharp
    [ValidatePattern("[0-9][0-9][0-9][0-9]")]
    [Parameter(Position = 0, Mandatory = true)]
    public int InputData
    {
      get { return inputData; }
      set { inputData = value; }
    }

    private int inputData;
    ```

For more information about how to declare this attribute, see [ValidatePattern Attribute Declaration](./validatepattern-attribute-declaration.md).

## See Also

[ValidatePattern Attribute Declaration](./validatepattern-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
