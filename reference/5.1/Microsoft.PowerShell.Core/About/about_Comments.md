---
description: Describes how to use comments and lists special use cases
Locale: en-US
ms.date: 01/10/2025
online version: 
schema: 2.0.0
title: about_Comments
---
# about_Comments

## Short description

Describes how to use PowerShell comments and lists special use cases.

## Long description

You can write comments to annotate or structure your PowerShell code to help
with readability. When your code is run, comment text is ignored by PowerShell.

Comments are typically used to provide important context to readers of the code
that may not be apparent from the code alone. This may include explanations on
why a particular approach was chosen, edge cases to be aware of or links to
supporting reference material.

Some comments have special meaning in PowerShell. See [Special comments][01].

## PowerShell comment styles

Comments are designated by the `#` or `<# #>` characters.

- **Single-line comments** begin with `#` and end with a newline. The `#` may
  be preceded by text not a part of the comment, including whitespace.
  Single-line comments placed on the same line as uncommented source code are
  end-of-line comments.
- **Block comments** begin and end with a matching pair of `<#` and `#>`
  characters. All text within the block is treated as part of the same comment,
  including whitespace. A block comment can span any number of lines,
  and can be included before, after or in the middle of uncommented source
  code.

## Examples

### Example 1: Single-line comment

```powershell
# This is a single-line comment.
# This is also a single-line comment.
```

### Example 2: Block comment

```powershell
<#
    This is a block comment.
    Text within the block is a part of the same comment.
Whitespace is unimportant in a block comment.
#>
```

### Example 3: End-of-line comment

```powershell
$var = 4 # This is an end-of-line comment
```

### Example 4: Inline block comment

```powershell
'Foo'; <# This is an inline block comment #> 'Bar'
```

### Example 5: Full example

```powershell
<#
    .DESCRIPTION
    Demonstrates PowerShell's different comment styles.
#>
param (
    [string] $Param1, # End-of-line comment
    <# Inline block comment #> $Param2
)

$var = 1, <# Inline block comment #> 2, 2

# Single-line comment.
# Another single-line comment.
$var.Where(
    <# Arg1 note #> { $_ -eq 2 },
    <# Arg2 note #> 'First',
    <# Arg3 note #> 1
)
```

## Special comments

### Comment-based help

You can write comment-based help content for functions and scripts using either
single-line or block comments. Comment-based help is used by the [Get-Help][02]
cmdlet to output information such as the description and example usage of a
function or script.

```powershell
<#
    .DESCRIPTION
    Comment-based help using a block comment.
#>
function Get-Function { }
```

```powershell
# .DESCRIPTION
# Comment-based help using multiple single-line comments.
function Get-Function { }
```

For more information, see:

- [about_Comment_Based_Help][03].
- [Writing Comment-Based Help Topics][04]

### `#Requires`

The `#Requires` statement prevents a script from running unless the PowerShell
version, modules (and version), and edition prerequisites are met.

`#Requires` can appear on any line in a script, but is processed in the same
manner regardless of position.

```powershell
#Requires -Modules AzureRM.Netcore
#Requires -Version 6.0

param (
    [Parameter(Mandatory)]
    [string[]] $Path
)
```

For more information, see [about_Requires][05].

### Signature block

Scripts can be signed so that they comply with PowerShell execution policies.
Once signed, a signature block is added to the end of a script. This block
takes the form of multiple single-line comments, which are read by PowerShell
before the script is executed.

```powershell
# SIG # Begin signature block
# ...
# SIG # End signature block
```

For more information, see [about_signing][06].

## Comments in string tokens

`#` and `<# #>` do not have special meaning within an [expandable][08] or
[verbatim][09] string. PowerShell interprets the characters literally.

```powershell
PS> '# This is not interpreted as a comment.'
# This is not interpreted as a comment.

PS> "This is <# also not interpreted #> as a comment."
This is <# also not interpreted #> as a comment.
```

However, certain PowerShell features are designed to work with strings that
contain comments. Interpretation of the comment is dependant on the specific
feature.

### Regular expression comments

Regular expressions (regex) in PowerShell use the [.NET regex][10] engine,
which supports two comment styles:

- Inline comment (`(?#)`)
- End-of-line comment (`#`)

Regex comments are supported by all regex-based features in PowerShell. For
example:

```powershell
PS> 'book' -match '(?# This is an inline comment)oo'
True

PS> 'book' -match '(?x)oo# This is an end-of-line comment'
True

PS> $regex = 'oo # This is an end-of-line comment'
PS> 'book' -split $regex, 0, 'IgnorePatternWhitespace'
b
k
```

> [!NOTE]
> An end-of-line regex comment requires either the `(?x)` construct or the
> [`IgnorePatternWhitespace`][11] option.

For more information, see:

- [about_Regular_Expressions][12]
- [Miscellaneous Constructs in Regular Expressions][13]

### JSON comments

Beginning in PowerShell 6.0, the [ConvertFrom-Json][14] cmdlet supports the
following JSON comment styles:

- Single-line comment (`//`)
- Block comment (`/* */`)

> [!NOTE]
> The [Invoke-RestMethod][15] cmdlet automatically deserializes received JSON
> data. In PowerShell 6.0 onwards, comments are permitted in the JSON data.

For example:

```powershell
'{ 
    "Foo": "Bar" // This is a single-line comment 
}' | ConvertFrom-Json
```

```Output
Foo
---
Bar
```

> [!WARNING]
> Beginning in PowerShell 7.4, the [Test-Json][16] cmdlet no longer supports
> JSON with comments. An error is returned if the JSON includes comments. In
> supported versions prior to 7.4, `Test-Json` successfully parses JSON with
> comments.

### CSV comments

In Windows PowerShell 5.1, the default [Export-Csv][20] and [ConvertTo-Csv][21]
behavior is to include type information in the form of a `#TYPE` comment.
Beginning in PowerShell 6.0, the default is not to include the comment, but
this can be overridden with the **IncludeTypeInformation** parameter.

```powershell
[pscustomobject] @{ Foo = 'Bar' } | ConvertTo-Csv
```

```Output
#TYPE System.Management.Automation.PSCustomObject
"Foo"
"Bar"
```

When a `#TYPE` comment is included in CSV data, `Import-Csv` and
`ConvertFrom-Csv` use this information to set the `pstypenames` property of the
deserialized object(s).

```powershell
class Test { $Foo = 'Bar' }
$test = [Test]::new()

$var = $test | ConvertTo-Csv | ConvertFrom-Csv
$var.pstypenames
```

```Output
CSV:Test
```

### `ConvertFrom-StringData` comments

Within its string data, the [ConvertFrom-StringData][22] cmdlet treats lines
beginning with `#` as comments. For more information, see:

- [Example 3: Convert a here-string containing a comment][23]

## Notes

- Block comments cannot be nested. In the following example, `Baz` is not a
  part of the comment.

  ```powershell
  <#
  Foo
  <# Bar #>
  Baz
  #>
  ```

- `<# #>` has no special meaning within a single-line comment. `#` has no
  special meaning within a block comment.
- To be treated as a comment, the comment character must not be a part
  of a non-comment token. In the following example, `#Bar` and `<#Bar#>` are
  a part of the same `Foo...` token and are therefore not treated as comments.

  ```powershell
  PS> Foo#Bar
  Foo#Bar: The term 'Foo#Bar' is not recognized as a name [...]

  PS> Foo<#Bar#>
  Foo<#Bar#>: The term 'Foo<#Bar#>' is not recognized as a name [...]
  ```

<!-- link references -->
[01]: #special-comments
[02]: xref:Microsoft.PowerShell.Core.Get-Help
[03]: about_Comment_Based_Help.md
[04]: /powershell/scripting/developer/help/writing-comment-based-help-topics
[05]: about_Requires.md
[06]: about_signing.md
[08]: about_quoting_rules#double-quoted-strings
[09]: about_quoting_rules#single-quoted-strings
[10]: /dotnet/standard/base-types/regular-expressions
[11]: /dotnet/api/system.text.regularexpressions.regexoptions#system-text-regularexpressions-regexoptions-ignorepatternwhitespace
[12]: about_Regular_Expressions.md
[13]: /dotnet/standard/base-types/miscellaneous-constructs-in-regular-expressions
[14]: xref:Microsoft.PowerShell.Utility.ConvertFrom-Json
[15]: xref:Microsoft.PowerShell.Utility.Invoke-RestMethod
[16]: xref:Microsoft.PowerShell.Utility.Test-Json
[20]: xref:Microsoft.PowerShell.Utility.Export-Csv
[21]: xref:Microsoft.PowerShell.Utility.ConvertTo-Csv
[22]: xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData
[23]: xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData#example-3-convert-a-here-string-containing-a-comment
