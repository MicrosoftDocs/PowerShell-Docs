---
ms.date: 09/13/2016
ms.topic: reference
title: How to Validate an Argument Count
description: How to Validate an Argument Count
---
# How to Validate an Argument Count

This example shows how to specify a validation rule that the Windows PowerShell runtime can use to check the number of arguments (the count) that a parameter accepts before the cmdlet is run. You set this validation rule by declaring the ValidateCount attribute.

> [!NOTE]
> For more information about the class that defines this attribute, see [System.Management.Automation.Validatecountattribute](/dotnet/api/System.Management.Automation.ValidateCountAttribute).

## To validate an argument count

- Add the Validate attribute as shown in the following code. This example specifies that the parameter will accept one argument or as many as three arguments.

    ```csharp
    [ValidateCount(1, 3)]
    [Parameter(Position = 0, Mandatory = true)]
    public string[] UserNames
    {
      get { return userNames; }
      set { userNames = value; }
    }

    private string[] userNames;
    ```

For more information about how to declare this attribute, see [ValidateCount Attribute Declaration](./validatecount-attribute-declaration.md).

## See Also

[ValidateCount Attribute Declaration](./validatecount-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
