---
description: This article provides the rules of style for writing PowerShell documentation.
ms.date: 11/14/2022
ms.topic: conceptual
title: PowerShell-Docs style guide
---
# PowerShell-Docs style guide

This article provides style guidance specific to the PowerShell-Docs content. It builds on the
information outlined in the [Overview][1].

## Formatting command syntax elements

- Always use the full name for cmdlets and parameters. Avoid using aliases unless you're
  specifically demonstrating the alias.
- Property, parameter, object, type names, class names, class methods should be **bold**.
  - Property and parameter values should be wrapped in backticks (`` ` ``).
  - When referring to types using the bracketed style, use backticks. For example:
    `[System.Io.FileInfo]`
- Language keywords, cmdlet names, functions, variables, native EXEs, file paths, and inline syntax
  examples should be wrapped in backtick (`` ` ``) characters.

  For example:

  ~~~markdown
  The following code uses `Get-ChildItem` to list the contents of `C:\Windows` and assigns
  the output to the `$files` variable.

  ```powershell
  $files = Get-ChildItem C:\Windows
  ```
  ~~~

  - PowerShell keywords and operators should be all lowercase

  - Use proper (Pascal) casing for cmdlet names and parameters

  - When referring to a parameter by name, the name should be **bold**. When illustrating the use of
    a parameter with the hyphen prefix, the parameter should be wrapped in backticks. For example:

    ```markdown
    The parameter's name is **Name**, but it's typed as `-Name` when used on the command
    line as a parameter.
    ```

  - When showing example usage of an external command, the example should be wrapped in backticks.
    Always include the file extension in the native command. For example:

    ```markdown
    To start the spooler service on a remote computer named DC01, you type:
    `sc.exe \\DC01 start spooler`.
    ```

    Including the file extension ensures that the correct command is executed according to
    PowerShell's command precedence.

## Markdown for code samples

Markdown supports two different code styles:

- **Code spans (inline)** - marked by a single backtick (`` ` ``) character. Used within a paragraph
  rather than as a standalone block.
- **Code blocks** - a multi-line block surrounded by triple-backtick (`` ``` ``) strings. Code
  blocks may also have a language label following the backticks. The language label enables syntax
  highlighting for the contents of the code block.

All code blocks should be contained in a code fence. Never use indentation for code blocks. Markdown
allows this pattern but it can be problematic and should be avoided.

A code block is one or more lines of code surrounded by a triple-backtick (`` ``` ``) code fence.
The code fence markers must be on their own line before and after the code sample. The opening
marker may have an optional language label. The language label enables syntax highlighting on the
rendered webpage.

For a full list of supported language tags, see [Fenced code blocks][2] in the centralized
contributor guide.

Publishing also adds a **Copy** button that can copy the contents of the code block to the
clipboard. This allows you to paste the code into a script to test the code sample. However, not all
examples are intended to be run as written. Some code blocks are basic illustrations of PowerShell
concepts.

There are three types code blocks used in our documentation:

1. Syntax blocks
1. Illustrative examples
1. Executable examples

### Syntax code blocks

Syntax code blocks are used to describe the syntactic structure of a command. Don't use a language
tag on the code fence. This example illustrates all the possible parameters of the `Get-Command`
cmdlet.

~~~markdown
```
Get-Command [-Verb <String[]>] [-Noun <String[]>] [-Module <String[]>]
  [-FullyQualifiedModule <ModuleSpecification[]>] [-TotalCount <Int32>] [-Syntax]
  [-ShowCommandInfo] [[-ArgumentList] <Object[]>] [-All] [-ListImported]
  [-ParameterName <String[]>] [-ParameterType <PSTypeName[]>] [<CommonParameters>]
```
~~~

This example describes the `for` statement in generalized terms:

~~~markdown
```
for (<init>; <condition>; <repeat>)
{<statement list>}
```
~~~

### Illustrative examples

Illustrative examples are used to explain a PowerShell concept. They aren't meant to be copied and
pasted for execution. These are most commonly used for simple examples that are easy to understand.
The code block can include the PowerShell prompt and example output.

Here's a simple example illustrating the PowerShell comparison operators. In this case, we don't
intend the reader to copy and run this example.

~~~markdown
```powershell
PS> 2 -eq 2
True

PS> 2 -eq 3
False

PS> 1,2,3 -eq 2
2

PS> "abc" -eq "abc"
True

PS> "abc" -eq "abc", "def"
False

PS> "abc", "def" -eq "abc"
abc
```
~~~

### Executable examples

Complex examples, or examples that are intended to be copied and executed, should use the following
block-style markup:

~~~markdown
```powershell
<Your PowerShell code goes here>
```
~~~

The output displayed by PowerShell commands should be enclosed in an **Output** code block to
prevent syntax highlighting. For example:

~~~markdown
```powershell
Get-Command -Module Microsoft.PowerShell.Security
```

```Output
CommandType  Name                        Version    Source
-----------  ----                        -------    ------
Cmdlet       ConvertFrom-SecureString    3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       ConvertTo-SecureString      3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-Acl                     3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-AuthenticodeSignature   3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-CmsMessage              3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-Credential              3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-ExecutionPolicy         3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Get-PfxCertificate          3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       New-FileCatalog             3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Protect-CmsMessage          3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Set-Acl                     3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Set-AuthenticodeSignature   3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Set-ExecutionPolicy         3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Test-FileCatalog            3.0.0.0    Microsoft.PowerShell.Security
Cmdlet       Unprotect-CmsMessage        3.0.0.0    Microsoft.PowerShell.Security
```
~~~

The **Output** code label isn't an official "language" supported by the syntax highlighting system.
However, this label is useful because our publishing system adds the "Output" label to the code box
frame on the web page. The "Output" code box has no syntax highlighting.

## Coding style rules

### Avoid line continuation in code samples

Avoid using line continuation characters (`` ` ``) in PowerShell code examples. These are hard to
see and can cause problems if there are extra spaces at the end of the line.

- Use PowerShell [splatting][3] to reduce line length for cmdlets that have several parameters.
- Take advantage of PowerShell's natural line break opportunities, like after pipe (`|`) characters,
  opening braces (`{`), parentheses (`(`), and brackets (`[`).

### Avoid using PowerShell prompts in examples

Use of the prompt string is discouraged and should be limited to scenarios that are meant to
illustrate command-line usage. For most of these examples, the prompt string should be `PS>`. This
prompt is independent of OS-specific indicators.

Prompts are required in examples to illustrate commands that alter the prompt or when the path
displayed is significant to the scenario. The following example illustrates how the prompt changes
when using the Registry provider.

```powershell
PS C:\> cd HKCU:\System\
PS HKCU:\System\> dir

    Hive: HKEY_CURRENT_USER\System

Name                   Property
----                   --------
CurrentControlSet
GameConfigStore        GameDVR_Enabled                       : 1
                       GameDVR_FSEBehaviorMode               : 2
                       Win32_AutoGameModeDefaultProfile      : {2, 0, 1, 0...}
                       Win32_GameModeRelatedProcesses        : {1, 0, 1, 0...}
                       GameDVR_HonorUserFSEBehaviorMode      : 0
                       GameDVR_DXGIHonorFSEWindowsCompatible : 0
```

### Don't use aliases in examples

Use the full name of all cmdlets and parameters unless you're specifically documenting the alias.
Cmdlet and parameter names must use the proper [Pascal-cased][4] names.

### Using parameters in examples

Avoid using positional parameters. In general, you should always include the parameter name in an
example, even if the parameter is positional. This reduces the chance of confusion in your examples.

## Formatting cmdlet reference articles

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS][5].
PlatyPS generates the cmdlet help for PowerShell modules in Markdown. After editing the Markdown
files, PlatyPS is used create the MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a schema that expects a specific structure for cmdlet reference. The
[platyPS.schema.md][6] document attempts to describe this structure. Schema violations cause build
errors that must be fixed before we can accept your contribution.

- Don't remove any of the ATX header structures. PlatyPS expects a specific set of headers.
- The **Input type** and **Output type** headers must have a type. If the cmdlet doesn't take input
  or return a value, then use the value `None`.
- Inline code spans can be used in any paragraph.
- Fenced code blocks are only allowed in the **EXAMPLES** section.

In the PlatyPS schema, **EXAMPLES** is an H2 header. Each example is an H3 header. Within an
example, the schema doesn't allow code blocks to be separated by paragraphs. The schema allows the
following structure:

```
### Example X - Title sentence

0 or more paragraphs
1 or more code blocks
0 or more paragraphs.
```

Number each example and add a brief title.

For example:

~~~markdown
### Example 1: Get cmdlets, functions, and aliases

This command gets the PowerShell cmdlets, functions, and aliases that are installed on the
computer.

```powershell
Get-Command
```

### Example 2: Get commands in the current session

```powershell
Get-Command -ListImported
```
~~~

## Formatting About_ files

`About_*` files are written in Markdown but are shipped as plain text files. We use [Pandoc][7] to
convert the Markdown to plain text. `About_*` files are formatted for the best compatibility across
all versions of PowerShell and with the publishing tools.

Basic formatting guidelines:

- Limit paragraph lines to 80 characters
- Limit code blocks to 76 characters
- Limit blockquotes and alerts to 78 characters
- When using these special meta-characters `\`,`$`, and `<`:
  - Within a header, these characters must be escaped using a leading `\` character or enclosed in
    code spans using backticks (`` ` ``)
  - Within a paragraph, these characters should be put into code spans. For example:

    ```markdown
    ### The purpose of the \$foo variable

    The `$foo` variable is used to store ...
    ```

- Markdown tables
  - For `About_*` topics, tables must fit within 76 characters
    - If the content doesn't fit within 76 character limit, use bullet lists instead
  - Use opening and closing `|` characters on each line

## Next steps

[Editorial checklist][8]

<!-- link references -->
[1]: overview.md#get-started-writing-docs
[2]: /contribute/code-in-docs#inline-code-blocks
[3]: /powershell/module/microsoft.powershell.core/about/about_splatting
[4]: https://en.wikipedia.org/wiki/PascalCase
[5]: https://github.com/powershell/platyps
[6]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
[7]: https://pandoc.org
[8]: editorial-checklist.md
