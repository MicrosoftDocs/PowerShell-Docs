---
description: How to Write a Simple Cmdlet
ms.date: 11/02/2026
title: How to Write a Simple Cmdlet
---

# How to write a cmdlet

This article shows how to write a cmdlet. The `Send-Greeting` cmdlet takes a single user name as
input and then writes a greeting to that user. Although the cmdlet does not do much work, this
example demonstrates the major sections of a cmdlet.

## Prerequisites

To compile this C# cmdlet, create a class library project that references
the `System.Management.Automation` assembly.

For Windows PowerShell 5.1, add the
[`Microsoft.PowerShell.5.1.ReferenceAssemblies`](https://www.nuget.org/packages/Microsoft.PowerShell.5.1.ReferenceAssemblies)
NuGet package to your project:

```xml
<PackageReference Include="Microsoft.PowerShell.5.1.ReferenceAssemblies" Version="1.0.0" PrivateAssets="all" />
```

This package targets .NET Framework 4.6.1 or later. For Windows
PowerShell 5.0, use
[`Microsoft.PowerShell.5.ReferenceAssemblies`](https://www.nuget.org/packages/Microsoft.PowerShell.5.ReferenceAssemblies).

Reference assemblies are used for compilation and shouldn't be
redistributed with a binary module loaded into an existing PowerShell
installation.

For other target versions, see
[Choosing the right PowerShell NuGet package](../../dev-cross-plat/choosing-the-right-nuget-package.md).

## Steps to write a cmdlet

1. To declare the class as a cmdlet, use the **Cmdlet** attribute. The **Cmdlet** attribute
   specifies the verb and the noun for the cmdlet name.

   For more information about the **Cmdlet** attribute, see [CmdletAttribute Declaration](cmdlet-attribute-declaration.md).

2. Specify the name of the class.

3. Specify that the cmdlet derives from either of the following classes:

   * [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet)
   * [System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet)

4. To define the parameters for the cmdlet, use the **Parameter** attribute. In this case, only one
   required parameter is specified.

   For more information about the **Parameter** attribute, see [ParameterAttribute Declaration](parameter-attribute-declaration.md).

5. Override the input processing method that processes the input. In this case, the
   [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
   method is overridden.

6. To write the greeting, use the method [System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject).
   The greeting is displayed in the following format:

   ```Output
   Hello <UserName>!
   ```

## Example

```csharp
using System.Management.Automation;  // Windows PowerShell assembly.

namespace SendGreeting
{
  // Declare the class as a cmdlet and specify the
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

## See also

[System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet)

[System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet)

[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)

[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)

[CmdletAttribute Declaration](cmdlet-attribute-declaration.md)

[ParameterAttribute Declaration](parameter-attribute-declaration.md)

[Writing a Windows PowerShell Cmdlet](writing-a-windows-powershell-cmdlet.md)
