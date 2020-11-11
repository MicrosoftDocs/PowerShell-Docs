---
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Dynamic Parameters
description: Cmdlet Dynamic Parameters
---

# Cmdlet dynamic parameters

Cmdlets can define parameters that are available to the user under special conditions, such as when
the argument of another parameter is a specific value. These parameters are added at runtime and are
referred to as dynamic parameters because they're only added when needed. For example, you can
design a cmdlet that adds several parameters only when a specific switch parameter is specified.

> [!NOTE]
> Providers and PowerShell functions can also define dynamic parameters.

## Dynamic parameters in PowerShell cmdlets

PowerShell uses dynamic parameters in several of its provider cmdlets. For example, the `Get-Item`
and `Get-ChildItem` cmdlets add a **CodeSigningCert** parameter at runtime when the **Path**
parameter specifies the **Certificate** provider path. If the **Path** parameter specifies a path
for a different provider, the **CodeSigningCert** parameter isn't available.

The following examples show how the **CodeSigningCert** parameter is added at runtime when
`Get-Item` is run.

In this example, the PowerShell runtime has added the parameter and the cmdlet is successful.

```powershell
Get-Item -Path cert:\CurrentUser -CodeSigningCert
```

```Output
Location   : CurrentUser
StoreNames : {SmartCardRoot, UserDS, AuthRoot, CA...}
```

In this example, a **FileSystem** drive is specified and an error is returned. The error message
indicates that the **CodeSigningCert** parameter can't be found.

```powershell
Get-Item -Path C:\ -CodeSigningCert
```

```Output
Get-Item : A parameter cannot be found that matches parameter name 'codesigningcert'.
At line:1 char:37
+  get-item -path C:\ -codesigningcert <<<<
--------
    CategoryInfo          : InvalidArgument: (:) [Get-Item], ParameterBindingException
    FullyQualifiedErrorId : NamedParameterNotFound,Microsoft.PowerShell.Commands.GetItemCommand
```

## Support for dynamic parameters

To support dynamic parameters, the following elements must be included in the cmdlet code.

### Interface

[System.Management.Automation.IDynamicParameters](/dotnet/api/System.Management.Automation.IDynamicParameters).
This interface provides the method that retrieves the dynamic parameters.

For example:

`public class SendGreetingCommand : Cmdlet, IDynamicParameters`

### Method

[System.Management.Automation.IDynamicParameters.GetDynamicParameters](/dotnet/api/System.Management.Automation.IDynamicParameters.GetDynamicParameters).
This method retrieves the object that contains the dynamic parameter definitions.

For example:

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

### Class

A class that defines the dynamic parameters to be added. This class must include a **Parameter**
attribute for each parameter and any optional **Alias** and **Validation** attributes that are
needed by the cmdlet.

For example:

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

For a complete example of a cmdlet that supports dynamic parameters, see [How to Declare Dynamic Parameters](./how-to-declare-dynamic-parameters.md).

## See also

[System.Management.Automation.IDynamicParameters](/dotnet/api/System.Management.Automation.IDynamicParameters)

[System.Management.Automation.IDynamicParameters.GetDynamicParameters](/dotnet/api/System.Management.Automation.IDynamicParameters.GetDynamicParameters)

[How to Declare Dynamic Parameters](./how-to-declare-dynamic-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
