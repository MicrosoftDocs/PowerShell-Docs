---
title: Editing reference articles
description: This article explains the specific requirements for editing cmdlet reference and About topics in the PowerShell documentation.
ms.date: 03/05/2020
ms.topic: conceptual
---
# Editing reference articles

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS][].
PlatyPS generates the cmdlet help for PowerShell modules in Markdown. After editing the Markdown
files, PlatyPS is used create the MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a hard-coded schema for cmdlet reference that is written into the code. The
[platyPS.schema.md][] document attempts to describe this structure. Schema violations cause build
errors that must be fixed before we can accept your contribution.

## General guidelines

- Do not remove any of the header structures. PlatyPS expects a specific set of headers.
- The **Input type** and **Output type** headers must have a type. If the cmdlet does not take input
  or return a value then use the value `None`.
- Fenced code blocks are only allowed in the [Examples](#structuring-examples) section.
- Inline code spans can be used in any paragraph.

## Formatting About_ files

`About_*` files are written in Markdown but are shipped as plain text files. We use [Pandoc][] to
convert the Markdown to plain text. `About_*` files are formatted for the best compatibility across
all versions of PowerShell and with the publishing tools.

Basic formatting guidelines:

- Limit lines to 80 characters. Pandoc indents some Markdown blocks so those block must be adjusted.
  - Code blocks are limited to 76 characters
  - Tables are limited 76 characters
  - Blockquotes (and Alerts) are limited 78 characters

- Using Pandoc's special meta-characters `\`,`$`, and `<`
  - Within a header - these characters must be escaped using a leading `\` character or enclosed in
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

## Structuring examples

In the PlatyPS schema, the **EXAMPLES** header is an H2 header and each example is an H3 header.

Within an example, the schema does not allow code blocks to be separated by paragraphs. The
supported schema is:

```
### Example #X title

0 or more paragraphs
1 or more code blocks
0 or more paragraphs.
```

Number each example and add a brief title.

For example:

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

## Next steps

[Editorial checklist](editorial-checklist.md)

<!-- link references -->
[PlatyPS]: https://github.com/powershell/platyps
[platyPS.schema.md]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
[issue1806]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/1806
[about-example]: /PowerShell/module/Microsoft.PowerShell.Core/About/about_Comparison_Operators
[Pandoc]: https://pandoc.org
