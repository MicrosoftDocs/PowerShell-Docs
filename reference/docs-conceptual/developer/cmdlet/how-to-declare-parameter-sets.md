---
ms.date: 09/13/2016
ms.topic: reference
title: How to Declare Parameter Sets
description: How to Declare Parameter Sets
---
# How to Declare Parameter Sets

This example shows how to define two parameter sets when you declare the parameters for a cmdlet. Each parameter set has both a unique parameter and a shared parameter that is used by both parameter sets. For more information about parameters sets, including how to specify the default parameter set, see [Cmdlet Parameter Sets](./cmdlet-parameter-sets.md).

> [!IMPORTANT]
> Whenever possible, define the unique parameter of a parameter set as a required parameter. However, if you want your cmdlet to run without specifying any parameters, the unique parameter can be an optional parameter. For example, the unique parameter of the `Get-Command` cmdlet is optional.

## How to Define Two Parameter Sets

1. Add the `ParameterSet` keyword to the Parameter attribute for the unique parameter of the first parameter set.

   ```csharp
   [Parameter(Position = 0, Mandatory = true,
              ParameterSetName = "Test01")]
   public string UserName
   {
     get { return userName; }
     set { userName = value; }
   }
   private string userName;
   ```

2. Add the `ParameterSet` keyword to the Parameter attribute for the unique parameter of the second parameter set.

   ```csharp
   [Parameter(Position = 0, Mandatory = true,
              ParameterSetName = "Test02")]
   public string ComputerName
   {
     get { return computerName; }
     set { computerName = value; }
   }
   private string computerName;
   ```

3. For the parameter that belongs to both parameter sets, add a Parameter attribute for each parameter set and then add the `ParameterSet` keyword to each set. In each Parameter attribute, you can specify how that parameter is defined. A parameter can be optional in one set and mandatory in another.

   ```csharp
   [Parameter(Mandatory= true, ParameterSetName = "Test01")]
   [Parameter(ParameterSetName = "Test02")]
   public string SharedParam
   {
       get { return sharedParam; }
       set { sharedParam = value; }
   }
   private string sharedParam;
   ```

## See Also

[Cmdlet Parameter Sets](./cmdlet-parameter-sets.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
