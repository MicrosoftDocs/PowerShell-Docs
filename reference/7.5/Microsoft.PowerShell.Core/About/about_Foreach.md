---
description: Describes a language command you can use to traverse all the items in a collection of items.
Locale: en-US
ms.date: 10/20/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Foreach
---
# about_Foreach

## Short description

Describes a language command you can use to traverse all the items in a
collection of items.

## Long description

The `foreach` statement is a language construct for iterating over a set of
values in a collection.

The simplest and most typical type of collection to traverse is an array.
Within a `foreach` loop, it's common to run one or more commands against each
item in an array.

## Syntax

The following shows the `foreach` syntax:

```
foreach ($<item> in $<collection>){<statement list>}
```

The part of the `foreach` statement inside parenthesis represents a variable
and a collection to iterate. PowerShell creates the variable `$<item>`
automatically when the `foreach` loop runs. At the start of each iteration,
`foreach` sets the item variable to the next value in the collection. The
`{<statement list>}` block contains the commands to execute for each iteration.

### Examples

For example, the `foreach` loop in the following example displays the values in
the `$letterArray` array.

```powershell
$letterArray = 'a','b','c','d'
foreach ($letter in $letterArray)
{
  Write-Host $letter
}
```

In this example, the `$letterArray` contains the string values `a`, `b`,
`c`, and `d`. The first time the `foreach` statement runs, it sets the
`$letter` variable equal to the first item in `$letterArray` (`a`). Then, it
uses `Write-Host` to display the value. The next time through the loop,
`$letter` is set to `b`. The pattern repeats for each item in the array.

You can also use `foreach` statements with cmdlets that return a collection of
items. In the following example, the `foreach` statement steps through the list
of items returned by the `Get-ChildItem` cmdlet.

```powershell
foreach ($file in Get-ChildItem)
{
  Write-Host $file
}
```

You can refine the example using an `if` statement to limit the results that
are returned. In the following example, the `if` statement limits the results
to files that are greater than 100 kilobytes (KB):

```powershell
foreach ($file in Get-ChildItem)
{
  if ($file.Length -gt 100KB)
  {
    Write-Host $file
  }
}
```

In this example, the `foreach` loop uses a property of the `$file` variable to
perform a comparison operation (`$file.length -gt 100KB`). The `$file` variable
has all the properties of the object returned by the `Get-ChildItem`.

In the next example, the script displays the length and the last access time
inside the statement list:

```powershell
foreach ($file in Get-ChildItem)
{
  if ($file.Length -gt 100KB)
  {
    Write-Host $file
    Write-Host $file.Length
    Write-Host $file.LastAccessTime
  }
}
```

You can also use variables from outside a `foreach` loop. The following example
counts files over 100 KB in size:

```powershell
$i = 0
foreach ($file in Get-ChildItem) {
  if ($file.length -gt 100KB) {
    Write-Host $file 'file size:' ($file.length / 1024).ToString('F0') KB
    $i = $i + 1
  }
}

if ($i -ne 0) {
  Write-Host
  Write-Host $i ' file(s) over 100KB in the current directory.'
}
else {
  Write-Host 'No files greater than 100KB in the current directory.'
}
```

In the preceding example, `$i` starts with a value of `0` outside the loop.
Then, `$i` is incremented inside the loop for each file that's larger than
100KB. When the loop exits, an `if` statement evaluates the value of `$i` to
display a count of files over 100KB.

The previous example also demonstrates how to format the file length results:

```powershell
($file.length / 1024).ToString('F0')
```

The value is divided by 1,024 to show the results in kilobytes rather than
bytes, and the resulting value is then formatted using the fixed-point format
specifier to remove any decimal values from the result. The `0` makes the
format specifier show no decimal places.

The following function parses PowerShell scripts and script modules and returns
the location of functions contained within. The example demonstrates how to use
the `MoveNext` method and the `Current` property of the `$foreach` variable
inside of a `foreach` script block.

For more information, see [Using Enumerators][02].

```powershell
function Get-FunctionPosition {
  [CmdletBinding()]
  [OutputType('FunctionPosition')]
  param(
    [Parameter(Position = 0, Mandatory,
      ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('PSPath')]
    [System.String[]]
    $Path
  )

  process {
    try {
      $filesToProcess = if ($_ -is [System.IO.FileSystemInfo]) {
        $_
      } else {
        Get-Item -Path $Path
      }
      $parser = [System.Management.Automation.Language.Parser]
      foreach ($item in $filesToProcess) {
        if ($item.PSIsContainer -or
            $item.Extension -notin @('.ps1', '.psm1')) {
          continue
        }
        $tokens = $errors = $null
        $ast = $parser::ParseFile($item.FullName, ([ref]$tokens),
          ([ref]$errors))
        if ($errors) {
          $msg = "File '{0}' has {1} parser errors." -f $item.FullName,
            $errors.Count
          Write-Warning $msg
        }
        :tokenLoop foreach ($token in $tokens) {
          if ($token.Kind -ne 'Function') {
            continue
          }
          $position = $token.Extent.StartLineNumber
          do {
            if (-not $foreach.MoveNext()) {
              break tokenLoop
            }
            $token = $foreach.Current
          } until ($token.Kind -in @('Generic', 'Identifier'))
          $functionPosition = [pscustomobject]@{
            Name       = $token.Text
            LineNumber = $position
            Path       = $item.FullName
          }
          $addMemberSplat = @{
              InputObject = $functionPosition
              TypeName = 'FunctionPosition'
              PassThru = $true
          }
          Add-Member @addMemberSplat
        }
      }
    }
    catch {
      throw
    }
  }
}
```

## See also

- [about_Automatic_Variables][01]
- [about_If][03]
- [ForEach-Object][04]

<!-- link references -->
[01]: about_Automatic_Variables.md
[02]: about_Automatic_Variables.md#using-enumerators
[03]: about_If.md
[04]: xref:Microsoft.PowerShell.Core.ForEach-Object
