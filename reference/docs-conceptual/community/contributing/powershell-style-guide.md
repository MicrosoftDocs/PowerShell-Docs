---
title: PowerShell-Docs style guide
description: This article provides the rules of style for writing PowerShell documentation.
ms.date: 03/05/2020
ms.topic: conceptual
---
# PowerShell-Docs style guide

This article provides style guidance specific to the PowerShell-Docs content. This builds on the
information outlined in the [Overview](overview.md#get-started-writing-docs).

## Product Terminology

There are several variants of PowerShell.
This table defines some of the different terms used to discuss PowerShell.

- **PowerShell** - This is the default. We consider PowerShell 7 and beyond to be the one, true
  PowerShell going forward.

- **PowerShell Core** - PowerShell built on .NET Core. Usage of the term **Core** should be limited
  to cases where it is necessary to differentiate it from Windows PowerShell.

- **Windows PowerShell** - PowerShell built on .NET Framework. Windows PowerShell ships only on
  Windows and requires the complete Framework.

In general, references to "Windows PowerShell" in documentation can be changed to "PowerShell".
"Windows PowerShell" should **not** be changed when Windows-specific technology is being discussed.

## Markdown specifics

The Microsoft Open Publishing System (OPS) that builds our documentation uses [markdig][] to process
the Markdown documents. Markdig parses the documents based on the rules of the latest [CommonMark][]
specification.

The new CommonMark spec is much stricter about the construction of some Markdown elements. Pay close
attention to the details provided in this document.

### Blank lines, spaces, and tabs

Remove duplicate blank lines. Multiple blank lines render as a single blank line in HTML so there is
not purpose for multiple blank lines.

Blank lines also signal the end of a block in Markdown. There should be a single blank between
Markdown blocks of different types (for example, between a paragraph and a list or header).

> [!NOTE]
> Spacing is significant in Markdown. Always uses spaces instead of hard tabs. Remove
> extra spaces at the end of lines.

### Titles and headings

Only use [ATX headings][atx] (# style, as opposed to `=` or `-` style headers).

- Use sentence case - only proper nouns and the first letter of a title or header should be
  capitalized
- There must be a single space between the `#` and the first letter of the heading
- Headings should be surrounded by a single blank line
- Only one H1 per document
- Header levels should increment by one. Do not skip levels
- Do not use bold or other markup in headers

### Limit line length to 100 characters

This applies to conceptual articles and cmdlet reference. About_topics are limited to 80 characters.
Limiting the line length improves the readability of git diffs and history. It also makes it easier
for other writers to make contributions.

Use the [Reflow Markdown][reflow] extension in Visual Studio Code to easily reflow paragraphs to fit
the prescribed line length.

### Lists

If your list contains multiple sentences or paragraphs, consider using a sub-level header rather
than a list.

List should be surrounded by a single blank line.

#### Unordered lists

Do not end list items with a period unless they contain multiple sentences. Use the hyphen character
(`-`) for list item bullets. This avoids confusion with bold or italic markup that uses the asterisk
[`*`]. To include a paragraph or other elements under a bullet item, insert a line break and align
indentation with the first character after the bullet.

For example:

```markdown
This is a list that contain sub-elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Sub-bullet item

    Sentence explaining the sub-bullet.

- Second bullet item
- Third bullet item
```

This is a list that contains sub-elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Sub-bullet item

    Sentence explaining the sub-bullet.

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

### Formatting command syntax elements

- Always use the full name for cmdlets and parameters. Avoid using aliases unless you are
  specifically demonstrating the alias.

- Within a paragraph, language keywords, cmdlet names, variables, and file paths should be wrapped
  in backtick (`` ` ``) characters. Property, parameter, and class names should be **bold**.

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
  The parameter's name is **Name**, but it is typed as `-Name` when used on the command
  line as a parameter.
  ```

- When referring to external commands (EXEs, scripts, etc.), the command name should be bold, all
  lowercase (or capitalized if at the beginning of a sentence), and include the appropriate file
  extension. For example:

  ```markdown
  For example, on Windows systems, you can use the `net start` and `net stop` commands
  to start and stop a service. **Sc.exe** is another service control tool for Windows.
  That name does not fit into the naming pattern for the **net.exe** service commands.
  ```

- When showing example usage of an external command, the example should be wrapped in backticks.
  When there is a name collisions with an alias you must include the file extension in the command
  example. For example:

  ```markdown
  To start the spooler service on a remote computer named DC01, you type `sc.exe \\DC01 start spooler`.
  ```

- When writing a conceptual article (as opposed to reference content), the first instance of a
  cmdlet name should be hyperlinked to the cmdlet documentation. Do not use backticks, bold, or
  other markup inside the brackets of a hyperlink.

  For example:

  ```markdown
  This [Write-Host](/powershell/module/Microsoft.PowerShell.Utility/Write-Host) cmdlet
  uses the **Object** parameter to ...
  ```

  For more information, see [Hyperlinks](#hyperlinks) section of this article.

### Images

The syntax to include an image is:

```markdown
![[alt text]](<folderPath>)

Example:
![Introduction](./media/overview/Introduction.png)
```

Where `alt text` is a brief description of the image and `<folder path>` is a relative path to the
image. Alternate text is required for screen readers for the visually impaired. It is also useful in
case there is a site bug where the image cannot be rendered.

Images should be stored in a `media/<article-name>` folder within the folder containing the article.
Images should not be shared between articles. Create a folder that matches the filename of your
article under the `media` folder. Copy the images for that article to that new folder. If an image
is used by multiple articles, each image folder must have a copy of that image file. This practice
prevents a change to an image in one article affecting another article.

The following image file types are supported: `*.png`, `*.gif`, `*.jpeg`, `*.jpg`, `*.svg`

### Markdown extensions supported by Open Publishing

The [Microsoft Docs Authoring Pack](/contribute/how-to-write-docs-auth-pack) contains tools that
support features unique to our publishing system. Alerts are a Markdown extension to create block
quotes that render on docs.microsoft.com with colors and icons that indicate the significance of the
content. The following alert types are supported:

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

## Hyperlinks

- Avoid using bare URLs. Links should use Markdown syntax `[friendlyname](url-or-path)`
- Bare URLs may be used when necessary, but should be enclosed in backticks. For example:

  ```markdown
  By default, if you do not specify this parameter, the DMTF standard resource URI
  `http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.
  ```

- URL links should be HTTPS when possible.
- Links must have a friendly name, usually the title of the linked topic
- All items in the "related links" section at the bottom should be hyperlinked.
- Do not use backticks, bold, or other markup inside the brackets of a hyperlink.

### Linking to other content

There are two types of hyperlinks supported by the publishing system: URLs and file links.

A URL link can be a URL path that is relative to the root of docs.microsoft.com. Or an absolute URL that include the full URL syntax. (For example: `https:/github.com/MicrosoftDocs/PowerShell-Docs`)

- Use URL links when linking to content outside of PowerShell-Docs or between cmdlet reference and
  conceptual articles within PowerShell-docs.
- The simplest way to create a relative link is to copy the URL from your browser then remove
  `https://docs.microsoft.com/en-us` from the value you paste into markdown.
   - Do not include locales in URLs on Microsoft properties (eg. remove "/en-us" from URL).
- All URLs to external websites should use HTTPS unless that is not valid for the target site.

A file link is used to link from one reference article to another, or from one conceptual article to another. If you need to link to a reference article for a specific version of PowerShell, then you need to use a URL link.

- File links contain a relative file path (for example: `../folder/file.md`)
- All file paths use forward-slash (`/`) characters

## Formatting code samples

Markdown supports two different code styles:

- Code spans (inline) - marked by a single backtick (`` ` ``) character. Used within a paragraph
  rather than as a standalone block.
- Code blocks - a multi-line block surrounded by triple-backtick (`` ``` ``) strings. Code blocks
  may also have a language label following the backticks. The language label enables syntax
  highlighting for the contents of the code block.

### Using code blocks

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

### Syntax code blocks

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

### Illustrative examples

Illustrative examples are used to explain a PowerShell concept. They are not meant to be copied to
the clipboard for execution. These are most commonly used for simple examples that are easy to type.
They are also used for syntax examples where you are illustrating the syntax of a command. The code
block may contain example output from the command being illustrated.

Here is a simple example illustrating a PowerShell comparison operators:

~~~markdown
```powershell
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

### Executable examples

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
However, this label is useful because OPS adds the "Output" label to the code box frame on the web
page. The "Output" code box has no syntax highlighting.

## Coding style rules

### Avoid line continuation in code samples

Avoid using line continuation characters (`` ` ``) in PowerShell code examples. These are hard to
see and can cause problems if there are extra spaces at the end of the line.

- Use PowerShell splatting to reduce line length for cmdlets that have a lot of parameters.
- Take advantage of PowerShell's natural line break opportunities, like after pipe (`|`) characters,
  opening braces, parentheses, and brackets.

### Avoid using PowerShell prompts in examples

Use of the prompt string is discouraged and should be limited to scenarios that are meant to
illustrate command line usage. For most of these examples, the prompt string should be `PS>`. This
prompt is independent of OS-specific indicators.

Prompts are required for examples that illustrate commands that alter the prompt or when the path
displayed is significant to the scenario being illustrated. The following example illustrates how
the prompt changes when using the Registry provider.

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
talking about the alias. Cmdlet and parameter names must use the proper spelling defined in the
code.

### Using parameters in examples

Avoid using positional parameters. In general, you should always include the parameter name in an
example, even if the parameter is positional. This reduces the chance of confusion in your examples.

## Next steps

[Editing cmdlet reference](editing-cmdlet-ref.md)

<!-- External URLs -->
[platyPS]: https://github.com/PowerShell/platyPS
[markdig]: https://github.com/lunet-io/markdig
[CommonMark]: https://spec.commonmark.org/
[atx]: https://github.github.com/gfm/#atx-headings
[pascal-case]: https://en.wikipedia.org/wiki/PascalCase
[reflow]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
