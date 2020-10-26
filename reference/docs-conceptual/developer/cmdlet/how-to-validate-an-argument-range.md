---
ms.date: 09/13/2016
ms.topic: reference
title: How to Validate an Argument Range
description: How to Validate an Argument Range
---
# How to Validate an Argument Range

This example shows how to specify a validation rule that the Windows PowerShell runtime can use to check the minimum and maximum values of the parameter argument before the cmdlet is run. You set this validation rule by declaring the ValidateRange attribute.

> [!NOTE]
> For more information about the class that defines this attribute, see [System.Management.Automation.Validaterangeattribute](/dotnet/api/System.Management.Automation.ValidateRangeAttribute).

### To validate an argument range

- Add the ValidateRange attribute as shown in the following code. This example specifies a range of 0 to 5 for the `InputData` parameter.

    ```csharp
    [ValidateRange(0, 5)]
    [Parameter(Position = 0, Mandatory = true)]
    public int InputData
    {
      get { return inputData; }
      set { inputData = value; }
    }
    private int inputData;
    ```

For more information about how to declare this attribute, see [ValidateRange Attribute Declaration](./validaterange-attribute-declaration.md).

## See Also

[ValidateRange Attribute Declaration](./validaterange-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
