---
description: How to Declare Dynamic Parameters
ms.date: 09/13/2016
ms.topic: reference
title: How to Declare Dynamic Parameters
---
# How to Declare Dynamic Parameters

This example shows how to define dynamic parameters that are added to the cmdlet at runtime. In this
example, the `Department` parameter is added to the cmdlet whenever the user specifies the
`Employee` switch parameter. For more information about dynamic parameters, see
[Cmdlet Dynamic Parameters][02].

## To define dynamic parameters

1. In the cmdlet class declaration, add the [System.Management.Automation.Idynamicparameters][03]
   interface as shown.

   ```csharp
   public class SendGreetingCommand : Cmdlet, IDynamicParameters
   ```

1. Call the [System.Management.Automation.Idynamicparameters.Getdynamicparameters*][04] method,
   which returns the object in which the dynamic parameters are defined. In this example, the method
   is called when the `Employee` parameter is specified.

   ```csharp
   public object GetDynamicParameters()
   {
       if (employee)
       {
         context= new SendGreetingCommandDynamicParameters();
         return context;
       }
       return null;
   }
   private SendGreetingCommandDynamicParameters context;
   ```

1. Declare a class that defines the dynamic parameters to be added. You can use the attributes that
   you used to declare the static cmdlet parameters to declare the dynamic parameters.

   ```csharp
   public class SendGreetingCommandDynamicParameters
   {
     [Parameter]
     [ValidateSet ("Marketing", "Sales", "Development")]
     public string Department
     {
       get { return department; }
       set { department = value; }
     }
     private string department;
   }
   ```

## Example

In this example, the `Department` parameter is added whenever the user specifies the `Employee`
parameter. The `Department` parameter is an optional parameter, and the ValidateSet attribute is
used to specify the allowed arguments.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management.Automation;     // PowerShell assembly.

namespace SendGreeting
{
  // Declare the cmdlet class that supports the
  // IDynamicParameters interface.
  [Cmdlet(VerbsCommunications.Send, "Greeting")]
  public class SendGreetingCommand : Cmdlet, IDynamicParameters
  {
    // Declare the parameters for the cmdlet.
    [Parameter(Mandatory = true)]
    public string Name
    {
      get { return name; }
      set { name = value; }
    }
    private string name;

    [Parameter]
    [Alias ("FTE")]
    public SwitchParameter Employee
    {
      get { return employee; }
      set { employee = value; }
    }
    private Boolean employee;

    // Implement GetDynamicParameters to
    // retrieve the dynamic parameter.
    public object GetDynamicParameters()
    {
      if (employee)
      {
        context= new SendGreetingCommandDynamicParameters();
        return context;
      }
      return null;
   }
   private SendGreetingCommandDynamicParameters context;

    // Override the ProcessRecord method to process the
    // supplied user name and write out a greeting to
    // the user by calling the WriteObject method.
    protected override void ProcessRecord()
    {
      WriteObject("Hello " + name + "! ");
      if (employee)
      {
        WriteObject("Department: " + context.Department);
      }
    }
  }

  // Define the dynamic parameters to be added
  public class SendGreetingCommandDynamicParameters
  {
    [Parameter]
    [ValidateSet ("Marketing", "Sales", "Development")]
    public string Department
    {
      get { return department; }
      set { department = value; }
    }
    private string department;
  }
}
```

## See Also

- [System.Management.Automation.RuntimeDefinedParameterDictionary][05]
- [System.Management.Automation.IDynamicParameters.GetDynamicParameters*][04]
- [Cmdlet Dynamic Parameters][02]
- [Windows PowerShell SDK][01]

<!-- link references -->
[01]: ../windows-powershell-reference.md
[02]: cmdlet-dynamic-parameters.md
[03]: xref:System.Management.Automation.IDynamicParameters
[04]: xref:System.Management.Automation.IDynamicParameters.GetDynamicParameters
[05]: xref:System.Management.Automation.RuntimeDefinedParameterDictionary
