---
description: Describes the syntax diagrams that are used in PowerShell.
Locale: en-US
ms.date: 10/31/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_command_syntax?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Command_Syntax
---
# about_Command_Syntax

## Short description

Describes the syntax diagrams that are used in PowerShell.

## Long description

The [Get-Help][03] and [Get-Command][02] cmdlets display syntax diagrams to
help you construct commands correctly. This article explains how to interpret
the syntax diagrams.

## Get the syntax for a command

There are two ways to get the syntax for a command: `Get-Help` and
`Get-Command`.

### Get-Command

The `Get-Command` command can be used to get information about any command on
your system. Use the **Syntax** parameter to get the syntax for a command.

```powershell
Get-Command Get-Command -Syntax
```

```Output
Get-Command [[-ArgumentList] <Object[]>] [-Verb <string[]>] [-Noun <string[]>]
 [-Module <string[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
 [-TotalCount <int>] [-Syntax] [-ShowCommandInfo] [-All] [-ListImported]
 [-ParameterName <string[]>] [-ParameterType <PSTypeName[]>]
 [<CommonParameters>]

Get-Command [[-Name] <string[]>] [[-ArgumentList] <Object[]>]
 [-Module <string[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
 [-CommandType <CommandTypes>] [-TotalCount <int>] [-Syntax] [-ShowCommandInfo]
 [-All] [-ListImported] [-ParameterName <string[]>]
 [-ParameterType <PSTypeName[]>] [-UseFuzzyMatching]
 [-FuzzyMinimumDistance <uint>] [-UseAbbreviationExpansion]
 [<CommonParameters>]
```

### Get-Help

The `Get-Help` command provides detailed information about PowerShell commands
including, syntax, detailed description of the cmdlet and parameters, and
examples. The output `Get-Help` command starts with a brief description of the
command followed by the syntax.

```powershell
Get-Help Get-Command
```

The following output has been shortened to focus on the syntax description.

```Output
NAME
    Get-Command

SYNOPSIS
    Gets all commands.

SYNTAX

    Get-Command [[-Name] <System.String[]>] [[-ArgumentList] <System.Object[]>]
    [-All] [-CommandType {Alias | Function | Filter | Cmdlet | ExternalScript |
    Application | Script | Workflow | Configuration | All}]
    [-FullyQualifiedModule <Microsoft.PowerShell.Commands.ModuleSpecification[]>]
    [-ListImported] [-Module <System.String[]>] [-ParameterName <System.String[]>]
    [-ParameterType <System.Management.Automation.PSTypeName[]>]
    [-ShowCommandInfo] [-Syntax] [-TotalCount <System.Int32>]
    [-UseAbbreviationExpansion] [-UseFuzzyMatching] [<CommonParameters>]

    Get-Command [[-ArgumentList] <System.Object[]>] [-All]
    [-FullyQualifiedModule <Microsoft.PowerShell.Commands.ModuleSpecification[]>]
    [-ListImported] [-Module <System.String[]>] [-Noun <System.String[]>]
    [-ParameterName <System.String[]>]
    [-ParameterType <System.Management.Automation.PSTypeName[]>]
    [-ShowCommandInfo] [-Syntax] [-TotalCount <System.Int32>]
    [-Verb <System.String[]>] [<CommonParameters>]
...
```

The output of `Get-Help` is slightly different from the output of
`Get-Command`. Notice the difference in the syntax for the **CommandType**
parameter. `Get-Command` shows the parameter type as the `[CommandTypes]`
enumeration, while `Get-Help` show the possible values for the enumeration.

## Parameter Sets

The parameters of a PowerShell command are listed in parameter sets. A
PowerShell command can have one or more parameter sets. The `Get-Command`
cmdlet has two parameter sets, as shown in the previous examples.

Some of the cmdlet parameters are unique to a parameter set, and others appear
in multiple parameter sets. Each parameter set represents the format for a
valid command. A parameter set includes only parameters that can be used
together in a command. When parameters can't be used in the same command, they
are listed in separate parameter sets.

For example, the [Get-Random][05] cmdlet has the following parameter sets:

```powershell
$cmd = Get-Command Get-Random
$cmd.ParameterSets |
    Select-Object Name, IsDefault, @{n='Parameters';e={$_.ToString()}} |
    Format-Table -Wrap
```

```Output
Name                       IsDefault Parameters
----                       --------- ----------
RandomNumberParameterSet        True [[-Maximum] <Object>] [-SetSeed <int>]
                                     [-Minimum <Object>] [-Count <int>]
                                     [<CommonParameters>]
RandomListItemParameterSet     False [-InputObject] <Object[]> [-SetSeed <int>]
                                     [-Count <int>] [<CommonParameters>]
ShuffleParameterSet            False [-InputObject] <Object[]> -Shuffle
                                     [-SetSeed <int>] [<CommonParameters>]
```

- The first parameter set returns one or more random numbers and has the
  **Minimum**, **Maximum**, and **Count** parameters.
- The second parameter set returns a randomly selected object from a set of
  objects and includes the **InputObject** and **Count** parameters.
- The third parameter set has the **Shuffle** parameter that returns a
  collection of objects in a random order, like shuffling a deck of cards.
- All parameter sets have the **SetSeed** parameter and the common parameters.

These parameter sets show that you can use the **InputObject** and **Count**
parameters in the same command, but you can't use the **Maximum** and
**Shuffle** parameters together.

Every cmdlet also has a default parameter set. The default parameter set is
used when you don't specify parameters that are unique to a parameter set. For
example, if you use `Get-Random` without parameters, PowerShell assumes that
you're using the **RandomNumberParameterSet** parameter set and it returns a
random number.

## Symbols in Syntax Diagrams

The syntax diagram lists the command name, the command parameters, and the
parameter values.

The syntax diagrams use the following symbols:

- A hyphen `-` indicates a parameter name. In a command, type the hyphen
  immediately before the parameter name with no intervening spaces, as shown in
  the syntax diagram.

  For example, to use the **Name** parameter of `Get-Command`, type:
  `Get-Command -Name`.

<!-- `< >` - also known as chi-hua-huas -->
- Angle brackets `< >` indicate placeholder text. You don't type the angle
  brackets or the placeholder text in a command. Instead, you replace it with
  the item that it describes.

  The placeholder inside the angle brackets identifies the .NET type of the
  value that a parameter takes. For example, to use the **Name** parameter of
  the `Get-Command` cmdlet, you replace the `<string[]>` with one or more
  strings separated by commas (`,`).

<!-- `[]` - also known as binkies -->
- Brackets `[]` appended to a .NET type indicate that the parameter can accept
  one or more values of that type. Enter the values as a comma-separated
  list.

  For example, the **Name** and **Value** parameters of the `New-Alias` cmdlet
  only take one string each.

  ```Syntax
  New-Alias [-Name] <string> [-Value] <string>
  ```

  ```powershell
  New-Alias -Name MyAlias -Value mycommand.exe
  ```

  But the **Name** parameter of [Get-Process][04] can take one or more strings.

  ```Syntax
  Get-Process [-Name] <string[]>
  ```

  ```powershell
  Get-Process -Name Explorer, Winlogon, Services
  ```

- Parameters with no values

  Some parameters don't accept input, so they don't have a parameter value.
  Parameters without values are _switch parameters_. Switch parameters are used
  like boolean values. They default to `$false`. When you use a switch
  parameter, the value is set to `$true`.

  For example, the **ListImported** parameter of `Get-Command` is a switch
  parameter. When you use the **ListImported** parameter, the cmdlet return
  only commands that were imported from modules in the current session.

  ```Syntax
  Get-Command [-ListImported]
  ```

<!-- So what are these `[    ]`? - square brackets, duh! -->
- Brackets `[  ]` around parameters indicate optional items. A parameter and
  its value can be optional. For example, the **CommandType** parameter of
  `Get-Command` and its value are enclosed in brackets because they're both
  optional.

  ```Syntax
  Get-Command [-CommandType <CommandTypes>]
  ```

  Brackets around the parameter name, but not the parameter value, indicate
  that the parameter name is optional. These parameters are known as positional
  parameters. The parameter values must be presented in the correct order for
  the values to be bound to the correct parameter.

  For example, for the `New-Alias` cmdlet, the **Name** and **Value** parameter
  values are required, but the parameter names, `-Name` and `-Value`, are
  optional.

  ```Syntax
  New-Alias [-Name] <string> [-Value] <string>
  ```

  ```powershell
  New-Alias MyAlias mycommand.exe
  ```

  In each parameter set, the parameters appear in position order. The order of
  parameters in a command matters only when you omit the optional parameter
  names. When parameter names are omitted, PowerShell assigns values to
  parameters by position and type. For more information about parameter
  position, see [about_Parameters][01].

- Braces `{}` indicate an "enumeration," which is a set of valid values for a
  parameter.

  The values in the braces are separated by vertical bars `|`. These bars
  indicate an _exclusive-OR_ choice, meaning that you can choose only one value
  from the set of values that are listed inside the braces.

  For example, the syntax for the `New-Alias` cmdlet includes the following
  value enumeration for the **Option** parameter:

  ```Syntax
  New-Alias -Option {None | ReadOnly | Constant | Private | AllScope}
  ```

  The braces and vertical bars indicate that you can choose any one of the
  listed values for the **Option** parameter, such as `ReadOnly` or `AllScope`.

  ```powershell
  New-Alias -Option ReadOnly
  ```

## See also

- [about_Parameters][01]
- [Get-Command][02]
- [Get-Help][03]

<!-- link references -->
[01]: about_Parameters.md
[02]: xref:Microsoft.PowerShell.Core.Get-Command
[03]: xref:Microsoft.PowerShell.Core.Get-Help
[04]: xref:Microsoft.PowerShell.Management.Get-Process
[05]: xref:Microsoft.PowerShell.Utility.Get-Random
