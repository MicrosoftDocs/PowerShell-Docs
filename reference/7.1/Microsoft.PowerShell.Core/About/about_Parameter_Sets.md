---
description: Describes how to define and use parameter sets in advanced functions. 
title: about_Parameter_Sets
ms.date: 02/11/2020
---
# About parameter sets

## SHORT DESCRIPTION
Describes how to define and use parameter sets in advanced functions.

## LONG DESCRIPTION

PowerShell uses parameter sets to enable you to write a single function that
can do different actions for different scenarios. Parameter sets enable you to
expose different parameters to the user. And, to return different information
based on the parameters specified by the user.

## Parameter set requirements

The following requirements apply to all parameter sets.

- Each parameter set must have at least one unique parameter. If possible, make
  this parameter a mandatory parameter.

- A parameter set that contains multiple positional parameters must define
  unique positions for each parameter. No two positional parameters can specify
  the same position.

- Only one parameter in a set can declare the `ValueFromPipeline` keyword with
  a value of `true`. Multiple parameters can define the
  `ValueFromPipelineByPropertyName` keyword with a value of `true`.

- If no parameter set is specified for a parameter, the parameter belongs to
  all parameter sets.

> [!NOTE]
> There is a limit of 32 parameter sets.

## Default parameter sets

When multiple parameter sets are defined, the `DefaultParameterSetName` keyword
of the **CmdletBinding** attribute specifies the default parameter set.
PowerShell uses the default parameter set when it can't determine the parameter
set to use based on the information provided to the command. For more
information about the **CmdletBinding** attribute, see
[about_functions_cmdletbindingattribute](about_functions_cmdletbindingattribute.md).

## Declaring parameter sets

To create a parameter set, you must specify the `ParameterSetName` keyword of
the **Parameter** attribute for every parameter in the parameter set. For
parameters that belong to multiple parameter sets, add a **Parameter**
attribute for each parameter set.

The **Parameter** attribute enables you to define the parameter differently for
each parameter set. For example, you can define a parameter as mandatory in one
set and optional in another. However, each parameter set must contain at least
one unique parameter.

Parameters that don't have an assigned parameter set name belong to all
parameter sets.

### Example

The following example function counts the number lines, characters, and words
in a text file. Using parameters, you can specify which values you want
returned and which files you want to measure. There are four parameter sets
defined:

- Path
- PathAll
- LiteralPath
- LiteralPathAll

```powershell
function Measure-Lines {
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Path',
            HelpMessage = 'Enter one or more filenames',
            Position = 0)]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'PathAll',
            Position = 0)]
        [string[]]$Path,

        [Parameter(Mandatory = $true, ParameterSetName = 'LiteralPathAll')]
        [Parameter(Mandatory = $true,
            ParameterSetName = 'LiteralPath',
            HelpMessage = 'Enter a single filename',
            ValueFromPipeline = $true)]
        [string]$LiteralPath,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'LiteralPath')]
        [switch]$Lines,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'LiteralPath')]
        [switch]$Words,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'LiteralPath')]
        [switch]$Characters,

        [Parameter(Mandatory = $true, ParameterSetName = 'PathAll')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LiteralPathAll')]
        [switch]$All,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'PathAll')]
        [switch]$Recurse
    )

    begin {
        if ($All) {
            $Lines = $Words = $Characters = $true
        }
        elseif (($Words -eq $false) -and ($Characters -eq $false)) {
            $Lines = $true
        }

        if ($Path) {
            $Files = Get-ChildItem -Path $Path -Recurse:$Recurse
        }
        else {
            $Files = Get-ChildItem -LiteralPath $LiteralPath
        }
    }
    process {
        foreach ($file in $Files) {
            $result = [ordered]@{ }
            $result.Add('File', $file.fullname)

            $content = Get-Content -LiteralPath $file.fullname

            if ($Lines) { $result.Add('Lines', $content.Length) }

            if ($Words) {
                $wc = 0
                foreach ($line in $content) { $wc += $line.split(' ').Length }
                $result.Add('Words', $wc)
            }

            if ($Characters) {
                $cc = 0
                foreach ($line in $content) { $cc += $line.Length }
                $result.Add('Characters', $cc)
            }

            New-Object -TypeName psobject -Property $result
        }
    }
}
```

Each parameter set must have a unique parameter or a unique combination of
parameters. The `Path` and `PathAll` parameter sets are very similar but the
**All** parameter is unique to the `PathAll` parameter set. The same is true
with the `LiteralPath` and `LiteralPathAll` parameter sets. Even though the
`PathAll` and `LiteralPathAll` parameter sets both have the **All** parameter,
the **Path** and **LiteralPath** parameters differentiate them.

Use `Get-Command -Syntax` shows you the syntax of each parameter set. However
it does not show the name of the parameter set. The following example shows
which parameters can be used in each parameter set.

```powershell
(Get-Command Measure-Lines).ParameterSets |
  Select-Object -Property @{n='ParameterSetName';e={$_.name}},
    @{n='Parameters';e={$_.ToString()}}
```

```Output
ParameterSetName Parameters
---------------- ----------
Path             [-Path] <string[]> [-Lines] [-Words] [-Characters] [-Recurse] [<CommonParameters>]
PathAll          [-Path] <string[]> -All [-Recurse] [<CommonParameters>]
LiteralPath      -LiteralPath <string> [-Lines] [-Words] [-Characters] [<CommonParameters>]
LiteralPathAll   -LiteralPath <string> -All [<CommonParameters>]
```

### Parameter sets in action

In this example, we are using the `PathAll` parameter set.

```powershell
Measure-Lines test* -All
```

```Output
File                       Lines Words Characters
----                       ----- ----- ----------
C:\temp\test\test.help.txt    31   562       2059
C:\temp\test\test.md          30  1527       3224
C:\temp\test\test.ps1          3     3         79
C:\temp\test\test[1].txt      31   562       2059
```

