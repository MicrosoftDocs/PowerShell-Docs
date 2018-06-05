---
title: "How to Write a Simple Cmdlet | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 137543d8-0012-4cba-bcd6-98b25aac83bb
caps.latest.revision: 9
---
# How to Write a Simple Cmdlet

This topic shows how to write a simple cmdlet (the **Send-Greeting** cmdlet) that takes a single user name as input  and then writes a greeting to that user. Although the cmdlet does not do much work, this example demonstrates the major sections of a cmdlet.

## To Write a Simple Cmdlet

1. Use the Cmdlet attribute to declare the class as a cmdlet. This attribute specifies the verb and the noun for the cmdlet name.

    For more information about how to declare the Cmdlet attribute, see [CmdletAttribute Declaration](./cmdlet-attribute-declaration.md).

2. Specify the name of the class.

3. Specify that the cmdlet derives from the [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) or [System.Management.Automation.Pscmdlet](/dotnet/api/System.Management.Automation.PSCmdlet) class.

4. Use the Parameter attribute to define the parameters for the cmdlet. In this case, only one required parameter is specified.

    For more information about how to declare the Parameter attribute, see [ParameterAttribute Declaration](./parameter-attribute-declaration.md).

5. Override the input processing method that will process the input. In this case, the [System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method is overridden.

6. Use the [System.Management.Automation.Cmdlet.Writeobject*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) method to write the following greeting: "Hello [UserName]!".

## Example

```vb
using System.Management.Automation;  // Windows PowerShell assembly.

namespace SendGreeting
{
  // Declare the class as a cmdlet and specify and
  // appropriate verb and noun for the cmdlet name.
  [Cmdlet(VerbsCommunications.Send, "Greeting")]
  public class SendGreetingCommand : Cmdlet
  {
    // Declare the parameters for the cmdlet.
    [Parameter(Mandatory=true)]
    public string Name
    {
      get { return name; }
      set { name = value; }
    }
    private string name;

    // Overide the ProcessRecord method to process
    // the supplied user name and write out a
    // greeting to the user by calling the WriteObject
    // method.
    protected override void ProcessRecord()
    {
      WriteObject("Hello " + name + "!");
    }
  }
}
```

## See Also

[System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet)

[System.Management.Automation.Pscmdlet](/dotnet/api/System.Management.Automation.PSCmdlet)

[System.Management.Automation.Cmdlet.Processrecord*](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)

[System.Management.Automation.Cmdlet.Writeobject*](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)

[CmdletAttribute Declaration](./cmdlet-attribute-declaration.md)

[ParameterAttribute Declaration](./parameter-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
