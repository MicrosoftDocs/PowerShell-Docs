---
ms.date: 09/13/2016
ms.topic: reference
title: Adding and invoking commands
description: Adding and invoking commands
---
# Adding and invoking commands

After creating a runspace, you can add Windows PowerShellcommands and scripts to a pipeline, and
then invoke the pipeline synchronously or asynchronously.

## Creating a pipeline

The [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell)
class provides several methods to add commands, parameters, and scripts to the pipeline. You can
invoke the pipeline synchronously by calling an overload of the
[System.Management.Automation.Powershell.Invoke*](/dotnet/api/System.Management.Automation.PowerShell.Invoke)
method, or asynchronously by calling an overload of the
[System.Management.Automation.Powershell.Begininvoke*](/dotnet/api/System.Management.Automation.PowerShell.BeginInvoke)
and then the
[System.Management.Automation.Powershell.Endinvoke*](/dotnet/api/System.Management.Automation.PowerShell.EndInvoke)
method.

### AddCommand

1. Create a [System.Management.Automation.Powershell](/dotnet/api/system.management.automation.powershell) object.

   ```csharp
   PowerShell ps = PowerShell.Create();
   ```

2. Add the command that you want to execute.

   ```csharp
   ps.AddCommand("Get-Process");
   ```

3. Invoke the command.

   ```csharp
   ps.Invoke();
   ```

If you call the
[System.Management.Automation.Powershell.Addcommand*](/dotnet/api/System.Management.Automation.PowerShell.AddCommand)
method more than once before you call the
[System.Management.Automation.Powershell.Invoke*](/dotnet/api/System.Management.Automation.PowerShell.Invoke)
method, the result of the first command is piped to the second, and so on. If you do not want to
pipe the result of a previous command to a command, add it by calling the
[System.Management.Automation.Powershell.Addstatement*](/dotnet/api/System.Management.Automation.PowerShell.AddStatement)
instead.

### AddParameter

 The previous example executes a single command without any parameters. You can add parameters to
 the command by using the
 [System.Management.Automation.Pscommand.Addparameter*](/dotnet/api/System.Management.Automation.PSCommand.AddParameter)
 method For example, the following code gets a list of all of the processes that are named
 `PowerShell` running on the machine.

```csharp
PowerShell.Create().AddCommand("Get-Process")
                   .AddParameter("Name", "PowerShell")
                   .Invoke();
```

You can add additional parameters by calling
[System.Management.Automation.Pscommand.Addparameter*](/dotnet/api/System.Management.Automation.PSCommand.AddParameter)
repeatedly.

```csharp
PowerShell.Create().AddCommand("Get-Command")
                   .AddParameter("Name", "Get-VM")
                   .AddParameter("Module", "Hyper-V")
                   .Invoke();
```

You can also add a dictionary of parameter names and values by calling the
[System.Management.Automation.Powershell.Addparameters*](/dotnet/api/System.Management.Automation.PowerShell.AddParameters)
method.

```csharp
IDictionary parameters = new Dictionary<String, String>();
parameters.Add("Name", "Get-VM");

parameters.Add("Module", "Hyper-V");
PowerShell.Create().AddCommand("Get-Command")
   .AddParameters(parameters)
      .Invoke()

```

### AddStatement

You can simulate batching by using the
[System.Management.Automation.Powershell.Addstatement*](/dotnet/api/System.Management.Automation.PowerShell.AddStatement)
method, which adds an additional statement to the end of the pipeline The following code gets a list
of running processes with the name `PowerShell`, and then gets the list of running services.

```csharp
PowerShell ps = PowerShell.Create();
ps.AddCommand("Get-Process").AddParameter("Name", "PowerShell");
ps.AddStatement().AddCommand("Get-Service");
ps.Invoke();
```

### AddScript

You can run an existing script by calling the
[System.Management.Automation.Powershell.Addscript*](/dotnet/api/System.Management.Automation.PowerShell.AddScript)
method. The following example adds a script to the pipeline and runs it. This example assumes there
is already a script named `MyScript.ps1` in a folder named `D:\PSScripts`.

```csharp
PowerShell ps = PowerShell.Create();
ps.AddScript("D:\PSScripts\MyScript.ps1").Invoke();
```

There is also a version of the
[System.Management.Automation.Powershell.Addscript*](/dotnet/api/System.Management.Automation.PowerShell.AddScript)
method that takes a boolean parameter named `useLocalScope`. If this parameter is set to `true`,
then the script is run in the local scope. The following code will run the script in the local
scope.

```csharp
PowerShell ps = PowerShell.Create();
ps.AddScript(@"D:\PSScripts\MyScript.ps1", true).Invoke();
```

### Invoking a pipeline synchronously

After you add elements to the pipeline, you invoke it. To invoke the pipeline synchronously, you
call an overload of the
[System.Management.Automation.Powershell.Invoke*](/dotnet/api/System.Management.Automation.PowerShell.Invoke)
method. The following example shows how to synchronously invoke a pipeline.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management.Automation;

namespace HostPS1e
{
  class HostPS1e
  {
    static void Main(string[] args)
    {
      // Using the PowerShell.Create and AddCommand
      // methods, create a command pipeline.
      PowerShell ps = PowerShell.Create().AddCommand ("Sort-Object");

      // Using the PowerShell.Invoke method, run the command
      // pipeline using the supplied input.
      foreach (PSObject result in ps.Invoke(new int[] { 3, 1, 6, 2, 5, 4 }))
      {
          Console.WriteLine("{0}", result);
      } // End foreach.
    } // End Main.
  } // End HostPS1e.
}
```

### Invoking a pipeline asynchronously

You invoke a pipeline asynchronously by calling an overload of the
[System.Management.Automation.Powershell.Begininvoke*](/dotnet/api/System.Management.Automation.PowerShell.BeginInvoke)
to create an [IAsyncResult](/dotnet/api/system.iasyncresult) object, and then calling the
[System.Management.Automation.Powershell.Endinvoke*](/dotnet/api/System.Management.Automation.PowerShell.EndInvoke)
method.

 The following example shows how to invoke a pipeline asynchronously.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management.Automation;

namespace HostPS3
{
  class HostPS3
  {
    static void Main(string[] args)
    {
      // Use the PowerShell.Create and PowerShell.AddCommand
      // methods to create a command pipeline that includes
      // Get-Process cmdlet. Do not include spaces immediately
      // before or after the cmdlet name as that will cause
      // the command to fail.
      PowerShell ps = PowerShell.Create().AddCommand("Get-Process");

      // Create an IAsyncResult object and call the
      // BeginInvoke method to start running the
      // command pipeline asynchronously.
      IAsyncResult async = ps.BeginInvoke();

      // Using the PowerShell.Invoke method, run the command
      // pipeline using the default runspace.
      foreach (PSObject result in ps.EndInvoke(async))
      {
        Console.WriteLine("{0,-20}{1}",
                result.Members["ProcessName"].Value,
                result.Members["Id"].Value);
      } // End foreach.
      System.Console.WriteLine("Hit any key to exit.");
      System.Console.ReadKey();
    } // End Main.
  } // End HostPS3.
}
```

## See Also

 [Creating an InitialSessionState](./creating-an-initialsessionstate.md)

 [Creating a constrained runspace](./creating-a-constrained-runspace.md)
