# Updating reference articles

Cmdlet reference articles have a specific structure. This structure is defined by [PlatyPS].
PlatyPS is the tool we use to generate the cmdlet help for a PowerShell module and to create the
MAML help files used by the `Get-Help` cmdlet.

PlatyPS has a hardcoded schema for cmdlet reference that is written into the code. The
[platyPS.schema.md] document attempts to describe this structure. When updating cmdlet reference,
if you don't follow this schema you can cause build errors that must be fixed before we can
accept your contribution.

## Guidelines

- Do not remove any of the header structures. PlatyPS expect a specific set of headers.
- The **Input type** and **Output type** headers must have a type.
  If the cmdlet does not take input or return a value then use the value "None".
- Fenced code blocks are only allowed in the **Examples** section.
- Inline code spans can be used in any paragraph.

## Writing examples

The **Examples** header is an H2 header. Each example must be an H3 header. Number the examples and
add a title for each example. For example:

### Example 1: Get cmdlets, functions, and aliases

```powershell
Get-Command
```

This command gets the PowerShell cmdlets, functions, and aliases that are installed on the
computer.

### Example 2: Get commands in the current session

```powershell
Get-Command -ListImported
```

The structure of an Example is:

1. H3 header describing the example
2. One or more fenced code blocks
3. Zero or more paragraphs describing the code in the example

If you break these rules you will cause a build error. Therefore, you cannot have multiple code
blocks with paragraphs in between them.

[PlatyPS]: http://github.com/powershell/platyps
[platyPS.schema.md]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
