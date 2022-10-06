---
description: How to Invoke a Cmdlet from Within a Cmdlet
ms.date: 10/06/2022
ms.topic: reference
title: How to Invoke a Cmdlet from Within a Cmdlet
---
# How to Invoke a Cmdlet from Within a Cmdlet

This example shows how to invoke a cmdlet from within another cmdlet, which allows you to add the
functionality of the invoked cmdlet to the cmdlet you are developing. In this example, the
`Get-Process` cmdlet is invoked to get the processes that are running on the local computer. The
call to the `Get-Process` cmdlet is equivalent to the following command. This command retrieves all
the processes whose names start with the characters "a" through "t".

```powershell
Get-Process -name [a-t]
```

> [!IMPORTANT]
> You can invoke only those cmdlets that derive directly from the
> [System.Management.Automation.Cmdlet][01] class. You can't invoke a cmdlet that derives from the
> [System.Management.Automation.PSCmdlet][02] class. For an example, see
> [How to invoke a PSCmdlet from within a PSCmdlet][07].

## To invoke a cmdlet from within a cmdlet

1. Ensure that the assembly that defines the cmdlet to be invoked is referenced and that the
   appropriate `using` statement is added. In this example, the following namespaces are added.

    ```csharp
    using System.Diagnostics;
    using System.Management.Automation;   // Windows PowerShell assembly.
    using Microsoft.PowerShell.Commands;  // Windows PowerShell assembly.
    ```

1. In the input processing method of the cmdlet, create a new instance of the cmdlet to be invoked.
   In this example, an object of type [Microsoft.PowerShell.Commands.GetProcessCommand][03] is
   created along with the string that contains the arguments that are used when the cmdlet is
   invoked.

    ```csharp
    GetProcessCommand gp = new GetProcessCommand();
    gp.Name = new string[] { "[a-t]*" };
    ```

1. Call the [System.Management.Automation.Cmdlet.Invoke*][04] method to invoke the `Get-Process`
   cmdlet.

    ```csharp
      foreach (Process p in gp.Invoke<Process>())
      {
        Console.WriteLine(p.ToString());
      }
    }
    ```

## Example

In this example, the `Get-Process` cmdlet is invoked from within the
[System.Management.Automation.Cmdlet.BeginProcessing][05] method of a cmdlet.

```csharp
using System;
using System.Diagnostics;
using System.Management.Automation;   // Windows PowerShell assembly.
using Microsoft.PowerShell.Commands;  // Windows PowerShell assembly.

namespace SendGreeting
{
  // Declare the class as a cmdlet and specify an
  // appropriate verb and noun for the cmdlet name.
  [Cmdlet(VerbsCommunications.Send, "GreetingInvoke")]
  public class SendGreetingInvokeCommand : Cmdlet
  {
    // Declare the parameters for the cmdlet.
    [Parameter(Mandatory = true)]
    public string Name
    {
      get { return name; }
      set { name = value; }
    }
    private string name;

    // Override the BeginProcessing method to invoke
    // the Get-Process cmdlet.
    protected override void BeginProcessing()
    {
      GetProcessCommand gp = new GetProcessCommand();
      gp.Name = new string[] { "[a-t]*" };
      foreach (Process p in gp.Invoke<Process>())
      {
        Console.WriteLine(p.ToString());
      }
    }

    // Override the ProcessRecord method to process
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

[Writing a Windows PowerShell Cmdlet][06]

<!-- link references -->
[01]: /dotnet/api/System.Management.Automation.Cmdlet
[02]: /dotnet/api/System.Management.Automation.PSCmdlet
[03]: /dotnet/api/Microsoft.PowerShell.Commands.GetProcessCommand
[04]: /dotnet/api/System.Management.Automation.Cmdlet.Invoke
[05]: /dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing
[06]: ./writing-a-windows-powershell-cmdlet.md
[07]: ./how-to-invoke-a-pscmdlet-from-within-a-pscmdlet.md
