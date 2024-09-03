---
description: Explains the various argument completion options available for function parameters.
Locale: en-US
ms.date: 01/04/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Functions_Argument_Completion?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: About_functions_argument_completion
---
# about_Functions_Argument_Completion

## Short description
Argument completion is a feature of PowerShell that provide hints, enables
discovery, and speeds up input entry of argument values.

## Long description

This article describes the different ways you can implement argument completers
for PowerShell functions. Argument completers provide the possible values for a
parameter. The available values are calculated at runtime when the user presses
the <kbd>Tab</kbd> key after the parameter name. There are several ways to
define an argument completer for a parameter.

> [!NOTE]
> <kbd>Tab</kbd> is the default key binding on Windows. This keybinding can be
> changed by the PSReadLine module or the application that is hosting
> PowerShell. The keybinding is different on non-Windows platforms. For more
> information, see
> [about_PSReadLine](/powershell/module/psreadline/about/about_psreadline#completion-functions).

## ValidateSet attribute

The **ValidateSet** attribute specifies a set of valid values for a parameter
or variable and enables tab completion. PowerShell generates an error if a
parameter or variable value doesn't match a value in the set. In the following
example, the value of the **Fruit** parameter can only be **Apple**,
**Banana**, or **Pear**.

```powershell
Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('Apple', 'Banana', 'Pear')]
    [string[]]
    $Fruit
)
```

In the following example, the value of the variable `$flavor` must be either
**Chocolate**, **Strawberry**, or **Vanilla**. The `ValidateSet` attribute can
be used on any variable, not just parameters.

```powershell
[ValidateSet('Chocolate', 'Strawberry', 'Vanilla')]
[string]$flavor = 'Strawberry'
```

The validation occurs whenever that variable is assigned even within the
script.

```powershell
Param(
    [ValidateSet('hello', 'world')]
    [string]$Message
)

$Message = 'bye'
```

This example returns the following error at runtime:

```
MetadataError: The attribute cannot be added because variable Message with
value bye would no longer be valid.
```

For more information about tab expansion, see
[about_Tab_Expansion](about_Tab_Expansion.md).

### Dynamic ValidateSet values using classes

You can use a **Class** to dynamically generate the values for **ValidateSet**
at runtime. In the following example, the valid values for the variable
`$Sound` are generated via a **Class** named **SoundNames** that checks three
filesystem paths for available sound files:

```powershell
Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $SoundPaths = '/System/Library/Sounds/',
                      '/Library/Sounds',
                      '~/Library/Sounds'
        $SoundNames = ForEach ($SoundPath in $SoundPaths) {
            If (Test-Path $SoundPath) {
                (Get-ChildItem $SoundPath).BaseName
            }
        }
        return [string[]] $SoundNames
    }
}
```

The `[SoundNames]` class is then implemented as a dynamic **ValidateSet** value
as follows:

```powershell
Param(
    [ValidateSet([SoundNames])]
    [string]$Sound
)
```

> [!NOTE]
> The `IValidateSetValuesGenerator` class was introduced in PowerShell 6.0.

## ArgumentCompleter attribute

The **ArgumentCompleter** attribute allows you to add tab completion values to
a specific parameter. An **ArgumentCompleter** attribute must be defined for
each parameter that needs tab completion.

To add an **ArgumentCompleter** attribute, you need to define a script block
that determines the values. The script block must take the following
parameters in the order specified below. The parameter's names don't matter as
the values are provided positionally.

The syntax is as follows:

```powershell
function MyArgumentCompleter {
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
            param ( $commandName,
                    $parameterName,
                    $wordToComplete,
                    $commandAst,
                    $fakeBoundParameters )
            # Perform calculation of tab completed values here.
        } )]
        $ParamName
    )
}
```

### ArgumentCompleter script block

The script block parameters are set to the following values:

- `$commandName` (Position 0) - This parameter is set to the name of the
  command for which the script block is providing tab completion.
- `$parameterName` (Position 1) - This parameter is set to the parameter whose
  value requires tab completion.
- `$wordToComplete` (Position 2) - This parameter is set to value the user has
  provided before they pressed <kbd>Tab</kbd>. Your script block should use
  this value to determine tab completion values.
- `$commandAst` (Position 3) - This parameter is set to the Abstract Syntax
  Tree (AST) for the current input line. For more information, see the
  [AST](/dotnet/api/system.management.automation.language.ast) type
  documentation.
- `$fakeBoundParameters` (Position 4) - This parameter is set to a hashtable
  containing the `$PSBoundParameters` for the cmdlet, before the user pressed
  <kbd>Tab</kbd>. For more information, see
  [about_Automatic_Variables](about_Automatic_Variables.md).

The **ArgumentCompleter** script block must unroll the values using the
pipeline, such as `ForEach-Object`, `Where-Object`, or another suitable method.
Returning an array of values causes PowerShell to treat the entire array as
**one** tab completion value.

The following example adds tab completion to the **Value** parameter. If only
the **Value** parameter is specified, all possible values, or arguments, for
**Value** are displayed. When the **Type** parameter is specified, the
**Value** parameter only displays the possible values for that type.

In addition, the `-like` operator ensures that if the user types the following
command and uses <kbd>Tab</kbd> completion, only **Apple** is returned.

`Test-ArgumentCompleter -Type Fruits -Value A`

```powershell
function MyArgumentCompleter{
    param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )

    $possibleValues = @{
        Fruits = @('Apple', 'Orange', 'Banana')
        Vegetables = @('Onion', 'Carrot', 'Lettuce')
    }

    if ($fakeBoundParameters.ContainsKey('Type')) {
        $possibleValues[$fakeBoundParameters.Type] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    } else {
        $possibleValues.Values | ForEach-Object {$_}
    }
}

function Test-ArgumentCompleter {
[CmdletBinding()]
 param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Fruits', 'Vegetables')]
        $Type,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter({ MyArgumentCompleter @args })]
        $Value
      )
}
```

## Register-ArgumentCompleter

The `Register-ArgumentCompleter` cmdlet registers a custom argument completer.
An argument completer allows you to provide dynamic tab completion, at run time
for any command that you specify.

For more information, see
[Register-ArgumentCompleter](xref:Microsoft.PowerShell.Core.Register-ArgumentCompleter).

## See also

- [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)
- [about_Tab_Expansion](about_Tab_Expansion.md)
- [Register-ArgumentCompleter](xref:Microsoft.PowerShell.Core.Register-ArgumentCompleter)
