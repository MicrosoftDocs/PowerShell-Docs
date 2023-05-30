---
description: Describes the syntax diagrams that are used in PowerShell.
Locale: en-US
ms.date: 05/30/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_command_syntax?view=powershell-7.3&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Command Syntax
---
# about_Command_Syntax

## Short description
Describes the syntax diagrams that are used in PowerShell.

## Long description

The [Get-Help][03] and [Get-Command][02] cmdlets display syntax diagrams to
help you construct commands correctly. This topic explains how to interpret the
syntax diagrams.

## SYNTAX DIAGRAMS

Each paragraph in a command syntax diagram represents a valid form of the
command.

To construct a command, follow the syntax diagram from left to right. Select
from among the optional parameters and provide values for the placeholders.

PowerShell uses the following notation for syntax diagrams.

```Syntax
<command-name> -<Required Parameter Name> <Required Parameter Value Type>
 [-<Optional Parameter Name> <Optional Parameter Value Type>]
 [-<Optional Switch Parameters>]
 [-<Optional Parameter Name>] <Required Parameter Value Type>
```

`Get-Help` shows the following syntax for the [New-Alias][06] cmdlet.

```Syntax
New-Alias [-Name] <String> [-Value] <String> [-Description <String>] [-Force]
 [-Option {None | ReadOnly | Constant | Private | AllScope | Unspecified}]
 [-PassThru] [-Scope <String>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

The syntax is capitalized for readability, but PowerShell is case-insensitive.

The syntax diagram has the following elements.

## Command name

Commands always begin with a command name, such as `New-Alias`. Type the
command name or its alias, such a "gcm" for `Get-Command`.

## Parameters

The parameters of a command are options that determine what the command does.
Some parameters take a value as user input to the command.

For example, the `Get-Help` command has a **Name** parameter that lets you
specify the name of the topic for which help is displayed. The topic name is
the value of the **Name** parameter.

In a PowerShell command, parameter names always begin with a hyphen. The hyphen
tells PowerShell that the item in the command is a parameter name.

For example, to use the **Name** parameter of `New-Alias`, you type the
following: `New-Alias -Name`

Parameters can be mandatory or optional. In a syntax diagram, optional items
are enclosed in brackets `[]`.

For more information about parameters, see [about_Parameters][01].

## Parameter Values

A parameter value is the input that the parameter takes. Because Windows
PowerShell is based on the Microsoft .NET Framework, parameter values are
represented in the syntax diagram by their .NET type.

For example, the Name parameter of `Get-Help` takes a "String" value, which is
a text string, such as a single word or multiple words enclosed in quotation
marks.

```Syntax
New-Alias [-Name] <string>
```

The .NET type of a parameter value is enclosed in angle brackets `<>` to
indicate that it's placeholder for a value and not a literal that you type in a
command.

To use the parameter, replace the .NET type placeholder with an object that has
the specified .NET type.

For example, to use the **Name** parameter, type `-Name` followed by a string,
such as the following: `-Name MyAlias`

## Parameters with no values

Some parameters don't accept input, so they don't have a parameter value.
Parameters without values are called _switch parameters_ because they work like
on/off switches. You include them (on) or you omit them (off) from a command.

To use a switch parameter, just type the parameter name, preceded by a hyphen.

For example, to use the **WhatIf** parameter of the `New-Alias` cmdlet, type
the following: `New-Alias -WhatIf`.

## Parameter Sets

The parameters of a command are listed in parameter sets. Parameter sets look
like the paragraphs of a syntax diagram.

The `New-Alias` cmdlet has one parameter set, but many cmdlets have multiple
parameter sets. Some of the cmdlet parameters are unique to a parameter set,
and others appear in multiple parameter sets. Each parameter set represents the
format of a valid command. A parameter set includes only parameters that can be
used together in a command. If parameters can't be used in the same command,
they appear in separate parameter sets.

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

The first parameter set returns one or more random numbers and has the
**Minimum**, **Maximum**, and **Count** parameters. The second parameter set
returns a randomly selected object from a set of objects and includes the
**InputObject** and **Count** parameters. The third parameter set has the
**Shuffle** parameters that returns a collection of objects in a random order,
like shuffling a deck of cards. All parameter sets have the **SetSeed**
parameter and the common parameters.

These parameter sets indicate that you can use the **InputObject** and
**Count** parameters in the same command, but you can't use the **Maximum** and
**Shuffle** parameters in the same command.

You indicate which parameter set you want to use by using the parameters in
that parameter set. However, every cmdlet also has a default parameter set. The
default parameter set is used when you don't specify parameters that are unique
to a parameter set. For example, if you use `Get-Random` without parameters,
Windows PowerShell assumes that you are using the **RandomNumberParameterSet**
parameter set and it returns a random number.

## Symbols in Syntax Diagrams

The syntax diagram lists the command name, the command parameters, and the
parameter values. It also uses symbols to show how to construct a valid
command.

The syntax diagrams use the following symbols:

- A hyphen `-` indicates a parameter name. In a command, type the hyphen
  immediately before the parameter name with no intervening spaces, as shown in
  the syntax diagram.

  For example, to use the **Name** parameter of `New-Alias`, type:
  `New-Alias -Name`.

- Angle brackets `<>` indicate placeholder text. You don't type the angle
  brackets or the placeholder text in a command. Instead, you replace it with
  the item that it describes.

  The placeholder inside the angle brackets identifies the .NET type of the
  value that a parameter takes. For example, to use the **Name** parameter of
  the `New-Alias` cmdlet, you replace the `<string>` with a string, which is a
  single word or a group of words that are enclosed in quotation marks.

- Brackets `[]` around parameters indicate optional items. A parameter and its
  value can be optional, or the name of a required parameter can be optional.

  For example, the **Description** parameter of `New-Alias` and its value are
  enclosed in brackets because they're both optional.

  The brackets also indicate that the value of the **Name** parameter is
  required, but the parameter name, `-Name`, is optional.

  In each parameter set, the parameters appear in position order. The order of
  parameters in a command matters only when you omit the optional parameter
  names. When parameter names are omitted, PowerShell assigns values to
  parameters by position and type. For more information about parameter
  position, see [about_Parameters][01].

- Brackets `[]` appended to a .NET type indicate that the parameter can accept
  one or more values of that type. Enter the values as a comma-separated
  list.

  For example, the **Name** parameter of the `New-Alias` cmdlet takes only one
  string.

  ```Syntax
  New-Alias [-Name] <string>
  ```

  ```powershell
  New-Alias -Name MyAlias
  ```

  But the **Name** parameter of [Get-Process][04] can take one or more strings.

  ```Syntax
  Get-Process [-Name] <string[]>
  ```

  ```powershell
  Get-Process -Name Explorer, Winlogon, Services
  ```

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
  listed values for the **Option** parameter, such as "ReadOnly" or "AllScope".

  ```powershell
  New-Alias -Option ReadOnly
  ```

## Optional Items

Brackets `[]` surround optional items. For example, in the `New-Alias` cmdlet
syntax description, the **Scope** parameter is optional. This is indicated in
the syntax by the brackets around the parameter name and type:

```powershell
New-Alias [-Scope <string>]
```

Both the following examples are correct uses of the `New-Alias` cmdlet:

```powershell
New-Alias -Name utd -Value Update-TypeData
New-Alias -Name utd -Value Update-TypeData -Scope Global
```

A parameter name can be optional even if the value for that parameter is
required. This is indicated in the syntax by the brackets around the parameter
name but not the parameter type, as in this example from the `New-Alias`
cmdlet:

```Syntax
New-Alias [-Name] <string> [-Value] <string>
```

The following commands correctly use the `New-Alias` cmdlet. The commands
produce the same result.

```powershell
New-Alias -Name utd -Value Update-TypeData
New-Alias -Name utd Update-TypeData
New-Alias utd -Value Update-TypeData
New-Alias utd Update-TypeData
```

If the parameter name isn't included in the statement as typed, Windows
PowerShell tries to use the position of the arguments to assign the values to
parameters.

The following example isn't complete:

```powershell
New-Alias utd
```

This cmdlet requires values for both the **Name** and **Value** parameters.

In syntax examples, brackets are also used in naming and casting to .NET
Framework types. In this context, brackets don't indicate an element is
optional.

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
[06]: xref:Microsoft.PowerShell.Utility.New-Alias
