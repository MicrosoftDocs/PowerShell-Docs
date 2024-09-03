---
description: Describes how PowerShell binds arguments to cmdlet parameters.
Locale: en-US
ms.date: 05/17/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameter_binding?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Parameter_Binding
---
# about_Parameter_Binding

## Short description

Parameter binding is the process that PowerShell uses to determine which
parameter set is being used and to associate (bind) values to the parameters of
a command. These values can come from the command line and the pipeline.

## Long description

The parameter binding process starts by binding command-line arguments.

1. Bind named parameters

   Find unquoted tokens on the command line that start with a dash. If the
   token ends with a colon, an argument is required. If there's no colon, look
   at the type of the parameter and see if an argument is required. If a value
   is required, attempt to convert the type of argument to the type required by
   the parameter, and the conversion is successful, bind the parameter.

1. Bind positional parameters

   If there are any unused command-line arguments, look for unbound parameters
   that take positional parameters and try to bind them.

After binding command-line arguments, PowerShell tries to bind any pipeline
input. There are two ways that values are bound from the pipeline. Parameters
that accept pipeline input have one or both of the following attributes:

- [ValueFromPipeline][02] - The value from the pipeline is bound to the
  parameter based on its type. The type of the argument must match the type of
  the parameter.
- [ValueFromPipelineByPropertyName][03] - The value from the pipeline is bound
  to the parameter based on its name. The object in the pipeline must have a
  property that matches the name of the parameter or one of its aliases. The
  type of the property must match or be convertible to the type of the
  parameter.

PowerShell tries to bind pipeline input in the following order:

1. Try to bind `ValueFromPipeline` parameters without type conversion:

   Bind from the pipeline by value with exact type match. If the command has
   pipeline input and there are still unbound parameters, try to bind to a
   parameter that matches the type exactly.

1. Try to bind `ValueFromPipelineByPropertyName` parameters without type
   conversion:

   If no value match is found, then bind from the pipeline by name with exact
   match. Look for a property on the input object that matches the name of the
   parameter or one of its aliases. If the types exactly match, bind the
   parameter.

1. If the pipeline input hasn't been bound, try to bind `ValueFromPipeline`
   parameters with type conversion:

   Attempt to convert the pipeline input to the required type. If the
   conversion fails, the parameter isn't bound.

1. If the pipeline input hasn't been bound, try to bind
   `ValueFromPipelineByPropertyName` parameters with type conversion:

   The name of the property must match the name of the parameter or one of its
   aliases. If the input type doesn't match, attempt to convert the input to
   the matching type. If the conversion fails, the parameter isn't bound.

## Visualize parameter binding

Troubleshooting parameter binding issues can be challenging. You can use the
[Trace-Command][04] cmdlet to visualize the parameter binding process. The
following example shows how to trace the parameter binding for a simple
pipeline.

```powershell
Trace-Command -PSHost -Name ParameterBinding -Expression {
    Get-Item *.txt | Remove-Item
}
```

The output shows every step of the parameter binding process for the commands
in the **Expression**. The output can be verbose, but it can help you
understand why a parameter isn't being bound as expected. For a complete
example, see the [Visualize parameter binding][01] article.

<!-- link references -->
[01]: /powershell/scripting/learn/deep-dives/visualize-parameter-binding
[02]: about_functions_advanced_parameters.md#valuefrompipeline-argument
[03]: about_functions_advanced_parameters.md#valuefrompipelinebypropertyname-argument
[04]: xref:Microsoft.PowerShell.Utility.Trace-Command
