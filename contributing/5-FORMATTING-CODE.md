# Formatting code samples

The existing documentation has used multiple styles, over time, and the formatting rules have
changed multiple times. We have adopted a consistent style for PowerShell code blocks and output in
our documentation.

Markdown supports two different code styles:

- Code spans (inline) - marked by a single backtick (`` ` ``) character. Used inline in a paragraph
  rather than as a standalone block. Most commonly used around cmdlet names. See
  [Formatting command syntax elements](4-MARKDOWN-SPECIFICS.md#formatting-command-syntax-elements).
- Code blocks - a multi-line block surrounded by triple-backtick (`` ``` ``) strings.

## Using code blocks

Markdown allows for indentation to signify a code block, but this pattern can be problematic and
should be avoided. All code blocks should be contained in a code fence. A code fence is a block of
code surrounded by triple-backtick (`` ``` ``) strings. The code fence markers must be on their own
line before and after the code sample. The marker at the start of the code block may have an
optional language label. Microsoft's Open Publishing System (OPS) uses the language label to support
the syntax highlighting feature.

OPS also adds a **Copy** button that copies the contents of the code block to the clipboard. This
allows you to quickly paste the code into a script for testing the code example. However, not all
examples in our documentation are intended to be run. Some code blocks are simple illustrations of a
PowerShell concept.

There are two types code blocks used in our documentation:

1. Illustrative examples
2. Executable examples

## Formatting illustrative examples

Illustrative examples are used to explain a PowerShell concept. They are not meant to be copied to
the clipboard for execution. These are most commonly used for simple examples that are easy to type.
They are also used for syntax examples where you are illustrating the syntax of a command.

Illustrative examples use a "naked" code fence to mark the beginning and end of the code block. The
code block may contain example output from the command being illustrated.

### Syntax block

This example illustrates all the possible parameters of the `Get-Command` cmdlet.

~~~markdown
```
Get-Command [-Verb <String[]>] [-Noun <String[]>] [-Module <String[]>]
  [-FullyQualifiedModule <ModuleSpecification[]>] [-TotalCount <Int32>] [-Syntax] [-ShowCommandInfo]
  [[-ArgumentList] <Object[]>] [-All] [-ListImported] [-ParameterName <String[]>]
  [-ParameterType <PSTypeName[]>] [<CommonParameters>]
```
~~~

This example describes the `for` statement in generalized terms:

~~~markdown
```
for (<init>; <condition>; <repeat>)
{<statement list>}
```
~~~

### Simple illustration example

Here is an example illustrating PowerShell comparison operators:

~~~markdown
```
PS> 2 -eq 2
True

PS> 2 -eq 3
False

PS>  1,2,3 -eq 2
2

PS> "abc" -eq "abc"
True

PS> "abc" -eq "abc", "def"
False

PS> "abc", "def" -eq "abc"
abc
```
~~~

Note that this example has the simplified PowerShell prompt and shows the resulting output. In this
case, we don't intend the reader to copy and run this example.

## Formatting executable examples

More complex examples or examples that are intended to be useful to copy and execute should use the
following block-style markup:

~~~markdown
```powershell
<PowerShell code goes here>
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

The **Output** code label is not an official "language" supported by the syntax highlighting system.
However, this label is useful because OPS adds the "Output" label to the code box on the web page.
And this "Output" code box has no syntax highlighting.

## Coding style rules

### Avoid line continuation in code samples

Avoid using line continuation characters (`` ` ``) in PowerShell code examples. These are hard to
see and can cause problems if there are extra spaces at the end of the line.

- Use PowerShell splatting to reduce line length for cmdlets that have a lot of parameters.
- Take advantage of PowerShell's natural line break opportunities, like after pipe (`|`) characters,
  opening braces, parentheses, and brackets.

### Avoid using PowerShell prompts in examples

Use of the prompt string is discouraged and should be limited to scenarios that are meant to
illustrate command line usage. Prompts are required for examples that illustrate commands that alter
the prompt or when the path displayed is significant to the scenario being illustrated.

- PowerShell prompts should only be used in illustrative examples. For most of these examples, the
  prompt string should be "`PS>`". This prompt is independent of OS-specific indicators.
- Prompts should **NOT** be used in executable examples.

The following example illustrates how the prompt changes when using the Registry provider.

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

### Do not use aliases in examples

You should always use the full name of all cmdlets and parameters unless you are specifically
talking about the alias. Cmdlet and parameter names must use the proper Pascal-case spelling defined
in the code.

### Using parameters in examples

Avoid using positional parameters. In general, you should use always include the parameter name in
an example, even if the parameter positional. This reduces the chance of confusion in your examples.

## Next Steps

See the [Updating Reference](6-UPDATING-REFERENCE.md) article.
