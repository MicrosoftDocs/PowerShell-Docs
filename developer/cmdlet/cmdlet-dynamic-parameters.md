---
title: "Cmdlet Dynamic Parameters | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 8ae2196d-d6c8-4101-8805-4190d293af51
caps.latest.revision: 13
---
# Cmdlet Dynamic Parameters

Cmdlets can define parameters that are available to the user under special conditions, such as when the argument of another parameter is a specific value. These parameters are added at runtime and are referred to as *dynamic parameters* because they are added only when they are needed. For example, you can design a cmdlet that adds several parameters only when a specific switch parameter is specified.

> [!NOTE]
> Providers and Windows PowerShell functions can also define dynamic parameters.

## Dynamic Parameters in Windows PowerShell Cmdlets

Windows PowerShell uses dynamic parameters in several of its provider cmdlets. For example, the `Get-Item` and `Get-ChildItem` cmdlets add a `CodeSigningCert` parameter at runtime when the `Path` parameter of the cmdlet specifies the Certificate provider path. If the `Path` parameter of the cmdlet specifies a path for a different provider, the `CodeSigningCert` parameter is not available.

The following examples show how the `CodeSigningCert` parameter is added at runtime when the `Get-Item` cmdlet is run.

In the first example, the Windows PowerShell runtime has added the parameter, and the cmdlet is successful.

```powershell
Get-Item -Path cert:\CurrentUser -codesigningcert
```

```output
Location   : CurrentUser
StoreNames : {SmartCardRoot, UserDS, AuthRoot, CA...}
```

In the second example, a FileSystem drive is specified, and an error is returned. The error message indicates that the `CodeSigningCert` parameter cannot be found.

```powershell
Get-Item -Path C:\ -codesigningcert
```

```output
Get-Item : A parameter cannot be found that matches parameter name 'codesigningcert'.
At line:1 char:37
+  get-item -path C:\ -codesigningcert <<<<
--------
    CategoryInfo          : InvalidArgument: (:) [Get-Item], ParameterBindingException
    FullyQualifiedErrorId : NamedParameterNotFound,Microsoft.PowerShell.Commands.GetItemCommand
```

## Support for Dynamic Parameters

To support dynamic parameters, the cmdlet code must include the following elements.

[System.Management.Automation.Idynamicparameters](/dotnet/api/System.Management.Automation.IDynamicParameters)
This interface provides the method that retrieves the dynamic parameters.

Example:

`public class SendGreetingCommand : Cmdlet, IDynamicParameters`

[System.Management.Automation.Idynamicparameters.Getdynamicparameters*](/dotnet/api/System.Management.Automation.IDynamicParameters.GetDynamicParameters)
This method retrieves the object that contains the dynamic parameter definitions.

Example:

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

Dynamic Parameter class
This class defines the parameters to be added. This class must include a Parameter attribute for each parameter and any optional Alias and Validation attributes that are needed by the cmdlet.

Example:

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

## See Also

[System.Management.Automation.Idynamicparameters](/dotnet/api/System.Management.Automation.IDynamicParameters)

[System.Management.Automation.Idynamicparameters.Getdynamicparameters*](/dotnet/api/System.Management.Automation.IDynamicParameters.GetDynamicParameters)

[How to Declare Dynamic Parameters](./how-to-declare-dynamic-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
