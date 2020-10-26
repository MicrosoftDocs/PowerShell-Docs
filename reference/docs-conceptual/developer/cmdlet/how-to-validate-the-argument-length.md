---
ms.date: 09/13/2016
ms.topic: reference
title: How to Validate the Argument Length
description: How to Validate the Argument Length
---
# How to Validate the Argument Length

This example shows how to specify a validation rule that the Windows PowerShell runtime can use to check the number of characters (the length) of the parameter argument before the cmdlet is run. You set this validation rule by declaring the ValidateLength attribute.

> [!NOTE]
> For more information about the class that defines this attribute, see [System.Management.Automation.Validatelengthattribute](/dotnet/api/System.Management.Automation.ValidateLengthAttribute).

## To validate the argument length

- Add the Validate attribute as shown in the following code. This example specifies that the length of the argument should have a length of 0 to 10 characters.

    ```csharp
    [ValidateLength(0, 10)]
    [Parameter(Position = 0, Mandatory = true)]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

For more information about how to declare this attribute, see [ValidateLength Attribute Declaration](./validatelength-attribute-declaration.md).

## See Also

[ValidateLength Attribute Declaration](./validatelength-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
