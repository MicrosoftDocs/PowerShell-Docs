---
ms.date: 09/13/2016
ms.topic: reference
title: Types of Cmdlet Parameters
description: Types of Cmdlet Parameters
---
# Types of Cmdlet Parameters

This topic describes the different types of parameters that you can declare in cmdlets. Cmdlet parameters can be positional, named, required, optional, or switch parameters.

## Positional and Named Parameters

All cmdlet parameters are either named or positional parameters. A named parameter requires that you type the parameter name and argument when calling the cmdlet. A positional parameter requires only that you type the arguments in relative order. The system then maps the first unnamed argument to the first positional parameter. The system maps the second unnamed argument to the second unnamed parameter, and so on. By default, all cmdlet parameters are named parameters.

To define a named parameter, omit the `Position` keyword in the **Parameter** attribute declaration, as shown in the following parameter declaration.

```csharp
[Parameter(ValueFromPipeline=true)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

To define a positional parameter, add the `Position` keyword in the Parameter attribute declaration, and then specify a position. In the following sample, the `UserName` parameter is declared as a positional parameter with position 0. This means that the first argument of the call will be automatically bound to this parameter.

```csharp
[Parameter(Position = 0)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

> [!NOTE]
> Good cmdlet design recommends that the most-used parameters be declared as positional parameters so that the user does not have to enter the parameter name when the cmdlet is run.

Positional and named parameters accept single arguments or multiple arguments separated by commas. Multiple arguments are allowed only if the parameter accepts a collection such as an array of strings. You may mix positional and named parameters in the same cmdlet. In this case, the system retrieves the named arguments first, and then attempts to map the remaining unnamed arguments to the positional parameters.

The following commands show the different ways in which you can specify single and multiple arguments for the parameters of the `Get-Command` cmdlet. Notice that in the last two samples, **-name** does not need to be specified because the `Name` parameter is defined as a positional parameter.

```powershell
Get-Command -Name get-service
Get-Command -Name get-service,set-service
Get-Command get-service
Get-Command get-service,set-service
```

## Mandatory and Optional Parameters

You can also define cmdlet parameters as mandatory or optional parameters. (A mandatory parameter must be specified before the Windows PowerShell runtime invokes the cmdlet.)  By default, parameters are defined as optional.

To define a mandatory parameter, add the `Mandatory` keyword in the Parameter attribute declaration, and set it to `true`, as shown in the following parameter declaration.

```csharp
[Parameter(Position = 0, Mandatory = true)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

To define an optional parameter, omit the `Mandatory` keyword in the **Parameter** attribute declaration, as shown in the following parameter declaration.

```csharp
[Parameter(Position = 0)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

## Switch Parameters

Windows PowerShell provides a [System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter) type that allows you to define a parameter whose value is automatically set to `false` if the parameter is not specified when the cmdlet is called. Whenever possible, use switch parameters in place of Boolean parameters.

Consider the following sample. By default, several Windows PowerShell cmdlets do not pass an output object down the pipeline. However, these cmdlets have a `PassThru` switch parameter that overrides the default behavior. If the `PassThru` parameter is specified when these cmdlets are called, the cmdlet returns an output object to the pipeline.

If you need the parameter to have a default value of `true` when the parameter is not specified in the call, consider reversing the sense of the parameter. For sample, instead of setting the parameter attribute to a Boolean value of `true`, declare the property as the [System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter) type, and then set the default value of the parameter to `false`.

To define a switch parameter, declare the property as the [System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter) type, as shown in the following sample.

```csharp
[Parameter(Position = 1)]
public SwitchParameter GoodBye
{
  get { return goodbye; }
  set { goodbye = value; }
}
private bool goodbye;
```

To make the cmdlet act on the parameter when it is specified, use the following structure within one of the input processing methods.

```csharp
protected override void ProcessRecord()
{
  WriteObject("Switch parameter test: " + userName + ".");
  if(goodbye)
  {
    WriteObject(" Goodbye!");
  }
} // End ProcessRecord
```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
