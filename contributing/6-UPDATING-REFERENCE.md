# Updating reference articles

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS][].
PlatyPS generates the cmdlet help for PowerShell modules in Markdown. After editing the Markdown
files, PlatyPS is used create the MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a hard-coded schema for cmdlet reference that is written into the code. The
[platyPS.schema.md][] document attempts to describe this structure. Schema violations cause build
errors that must be fixed before we can accept your contribution.

## General guidelines

- Do not remove any of the header structures. PlatyPS expects a specific set of headers.
- The **Input type** and **Output type** headers must have a type. If the cmdlet does not take input
  or return a value then use the value "None".
- Fenced code blocks are only allowed in the [Examples](#writing-examples) section.
- Inline code spans can be used in any paragraph.

## Formatting About_ files

`About_*` files are now processed by [Pandoc][], instead of PlatyPS. `About_*` files are formatted
for the best compatibility across with all versions of PowerShell and with the publishing tools. For
details, see [issue #1806][issue1806]. Please do not alter the formatting of `about_*` files without
checking in with a repo maintainer.

Basic formatting guidelines:

- Limit lines to 80 characters
- Code blocks and table are limited to 76 characters - Pandoc indents these by 4 spaces during
  conversion
- Tables need fit within 76 characters
  - Manually wrap contents of cells across multiple lines
  - Use opening and closing `|` characters on each line
  - See a working example in [about_Comparison_Operators][about-example]
- Using Pandoc special characters `\`,`$`,`` ` ``, and `<`
  - Within a header - these characters must be escaped using a leading `\` character
  - Within a paragraph, these characters should be put into code spans. For example:

    ~~~markdown
    ### The purpose of the \$foo variable

    The `$foo` variable is used to store ...
    ~~~

## Format for examples

In the PlatyPS schema, the **EXAMPLES** header is an H2 header and each example is an H3 header.

Within an example, the schema does not allow code blocks to be separated by paragraphs. The valid
schema is:

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

## Next Steps

See the [Pull Requests](7-PULL-REQUESTS.md) article.

[PlatyPS]: https://github.com/powershell/platyps
[platyPS.schema.md]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
[issue1806]: https://github.com/PowerShell/PowerShell-Docs/issues/1806
[about-example]: ../reference/5.1/Microsoft.PowerShell.Core/About/about_Comparison_Operators.md
[Pandoc]: https://pandoc.org