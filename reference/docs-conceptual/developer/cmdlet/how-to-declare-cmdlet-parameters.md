---
ms.date: 09/13/2016
ms.topic: reference
title: How to Declare Cmdlet Parameters
description: How to Declare Cmdlet Parameters
---
# How to Declare Cmdlet Parameters

These examples show how to declare named, positional, required, optional, and switch parameters. These examples also show how to define a parameter alias.

## How to Declare a Named Parameter

- Define a public property as shown in the following code. When you add the Parameter attribute, omit the `Position` keyword from the attribute.

    ```csharp
    [Parameter()]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

For more information about the Parameter attribute, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

## How to Declare a Positional Parameter

- Define a public property as shown in the following code. When you add the Parameter attribute, set the `Position` keyword to the argument position. A value of 0 indicates the first position.

    ```csharp
    [Parameter(Position = 0)]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

For more information about the Parameter attribute, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

## How to Declare a Mandatory Parameter

- Define a public property as shown in the following code. When you add the Parameter attribute, set the `Mandatory` keyword to `true`.

    ```csharp
    [Parameter(Position = 0, Mandatory = true)]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

For more information about the Parameter attribute, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

## How to Declare an Optional Parameter

- Define a public property as shown in the following code. When you add the Parameter attribute, omit the `Mandatory` keyword.

    ```csharp
    [Parameter(Position = 0)]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

## How to Declare a Switch Parameter

- Define a public property as type [System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter), and then declare the Parameter attribute.

    ```csharp
    [Parameter(Position = 1)]
    public SwitchParameter GoodBye
    {
      get { return goodbye; }
      set { goodbye = value; }
    }
    private bool goodbye;
    ```

For more information about the Parameter attribute, see [Parameter Attribute Declaration](./parameter-attribute-declaration.md).

## How to Declare a Parameter with Aliases

- Define a public property as shown in the following code. Add an Alias attribute that lists the aliases for the parameter. In this example, three aliases are defined for the same parameter. The first alias provides a shortcut. The second and third aliases provide names you can use for different scenarios.

    ```csharp
    [Alias("UN","Writer","Editor")]
    [Parameter()]
    public string UserName
    {
      get { return userName; }
      set { userName = value; }
    }
    private string userName;
    ```

For more information about the Alias attribute, see [Alias Attribute Declaration](./alias-attribute-declaration.md).

## See Also

[System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter)

[Parameter Attribute Declaration](./parameter-attribute-declaration.md)

[Alias Attribute Declaration](./alias-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
