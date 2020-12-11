---
title: PowerShell-Docs style guide
description: This article provides the rules of style for writing PowerShell documentation.
ms.date: 12/09/2020
ms.topic: conceptual
---
# PowerShell-Docs style guide

This article provides style guidance specific to the PowerShell-Docs content. It builds on the
information outlined in the [Overview](overview.md#get-started-writing-docs).

## Product Terminology

There are several variants of PowerShell.

- **PowerShell** - This is the default. We consider PowerShell 7 and beyond to be the one, true
  PowerShell.
- **PowerShell Core** - PowerShell built on .NET Core. Usage of the term **Core** should be limited
  to cases where it's necessary to differentiate it from Windows PowerShell.
- **Windows PowerShell** - PowerShell built on .NET Framework. Windows PowerShell ships only on
  Windows and requires the complete Framework.

  In general, references to "Windows PowerShell" in documentation can be changed to _PowerShell_.
  "Windows PowerShell" should be used when _Windows PowerShell_-specific behavior is being
  discussed.

Related products

- **Visual Studio Code (VS Code)** - This is Microsoft's free, open-source editor. At first mention,
  the full name should be used. After that you may use **VS Code**. Don't use "VSCode".
- **PowerShell Extension for Visual Studio Code** - The extension turns VS Code into the preferred
  IDE for PowerShell. At first mention, the full name should be used. After that you may use
  **PowerShell extension**.
- **Azure PowerShell** - This is the collection of PowerShell modules used to manage Azure services.
- **Azure Stack PowerShell** - This is the collection of PowerShell modules used to manage
  Microsoft's hybrid cloud solution.

## Markdown specifics

The Microsoft Open Publishing System (OPS) that builds our documentation uses [markdig][] to process
the Markdown documents. Markdig parses the documents based on the rules of the latest [CommonMark][]
specification.

The new CommonMark spec is much stricter about the construction of some Markdown elements. Pay close
attention to the details provided in this document.

### Blank lines, spaces, and tabs

Blank lines also signal the end of a block in Markdown. There should be a single blank between
Markdown blocks of different types (for example, between a paragraph and a list or header).

Multiple consecutive blank lines render as a single blank line in HTML. They serve no purpose.
Within a code block, consecutive blank lines break the code block.

Remove extra spaces at the end of lines.

> [!NOTE]
> Spacing is significant in Markdown. Always uses spaces instead of hard tabs. Trailing spaces can
> change how Markdown renders.

### Titles and headings

Only use [ATX headings][atx] (# style, as opposed to `=` or `-` style headers).

- Use sentence case - only proper nouns and the first letter of a title or header should be
  capitalized
- There must be a single space between the `#` and the first letter of the heading
- Headings should be surrounded by a single blank line
- Only one H1 per document
- Header levels should increment by one. Don't skip levels
- Don't use bold or other markup in headers

### Limit line length to 100 characters

This applies to conceptual articles and cmdlet reference. Limiting the line length improves the
readability of git diffs and history. It also makes it easier for other writers to make
contributions.

Use the [Reflow Markdown][reflow] extension in Visual Studio Code to easily reflow paragraphs to fit
the prescribed line length.

About_topics are limited to 80 characters. For more specific information, see
[Formatting About_ files](#formatting-about_-files).

### Lists

If your list contains multiple sentences or paragraphs, consider using a sublevel header rather
than a list.

List should be surrounded by a single blank line.

#### Unordered lists

Don't end list items with a period unless they contain multiple sentences. Use the hyphen character
(`-`) for list item bullets. This avoids confusion with bold or italic markup that uses the asterisk
[`*`]. To include a paragraph or other elements under a bullet item, insert a line break and align
indentation with the first character after the bullet.

For example:

```markdown
This is a list that contain child elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Child bullet item

    Sentence explaining the child bullet.

- Second bullet item
- Third bullet item
```

This is a list that contains child elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Child bullet item

    Sentence explaining the child bullet.

- Second bullet item
- Third bullet item

#### Ordered lists

To include a paragraph or other elements under a numbered item, align indentation with the first
character after the item number. All items in a numbered listed should use the number `1.` rather
than incrementing each item. Markdown rendering increments the value automatically. This makes
reordering items easier and standardizes the indentation of subordinate content.

For example:

```markdown
1. For the first element, insert a single space after the 1. Long sentences should be
   wrapped to the next line and must line up with the first character after the numbered
   list marker.

   To include a second element (like this one), insert a line break after the first
   and align indentations. The indentation of the second element must line up with
   the first character after the numbered list marker. For single digit items, like
   this one, you indent to column 4. For double digits items, for example item number
   10, you indent to column 5.

1. The next numbered item starts here.
```

The resulting Markdown is rendered as follows:

1. For the first element, insert a single space after the 1. Long sentences should be wrapped to the
   next line and must line up with the first character after the numbered list marker.

   To include a second element (like this one), insert a line break after the first and align
   indentations. The indentation of the second element must line up with the first character after
   the numbered list marker. For single digit items, like this one, you indent to column 4. For
   double digits items, for example item number 10, you indent to column 5.

1. The next numbered item starts here.

### Images

The syntax to include an image is:

```markdown
![[alt text]](<folderPath>)

Example:
![Introduction](./media/overview/Introduction.png)
```

Where `alt text` is a brief description of the image and `<folder path>` is a relative path to the
image. Alternate text is required for screen readers for the visually impaired.

Images should be stored in a `media/<article-name>` folder within the folder containing the article.
Don't share images between articles. Create a folder that matches the filename of your article under
the `media` folder. Copy the images for that article to that new folder. If an image is used by
multiple articles, each image folder must have a copy of that image file. This practice prevents a
change to an image in one article affecting another article.

The following image file types are supported: `*.png`, `*.gif`, `*.jpeg`, `*.jpg`, `*.svg`

### Markdown extensions supported by Open Publishing

The [Microsoft Docs Authoring Pack](/contribute/how-to-write-docs-auth-pack) contains tools that
support features unique to our publishing system. Alerts are a Markdown extension to create
blockquotes that render on docs.microsoft.com with colors and icons that highlight the significance
of the content. The following alert types are supported:

```markdown
> [!NOTE]
> Information the user should notice even if skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Essential information required for user success.

> [!CAUTION]
> Negative potential consequences of an action.

> [!WARNING]
> Dangerous certain consequences of an action.
```

These alerts look like this on docs.microsoft.com:

Note block

> [!NOTE]
> Information the user should notice even if skimming.

Tip block

> [!TIP]
> Optional information to help a user be more successful.

Important block

> [!IMPORTANT]
> Essential information required for user success.

Caution block

> [!CAUTION]
> Negative potential consequences of an action.

Warning block

> [!WARNING]
> Dangerous certain consequences of an action.

### Hyperlinks

- Hyperlinks must use Markdown syntax `[friendlyname](url-or-path)`. [Link references][linkref] are
  supported.
- The publishing system supports three types of links:
  - URL links
  - File links
  - Cross-reference links
- Links to other articles on docs.microsoft.com must be site-relative paths
- All URLs to external websites should use HTTPS unless that isn't valid for the target site.
- Links must have a friendly name, usually the title of the linked article
- All items in the _Related links_ section at the bottom should be hyperlinked
- Don't use backticks, bold, or other markup inside the brackets of a hyperlink.
- Bare URLs may be used when you're documenting a specific URI. The URI must be enclosed in
  backticks. For example:

  ```markdown
  By default, if you don't specify this parameter, the DMTF standard resource URI
  `http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.
  ```

#### Linking to other content on docs.microsoft.com

- **URL links** to other articles on docs.microsoft.com must be site-relative paths. The simplest
  way to create a relative link is to copy the URL from your browser then remove
  `https://docs.microsoft.com/en-us` from the value you paste into markdown. Don't include locales
  in URLs on Microsoft properties (remove `/en-us` from URL). Remove any unnecessary query
  parameters from the URL. Examples that should be removed:

  - `?view=powershell-5.1` - used to link to a specific version of PowerShell
  - `?redirectedfrom=MSDN` - added to the URL when you get redirected from an old article to its new
    location

  If you need to link to a specific version of a document, then you need to add the
  `&preserve_view=true` parameter to the query string. For example:
  `?view=powershell-5.1&preserve_view=true`

- A **file link** is used to link from one reference article to another, or from one conceptual
  article to another. If you need to link to a reference article for a specific version of
  PowerShell, then you must use a URL link.

  - File links contain a relative file path (for example: `../folder/file.md`)
  - All file paths use forward-slash (`/`) characters

- **Cross-reference links** are a special feature supported by the publishing system. You can use
  cross-reference links in conceptual articles to link to .NET API or cmdlet reference.

  For links to .NET API reference, see
  [Use links in documentation](/contribute/how-to-write-links#xref-cross-reference-links) in the
  central Contributor Guide.

  Links to cmdlet reference have the following format: `xref:<module-name>.<cmdlet-name>`. For
  example, to link to the `Get-Content` cmdlet in the **Microsoft.PowerShell.Management** module.

  `[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)`

Deep linking is allowed on both URL and file links. Add the anchor to the end of the target path.
For example:

- `[about_Splatting](about_Splatting.md#splatting-with-arrays)`
- `[custom key bindings](https://code.visualstudio.com/docs/getstarted/keybindings#_custom-keybindings-for-refactorings)`

For more information, see [Use links in documentation](/contribute/how-to-write-links).

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

  - When referring to a parameter by name, the name should be **bold**. When illustrating the use of
    a parameter with the hyphen prefix, the parameter should be wrapped in backticks. For example:

    ```markdown
    The parameter's name is **Name**, but it's typed as `-Name` when used on the command
    line as a parameter.
    ```

  - When showing example usage of an external command, the example should be wrapped in backticks.
    Always include the file extension in the native command. For example:

    ```markdown
    To start the spooler service on a remote computer named DC01, you type `sc.exe \\DC01 start spooler`.
    ```

    Including the file extension ensures that the correct command is executed according to PowerShell's
    command precedence.

- When writing a conceptual article (as opposed to reference content), the first instance of a
  cmdlet name should be hyperlinked to the cmdlet documentation. Don't use backticks, bold, or
  other markup inside the brackets of a hyperlink.

  For example:

  ```markdown
  This [Write-Host](/powershell/module/Microsoft.PowerShell.Utility/Write-Host) cmdlet
  uses the **Object** parameter to ...
  ```

  For more information, see [Hyperlinks](#hyperlinks) section of this article.

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
The code fence markers must be on their own line before and after the code sample. The marker at the
start of the code block may have an optional language label. Microsoft's Open Publishing System
(OPS) uses the language label to support the syntax highlighting feature.

For a full list of supported language tags, see
[Fenced code blocks](/contribute/code-in-docs#fenced-code-blocks) in the centralized contributor
guide.

OPS also adds a **Copy** button that copies the contents of the code block to the clipboard. This
allows you to quickly paste the code into a script to test the code sample. However, not all
examples in our documentation are intended to be run as-is. Some code blocks are simple
illustrations of a PowerShell concept.

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

Illustrative examples are used to explain a PowerShell concept. They aren't meant to be copied to
the clipboard for execution. These are most commonly used for simple examples that are easy to type
and easy to understand. The code block can include the PowerShell prompt and example output.

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
However, this label is useful because OPS adds the "Output" label to the code box frame on the web
page. The "Output" code box has no syntax highlighting.

## Coding style rules

### Avoid line continuation in code samples

Avoid using line continuation characters (`` ` ``) in PowerShell code examples. These are hard to
see and can cause problems if there are extra spaces at the end of the line.

- Use PowerShell splatting to reduce line length for cmdlets that have several parameters.
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
Cmdlet and parameter names must use the proper [Pascal-cased][] names.

### Using parameters in examples

Avoid using positional parameters. In general, you should always include the parameter name in an
example, even if the parameter is positional. This reduces the chance of confusion in your examples.

## Formatting cmdlet reference articles

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS][].
PlatyPS generates the cmdlet help for PowerShell modules in Markdown. After editing the Markdown
files, PlatyPS is used create the MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a hard-coded schema for cmdlet reference that is written into the code. The
[platyPS.schema.md][] document attempts to describe this structure. Schema violations cause build
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

`About_*` files are written in Markdown but are shipped as plain text files. We use [Pandoc][] to
convert the Markdown to plain text. `About_*` files are formatted for the best compatibility across
all versions of PowerShell and with the publishing tools.

Basic formatting guidelines:

- Limit normal lines to 80 characters
- Code blocks are limited to 76 characters
- Blockquotes (and Alerts) are limited 78 characters
- When using these special meta-characters `\`,`$`, and `<`:
  - Within a header, these characters must be escaped using a leading `\` character or enclosed in
    code spans using backticks (`` ` ``)
  - Within a paragraph, these characters should be put into code spans. For example:

    ~~~markdown
    ### The purpose of the \$foo variable

    The `$foo` variable is used to store ...
    ~~~

- Tables need to fit within 76 characters
  - Manually wrap contents of cells across multiple lines
  - Use opening and closing `|` characters on each line
  - The following example illustrates how to properly construct a table that contains information
    that wraps on multiple lines within a cell.

    ~~~markdown
    ```
    |Operator|Description                |Example                          |
    |--------|---------------------------|---------------------------------|
    |`-is`   |Returns TRUE when the input|`(get-date) -is [DateTime]`      |
    |        |is an instance of the      |`True`                           |
    |        |specified .NET type.       |                                 |
    |`-isNot`|Returns TRUE when the input|`(get-date) -isNot [DateTime]`   |
    |        |not an instance of the     |`False`                          |
    |        |specified.NET type.        |                                 |
    |`-as`   |Converts the input to the  |`"5/7/07" -as [DateTime]`        |
    |        |specified .NET type.       |`Monday, May 7, 2007 12:00:00 AM`|
    ```
    ~~~

    > [!NOTE]
    > The 76-column limitation applies only to `About_*` topics. You can use wide columns in
    > conceptual or cmdlet reference articles.

## Next steps

[Editorial checklist](editorial-checklist.md)

<!-- link references -->
[atx]: https://github.github.com/gfm/#atx-headings
[CommonMark]: https://spec.commonmark.org/
[markdig]: https://github.com/lunet-io/markdig
[Pandoc]: https://pandoc.org
[Pascal-cased]: https://en.wikipedia.org/wiki/PascalCase
[platyPS.schema.md]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
[PlatyPS]: https://github.com/powershell/platyps
[reflow]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[linkref]: https://spec.commonmark.org/0.29/#link-reference-definitions
