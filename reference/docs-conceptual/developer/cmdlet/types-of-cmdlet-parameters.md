---
description: Types of Cmdlet Parameters
ms.date: 02/25/2025
title: Types of Cmdlet Parameters
---
# Types of Cmdlet Parameters

This topic describes the different types of parameters that you can declare in cmdlets. Cmdlet
parameters can be positional, named, required, optional, or switch parameters.

## Positional and Named Parameters

All cmdlet parameters are either named or positional parameters. A named parameter requires that you
type the parameter name and argument when calling the cmdlet. A positional parameter requires only
that you type the arguments in relative order. The system then maps the first unnamed argument to
the first positional parameter. The system maps the second unnamed argument to the second unnamed
parameter, and so on. By default, all cmdlet parameters are named parameters.

To define a named parameter, omit the `Position` keyword in the **Parameter** attribute declaration,
as shown in the following parameter declaration.

```csharp
[Parameter(ValueFromPipeline=true)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

To define a positional parameter, add the `Position` keyword in the Parameter attribute declaration,
and then specify a position. In the following sample, the `UserName` parameter is declared as a
positional parameter with position 0. This means that the first argument of the call is
automatically bound to this parameter.

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
> Good cmdlet design recommends that the most-used parameters be declared as positional parameters
> so that the user doesn't have to enter the parameter name when the cmdlet is run.

Positional and named parameters accept single arguments or multiple arguments separated by commas.
Multiple arguments are allowed only if the parameter accepts a collection such as an array of
strings. You may mix positional and named parameters in the same cmdlet. In this case, the system
retrieves the named arguments first, and then attempts to map the remaining unnamed arguments to the
positional parameters.

The following commands show the different ways in which you can specify single and multiple
arguments for the parameters of the `Get-Command` cmdlet. Notice that in the last two samples,
`-Name` doesn't need to be specified because the **Name** parameter is defined as a positional
parameter.

```powershell
Get-Command -Name Get-Service
Get-Command -Name Get-Service,Set-Service
Get-Command Get-Service
Get-Command Get-Service,Set-Service
```

## Mandatory and Optional Parameters

You can also define cmdlet parameters as mandatory or optional parameters. (A mandatory parameter
must be specified before the PowerShell runtime invokes the cmdlet.) By default, parameters
are defined as optional.

To define a mandatory parameter, add the `Mandatory` keyword in the Parameter attribute declaration,
and set it to `true`, as shown in the following parameter declaration.

```csharp
[Parameter(Position = 0, Mandatory = true)]
public string UserName
{
  get { return userName; }
  set { userName = value; }
}
private string userName;
```

To define an optional parameter, omit the `Mandatory` keyword in the **Parameter** attribute
declaration, as shown in the following parameter declaration.

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

PowerShell provides a [System.Management.Automation.SwitchParameter][02] type that allows you to
define a parameter whose default value `false` unless the parameter is specified when the cmdlet is
called. Whenever possible, use switch parameters instead of Boolean parameters.

Consider the following example. Many PowerShell cmdlets return output. However, these cmdlets have a
`PassThru` switch parameter that overrides the default behavior. When you use the `PassThru`
parameter, the cmdlet returns output objects to the pipeline.

To define a switch parameter, declare the property as the `[SwitchParameter]` type, as shown in the
following sample.

```csharp
[Parameter()]
public SwitchParameter GoodBye
{
  get { return goodbye; }
  set { goodbye = value; }
}
private bool goodbye;
```

To make the cmdlet act on the parameter when it's specified, use the following structure within one
of the input processing methods.

```csharp
protected override void ProcessRecord()
{
  WriteObject("Switch parameter test: " + userName + ".");
  if (goodbye)
  {
    WriteObject(" Goodbye!");
  }
} // End ProcessRecord
```

By default, switch parameters are excluded from positional parameters. You _can_ override that in
the **Parameter** attribute, but it can confuse users.

Design switch parameters so that using parameter changes the default behavior of the command to a
less common or more complicated mode. The simplest behavior of a command should be the default
behavior that doesn't require the use of switch parameters. Base the behavior controlled by the
switch on the value of the switch, not the presence of the parameter.

There are several ways to test for the presence of a switch parameters:

- `Invocation.BoundParameters` contains the switch parameter name as a key
- `PSCmdlet.ParameterSetName` when the switch defines a unique parameter set

For example, it's possible to provide an explicit value for the switch using `-MySwitch:$false` or
splatting. If you only test for the presence of the parameter, the command behaves as if the switch
value is `$true` instead of `$false`.

## See Also

[Writing a Windows PowerShell Cmdlet][01]

<!-- link references -->
[01]: writing-a-windows-powershell-cmdlet.md
[02]: xref:System.Management.Automation.SwitchParameter
