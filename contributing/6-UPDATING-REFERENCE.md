# Updating reference articles

The PowerShell documentation has

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS][].
PlatyPS is the tool we use to generate the cmdlet help for a PowerShell module and to create the
MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a hardcoded schema for cmdlet reference that is written into the code. The [platyPS.schema.md][]
document attempts to describe this structure. When updating cmdlet reference, if you don't follow
this schema you can cause build errors that must be fixed before we can accept your contribution.

## General guidelines

- Do not remove any of the header structures. PlatyPS expect a specific set of headers.
- The **Input type** and **Output type** headers must have a type. If the cmdlet does not take input
  or return a value then use the value "None".
- Fenced code blocks are only allowed in the **Examples** section.
- Inline code spans can be used in any paragraph.

## Formatting About_ files

We are changing the way we process `about_*` files. `About_*` files are being reformatted for the
best compatibility across PowerShell versions and our publishing tools. For details, see [issue #1806][issue1806].
Please do not alter the formatting of `about_*` files without checking in with a repo maintainer.

Basic formatting guidelines:

- Limit lines to 80 characters
- Code blocks should be limited to 76 characters
- Within a paragraph, the following characters must be escaped using a leading `\` character:
  <code>$</code>, <code>\`</code>, <code>\<</code>
- Tables need fit withing 76 characters
  - Manually wrap contents of cells across multiple lines
  - Use opening and closing `|` characters on each line
  - See a working example in [about_Comparison_Operators][about-example]

## Writing examples

In the PlatyPS schema, the **Examples** header is an H2 header and each example is an H3 header.

The schema does not allow code blocks to be separated by paragraphs in an example. The valid schema
is:

```
### Example #X title
0 or more paragraphs
1 or more code blocks
0 or more paragraphs.
```

Number the examples and add a title for each example.

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
