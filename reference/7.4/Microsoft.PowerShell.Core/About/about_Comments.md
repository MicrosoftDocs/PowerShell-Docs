---
description: Describes how to use comments and lists special use cases.
Locale: en-US
ms.date: 01/10/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comments?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Comments
---
# about_Comments

## Short description

Describes how to use PowerShell comments and lists special use cases.

## Long description

You can write comments to annotate or structure your PowerShell code to help
with readability. When your code is run, comment text is ignored by PowerShell.

Comments provide important context to readers of the code. You should use
comments for the following purposes:

- Explain complex code in simpler terms
- Explain why a particular approach was chosen
- Document edge cases to be aware
- Provide links to supporting reference material

Some comments have special meaning in PowerShell. See [Special comments][04].

## PowerShell comment styles

PowerShell supports two comment styles:

- **Single-line comments** begin with hash character (`#`) and end with a
  newline. The `#` can be preceded by text that's not a part of the comment,
  including whitespace. Single-line comments placed on the same line as
  uncommented source code are known as end-of-line comments.
- **Block comments** begin with `<#` and end with `#>`. A block comment can
  span any number of lines, and can be included before, after or in the middle
  of uncommented source code. All text within the block is treated as part of
  the same comment, including whitespace.

  > [!IMPORTANT]
  > You can include single-line comments within a block comment. However, you
  > can't nest block comments. If you attempt to nest block comments, the outer
  > block comment ends at the first `#>` encountered.

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

PowerShell includes several comment keywords to support specific uses.

### Comment-based help

You can write comment-based help content for functions and scripts using either
single-line or block comments. Users can use the [Get-Help][14] cmdlet to view
comment-based help for a function or script. PowerShell defines 15 comment
keywords that can be used to provide information such as the description and
example usage.

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

- [about_Comment_Based_Help][05]
- [Writing Comment-Based Help Topics][03]

### `#Requires`

The `#Requires` statement prevents a script from running unless the current
PowerShell session meets the specified prerequisites. `#Requires` can appear on
any line in a script, but is processed in the same manner regardless of
position.

```powershell
#Requires -Modules AzureRM.Netcore
#Requires -Version 6.0

param (
    [Parameter(Mandatory)]
    [string[]] $Path
)
```

For more information, see [about_Requires][09].

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

For more information, see [about_signing][10].

### Shebang

On Unix-like systems, a [shebang][12] (`#!`) is a directive used at the
beginning of a script to indicate which shell should be used to run the script.
Shebang isn't a part of the PowerShell language. PowerShell interprets it as a
regular comment. Shebang is interpreted by the operating system.

In the following example, the shebang ensures PowerShell runs the script when
the script is invoked from a non-PowerShell context.

```powershell
#!/usr/bin/env pwsh
Write-Host 'Begin script'
```

### Code editor region markers

Some code editors support region markers that allow you to collapse and expand
sections of code. For PowerShell, the region markers are comments that begin
with `#region` and end with `#endregion`. The region markers must be at the
beginning of a line. The region markers are supported in the PowerShell ISE and
in Visual Studio Code with the PowerShell extension. The region markers aren't
a part of the PowerShell language. PowerShell interprets them as regular
comments.

For more information, see the _Folding_ section of the
[Basic editing in Visual Studio Code][11] documentation.

## Comments in string tokens

`#` and `<# #>` don't have special meaning within an [expandable][06] or
[verbatim][07] string. PowerShell interprets the characters literally.

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

Regular expressions (regex) in PowerShell use the [.NET regex][02] engine,
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
> [`IgnorePatternWhitespace`][24] option.

For more information, see:

- [about_Regular_Expressions][08]
- [Miscellaneous Constructs in Regular Expressions][01]

### JSON comments

Beginning in PowerShell 6.0, the [ConvertFrom-Json][16] cmdlet supports the
following JSON comment styles:

- Single-line comment (`//`)
- Block comment (`/* */`)

> [!NOTE]
> The [Invoke-RestMethod][22] cmdlet automatically deserializes received JSON
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
> Beginning in PowerShell 7.4, the [Test-Json][23] cmdlet no longer supports
> JSON with comments. An error is returned if the JSON includes comments. In
> supported versions prior to 7.4, `Test-Json` successfully parses JSON with
> comments. In PowerShell 7.5, `Test-Json` includes an option to ignore
> JSON comments.

### CSV comments

[Import-Csv][21] and [ConvertFrom-Csv][15] support the W3C Extended Log format.
Lines starting with the hash character (`#`) are treated as comments and
ignored unless the comment starts with `#Fields:` and contains delimited list
of column names. In that case, the cmdlet uses those column names. This is the
standard format for Windows IIS and other web server logs. For more
information, see [Extended Log File Format][13].

```powershell
@'
# This is a CSV comment
Col1,Col2
Val1,Val2
'@ | ConvertFrom-Csv
```

```Output
Col1 Col2
---- ----
Val1 Val2
```

In Windows PowerShell 5.1, the default [Export-Csv][20] and [ConvertTo-Csv][19]
behavior is to include type information in the form of a `#TYPE` comment.
Beginning in PowerShell 6.0, the default is not to include the comment, but
this can be overridden with the **IncludeTypeInformation** parameter.

```powershell
[pscustomobject] @{ Foo = 'Bar' } | ConvertTo-Csv -IncludeTypeInformation
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

$var = $test | ConvertTo-Csv -IncludeTypeInformation | ConvertFrom-Csv
$var.pstypenames
```

```Output
Test
CSV:Test
```

### `ConvertFrom-StringData` comments

Within its string data, the [ConvertFrom-StringData][17] cmdlet treats lines
beginning with `#` as comments. For more information, see:

- [Example 3: Convert a here-string containing a comment][18]

## Notes

- Block comments can't be nested. In the following example, `Baz` is not a
  part of the comment.

  ```powershell
  <#
  'Foo'
  <# 'Bar' #>
  'Baz'
  #>
  ```

- `<# #>` has no special meaning within a single-line comment. `#` has no
  special meaning within a block comment.
- To be treated as a comment, the comment character must not be a part
  of a non-comment token. In the following example, `#Bar` and `<#Bar#>` are
  a part of the `Foo...` token. Therefore, they aren't treated as comments.

  ```powershell
  PS> Foo#Bar
  Foo#Bar: The term 'Foo#Bar' is not recognized as a name [...]

  PS> Foo<#Bar#>
  Foo<#Bar#>: The term 'Foo<#Bar#>' is not recognized as a name [...]
  ```

<!-- link references -->
[01]: /dotnet/standard/base-types/miscellaneous-constructs-in-regular-expressions
[02]: /dotnet/standard/base-types/regular-expressions
[03]: /powershell/scripting/developer/help/writing-comment-based-help-topics
[04]: #special-comments
[05]: about_Comment_Based_Help.md
[06]: about_quoting_rules.md#double-quoted-strings
[07]: about_quoting_rules.md#single-quoted-strings
[08]: about_Regular_Expressions.md
[09]: about_Requires.md
[10]: about_signing.md
[11]: https://code.visualstudio.com/docs/editor/codebasics#_folding
[12]: https://wikipedia.org/wiki/Shebang_(Unix)
[13]: https://www.w3.org/TR/WD-logfile.html
[14]: xref:Microsoft.PowerShell.Core.Get-Help
[15]: xref:Microsoft.PowerShell.Utility.ConvertFrom-Csv
[16]: xref:Microsoft.PowerShell.Utility.ConvertFrom-Json
[17]: xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData
[18]: xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData#example-3-convert-a-here-string-containing-a-comment
[19]: xref:Microsoft.PowerShell.Utility.ConvertTo-Csv
[20]: xref:Microsoft.PowerShell.Utility.Export-Csv
[21]: xref:Microsoft.PowerShell.Utility.Import-Csv
[22]: xref:Microsoft.PowerShell.Utility.Invoke-RestMethod
[23]: xref:Microsoft.PowerShell.Utility.Test-Json
[24]: xref:System.Text.RegularExpressions.RegexOptions#system-text-regularexpressions-regexoptions-ignorepatternwhitespace
